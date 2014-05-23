From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 12:19:34 +0200
Subject: [PATCH] pinctrl: sunxi: Enable the pinctrl Kconfig options by
 default
In-Reply-To: <CACRpkdb2gzpftp3PWkr40v1CZm2J=SmnY9Mb=5S-AJr+YXgkNg@mail.gmail.com>
References: <1399994597-15177-1-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdb2gzpftp3PWkr40v1CZm2J=SmnY9Mb=5S-AJr+YXgkNg@mail.gmail.com>
Message-ID: <201405231219.35061.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 May 2014, Linus Walleij wrote:
> On Tue, May 13, 2014 at 5:23 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > Enable the freshly introduced Kconfig options whenever their matching
> > architecture is enabled.
> >
> > Since the Kconfig symbols for these machines are going through a different
> > tree, keep PINCTRL_SUNXI around for the moment to avoid breaking the defconfig.
> > It should be removed eventually.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> OK patch applied.


I stumbled over this build error now:

/git/arm-soc/drivers/phy/phy-sun4i-usb.c: In function 'sun4i_usb_phy_probe':
/git/arm-soc/drivers/phy/phy-sun4i-usb.c:282:3: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]
   phy->reset = devm_reset_control_get(dev, name);
   ^
/git/arm-soc/drivers/phy/phy-sun4i-usb.c:282:14: warning: assignment makes pointer from integer without a cast [enabled by default]
   phy->reset = devm_reset_control_get(dev, name);
              ^
cc1: some warnings being treated as errors
make[4]: *** [drivers/phy/phy-sun4i-usb.o] Error 1
/git/arm-soc/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c: In function 'sun6i_a31_r_pinctrl_probe':
/git/arm-soc/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c:103:2: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]
  rstc = devm_reset_control_get(&pdev->dev, NULL);
  ^
/git/arm-soc/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c:103:7: warning: assignment makes pointer from integer without a cast [enabled by default]
  rstc = devm_reset_control_get(&pdev->dev, NULL);
       ^
cc1: some warnings being treated as errors


It seems both the phy and the pinctrl driver actually depend on the
reset controller framework, but this is not reflected in Kconfig.

I guess these should either use devm_reset_control_get_optional
or have 'depends on RESET_CONTROLLER' in Kconfig.

	Arnd
