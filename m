From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Mar 2016 01:22:17 +0300
Subject: arm64: kernel v4.6-rc1 hangs on QEMU
In-Reply-To: <3753214.GGjb33ZPlQ@wuerfel>
References: <20160329220502.GA14443@yury-N73SV>
 <3753214.GGjb33ZPlQ@wuerfel>
Message-ID: <20160329222217.GA31869@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 12:12:30AM +0200, Arnd Bergmann wrote:
> On Wednesday 30 March 2016 01:05:02 Yury Norov wrote:
> > Checked  for both v4.6-rc1 and current master (1993b17).
> > Config: arm64 defconfig
> > QEMU: QEMU emulator version 2.3.0 (Debian 1:2.3+dfsg-5ubuntu9.2)
> > 
> > Stacktrace:
> > #0  arch_counter_get_cntvct () at
> > ./arch/arm64/include/asm/arch_timer.h:121
> > #1  __delay (cycles=1024) at arch/arm64/lib/delay.c:31
> > #2  0xffffff8008340970 in __const_udelay (xloops=<optimized out>) at
> > arch/arm64/lib/delay.c:41
> > #3  0xffffff800815420c in panic (fmt=<optimized out>) at
> > kernel/panic.c:257
> > #4  0xffffff80080be588 in do_exit (code=11) at kernel/exit.c:666
> > #5  0xffffff8008089d08 in die (str=<optimized out>, regs=0xffffff8008aebe20 <init_thread_union+15904>, err=143867376) at arch/arm64/kernel/traps.c:298
> > #6  0xffffff8008089dec in arm64_notify_die (str=<optimized out>, regs=<optimized out>, info=<optimized out>, err=<optimized out>) at arch/arm64/kernel/traps.c:309
> > #7  0xffffff800808212c in do_undefinstr (regs=0xffffff8008aebe20 <init_thread_union+15904>) at arch/arm64/kernel/traps.c:399
> > #8  0xffffff8008a1fe08 in cpuinfo_store_boot_cpu () at arch/arm64/kernel/cpuinfo.c:252
> > #9  0xffffff8008a1fe08 in cpuinfo_store_boot_cpu () at arch/arm64/kernel/cpuinfo.c:252
> > #10 0xffffff8008a20388 in smp_prepare_boot_cpu () at arch/arm64/kernel/smp.c:403
> > #11 0xffffff8008a1d6ec in start_kernel () at init/main.c:511
> > #12 0xffffff80080811d8 in __mmap_switched () at arch/arm64/kernel/head.S:437
> > Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> > 
> 
> Undefined instruction in cpuinfo_store_boot_cpu() could be related
> to the SYS_ID_AA64MMFR2_EL1 access that was recently added.
> 
> What does the architecture say about reading unknown cpuid registers?
> 
> 	Arnd

ThunderX has some unimplemented system registers. AFAIR, attempt to access it
causes data abort.

Yury.
