From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 May 2015 09:55:37 +0200
Subject: [PATCH v2 04/10] pinctrl: sunxi: Prepare for building SoC
 specific drivers as modules
In-Reply-To: <5559B1AF.2010200@gmail.com>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
 <1431707940-19372-5-git-send-email-jenskuske@gmail.com>
 <20150517141922.GE4004@lukather> <5559B1AF.2010200@gmail.com>
Message-ID: <20150519075537.GU4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:32:31AM +0200, Jens Kuske wrote:
> Hi,
> 
> On 05/17/15 16:19, Maxime Ripard wrote:
> > On Fri, May 15, 2015 at 06:38:54PM +0200, Jens Kuske wrote:
> >> Add a remove function and export the init and remove function
> >> to allow us to build the SoC specific drivers as modules.
> >>
> >> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> >> ---
> >>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 25 +++++++++++++++++++------
> >>  drivers/pinctrl/sunxi/pinctrl-sunxi.h |  2 ++
> >>  2 files changed, 21 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> index f8e171b..4ef6b3d 100644
> >> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> >> @@ -856,7 +856,6 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
> >>  	struct sunxi_pinctrl *pctl;
> >>  	struct resource *res;
> >>  	int i, ret, last_pin;
> >> -	struct clk *clk;
> >>  
> >>  	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
> >>  	if (!pctl)
> >> @@ -954,13 +953,13 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
> >>  			goto gpiochip_error;
> >>  	}
> >>  
> >> -	clk = devm_clk_get(&pdev->dev, NULL);
> >> -	if (IS_ERR(clk)) {
> >> -		ret = PTR_ERR(clk);
> >> +	pctl->clk = devm_clk_get(&pdev->dev, NULL);
> >> +	if (IS_ERR(pctl->clk)) {
> >> +		ret = PTR_ERR(pctl->clk);
> >>  		goto gpiochip_error;
> >>  	}
> >>  
> >> -	ret = clk_prepare_enable(clk);
> >> +	ret = clk_prepare_enable(pctl->clk);
> >>  	if (ret)
> >>  		goto gpiochip_error;
> >>  
> >> @@ -1015,10 +1014,24 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
> >>  	return 0;
> >>  
> >>  clk_error:
> >> -	clk_disable_unprepare(clk);
> >> +	clk_disable_unprepare(pctl->clk);
> >>  gpiochip_error:
> >>  	gpiochip_remove(pctl->chip);
> >>  pinctrl_error:
> >>  	pinctrl_unregister(pctl->pctl_dev);
> >>  	return ret;
> >>  }
> >> +EXPORT_SYMBOL(sunxi_pinctrl_init);
> >> +
> >> +int sunxi_pinctrl_remove(struct platform_device *pdev)
> >> +{
> >> +	struct sunxi_pinctrl *pctl = platform_get_drvdata(pdev);
> >> +
> >> +	gpiochip_remove(pctl->chip);
> >> +	pinctrl_unregister(pctl->pctl_dev);
> >> +
> >> +	clk_disable_unprepare(pctl->clk);
> > 
> > We should also remove the domain and the interrupt mapping here.
> 
> Ouch, I missed that. Only looked at the *_error: labels.
> 
> Apart from that, currently the kernel panics some seconds after removing
> the pinctrl module because mmc wants to access a gpio. Can this be
> prevented somehow? I think pinctrl must not be removed once other
> devices use any pin-related things.

pinctrl_unregister doesn't look like it cares about whether or not
there's users left in the system.

Maybe the easiest path would be to just make this builtin like Paul
suggested then ... :/

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150519/467ad013/attachment.sig>
