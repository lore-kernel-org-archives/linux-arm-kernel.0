From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Nov 2012 18:34:44 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <201211061733.44781.arnd@arndb.de>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211051908.34291.arnd@arndb.de>
 <20121106122011.GE29853@mudshark.cambridge.arm.com>
 <201211061733.44781.arnd@arndb.de>
Message-ID: <20121106183444.GJ30931@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 05:33:44PM +0000, Arnd Bergmann wrote:
> On Tuesday 06 November 2012, Will Deacon wrote:
> > nommu-XIP kernels are a different kettle
> > of fish, but we don't care about a decompressor there.
> 
> XIP is only supported on ARCH_PXA and ARCH_SA1100. I don't see either
> of them moving to CONFIG_MULTIPLATFORM any time soon, given how much
> work that would be. ARCH_MMP should be possible in the future, but
> has never supported XIP so far.

Indeed, although I expect systems with M-class CPUs to make more use of XIP
(I believe Uwe's board does this and uses the framebuffer for main memory).

> > The real problem will hit with things like CONFIG_DRAM_BASE, where !MMU
> > can't realistically support multiple platforms, so allowing
> > ARCH_MULTIPLATFORM doesn't feel quite right either...
> 
> Anybody who wants to build a !MMU kernel already needs to tweak the
> configuration quite a lot and usually knows more about the system than
> a typical end user. Having to pick the correct DRAM_BASE probably
> isn't too bad in that case, as long as the kernels actually build.

Ok, that's fair enough. Patch below.

Cheers,

Will

--->8

    ARM: nommu: remove MMU dependency from ARCH_MULTIPLATFORM
    
    ARCH_MULTIPLATFORM is the only way to select ARCH_VEXPRESS, so remove
    the dependency on MMU and instead use it to predicate the selection of
    ARM_PATCH_PHYS_VIRT.
    
    Although running a multi-platform kernel on a selection of MMU-less
    targets might not yet be possible, the thing should build and targetting
    a nommu platform is already a fairly involved exercise.
    
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Pawel Moll <Pawel.Moll@arm.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 335e220..5758cfb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -264,8 +264,7 @@ choice
 
 config ARCH_MULTIPLATFORM
        bool "Allow multiple platforms to be selected"
-       depends on MMU
-       select ARM_PATCH_PHYS_VIRT
+       select ARM_PATCH_PHYS_VIRT if MMU
        select AUTO_ZRELADDR
        select COMMON_CLK
        select MULTI_IRQ_HANDLER
