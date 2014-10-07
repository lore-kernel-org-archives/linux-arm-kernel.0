From: lanchon@gmail.com (Lanchon)
Date: Tue, 07 Oct 2014 18:48:23 -0300
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
Message-ID: <54345FA7.9030606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There is a longstanding bug in all the after-market kernels (and maybe 
manufacturer's kernels too) for all the Exynos 4210 (Cortex-A9)-based 
devices. These include:

Samsung Galaxy S II
Samsung Galaxy Note
Samsung Galaxy Tab 7.0 Plus
...and others.

Under rare conditions which are not easy to reproduce, floating point 
registers of userland processes get clobbered.

There is a vital FUSE process in Android 4.4 (called 'sdcard.c') that 
mediates access to internal phone storage as an emulated sdcard, and to 
external sdcards too. This process, normally compiled using 
-mfloat-abi=softfp, calls pread64() after saving the value of a 64-bit 
integer variable (called 'unique') in an FPU register (d8). On very rare 
occasions, upon return from pread64() the value of the FP register is 
corrupted; as a result the process stops responding and the devices 
loose access to storage.

There are other instabilities in the platform suspected of having the 
same cause. This bug has plagued the platform for years, but only 
recently FP clobbering was identified as the culprit.


More context:

This only happens on 4210-based devices. The same kernel tree compiled 
for 4212- and 4412-based devices does not exhibit the behavior. (The 
4x12 SoCs are a newer iteration of the 4210, with the 'x' corresponding 
to the number of cores. See: 
http://en.wikipedia.org/wiki/Exynos#List_of_Exynos_SoCs ) This points to 
a hardware issue, maybe a missing errata in the kernel, or to a driver 
issue.

Simply busy-spinning in userland waiting for FP corruption does not seem 
to trigger the issue. Concurrently accessing storage in another process 
while spinning also does not work; power management (sleep, etc) may be 
involved.

Compiling 'sdcard.c' using -mfloat-abi=soft solves the issue (for this 
vital process) since the 'unique' variable is saved in regular instead 
of FP registers then.

Objdumping the complete kernel does not show any instructions that 
access 'd' registers, except in context switching code, and in the code 
that implements traps that old VFP units need to handle some corner 
cases. Also, objdumps of *.ko files do not reveal any instructions that 
access 'd' registers.

We do not have 'kernel_neon_begin' nor 'kernel_vfp_begin' support in 
these kernels; the code is just not there.


Some links:

One of the affected kernel trees:
https://github.com/CyanogenMod/android_kernel_samsung_smdk4412/tree/cm-11.0

First direct observation of corruption:
http://forum.xda-developers.com/showthread.php?p=51237856&highlight=unique

The 'sdcard.c' process:
http://forum.xda-developers.com/showthread.php?p=55787440

Post showing that 'unique' is saved in 'd8':
http://forum.xda-developers.com/showthread.php?p=55783884

A busy-spin FP corruption test (that fails to reproduce the bug):
http://forum.xda-developers.com/showthread.php?p=55861206

Objdumps:
http://forum.xda-developers.com/showthread.php?p=55839635


And finally some questions:

Kernel threads (such as the worker thread of a threaded interrupt) 
should guard FPU access in between 'kernel_XXX_begin'/'kernel_XXX_end' 
calls (which our kernels do not implement). But what if it did not?

1) What is the FPU enable state while executing a kernel thread in ARM 
arch? Which of these answers is correct?

1a) the FPU is always disabled in kernel threads.
1b) the FPU might be enabled or disabled in a kernel thread, depending 
on the FPU enable state of the userland context that executed before 
and/or some other factors.

2) What would happen if a kernel thread executed an FPU instruction 
without the kernel_XXX_begin'/'kernel_XXX_end' guards in ARM arch and 
the FPU was disabled at the time?

2a) In the FPU trap the kernel would always detect the issue and panic 
or oops or something.
2b) In the FPU trap the kernel might enable the FPU, load the FPU 
context of some userland process and resume the kernel thread.

Of course an ISR should not touch the FPU at all. But what if it did?

3) What would happen if an ISR executed an FPU instruction in ARM arch 
and the FPU was disabled in the context that was interrupted:

3a) In the FPU trap the kernel would always detect the issue and panic 
or oops or something.
3b) In the FPU trap the kernel would react as if the interrupted context 
executed the FPU instruction: If the interrupted context was user mode, 
it would restore the userland process' FP context into the FPU. If the 
interrupted context was kernel mode, it would react as per the answer to 
question 2) above.

4) What would happen if an ISR executed an FPU instruction in ARM arch 
and the FPU was enabled in the context that was interrupted:

4a) The processor would disable the FPU on ISR entry automatically and 
thus the system would behave as described in the answer to question 3) 
above.
4b) If the driver uses the standard kernel interrupt dispatch 
architecture, the kernel would disable the FPU before dispatching the 
interrupt to the driver ISR, and so the system would also behave as 
described in 3).
4c) The FPU instruction would execute. There is no fail-fast or 
detection of this kind of violation by the kernel.


Of course every pointer, idea, or suspicion that might seem relevant to 
the case is welcome.

Thank you very much for reading and for your help.

Regards,
Lanchon
