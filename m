From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 21 Jun 2013 01:42:26 +0000
Subject: [RFC PATCH 2/4] watchdog: at91sam9_wdt: update device tree doc
In-Reply-To: <1370947890-954-3-git-send-email-b.brezillon@overkiz.com>
References: <1370947890-954-1-git-send-email-b.brezillon@overkiz.com>
 <1370947890-954-3-git-send-email-b.brezillon@overkiz.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641687DE052@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> On Behalf Of Boris BREZILLON
> Sent: 2013?6?11? 18:51
> To: Wim Van Sebroeck; Jean-Christophe Plagniol-Villard; Ferre, Nicolas
> Cc: linux-watchdog at vger.kernel.org; linux-doc at vger.kernel.org;
> devicetree-discuss at lists.ozlabs.org; linux-kernel at vger.kernel.org; Rob
> Herring; Boris BREZILLON; Rob Landley; Grant Likely;
> linux-arm-kernel at lists.infradead.org
> Subject: [RFC PATCH 2/4] watchdog: at91sam9_wdt: update device tree doc
> 
> Add new at91sam9 watchdog properties to the documentation.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>  .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30
> ++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> index fcdd48f..e043106 100644
> --- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> @@ -9,11 +9,37 @@ Required properties:
> 
>  Optional properties:
>  - timeout-sec: contains the watchdog timeout in seconds.
> +- interrupts : Should contain WDT interrupt.
> +- atmel,max-heartbeat-sec : Should contain the maximum heartbeat value in
> +	seconds. This value should be less than 16. It is used to compute the
> +	WDV field.
> +- atmel,max-heartbeat-sec : Should contain the minimum heartbeat value in
Typo, should be,
- atmel,min-heartbeat-sec
> +	seconds. This value should be less than 4 times the max-heartbeat-sec
> +	value. It is used to compute the WDD field.
> +- atmel,watchdog-type : Should be "hardware" or "software". Hardware
> watchdog
> +	use the at91 watchdog reset. Software watchdog use the watcdog
> interrup
> +	to trigger a software reset.
> +- atmel,reset-type : Should be "proc" or "all".
> +	"all" : assert peripherals and processor reset signals
> +	"proc" : assert the processor reset signal
> +	This is valid only when using "hardware" watchdog.
> +- atmel,disable : Should be present if you want to disable the watchdog.
> +- atmel,idle-halt : Should be present if you want to stop the watchdog when
> +	entering idle state.
> +- atmel,dbg-halt : Should be present if you want to stop the watchdog when
> +	entering debug state.
> 
>  Example:
> -
>  	watchdog at fffffd40 {
>  		compatible = "atmel,at91sam9260-wdt";
>  		reg = <0xfffffd40 0x10>;
> -		timeout-sec = <10>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +		timeout-sec = <15>;
> +		atmel,watchdog-type = "hardware";
> +		atmel,reset-type = "all";
> +		atmel,dbg-halt;
> +		atmel,idle-halt;
> +		atmel,max-heartbeat-sec = <16>;
> +		atmel,min-heartbeat-sec = <0>;
> +		status = "okay";
>  	};
> --
> 1.7.9.5
> 
> 
Best Regards,
Wenyou Yang
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
