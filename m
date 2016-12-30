From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 30 Dec 2016 15:13:23 +0800
Subject: Unhandled level 2 translation fault (11) at 0x000000b8, esr
 0x92000046, rpi3 (aarch64)
In-Reply-To: <CAGDbNAD7-TM6+x0A3FebTOPYmqQqbm1w29ZwH+9qePaAvhxTKw@mail.gmail.com>
References: <CAGDbNAD7-TM6+x0A3FebTOPYmqQqbm1w29ZwH+9qePaAvhxTKw@mail.gmail.com>
Message-ID: <20161230151323.583b7ac5@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 29 Dec 2016 17:38:14 +0100 Bas van Tiel wrote:

> Hi,
> 
> when using a signal handler as a way to context switch between
> different usercontexts a reproducible exception occurs on my rpi3 in
> 64-bit mode. (https://gist.github.com/DanGe42/7148946)
> 
> Running the context_demo program as a 32-bit ARM executable on a
> 64-bit kernel is OK, running as a 32 || 64 bit executable on an x86
> kernel is OK.
> 
> In the first exception the PC doesn?t look correct, and the *pmd is 0.
> The 2nd exception happens after running the program again, the PC is 0x0.
> 
> A successful function trace was not possible -> complete kernel hangup
> when enabling.
> 
> Is there another way to gather more information about what is happening?

I can reproduce Segmentation fault with your program on Marvell berlin SoCs
my kernel version is 4.1, I didn't tested 4.9, 4.10-rc1 etc..

Then I increased the STACKSIZE from 4096 to 8192 in context_demo.c,
everything works fine now. Maybe arm64 need a bit larger signalstack?

Thanks,
Jisheng

> 
> Linux (none) 4.10.0-rc1-v8+ #3 SMP PREEMPT Thu Dec 29 12:10:12 CET
> 2016 aarch64 GNU/Linux
> 
> [   46.350738] a.out[196]: unhandled level 2 translation fault (11) at
> 0x000000b8, esr 0x92000046
> [   46.360516] pgd = ffffffc0392cb000
> [   46.365377] [000000b8] *pgd=00000000392ec003
> [   46.365381] , *pud=00000000392ec003
> [   46.370878] , *pmd=0000000000000000
> [   46.375907]
> [   46.383974]
> [   46.389107] CPU: 0 PID: 196 Comm: a.out Not tainted 4.10.0-rc1-v8+ #3
> [   46.397949] Hardware name: Raspberry Pi 3 Model B (DT)
> [   46.406218] task: ffffffc039ad6580 task.stack: ffffffc039bfc000
> [   46.413892] PC is at 0x7fb4e34810
> [   46.418230] LR is at 0x400b84
> [   46.422956] pc : [<0000007fb4e34810>] lr : [<0000000000400b84>]
> pstate: 60000000
> [   46.431522] sp : 0000000000413350
> [   46.436480] x29: 0000000000413350 x28: 0000000000000016
> [   46.443142] x27: 0000000000000000 x26: 0000000000000020
> [   46.451908] x25: 0000007fb4f35488 x24: 0000000000415f00
> [   46.459641] x23: 0000000000000016 x22: 0000000000400b84
> [   46.469198] x21: 0000000000413670 x20: 0000000000417030
> [   46.476970] x19: 0000000000001000 x18: 0000000000000000
> [   46.484744] x17: 0000007fb4e34810 x16: 0000000000411270
> [   46.492175] x15: 00000000000005f1 x14: 0000000000000000
> [   46.498884] x13: 0000000000000000 x12: 0000000000000000
> [   46.506013] x11: 0000000000000020 x10: 0101010101010101
> [   46.517164] x9 : 0000000000413670 x8 : 00000000ffffffe0
> [   46.525541] x7 : 0000000000413350 x6 : 0000000000413350
> [   46.533495] x5 : 00000000ffffffe0 x4 : 0000000000413730
> [   46.544052] x3 : 0000000000000008 x2 : 0000000000000000
> [   46.552211] x1 : 0000000000413670 x0 : 0000000000000000
> [   46.558668]
> 
> 2nd time startup of the executable
> 
> [  262.565147] a.out[201]: unhandled level 2 translation fault (11) at
> 0x00000000, esr 0x82000006
> [  262.575243] pgd = ffffffc03939a000
> [  262.579948] [00000000] *pgd=000000003938f003
> [  262.579951] , *pud=000000003938f003
> [  262.586040] , *pmd=0000000000000000
> [  262.590479]
> [  262.598234]
> [  262.601108] CPU: 0 PID: 201 Comm: a.out Not tainted 4.10.0-rc1-v8+ #3
> [  262.609086] Hardware name: Raspberry Pi 3 Model B (DT)
> [  262.615731] task: ffffffc03904a600 task.stack: ffffffc039bfc000
> [  262.621768] PC is at 0x0
> [  262.624300] LR is at 0x0
> [  262.626835] pc : [<0000000000000000>] lr : [<0000000000000000>]
> pstate: 60000000
> [  262.634437] sp : 00000000004159c0
> [  262.637753] x29: 0000000000000000 x28: 0000000000000000
> [  262.643242] x27: 0000000000000000 x26: 0000000000000000
> [  262.648554] x25: 0000000000000000 x24: 0000000000000000
> [  262.654033] x23: 0000000000000000 x22: 0000000000000000
> [  262.659349] x21: 00000000004008f0 x20: 0000000000000000
> [  262.664825] x19: 0000000000000000 x18: 0000000000000000
> [  262.670145] x17: 0000007fb065b620 x16: 0000000000400b84
> [  262.675622] x15: 00000000000003d1 x14: 0000000000000000
> [  262.680938] x13: 0000000000000000 x12: 0000000000000000
> [  262.686413] x11: 0000000000000020 x10: 0101010101010101
> [  262.691835] x9 : 00000000004112c0 x8 : 0000000000000087
> [  262.697159] x7 : 0000000000000000 x6 : 0000000000000000
> [  262.702634] x5 : 0000000000000000 x4 : 0000000000000000
> [  262.707949] x3 : 0000000000000000 x2 : 0000000000000000
> [  262.713424] x1 : 0000000000000000 x0 : 0000000000000000
> [  262.718739]
> 
> rpi3:
> minimal kernel (64-bit, cortex-a53, little endian, 4Kb page,
> initramfs), different kernels tried 4.8/4.9/4.10.0-rc1-v8+ the same
> result occurs, also with different compilers.
> 
> kernel, aarch64-linux-gnu-gcc (Linaro GCC 6.2-2016.11) 6.2.1 20161016
> application, aarch64-linux-gnu-gcc (Linaro GCC 6.2-2016.11) 6.2.1 20161016
> 
> The only item I found by reading through the different source-files was the
> structure definition of struct kernel_rt_sigframe
> (http://osxr.org:8080/glibc/source/ports/sysdeps/unix/sysv/linux/aarch64/kernel_rt_sigframe.h?v=glibc-2.18)
> compared to the struct rt_sigframe (linux/arch/arm64/signal.c).
> 
> Any help or pointers to solve this issue are welcome,
> 
> regards
> Bas
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
