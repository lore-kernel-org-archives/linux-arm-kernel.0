From: ulf@emagii.com (Ulf Samuelsson)
Date: Sun, 26 Feb 2012 21:48:04 +0100
Subject: AT91: How copy kernel code to SRAM and execute?
In-Reply-To: <20120226175037.GA4706@n2100.arm.linux.org.uk>
References: <4F4A6DD5.5040606@emagii.com>
 <20120226175037.GA4706@n2100.arm.linux.org.uk>
Message-ID: <4F4A9A84.3050204@emagii.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-02-26 18:50, Russell King - ARM Linux wrote:
> On Sun, Feb 26, 2012 at 06:37:25PM +0100, ARM Linux wrote:
>> I am looking for some examples on how to copy a small piece of kernel code
>> to internal SRAM and then execute it.
> See fncpy.h
>
Thanks, this does the copy.
My problem is in making the SRAM executable.
I have already copied to SRAM (I think), but when I jump there
I get a trap and a stackdump.

The "mmap" system call, seems to do what I want, but is this callable
from within the kernel, or is there a better way?

I can see that is has been split upo into "old_mmap" (obsolete) and the 
newer
"sys_mmap2" which turns off the MAP_EXECUTABLE.
"mprotect" maybe can be used to fix that.

Googling for how to call a system call from within the kernel gave:

     mm_segment_t     oldfs = get_fs();
     set_fs(KERNEL_DS);
     /* Do SysCalls */
         sys_mprotect(sram_shutdown, PAGE_SIZE, ... );
     set_fs(old_fs);

which is yet to be tried.

PSEUDO CODE for what I think I need

     SETUP PAGE TABLE FOR SRAM
     SETUP SRAM PAGE PROTECTION AS (READ/WRITE)

     sram_shutdown    = phys_to_virt(0x300000);    /* Get transation for 
SRAM */
     target                    = (unsigned int *) sram_shutdown;

     memcpy((unsigned int *) sdram_shutdown, "target", size)

     SETUP SRAM PAGE PROTECTION AS (EXEC)

    (*sram_shutdown)();

>> Note that when arch_reset is called, the CPU is no longer executing
>> in its normal state.
>> It is called from arm_machine_restart in "arch/arm/kernel/process.c"
>> which has turned off the caches and setup some direct mapping at lower
>> addresses
> You're looking at old kernel code.  Stuff has substantially changed in
> this area, and CPU caches are no longer turned off if we're going to do
> a hardware based reset.
Yes, It is the std 2.6.30 kernel with Atmel patches from www.linux4sam.org
with some additions made by the customer,

> However, that doesn't negate what you're trying to do, and you'll need
> to use fncpy() for portability.
>

I have made a copy from SDRAM to 0x300000 "manually".
I enclose the piece of code, with a magic key, and check
that is exists in the beginning, and will copy until it is again found.
If the last key is not found, within 100 words, it is an error.

When I jump to the code, I get a trap, a stackdump and the part will reboot
properly, so it actually accomplish what it is supposed to...

An alternative solution to the problem, is to find out what the CPU
is doing after this trap.
If the user reset is replaced with this code, then this might be OK.

> The code which you want to copy must be written carefully in assembly
> language, and must be written to be relocatable.
It a piece of straight code, without jumps, so I do not expect problems 
here.

-- 
Best Regards
Ulf Samuelsson
ulf at emagii.com
+46 722 427437
