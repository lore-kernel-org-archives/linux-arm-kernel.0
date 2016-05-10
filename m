From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 10 May 2016 10:23:45 +0900
Subject: [PATCH v6 5/9] extcon: max8997: Fix handling error code of
 regmap_irq_get_virq()
In-Reply-To: <1462519636-3250-4-git-send-email-k.kozlowski@samsung.com>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <57313821.4050309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2016? 05? 06? 16:27, Krzysztof Kozlowski wrote:
> The regmap_irq_get_virq() can return negative ERRNO, so its result
> should not be stored in unsigned int because error would be ignored.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index 68754ac2c8ea..0afa3e8b5dc3 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -660,11 +660,11 @@ static int max8997_muic_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
>  		struct max8997_muic_irq *muic_irq = &muic_irqs[i];
> -		unsigned int virq = 0;
> +		int virq = 0;
>  
>  		virq = regmap_irq_get_virq(max8997->irq_data_muic,
>  					muic_irq->irq);
> -		if (!virq) {
> +		if (virq <= 0) {
>  			ret = -EINVAL;
>  			goto err_irq;
>  		}
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
