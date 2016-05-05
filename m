From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 5 May 2016 15:31:03 -0400
Subject: [RFC v2 07/13] power: pwrseq: simple: Add support for toggling
 regulator
In-Reply-To: <1462451666-17945-8-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-8-git-send-email-k.kozlowski@samsung.com>
Message-ID: <d27c30c1-f205-973e-71f1-f5b410418d04@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
> Some devices need real hard-reset by cutting the power.  During power
> sequence turn off and on the regulator, if it is provided.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

[snip]

>  
>  #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
> @@ -62,6 +65,13 @@ static void mmc_pwrseq_simple_post_power_on(struct pwrseq *_pwrseq)
>  {
>  	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
>  
> +	if (pwrseq->ext_reg) {
> +		int err;
> +
> +		err = regulator_enable(pwrseq->ext_reg);
> +		WARN_ON_ONCE(err);
> +	}
> +

Shouldn't this be in mmc_pwrseq_simple_pre_power_on() instead?

For example, a chip may need to be powered on before attempting to
toggle its reset or power pins using some GPIO lines.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
