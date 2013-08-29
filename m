From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Aug 2013 22:37:06 -0700
Subject: [GIT PULL] non-critical omap fixes for v3.12 merge window
In-Reply-To: <20130828185045.GI8607@quad.lixom.net>
References: <20130823054609.GW7656@atomide.com>
 <20130828185045.GI8607@quad.lixom.net>
Message-ID: <20130829053705.GL7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130828 11:58]:
> On Thu, Aug 22, 2013 at 10:46:10PM -0700, Tony Lindgren wrote:
> 
> > Matus Ujhelyi (1):
> >       ARM: OMAP2+: am33xx-restart: trigger warm reset on omap2+ boards
> 
> Sigh. am33xx has been a bit of a pain this release cycle. Can you please
> start double-checking builds when you apply am33xx stuff? :(
> 
> This breaks with:
> 
>         multi_v7_defconfig:
> arch/arm/mach-omap2/am33xx-restart.c:27:26: error: 'AM33XX_RST_GLOBAL_WARM_SW_MASK' undeclared (first use in this function)
> 
>         omap2plus_defconfig:
> arch/arm/mach-omap2/am33xx-restart.c:27:26: error: 'AM33XX_RST_GLOBAL_WARM_SW_MASK' undeclared (first use in this function)

Oops sorry, I see what's going on. It builds fine against v3.11-rc6, but
has a dependency for v3.12 for the cleanup branch that removed all the
unused defines. 
 
> I've unmerged the branch until that's resolved.

Care to apply the following fix to the cleanup branch?

This way this fixes branch keeps working both against v3.11 and the
patches queued for v3.12.

Regards,

Tony


8< ---------

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 28 Aug 2013 22:24:13 -0700
Subject: [PATCH] ARM: OMAP2+: Add back the define for AM33XX_RST_GLOBAL_WARM_SW_MASK

This is needed to prevent a build error with a patch queued for fixes
"ARM: OMAP2+: am33xx-restart: trigger warm reset on omap2+ boards".

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/prm-regbits-33xx.h b/arch/arm/mach-omap2/prm-regbits-33xx.h
index bbffc03..84feece 100644
--- a/arch/arm/mach-omap2/prm-regbits-33xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-33xx.h
@@ -22,6 +22,7 @@
 #define AM33XX_GFX_MEM_RETSTATE_MASK			(1 << 6)
 #define AM33XX_GFX_MEM_STATEST_MASK			(0x3 << 4)
 #define AM33XX_GLOBAL_WARM_SW_RST_MASK			(1 << 1)
+#define AM33XX_RST_GLOBAL_WARM_SW_MASK			(1 << 0)
 #define AM33XX_PRUSS_MEM_ONSTATE_MASK			(0x3 << 5)
 #define AM33XX_PRUSS_MEM_RETSTATE_MASK			(1 << 7)
 #define AM33XX_PRUSS_MEM_STATEST_MASK			(0x3 << 23)
