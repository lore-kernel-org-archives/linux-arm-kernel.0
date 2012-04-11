From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Apr 2012 20:38:18 +0800
Subject: [PATCH v6 04/17] pwm: Add table-based lookup for static mappings
In-Reply-To: <1334070400-25013-5-git-send-email-thierry.reding@avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <1334070400-25013-5-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120411123815.GB2445@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 05:06:27PM +0200, Thierry Reding wrote:
> In order to get rid of the global namespace for PWM devices, this commit
> provides an alternative method, similar to that of the regulator or
> clock frameworks, for registering a static mapping for PWM devices. This
> works by providing a table with a provider/consumer map in the board
> setup code.
> 
> With the new pwm_get() and pwm_put() functions available, usage of
> pwm_request() and pwm_free() becomes deprecated.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
...
> diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
> index 48f598a..bb3d2f9 100644
> --- a/Documentation/pwm.txt
> +++ b/Documentation/pwm.txt
> @@ -12,14 +12,33 @@ this kind of flexibility the generic PWM API exists.
>  Identifying PWMs
>  ----------------
>  
> -Users of the legacy PWM API use unique IDs to refer to PWM devices. One
> -goal of the new PWM framework is to get rid of this global namespace.
> +Users of the legacy PWM API use unique IDs to refer to PWM devices.
> +
> +Instead of referring to a PWM device via its unique ID, board setup code
> +should instead register a static mapping that can be used to match PWM
> +consumers to providers, as given in the following example:
> +
> +	static struct pwm_lookup board_pwm_lookup[] = {
> +		PWM_LOOKUP("tegra-pwm", 0, "pwm-backlight"),

PWM_LOOKUP takes 4 parameters now.  Other than that,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

> +	};
> +
> +	static void __init board_init(void)
> +	{
> +		...
> +		pwm_add_table(board_pwm_lookup, ARRAY_SIZE(board_pwm_lookup));
> +		...
> +	}
