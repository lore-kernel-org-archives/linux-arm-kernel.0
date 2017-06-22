From: zhi.mao@mediatek.com (Zhi Mao)
Date: Thu, 22 Jun 2017 20:48:07 +0800
Subject: [PATCH RESEND 2/4] pwm: mediatek: fix clk issue
In-Reply-To: <046facdc-b558-146a-dcfd-0ed98bfeb517@phrozen.org>
References: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
 <1498032672-7172-3-git-send-email-zhi.mao@mediatek.com>
 <046facdc-b558-146a-dcfd-0ed98bfeb517@phrozen.org>
Message-ID: <1498135687.18841.29.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-06-21 at 20:07 +0800, John Crispin wrote:
> Hi
> 
> comments inline
> 
> 
> > +static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{

> > +	ret = clk_prepare_enable(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> > +	if (ret < 0) {
> > +		clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
> > +		clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
> > +		return ret;
> > +	}
> > +
> Rather than disabling the already prepared clks in each error path and 
> then returning, you should use goto err_clk_{top,main,pwm1} in the same 
> style as what this patch removes from mtk_pwm_probe()
> 
> > +	return ret;
> > +}

> >   static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
> >   				unsigned int offset)
> >   {

> > @@ -91,10 +128,12 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >   	if (clkdiv > 7)
> >   		return -EINVAL;
> >   
> > -	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
> > +	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> 
> this chunk needs to go into its own patch
> 

> >   
> > @@ -102,11 +141,8 @@ static int mtk_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >   {
> >   
> > -	ret = clk_prepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> > -	if (ret < 0)
> > -		return ret;
> > +	mtk_pwm_clk_enable(chip, pwm);
> You need to check the error code here and return if clk enabling failed
> 

<....>
Hi John,
For these above comments, I will modified as your suggestions in the
next release.

> > 
> >   
> >   static int mtk_pwm_remove(struct platform_device *pdev)
> >   {
> >   	struct mtk_pwm_chip *pc = platform_get_drvdata(pdev);
> > -	unsigned int i;
> > -
> > -	for (i = 0; i < pc->chip.npwm; i++)
> > -		pwm_disable(&pc->chip.pwms[i]);
> why are you removing this chunk ?
> 
>      John
> 

After refering to some other vendor's pwm driver, we think the
"pwm_disable" is no need, and framework control flow should disable all
the pwms before removing them,
so we remove it.

Regards,
Zhi

> >   
> >   	return pwmchip_remove(&pc->chip);
> >   }
> 
