From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Thu, 27 Sep 2018 13:01:01 +0000
Subject: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A005F4A@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Marc
> Zyngier
> Sent: Saturday, September 22, 2018 5:00 AM
> To: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Cc: Jeffrey Hugo; Thomas Gleixner; Jason Cooper; Jeremy Linton; Ard
> Biesheuvel
> Subject: [PATCH 00/10] GICv3 support for kexec/kdump on EFI systems
> 
> The GICv3 architecture has the remarkable feature that once LPI tables
> have been assigned to redistributors and that LPI delivery is enabled,
> there is no guarantee that LPIs can be turned off (and most
> implementations do not allow it), nor can it be reprogrammed to use
> other tables.
> 
> This is a bit of a problem for kexec, where the secondary kernel
> completely looses track of the previous allocations. If the secondary
> kernel doesn't allocate the tables exactly the same way, no LPIs will
> be delivered by the GIC (which continues to use the old tables), and
> memory previously allocated for the pending tables will be slowly
> corrupted, one bit at a time.
> 
> The workaround for this is based on a series[1] by Ard Biesheuvel,
> which adds the required infrastructure for memory reservations to be
> passed from one kernel to another using an EFI table.
> 
> This infrastructure is then used to register the allocation of GIC
> tables with EFI, and allow the GIC driver to safely reuse the existing
> programming if it detects that the tables have been correctly
> registered. On non-EFI systems, there is not much we can do.
> 
> This has been tested on a TX2 system both as a host and a guest. I'd
> welcome additional testing of different HW. For convenience, I've
> stashed a branch containing the whole thing at [2].

We have done the test on our chip A64FX that When a write changes 
EnableLPI bit from 0 to 1, this bit becomes RES1. 
The result is that the kexec operation successfully works on our chip,
 and PCI based on LPI also works after kexec.

For detail:
We did "kexec -e" command, and the message, "Using preallocated 
redistributor tables", was shown.
After kexec, we can use our ssd normally.

Test environment
CPU: A64FX

Kernel version: v4.19 rc4 base
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gicv3-kdump
8bc67da irqchip/gic-v3-its: Allow use of LPI tables in reserved memory

kexec version:kexec-tools-2.0.14-17.2.el7.aarch64

Tested-by: Lei Zhang <zhang.lei@jp.fujitsu.com>

Thanks a lot.

Best Regards,
Lei,Zhang
FUJITSU LIMITED.
