From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 8 Mar 2012 17:51:53 +0100
Subject: [PATCH 5/6] ARM: at91: add ram controller DT support
In-Reply-To: <4F58CF29.6020906@gmail.com>
References: <20120302192844.GB21255@game.jcrosoft.org>
 <1330718048-9314-5-git-send-email-plagnioj@jcrosoft.com>
 <4F57BDCE.1050708@gmail.com>
 <20120308061324.GE27213@game.jcrosoft.org>
 <4F58BE4F.5080009@gmail.com>
 <20120308141000.GF27213@game.jcrosoft.org>
 <4F58CF29.6020906@gmail.com>
Message-ID: <20120308165153.GH27213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:24 Thu 08 Mar     , Rob Herring wrote:
> On 03/08/2012 08:10 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 08:12 Thu 08 Mar     , Rob Herring wrote:
> >> On 03/08/2012 12:13 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>>> diff --git a/arch/arm/mach-at91/include/mach/at91sam9x5.h b/arch/arm/mach-at91/include/mach/at91sam9x5.h
> >>>>> index a297a77..88e43d5 100644
> >>>>> --- a/arch/arm/mach-at91/include/mach/at91sam9x5.h
> >>>>> +++ b/arch/arm/mach-at91/include/mach/at91sam9x5.h
> >>>>> @@ -55,11 +55,6 @@
> >>>>>  #define AT91SAM9X5_BASE_USART2	0xf8024000
> >>>>>  
> >>>>>  /*
> >>>>> - * System Peripherals
> >>>>> - */
> >>>>> -#define AT91SAM9X5_BASE_DDRSDRC0	0xffffe800
> >>>>> -
> >>>>> -/*
> >>>>>   * Base addresses for early serial code (uncompress.h)
> >>>>>   */
> >>>>>  #define AT91_DBGU	AT91_BASE_DBGU0
> >>>>> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> >>>>> index 3e48b59..f86450d 100644
> >>>>> --- a/arch/arm/mach-at91/setup.c
> >>>>> +++ b/arch/arm/mach-at91/setup.c
> >>>>> @@ -315,12 +315,33 @@ static void at91_dt_rstc(void)
> >>>>>  	of_node_put(np);
> >>>>>  }
> >>>>>  
> >>>>> +static struct of_device_id ramc_ids[] = {
> >>>>> +	{ .compatible = "atmel,at91sam9260-sdramc" },
> >>>>> +	{ .compatible = "atmel,at91sam9g45-ddramc" },
> >>>>> +	{ /*sentinel*/ }
> >>>>> +};
> >>>>> +
> >>>>> +static void at91_dt_ramc(void)
> >>>>> +{
> >>>>> +	struct device_node *np;
> >>>>> +
> >>>>> +	np = of_find_matching_node(NULL, ramc_ids);
> >>>>> +	if (!np)
> >>>>> +		panic("unable to find compatible ram conroller node in dtb\n");
> >>>>
> >>>> You really can't boot if this fails? A WARN is better if it allows you
> >>>> to boot until at least your console is actually up.
> >>> if the restart is called you will have a oops so no it's a basic mandatory
> >>> device on at91
> >>>
> >>
> >> But you may never see the panic message because your console is not up.
> >> If you WARN and can continue to boot, then the user can see the problem
> >> and fix it. Otherwise you get nothing and have to go rebuild and turn on
> >> earlyprintk.
> > yeah agreed but if the restart id use before the console is enable you will
> > have the same issue. the ramc controller are basic device so people usally
> > don't touch it except you add a SoC support.
> > 
> > so I prefer to panic
> > 
> 
> Then panic in the restart code if it doesn't have something it needs.
The code is in assembly (mandatory) so difficult

The warn on other missing binding agreed but here please let go
It's basic device that except the maintainer will never touch

People will just include the dtsi and if you really need to debug soc init
enable earlyprintk is fine

Best Regards,
J.
