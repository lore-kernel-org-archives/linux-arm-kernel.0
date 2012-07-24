From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 24 Jul 2012 15:11:16 +0400
Subject: [PATCH 2/6] ARM: davinci: remove rtc kicker release
In-Reply-To: <f9e348c8cb7402b27b1a5633b06620266e369641.1343046707.git.afzal@ti.com>
References: <cover.1343046707.git.afzal@ti.com>
 <f9e348c8cb7402b27b1a5633b06620266e369641.1343046707.git.afzal@ti.com>
Message-ID: <500E82D4.9090702@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-07-2012 17:42, Afzal Mohammed wrote:

> rtc-omap driver is now capable of handling kicker mechanism,
> hence remove kicker handling at platform level, instead
> provide proper device name so that driver can handle kicker
> mechanism by itself

> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>   arch/arm/mach-davinci/devices-da8xx.c |   13 +------------
>   1 files changed, 1 insertions(+), 12 deletions(-)

> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index d1624a3..c915bff 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -679,7 +679,7 @@ static struct resource da8xx_rtc_resources[] = {
>   };
>
>   static struct platform_device da8xx_rtc_device = {
> -	.name           = "omap_rtc",
> +	.name           = "am1808-rtc",

    Why not "da8xx-rtc". Kick registers exist startting with 
DA830/OMAP-L137/AM1707, not only on AM1808.

>   	.id             = -1,
>   	.num_resources	= ARRAY_SIZE(da8xx_rtc_resources),
>   	.resource	= da8xx_rtc_resources,
> @@ -688,17 +688,6 @@ static struct platform_device da8xx_rtc_device = {
>   int da8xx_register_rtc(void)
>   {
>   	int ret;
> -	void __iomem *base;
> -
> -	base = ioremap(DA8XX_RTC_BASE, SZ_4K);
> -	if (WARN_ON(!base))
> -		return -ENOMEM;
> -
> -	/* Unlock the rtc's registers */
> -	__raw_writel(0x83e70b13, base + 0x6c);
> -	__raw_writel(0x95a4f1e0, base + 0x70);
> -
> -	iounmap(base);
>
>   	ret = platform_device_register(&da8xx_rtc_device);
>   	if (!ret)

WBR, Sergei
