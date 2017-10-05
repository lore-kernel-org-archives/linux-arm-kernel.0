From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 5 Oct 2017 14:33:56 +0800
Subject: [PATCH] soc: mediatek: turn MTK_PMIC_WRAP into visible symbols
In-Reply-To: <CAK8P3a3WPPQrLL0r2FSBms-9UxFFQTkBs7kBaCQRkqX5Ohv36g@mail.gmail.com>
References: <6c1696cf9f860cc8151a906ecbc799121b5aeeab.1505984256.git.sean.wang@mediatek.com>
 <20170926080022.215f7b7b@endymion>
 <CAK8P3a3WPPQrLL0r2FSBms-9UxFFQTkBs7kBaCQRkqX5Ohv36g@mail.gmail.com>
Message-ID: <1507185236.21840.3.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-10-02 at 13:21 +0200, Arnd Bergmann wrote:
> On Tue, Sep 26, 2017 at 8:00 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > On Thu, 21 Sep 2017 17:01:05 +0800, sean.wang at mediatek.com wrote:
> >> From: Sean Wang <sean.wang@mediatek.com>
> >>
> >> MTK_PMIC_WRAP is the basic and required configuration for those various
> >> MediaTek PMICs, so turning MTK_PMIC_WRAP into visible symbols easily
> >> allows users tending to have the enablement for those PMICs.
> >
> > I can't really make sense of the sentence above, sorry, and can't see
> > how it matches the change below anyway. MTK_PMIC_WRAP is already a
> > visible symbol before this change. The change is probably good in
> > itself, but please try to come up with a better description.
> >
> >> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >> ---
> >>  drivers/soc/mediatek/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> >> index a2fcd7f..d513629 100644
> >> --- a/drivers/soc/mediatek/Kconfig
> >> +++ b/drivers/soc/mediatek/Kconfig
> >> @@ -15,7 +15,7 @@ config MTK_INFRACFG
> >>  config MTK_PMIC_WRAP
> >>       tristate "MediaTek PMIC Wrapper Support"
> >>       depends on ARCH_MEDIATEK
> >> -     depends on RESET_CONTROLLER
> >> +     select RESET_CONTROLLER
> >>       select REGMAP
> 
> Your other patch now removes the ARCH_MEDIATEK dependency
> and allows enabling the driver for COMPILE_TEST on architectures
> that might not have ARCH_HAS_RESET_CONTROLLER set,
> so you cannot 'select' the symbol in general.
> 
> I think a better solution is to leave the 'depends on
> RESET_CONTROLLER' present here, but instead add
> 'select RESET_CONTROLLER' to the ARCH_MEDIATEK
> definition.
> 
> Generally speaking, we don't want to mix 'select' and 'depends on'
> statements for the same symbol, but if we do, it should be done
> consistently in a very clear hierarchy. In case of RESET_CONTROLLER,
> the rule seems to be to 'select' it from architectures and platforms,
> while using 'depends on' from device drivers that absolutely require it.
> 
> Note that for compile-testing, it should be fine to rely on the fallback
> definitions in include/linux/reset.h, so you might be able to just
> remove the 'depends on' statement completely.
> 
> In any case, please try to be clearer about what the patch
> actually tries to achieve. Did you run into a build error without
> it? If so, please copy the exact build error message into the
> patch description.
> 
>       Arnd

Thanks for your both suggestions and idea

No any compile error is present prior to the patch.

In the initial thought, I simply would like to allow the configuration
item able to be visible in menuconfig without visiting all dependencies
for it, especially for those SoC-required drivers when the corresponding
architecture target is already picked up.

I prefer to the better solution leaving 'depends on RESET_CONTROLLER'
present here, and add additional 'select ARCH_RESET_CONTROLLER' to the
ARCH_MEDIATEK definition, which could reach the goal initially I'd try
to. So I will update them in this way in the next version, including a
better description of the patch.

	Sean 
