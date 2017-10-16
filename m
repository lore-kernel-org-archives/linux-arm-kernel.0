From: sean.wang@mediatek.com (Sean Wang)
Date: Mon, 16 Oct 2017 15:27:21 +0800
Subject: [PATCH v2] soc: mediatek: place Kconfig for all SoC drivers
 under menu
In-Reply-To: <20171005105253.2f8dd7df@endymion>
References: <41e81ac2998b171ff4715cb2dc17f15aa10b7518.1507173110.git.sean.wang@mediatek.com>
 <20171005105253.2f8dd7df@endymion>
Message-ID: <1508138841.21840.46.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-10-05 at 10:52 +0200, Jean Delvare wrote:
> Hi Sean,
> 
> On Thu, 5 Oct 2017 11:17:49 +0800, sean.wang at mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Add cleanup for placing all Kconfig for all MediaTek SoC drivers under
> > the independent menu as other SoCs vendor usually did. Since the menu
> > would be shown depending on "ARCH_MEDIATEK || COMPILE_TEST" selected and
> > MTK_PMIC_WRAP is still safe compiling with the case of "COMPILE_TEST"
> > only, the superfluous dependency for those items under the menu also is
> > also being removed for the sake of simplicity.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/soc/mediatek/Kconfig | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index 609bb34..a7d0667 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -1,9 +1,11 @@
> >  #
> >  # MediaTek SoC drivers
> >  #
> > +menu "MediaTek SoC drivers"
> > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +
> >  config MTK_INFRACFG
> >  	bool "MediaTek INFRACFG Support"
> > -	depends on ARCH_MEDIATEK || COMPILE_TEST
> >  	select REGMAP
> >  	help
> >  	  Say yes here to add support for the MediaTek INFRACFG controller. The
> > @@ -12,7 +14,6 @@ config MTK_INFRACFG
> >  
> >  config MTK_PMIC_WRAP
> >  	tristate "MediaTek PMIC Wrapper Support"
> > -	depends on ARCH_MEDIATEK
> >  	depends on RESET_CONTROLLER
> >  	select REGMAP
> >  	help
> > @@ -22,7 +23,6 @@ config MTK_PMIC_WRAP
> >  
> >  config MTK_SCPSYS
> >  	bool "MediaTek SCPSYS Support"
> > -	depends on ARCH_MEDIATEK || COMPILE_TEST
> >  	default ARCH_MEDIATEK
> >  	select REGMAP
> >  	select MTK_INFRACFG
> > @@ -30,3 +30,5 @@ config MTK_SCPSYS
> >  	help
> >  	  Say yes here to add support for the MediaTek SCPSYS power domain
> >  	  driver.
> > +
> > +endmenu
> 
> While trying to test this, I found that I am not able to test-compile
> these drivers. The problem is in drivers/soc/Makefile:
> 
> obj-$(CONFIG_ARCH_MEDIATEK)     += mediatek/
> 
> So while Kconfig lets me select the drivers when COMPILE_TEST is
> enabled, the build system itself ignores the directory in which these
> drivers reside and they aren't built.
> 
> If you really want your drivers to be test-compilable then you must
> change the above to:
> 
> obj-y				+= mediatek/
> 
> I'll send a patch.
> 
> Your patch itself looks good to me.
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 

Thanks for catching up the problem and send out the patch.

I just also found and fixed in my local when I worked on the patch and
the COMPILE_TEST still can work fine on these drivers in my test.

	Sean
