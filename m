From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 22 Sep 2011 13:30:13 +0300
Subject: [PATCH] ARM: pxa/cm-x300: properly set bt_reset pin
In-Reply-To: <1316268934.16763.2.camel@phoenix>
References: <1316268934.16763.2.camel@phoenix>
Message-ID: <4E7B0E35.5010607@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On 09/17/11 17:15, Axel Lin wrote:
> Fix below build warning and properly set bt_reset pin.
> 
>   CC      arch/arm/mach-pxa/cm-x300.o
> arch/arm/mach-pxa/cm-x300.c: In function 'cm_x300_init_wi2wi':
> arch/arm/mach-pxa/cm-x300.c:779: warning: unused variable 'wlan_en'
> arch/arm/mach-pxa/cm-x300.c:795: warning: 'bt_reset' may be used uninitialized in this function

What a shame...
My patch 5a009df1f200efa49658b0e9c7ad056d59fbefe4
(ARM: pxa/cm-x300: GPIO cleanup) was f*cked up, sorry...
I should have not send it in a rush and I admit,
I had no possibility to test it. Sorry again...

> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Thanks for spotting this.

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Also, this patch fixes a real regression since
5a009df1f200efa49658b0e9c7ad056d59fbefe4 (ARM: pxa/cm-x300: GPIO cleanup)
- Wifi and Bluetooth do not work without it, so please:

Cc: <stable@kernel.org> [3.0.x]

> ---
>  arch/arm/mach-pxa/cm-x300.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index 0f00e01..0e18eb9 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -776,7 +776,6 @@ static struct gpio cm_x300_wi2wi_gpios[] __initdata = {
>  
>  static void __init cm_x300_init_wi2wi(void)
>  {
> -	int bt_reset, wlan_en;
>  	int err;
>  
>  	if (system_rev < 130) {
> @@ -792,12 +791,11 @@ static void __init cm_x300_init_wi2wi(void)
>  	}
>  
>  	udelay(10);
> -	gpio_set_value(bt_reset, 0);
> +	gpio_set_value(cm_x300_wi2wi_gpios[1].gpio, 0);
>  	udelay(10);
> -	gpio_set_value(bt_reset, 1);
> +	gpio_set_value(cm_x300_wi2wi_gpios[1].gpio, 1);
>  
> -	gpio_free(wlan_en);
> -	gpio_free(bt_reset);
> +	gpio_free_array(ARRAY_AND_SIZE(cm_x300_wi2wi_gpios));
>  }
>  
>  /* MFP */

-- 
Regards,
Igor.
