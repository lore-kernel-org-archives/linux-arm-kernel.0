From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Nov 2018 15:52:47 +0000
Subject: [PATCH 2/2] arm64: defconfig: enable BPF related configs
In-Reply-To: <20181126153820.GA28400@arm.com>
References: <20181111181048.10933-1-pbrobinson@gmail.com>
 <20181111181048.10933-2-pbrobinson@gmail.com>
 <20181112183623.GA2265@brain-police>
 <CAKv+Gu9EE_bWcoxEFr4pi41pfAQsDAywKR+gSueA9vE_Z4Np+g@mail.gmail.com>
 <20181126153820.GA28400@arm.com>
Message-ID: <20181126155247.GY30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 03:38:20PM +0000, Will Deacon wrote:
> On Sat, Nov 17, 2018 at 03:18:04PM -0800, Ard Biesheuvel wrote:
> > On Mon, 12 Nov 2018 at 10:36, Will Deacon <will.deacon@arm.com> wrote:
> > > On Sun, Nov 11, 2018 at 06:10:48PM +0000, Peter Robinson wrote:
> > > > The BPF components are getting more widely used by various components
> > > > so we should enable them in the ARMv7 multi config to ensure they
> > > > get wider testing and don't regress.
> > >
> > > Have other architectures already made this leap?
> > >
> > 
> > $ git grep CONFIG_BPF_SYSCALL=y arch/
> > arch/arm/configs/aspeed_g4_defconfig:CONFIG_BPF_SYSCALL=y
> > arch/arm/configs/aspeed_g5_defconfig:CONFIG_BPF_SYSCALL=y
> > arch/mips/configs/generic_defconfig:CONFIG_BPF_SYSCALL=y
> > arch/powerpc/configs/44x/fsp2_defconfig:CONFIG_BPF_SYSCALL=y
> > arch/powerpc/configs/powernv_defconfig:CONFIG_BPF_SYSCALL=y
> > arch/powerpc/configs/ppc64_defconfig:CONFIG_BPF_SYSCALL=y
> > arch/powerpc/configs/pseries_defconfig:CONFIG_BPF_SYSCALL=y
> > arch/riscv/configs/defconfig:CONFIG_BPF_SYSCALL=y
> > arch/s390/configs/debug_defconfig:CONFIG_BPF_SYSCALL=y
> > arch/s390/configs/performance_defconfig:CONFIG_BPF_SYSCALL=y
> > arch/s390/defconfig:CONFIG_BPF_SYSCALL=y
> > 
> > but nobody seems to enable CONFIG_BPF_JIT_ALWAYS_ON.
> > 
> > I sent some patches to move the BPF JIT allocations out of the module
> > range. Whether that really improves things in terms of security is not
> > obvious to me, but at least we stop wasting module region space (and
> > potentially KASAN shadow pages) on BPF programs.
> > 
> > If this is mainly for coverage, it would indeed be nice if we could at
> > least make it root only by default. However, if the distros are
> > enabling this in their default configurations, I'd prefer it if we at
> > least have a config that will help us spot issues early on.
> 
> That's a fair point on the distros. Peter, as author of the patch, please
> can you take a look at the arm64 kernel configs from some popular
> distributions and see which of these options they tend to enable?

Another point to consider is whether the BPF JIT creates code that
is safe from Spectre, or whether it opens up more Spectre issues.
If it isn't, maybe the better option is to disable kernel-side BPF
entirely until it is fixed up.

I've raised that point for 32-bit ARM already, and the 32-bit ARM
BPF JIT isn't going to have the Spectre mitigations applied (since
no one appears interested whenever I've raised it.)  So, for 32-bit
ARM, it's better to have kernel-side BPF entirely disabled if you
care about Spectre mitigations.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
