From: alan@signal11.us (Alan Ott)
Date: Fri, 17 Jan 2014 19:57:16 -0500
Subject: Deadlock in do_page_fault() on ARM (old kernel)
In-Reply-To: <20140117134646.GL27282@n2100.arm.linux.org.uk>
References: <52D73220.3030108@signal11.us>
 <20140117134646.GL27282@n2100.arm.linux.org.uk>
Message-ID: <52D9D16C.9080501@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2014 08:46 AM, Russell King - ARM Linux wrote:
> On Wed, Jan 15, 2014 at 08:13:04PM -0500, Alan Ott wrote:
>> So my questions are:
>> 1. Why don't I see a full backtrace beyond the exception stack? It's the
>> same when dump_stack() is called manually.
> No idea - it looks like you're not using frame pointers, but are using
> the unwinder.  Full backtraces can always be created with frame pointers,
> it's just that unwinding seems unreliable.

Hi Russell,

I managed to get frame pointers turned on, which in this kernel version, 
seems like it requires the unwinder to be turned off[1].

When I built with frame pointers, the backtraces show differently. It 
only shows the frames which were _not_ shown with the unwinder. 
Backtrace at [2]. As you can see, it shows the non-exception stack dumps 
ending at places which can't page fault (and if it did page fault in 
those locations, it wouldn't try to take the mmap_sem lock). Its as 
though it shows what's in the modules but not what's in the image, where 
with the unwinder, it showed what's in the image and not what's in the 
modules[3].

> I think we do need to see the full backtrace here - from looking at the
> full state dump, I don't see any sign of the mmap_sem being held except
> by an attempt to process a fault, and two threads trying to do a
> sys_mmap_pgoff().

The lockdep printout at the end of [4] (which is the original log I sent 
the other day) shows do_page_fault() holding mmap_sem in six tasks and 
sys_mmap_pgoff() holding it in two. (I don't like the term "held" in the 
lockdep printout and believe it to mean "held or waiting for," based on 
my analysis of the rw_semaphore code.)

Each of those tasks seems to be blocking for it.

> My suspicion therefore is that some other thread must have died while
> holding the mmap_sem, so there's probably a kernel oops earlier...
> that's my best guess at the moment without seeing the full backtrace.

There's no oops that I'm able to see.

Each of the tasks which lockdep reports as "holding" mmap_sem are 
blocking for it. If some other task had taken it and then crashed, I 
assume lockdep would list the crashed task as also holding the resource 
in the printout.

Thanks for having a look at this,

Alan.

[1] It seems a little strange to me even in the newest kernel:
1: lib/Kconfig.debug specifies FRAME_POINTER . The text of this instance 
shows up when one searches for FRAME_POINTER in menuconfig. It can 
become selected even though the dependencies listed here are not met.
2: arch/arm/Kconfig.debug also specifies FRAME_POINTER, with a 
dependency only on !THUMB2_KERNEL, defaulting to yes on !ARM_UNWIND
3: ARM doens't set ARCH_WANT_FRAME_POINTERS

[2] http://www.signal11.us/~alan/stack_dump_with_frame_pointers.txt
Note: This is a sysrq dump of the locks held at lockup time and then the 
automatic hung task detection.

[3] The modules are being built in the standard way for out-of-tree:
     $(MAKE) -C $(PRJDIR)/linux M=$(CWD) modules

[4] http://www.signal11.us/~alan/show-all-tasks-deadlock.txt
