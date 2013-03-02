From: zonque@gmail.com (Daniel Mack)
Date: Sat, 02 Mar 2013 15:09:47 +0100
Subject: Question about fixed-clock
In-Reply-To: <5123B719.2080300@gmail.com>
References: <5122BF88.1050007@gmail.com>
 <CAOMZO5BXVX8=QOV4+tN_w27ztSVkHAnOG2ifbS_Jpd=-cPnAdw@mail.gmail.com>
 <51234B8E.2000504@gmail.com> <20130219172246.11471.14635@quantum>
 <5123B719.2080300@gmail.com>
Message-ID: <5132082B.3030409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi eyerone,

On 19.02.2013 18:32, Daniel Mack wrote:
> On 19.02.2013 18:22, Mike Turquette wrote:
>> > Quoting Daniel Mack (2013-02-19 01:53:18)
>>> >> Hi Fabio,
>>> >> Hi Afzal,
>>> >>
>>> >> On 19.02.2013 02:33, Fabio Estevam wrote:
>>>> >>> On Mon, Feb 18, 2013 at 8:55 PM, Daniel Mack <zonque@gmail.com> wrote:
>>>>> >>>> Hi,
>>>>> >>>>
>>>>> >>>> This might be a stupid question, but I'm somehow stuck here. I'm using a
>>>>> >>>> driver with the following DTS sub-node:
>>>>> >>>>
>>>>> >>>>         ref25: ref25M {
>>>>> >>>>                 compatible = "fixed-clock";
>>>>> >>>>                 #clock-cells = <0>;
>>>>> >>>>                 clock-frequency = <25000000>;
>>>>> >>>>         };
>>>>> >>>>
>>>>> >>>>         clock-generator at 0 {
>>>>> >>>>                                 /* ... */
>>>>> >>>>                                 #clock-cells = <1>;
>>>>> >>>>                                 clocks = <&ref25>;
>>>>> >>>>         }
>>>>> >>>>
>>>>> >>>> The device driver for clock-generator uses something like the following
>>>>> >>>> call to get its clock:
>>>>> >>>>
>>>>> >>>>         clk = of_clk_get(np, 0);
>>>>> >>>>
>>>>> >>>> but the return value is ERR_PTR(-ENOENT) and I also can't find this
>>>>> >>>> clock in the clk debugfs tree.
>>>>> >>>>
>>>>> >>>> This is on a OMAP/AM33xx device with kernel 3.8-rc7 plus the -next tips
>>>>> >>>> of arm-soc and omap, but with no other special clock options selected in
>>>>> >>>> the config. Is there anything I'm missing to correctly instantiate the
>>>>> >>>> dummy clock?
>>>> >>>
>>>> >>> Have you registered it with clk_register_fixed_rate() ?
>>>> >>>
>>>> >>> In imx we use imx_clk_fixed, which in turns call  clk_register_fixed_rate().
>>>> >>>
>>>> >>> Take a look at arch/arm/mach-imx/clk-imx51-imx53.c for a reference.
>>> >>
>>> >> Hmm no, I didn't do anything else than adding it to the DT in the first
>>> >> place, hoping that a driver will pick it up and add the clock for me.
>>> >> But it turns out that of_clk_init() is not called at all on my platform.
>>> >>
>>> >> I'm doing this now from omap_generic_init() and it works. If that's an
>>> >> appropriate place to call it, I can provide a patch.
>>> >>
>> > 
>> > You can provide a patch, but your example above is for a dummy clock,
>> > correct?
> No, it's a real clock with a fixed frequency on the board, which feeds
> another clock chip. I thought this is what fixed-clock is for, just like
> what a fixed-regulator does? Or how would you describe such a thing in
> DT, in order to use it as input to another device?
> 
>> > It would be best to post your patch along with a real-world
>> > use for calling of_clk_init().
> Not sure what you mean exactly, but the patch is attached. However, I
> still think I lack some understanding here - the fact that compatible
> strings have to be passed explicitly from generic code feels wrong.
> 
> 
> Thanks,
> Daniel
> 
> 
> 0001-ARM-OMAP-generic-add-call-to-of_clk_init.patch
> 
> 
> From 850120371830ffb5e2146aeb2d21c724d6ded09e Mon Sep 17 00:00:00 2001
> From: Daniel Mack <zonque@gmail.com>
> Date: Tue, 19 Feb 2013 12:05:25 +0100
> Subject: [PATCH] ARM: OMAP: generic: add call to of_clk_init()
> 
> This is needed to instanciate fixed clocks in the DT.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-omap2/board-generic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 0274ff7..3580f16 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/irqdomain.h>
> +#include <linux/clk-provider.h>
>  
>  #include <asm/mach/arch.h>
>  
> @@ -35,6 +36,11 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
>  	{ }
>  };
>  
> +static const __initconst struct of_device_id clk_match[] = {
> +	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
> +	{}
> +};
> +
>  static void __init omap_generic_init(void)
>  {
>  	omap_sdrc_init(NULL, NULL);
> @@ -49,6 +55,7 @@ static void __init omap_generic_init(void)
>  		omap4_panda_display_init_of();
>  	else if (of_machine_is_compatible("ti,omap4-sdp"))
>  		omap_4430sdp_display_init_of();
> +	of_clk_init(clk_match);
>  }
>  
>  #ifdef CONFIG_SOC_OMAP2420

Any opinion about this approach?


Thanks,
Daniel
