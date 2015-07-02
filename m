From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 2 Jul 2015 15:01:41 +0200
Subject: [RFC PATCH 16/15] pwm: add informations about polarity, duty
 cycle and period to debugfs
In-Reply-To: <3365087.n2eEES60JK@diego>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <3365087.n2eEES60JK@diego>
Message-ID: <20150702150141.5018a791@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Jul 2015 23:50:46 +0200
Heiko St?bner <heiko@sntech.de> wrote:

> The pwm-states make it possible to also output the polarity, duty cycle
> and period information in the debugfs pwm summary-outout.
> This makes it easier to gather overview information about pwms without
> needing to walk through the sysfs attributes of every pwm.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> might be nice to have too ;-)

Yes.

> 
>  drivers/pwm/core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 6dafd8e..79037a2 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -951,9 +951,18 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
>  		if (test_bit(PWMF_REQUESTED, &pwm->flags))
>  			seq_puts(s, " requested");
>  
> -		if (pwm_is_enabled(pwm))
> +		if (pwm_is_enabled(pwm)) {
>  			seq_puts(s, " enabled");
>  
> +			seq_printf(s, " period:%uns",
> +				   pwm_get_period(pwm));
> +			seq_printf(s, " duty:%uns",
> +				   pwm_get_duty_cycle(pwm));
> +			seq_printf(s, " polarity:%s",
> +				   pwm_get_polarity(pwm) ? "inverse"
> +							 : "normal");

I would print those values even if the PWM is not enabled.



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
