From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 May 2016 13:43:43 +0200
Subject: [BUG] CONFIG_UNINLINE_SPIN_UNLOCK important for Cortex-A9
In-Reply-To: <871t4io608.fsf@gmail.com>
References: <874m9eoetu.fsf@gmail.com> <4854518.jvbplH0SM0@wuerfel>
 <871t4io608.fsf@gmail.com>
Message-ID: <6689734.3ffZe38SoY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 31, 2016 12:51:03 PM CEST Holger Schurig wrote:
> > Have you tried multi_v7_defconfig? That also does not set 
> > CONFIG_UNINLINE_SPIN_UNLOCK, but it is generally assumed to work.
> 
> Not yet, will try this (see below).

Ok

> > Just to be sure: If you just enable UNINLINE_SPIN_UNLOCK (e.g. using
> > a 'select' from arch/arm/mach-imx/Kconfig) without selecting PROVE_RCU,
> > you say the bug is gone too?
> 
> Currently I select it indirectly. One person that tried to help me
> turned on 29 different kernel debug options and the bug was gone. Then I
> reduced this step by step to find out which of them was needed
> minimally.
> 
> Still I don't think that it's an RCU issue. But it could of course be a
> "Heisenbug".

I would also not guess RCU as the first possibility. I was first guessing
that something might be wrong with arch_spin_unlock(), but it's actually
a really trivial function:

static inline void arch_spin_unlock(arch_spinlock_t *lock)
{
       smp_mb();
       lock->tickets.owner++;
       dsb_sev();
}

so there is really not much that can go wrong, and if there is,
then presumably either smp_mb() or dsb_sev() is not as strong
a barrier here as it should be, and that seems very unlikely.

The last change to the function was a while ago, but you could
try reverting this commit if nothing else helps:

commit 20e260b6f4f717c100620122f626a2c06a4cfd72
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu Jan 24 14:47:38 2013 +0100

    ARM: 7632/1: spinlock: avoid exclusive accesses on unlock() path
    
    When unlocking a spinlock, all we need to do is increment the owner
    field of the lock. Since only one CPU can be performing an unlock()
    operation for a given lock, this doesn't need to be exclusive.
    
    This patch simplifies arch_spin_unlock to use non-exclusive accesses
    when updating the owner field of the lock.
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index b4ca707d0a69..6220e9fdf4c7 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -119,22 +119,8 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	unsigned long tmp;
-	u32 slock;
-
 	smp_mb();
-
-	__asm__ __volatile__(
-"	mov	%1, #1\n"
-"1:	ldrex	%0, [%2]\n"
-"	uadd16	%0, %0, %1\n"
-"	strex	%1, %0, [%2]\n"
-"	teq	%1, #0\n"
-"	bne	1b"
-	: "=&r" (slock), "=&r" (tmp)
-	: "r" (&lock->slock)
-	: "cc");
-
+	lock->tickets.owner++;
 	dsb_sev();
 }

> > - Specific kernel version, and full list of patches applied (if any).
> >   Have you reproduced this with a plain unpatched linux-4.6 kernel?
> 
> I'm not in love with vendor-kernels, so I use kernels from kernel.org.
> When I started to chase the oops happened in 4.4.4, but the behavior was
> also present in 4.5, 4.5.1 ... 4.5.4 and 4.6.
> 
> I have some patches applied, e.g. aufs4, one patch in the i.MX6Q FEC
> ethernet driver and stuff to program the eMMC firmware. Nothing that
> plays with rcu, spinlocks etc, e.g. no preempt or Linux-RT patches.
> 
> However, a vanilla kernel boots on my device (isn't device tree
> nice?!?!?) and here I had the same behavior. I think that vanilla kernel
> was 4.5.3, but I'm unsure.

Ok, good, that should make it easy to reproduce.

> 
> > - Specific gcc version you used for building the kernel. Does this
> >   happen with both old and new compilers, e.g. 4.7 and 6.1?
> 
> I don't have yet a gcc 6.1 armhf cross compiler.

It's fairly straightforward to build gcc binaries for testing kernels
using Segher's "buildall" script from 
git://git.infradead.org/users/segher/buildall.git

I use that for testing out lots of gcc versions across architectures
when I run into a bug that is version specific.

> My gcc used to be
> http://releases.linaro.org/14.04/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux.tar.xz
> but during the bug chase I switched to Debian's cross-gcc. It says it is
> "arm-linux-gnueabihf-gcc ( 4.9.2-10) 4.9.2".
> 
> A kernel compiled by someone else with some "gcc-4.8
> 4.8.4-2ubuntu1~14.04" also had the same oopsing-behavior.

ok. Both of them are a few years old, so it would be interesting to
try a new version, probably not so interesting to try anything older.

