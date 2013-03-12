From: robherring2@gmail.com (Rob Herring)
Date: Tue, 12 Mar 2013 14:15:09 -0500
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <513F7EBD.80207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 12:08 PM, Haojian Zhuang wrote:
> Remove all code to parse sp804 in integrator platform driver. Use
> clocksource_of_init() instead since these code are implemented in sp804
> driver already.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/boot/dts/integrator.dtsi        |    3 +++
>  arch/arm/boot/dts/integratorap.dts       |   15 +++++------
>  arch/arm/boot/dts/integratorcp.dts       |    9 +++----
>  arch/arm/mach-integrator/Kconfig         |    3 +++
>  arch/arm/mach-integrator/integrator_ap.c |   41 +-----------------------------
>  arch/arm/mach-integrator/integrator_cp.c |   35 ++-----------------------
>  6 files changed, 20 insertions(+), 86 deletions(-)


> diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
> index c9c3fa3..70e321c 100644
> --- a/arch/arm/boot/dts/integratorap.dts
> +++ b/arch/arm/boot/dts/integratorap.dts
> @@ -9,11 +9,6 @@
>  	model = "ARM Integrator/AP";
>  	compatible = "arm,integrator-ap";
>  
> -	aliases {
> -		arm,timer-primary = &timer2;
> -		arm,timer-secondary = &timer1;
> -	};
> -
>  	chosen {
>  		bootargs = "root=/dev/ram0 console=ttyAM0,38400n8 earlyprintk";
>  	};
> @@ -24,15 +19,19 @@
>  	};
>  
>  	timer0: timer at 13000000 {
> -		compatible = "arm,integrator-timer";
> +		compatible = "arm,sp804", "arm,primecell";

You are breaking existing dtb's changing this, but this is wrong for
other reasons. The integrator does not have an SP804. It is the same
programming model, but is a single timer and not the dual timer. So
having a different compatible string is the correct way. I doubt it has
the primecell ID registers which is what "arm,primecell" indicates.

>  	};
>  
>  	timer1: timer at 13000100 {
> -		compatible = "arm,integrator-timer";
> +		compatible = "arm,sp804", "arm,primecell";
> +		arm,sp804-clockevent = <0>;

I don't like this nor the old way with aliases. We should describe the
h/w features of the timer to determine what to use it for. AFAICT, all 3
timers are identical on integrator and it does not matter which one
Linux picks for clocksource vs. clockevent.

Rob
