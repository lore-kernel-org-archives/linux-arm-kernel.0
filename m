From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 May 2014 20:45:26 +0200
Subject: [PATCH] pinctrl: sunxi: Enable the pinctrl Kconfig options by
 default
In-Reply-To: <201405231219.35061.arnd@arndb.de>
References: <1399994597-15177-1-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdb2gzpftp3PWkr40v1CZm2J=SmnY9Mb=5S-AJr+YXgkNg@mail.gmail.com>
 <201405231219.35061.arnd@arndb.de>
Message-ID: <20140523184526.GD10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, May 23, 2014 at 12:19:34PM +0200, Arnd Bergmann wrote:
> I stumbled over this build error now:
> 
> /git/arm-soc/drivers/phy/phy-sun4i-usb.c: In function 'sun4i_usb_phy_probe':
> /git/arm-soc/drivers/phy/phy-sun4i-usb.c:282:3: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]
>    phy->reset = devm_reset_control_get(dev, name);
>    ^
> /git/arm-soc/drivers/phy/phy-sun4i-usb.c:282:14: warning: assignment makes pointer from integer without a cast [enabled by default]
>    phy->reset = devm_reset_control_get(dev, name);
>               ^
> cc1: some warnings being treated as errors
> make[4]: *** [drivers/phy/phy-sun4i-usb.o] Error 1
> /git/arm-soc/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c: In function 'sun6i_a31_r_pinctrl_probe':
> /git/arm-soc/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c:103:2: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]
>   rstc = devm_reset_control_get(&pdev->dev, NULL);
>   ^
> /git/arm-soc/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c:103:7: warning: assignment makes pointer from integer without a cast [enabled by default]
>   rstc = devm_reset_control_get(&pdev->dev, NULL);
>        ^
> cc1: some warnings being treated as errors

Grrrr :(

> It seems both the phy and the pinctrl driver actually depend on the
> reset controller framework, but this is not reflected in Kconfig.
> 
> I guess these should either use devm_reset_control_get_optional
> or have 'depends on RESET_CONTROLLER' in Kconfig.

Yeah, we should have a depends on.

I'll send some patches.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/7573f8fb/attachment.sig>
