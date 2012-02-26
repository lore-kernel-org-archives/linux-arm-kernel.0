From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Feb 2012 21:05:39 +0000
Subject: AT91: How copy kernel code to SRAM and execute?
In-Reply-To: <4F4A9A84.3050204@emagii.com>
References: <4F4A6DD5.5040606@emagii.com>
 <20120226175037.GA4706@n2100.arm.linux.org.uk> <4F4A9A84.3050204@emagii.com>
Message-ID: <20120226210539.GB4706@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 09:48:04PM +0100, Ulf Samuelsson wrote:
> On 2012-02-26 18:50, Russell King - ARM Linux wrote:
>> On Sun, Feb 26, 2012 at 06:37:25PM +0100, ARM Linux wrote:
>>> I am looking for some examples on how to copy a small piece of kernel code
>>> to internal SRAM and then execute it.
>> See fncpy.h
>>
> Thanks, this does the copy.
> My problem is in making the SRAM executable.
> I have already copied to SRAM (I think), but when I jump there
> I get a trap and a stackdump.



> The "mmap" system call, seems to do what I want, but is this callable
> from within the kernel, or is there a better way?
>
> I can see that is has been split upo into "old_mmap" (obsolete) and the  
> newer
> "sys_mmap2" which turns off the MAP_EXECUTABLE.
> "mprotect" maybe can be used to fix that.
>
> Googling for how to call a system call from within the kernel gave:
>
>     mm_segment_t     oldfs = get_fs();
>     set_fs(KERNEL_DS);
>     /* Do SysCalls */
>         sys_mprotect(sram_shutdown, PAGE_SIZE, ... );
>     set_fs(old_fs);

Don't even think about that.  Google doesn't always answer the correct
question.  In this case, it's completely the wrong thing because all
the userspace APIs are _only_ designed to work with userspace addresses.

Moreover, this will fail because it won't find a VMA for the address
(which is a good thing - as it will attempt to modify the pages in
ways which could end up exposing them to userspace.)

In general, if you're coding inside the kernel, calling kernel syscalls
is 99.999% of the time totally the wrong thing to do.

The way to do this is to use __arm_ioremap_exec() to map the SRAM.
