From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Apr 2015 16:45:10 +0100
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <97B1A2D4-6F6B-433B-83E6-9C8A95D1BFC6@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <493B15F8-0EBE-4633-9604-671EF403F36E@codeaurora.org>
 <20150410161052.GF6854@e104818-lin.cambridge.arm.com>
 <FDC755A7-ACCF-4222-8730-782EEC632159@codeaurora.org>
 <20150413094117.GA2745@e104818-lin.cambridge.arm.com>
 <245B9FDD-E1B5-41E4-9F24-4D5BB86C450E@codeaurora.org>
 <97B1A2D4-6F6B-433B-83E6-9C8A95D1BFC6@codeaurora.org>
Message-ID: <20150414154509.GI28709@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 03:44:11PM +0100, Kumar Gala wrote:
> 
> > On Apr 14, 2015, at 9:21 AM, Kumar Gala <galak@codeaurora.org> wrote:
> > 
> >>>> 
> >>>> So please come up with proper technical arguments rather than the kernel
> >>>> should take whatever SoC vendors dreamt of.
> >>> 
> >>> There is no technical argument to be made.  This is about the
> >>> community and you as maintainer wanting to accept code that complies
> >>> to your decision or not.
> >> 
> >> If you are not willing to make technical arguments, I don't have to
> >> provide any further reasons in this thread. It's your choice. In the
> >> meantime, the short answer is NAK.
> 
> I assume you would than NAK someone trying to get support for their
> Nexus 9 Tablet using a Tegra K1.

That would depend on how they try to boot secondary CPUs. It's
unfortunate that a product is shipping with an arbitrary implementation
specific SMP bringup mechanism, but its existence doesn't necessitate
that we support it.

People are currently working on PSCI support for 32-bit Tegra platforms
in U-Boot, and it's my understanding that a reasonable proportion of
that could should be possible to reuse for 64-bit. That may be
applicable to the Nexus 9.

Otherwise it's possible to have a shim which can place the secondaries
into a spin-table. It looks like that would be necessary anyway; there
seem to be some egregious boot protocol violations. 

> It appears the shipping code for that device didn?t use PSCI (again guessing because it wasn?t available at the time).
> 
> https://android.googlesource.com/kernel/tegra/+/android-tegra-flounder-3.10-lollipop-release/arch/arm64/mach-tegra/platsmp.c

Commit e790f1deb26a2e23 ("arm64: psci: add support for PSCI invocations
from the kernel") has been upstream since v3.9-rc1. It's even in the
(v3.10 derived) tree you link to:

https://android.googlesource.com/kernel/tegra/+/android-tegra-flounder-3.10-lollipop-release/arch/arm64/kernel/psci.c

As is spin-table:

https://android.googlesource.com/kernel/tegra/+/android-tegra-flounder-3.10-lollipop-release/arch/arm64/kernel/smp_spin_table.c

> If so, I find this counter to the Linux kernel communities normal desire to support the most hardware platforms.

Supporting hardware platforms doesn't mean that we must accept code
which we believe to be problematic.

We don't want implementation-specific SMP bringup mechanisms because
we've learnt from the lessons of the past. They're almost always
ill-defined, not reusable, and they're a maintenance burden for all
system software targeting ARM which gets worse over time.

If there are technical problems with the existing mechanisms, we're open
to solving them. Others have engaged with the kernel community and/or
ARM (in the case of PSCI) to do so, and all others upstream so far have
used common enable methods.

Mark. 