If you like, I can also send you a tarball with gcc-6 binaries

> > - If it happens with an unpatched linux-4.6 and all gcc versions
> >   with multi_v7_defconfig, we should try reproducing it on some
> >   other quad-core Cortex-A9 (non-imx) platform with the same kernel
> >   binary.
> 
> I will try to reproduce it, as said it can take between 3 to 24 hours.
> 
> I'll be using
> 
> - vanilla 4.6 without any patch
> - ... and without any device-specific kernel module
> - multi_v7_defconfig
> - Debian 4.9.2 cross-compiler

awesome.

> [    2.844408] Bluetooth: L2CAP socket layer initialized
> [    2.849514] Bluetooth: SCO socket layer initialized
> [    2.895099] usbcore: registered new interface driver btusb
> [    3.257897] SMSC LAN8710/LAN8720 2188000.ethernet:00: attached PHY driver [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=2188000.ethernet:00, irq=-1)
> [17827.758966] Unable to handle kernel paging request at virtual address 00001014

0x1014 is a rather long offset, but still a plausible NULL pointer. The r10 register
contains 0x1000, so this is probably an incorrect value and is being used as a pointer
with offset 0x14 added in. With an objdump of your net/core/dev.o, we could
see which pointer that was, to maybe figure out which lock is supposed to protect
it and where that lock gets released.

> [17827.766279] pgd = ee09c000
> [17827.769003] [00001014] *pgd=3eba3831, *pte=00000000, *ppte=00000000
> [17827.775383] Internal error: Oops: 17 [#1] SMP ARM
> [17827.780108] Modules linked in: usbhid btusb btrtl btbcm btintel bluetooth flexcan smsc95xx usbnet mii ptxc(O)
> [17827.790242] CPU: 1 PID: 372 Comm: stress-ng-socke Tainted: G           O    4.5.4 #1
> [17827.797995] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [17827.804536] task: ed614780 ti: eebba000 task.ti: eebba000
> [17827.809977] PC is at __netif_receive_skb_core+0x328/0xa9c

Unfortunately in the middle of a rather long function, and I don't
see a spin_unlock in this function, in fact it's not even called
with a spinlock held, so it must be something more indirect.

> [17828.297390]  r4:ef7ba1b8 r3:ef7ba148
> [17828.301008] [<c03aaa30>] (process_backlog) from [<c03aa2cc>] (net_rx_action+0x1fc/0x2f0)
> [17828.309101]  r10:eebbbaf0 r9:00000040 r8:c05ea100 r7:0000012c r6:001abec9 r5:c03aaa30
> [17828.317014]  r4:ef7ba1b8 r3:eebbbaf0
> [17828.320637] [<c03aa0d0>] (net_rx_action) from [<c0022444>] (__do_softirq+0x134/0x254)
> [17828.328470]  r10:c05ea080 r9:40000003 r8:00000101 r7:eebba000 r6:c05ea08c r5:00000003
> [17828.336381]  r4:00000000
> [17828.338937] [<c0022310>] (__do_softirq) from [<c0022624>] (do_softirq+0x68/0x70)
> [17828.346334]  r10:00000006 r9:ef06a800 r8:0000000e r7:00000000 r6:eeb1c200 r5:ee05ba30
> [17828.354238]  r4:60030013
> [17828.356797] [<c00225bc>] (do_softirq) from [<c00226e8>] (__local_bh_enable_ip+0xbc/0xd0)
> [17828.364890]  r4:00000200 r3:00000008
> [17828.368520] [<c002262c>] (__local_bh_enable_ip) from [<c03e0360>] (ip_finish_output2+0x1b4/0x3b8)
> [17828.377395]  r5:ee05ba30 r4:00000000
> [17828.381005] [<c03e01ac>] (ip_finish_output2) from [<c03e1ed4>] (ip_finish_output+0x14c/0x20c)
> [17828.389531]  r8:ee2d2c00 r7:ee2d2c00 r6:c0606280 r5:0000ffff r4:ee05ba30
> [17828.396321] [<c03e1d88>] (ip_finish_output) from [<c03e2a34>] (ip_output+0x124/0x130)
> [17828.404153]  r10:00000006 r9:ef06a800 r8:ee2d2c00 r7:00000000 r6:0971f1b9 r5:c0606280
> [17828.412061]  r4:ee05ba30

This might be the smoking gun: We are in the middle of do_softirq() as triggered
from a __local_bh_enable_ip. This is often called from __raw_spin_unlock_bh(),
though I don't see that call in ip_finish_output2.

http://lwn.net/Articles/687617/ has some explanation about how this mechanism
works, and what some recent plans to change that are. I don't immediately see
anything that could lead to your bug there, but it's a start.

	Arnd
