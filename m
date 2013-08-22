From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 22 Aug 2013 11:43:12 -0700
Subject: [PATCH] irqchip: gic: Don't complain in gic_get_cpumask() if
 UP system
In-Reply-To: <51E7236D.3010700@codeaurora.org>
References: <1373067573-29946-1-git-send-email-sboyd@codeaurora.org>
 <20130712111322.GC3213@e102654-lin.cambridge.arm.com>
 <20130712121023.GB27430@codeaurora.org>
 <51E71249.4050200@codeaurora.org>
 <alpine.LFD.2.03.1307171830170.14924@syhkavp.arg>
 <51E71C78.6080604@codeaurora.org>
 <alpine.LFD.2.03.1307171849180.14924@syhkavp.arg>
 <51E7236D.3010700@codeaurora.org>
Message-ID: <20130822184312.GE23960@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17, Stephen Boyd wrote:
> On 07/17/13 15:53, Nicolas Pitre wrote:
> > On Wed, 17 Jul 2013, Stephen Boyd wrote:
> >
> >> On 07/17/13 15:34, Nicolas Pitre wrote:
> >>> On Wed, 17 Jul 2013, Stephen Boyd wrote:
> >>>
> >>>> On 07/12/13 05:10, Stephen Boyd wrote:
> >>>>> On 07/12, Javi Merino wrote:
> >>>>>> I agree, we should drop the check.  It's annoying in uniprocessors and
> >>>>>> unlikely to be found in the real world unless your gic entry in the dt
> >>>>>> is wrong.
> >>> And that's a likely outcome in the real world.
> >>>
> >>>>> Ok. How about this?
> >>>> Any comments?
> >>> What about this instead:
> >> Unfortunately arm64 doesn't have SMP_ON_UP. 
> > And why does that matter?
> 
> Because the gic driver is compiled on both arm and arm64? I suppose we
> could define is_smp() to 1 on arm64 but its probably better to rely on
> generic kernel things instead of arch specific functions.
> 
> >
> >> It sounds like you preferred the first patch using num_possible_cpus()
> > Probably, yes.  I didn't follow the early conversation though.
> 
> This was the first patch:
> 
> ---8<----
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 19ceaa6..589c760 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -368,7 +368,7 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
>  			break;
>  	}
>  
> -	if (!mask)
> +	if (!mask && num_possible_cpus() > 1)
>  		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
>  
>  	return mask;

Can one of these two patches be picked up?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
