From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Oct 2016 10:37:57 -0700
Subject: [PATCH/RESEND] clocksource/arm_arch_timer: Map frame with
 of_io_request_and_map()
In-Reply-To: <5807255A.8060906@arm.com>
References: <20161018234514.6175-1-sboyd@codeaurora.org>
 <5807255A.8060906@arm.com>
Message-ID: <20161019173757.GX8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19, Marc Zyngier wrote:
> On 19/10/16 00:45, Stephen Boyd wrote:
> > Let's use the of_io_request_and_map() API so that the frame
> > region is protected and shows up in /proc/iomem.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/clocksource/arm_arch_timer.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> > index 73c487da6d2a..cbfa3bc5be75 100644
> > --- a/drivers/clocksource/arm_arch_timer.c
> > +++ b/drivers/clocksource/arm_arch_timer.c
> > @@ -964,7 +964,8 @@ static int __init arch_timer_mem_init(struct device_node *np)
> >  	}
> >  
> >  	ret= -ENXIO;
> > -	base = arch_counter_base = of_iomap(best_frame, 0);
> > +	base = arch_counter_base = of_io_request_and_map(best_frame, 0,
> > +							 "arch_mem_timer");
> >  	if (!base) {
> >  		pr_err("arch_timer: Can't map frame's registers\n");
> >  		goto out;
> > 
> 
> Careful here: of_io_request_and_map() returns an ERR_PTR() on failure,
> while of_iomap just returns NULL. You want to change the error handling
> if you're going down that road.
> 

Eek! I was clearing out my pending queue and this one is
especially old so perhaps that function signature changed. Or I
just fail at life. Anyway, thanks!

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
