From: slemieux.tyco@gmail.com (Sylvain Lemieux (gmail))
Date: Tue, 27 Sep 2016 08:34:18 -0400
Subject: [PATCH] ARM: dts: lpc32xx: add pwm-cells to base dts file
In-Reply-To: <aaf0fc9c-ea2f-0081-cf58-b5024e450030@mleia.com>
References: <1474915641-11209-1-git-send-email-slemieux.tyco@gmail.com>
 <aaf0fc9c-ea2f-0081-cf58-b5024e450030@mleia.com>
Message-ID: <1474979658.10588.18.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Tue, 2016-09-27 at 01:07 +0300, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 26.09.2016 21:47, Sylvain Lemieux wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> > 
> > There is no need to define the "pwm-cells" in the board
> > specific dts file; move the entry to the base dts file.
> > 
> > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > ---
> > Note:
> > * This patch should be apply after
> >   "ARM: dts: lpc32xx: set default parent clock for pwm1 & pwm2"
> >   http://www.spinics.net/lists/arm-kernel/msg530277.html
> >   - There is no dependency between the patches.
> > 
> >  arch/arm/boot/dts/lpc32xx.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
[...] 
> 
> that's something I have done locally and in a different manner, but I haven't
> published it yet, please find below a draft.
> 
> First of all from multiple places in the User's Manual you can find that there
> are "two single output PWM blocks" or "the LPC32x0 provides two 8-bit PWMs" etc.
> 
> In this case it does not make sense to set PWM cells to 2 (there is only one
> channel), and 1 cell for frequency is good enough, and that's the proposed
> change to support it:
> 
> diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
> index a9b3cff..447ae44 100644
> --- a/drivers/pwm/pwm-lpc32xx.c
> +++ b/drivers/pwm/pwm-lpc32xx.c
> @@ -99,6 +99,22 @@ static const struct pwm_ops lpc32xx_pwm_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static struct pwm_device *lpc32xx_pwm_of_xlate(struct pwm_chip *pc,
> +				       const struct of_phandle_args *args)
> +{
> +	struct pwm_device *pwm;
> +
> +	pwm = pwm_request_from_chip(pc, 0, NULL);
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	pwm->args.period = args->args[0];
> +
> +	return pwm;
> +}
> +
>  static int lpc32xx_pwm_probe(struct platform_device *pdev)
>  {
>  	struct lpc32xx_pwm_chip *lpc32xx;
> @@ -123,6 +139,8 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
>  	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
>  	lpc32xx->chip.npwm = 1;
>  	lpc32xx->chip.base = -1;
> +	lpc32xx->chip.of_xlate = lpc32xx_pwm_of_xlate;
> +	lpc32xx->chip.of_pwm_n_cells = 1;
>  
>  	ret = pwmchip_add(&lpc32xx->chip);
>  	if (ret < 0) {
> 
> 
> What is your opinion about this proposal?
> 
I agree with you, this clean-up make sense; the PWM cell should be 1.

> If this change is applied, then lpc32xx.dtsi should contain #pwm-cells = <1>.
> 
Can you submit your change on the mailing list?
I will send a version 2 of this patch after.

If it is helping, I can take care of submitting a patch
to update the documentation (lpc32xx-pwm.txt).

Did you have a change to look at the 2 others PWM related change:
* clk: lpc32xx: fix pwm clock divider computation
  http://www.spinics.net/lists/arm-kernel/msg534048.html
* ARM: dts: lpc32xx: set pwm1 & pwm2 default clock rate
  http://www.spinics.net/lists/arm-kernel/msg534051.html
 
> --
> With best wishes,
> Vladimir

Sylvain
