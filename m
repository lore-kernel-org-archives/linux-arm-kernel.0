From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 29 Jan 2015 02:22:43 +0000
Subject: [PATCH v2 3/3] pm: at91: add disable/enable the L1/L2 cache
 while suspend/resume
In-Reply-To: <54C8B54B.3090607@cogentembedded.com>
References: <1422411707-10945-1-git-send-email-wenyou.yang@atmel.com>
 <1422411844-13241-1-git-send-email-wenyou.yang@atmel.com>
 <54C8B54B.3090607@cogentembedded.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFD38E20@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thank you for your review.

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov at cogentembedded.com]
> Sent: Wednesday, January 28, 2015 6:09 PM
> To: Yang, Wenyou; Ferre, Nicolas; linux at arm.linux.org.uk
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> alexandre.belloni at free-electrons.com; sylvain.rochet at finsecur.com;
> peda at axentia.se; linux at maxim.org.za
> Subject: Re: [PATCH v2 3/3] pm: at91: add disable/enable the L1/L2 cache while
> suspend/resume
> 
> Hello.
> 
> On 1/28/2015 5:24 AM, Wenyou Yang wrote:
> 
> > For the sama5, disable L1 D-cache and L2 cache before the cpu go to
> > wfi, after wakeing up, enable L1 D-cache and L2 cache.
> 
>     Waking.
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >   arch/arm/mach-at91/pm.c         |   12 +++++
> >   arch/arm/mach-at91/pm_suspend.S |  107
> +++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 119 insertions(+)
> 
> [...]
> > diff --git a/arch/arm/mach-at91/pm_suspend.S
> > b/arch/arm/mach-at91/pm_suspend.S index 311cc23..02d4e56 100644
> > --- a/arch/arm/mach-at91/pm_suspend.S
> > +++ b/arch/arm/mach-at91/pm_suspend.S
> [...]
> > @@ -324,3 +325,109 @@ ram_restored:
> [...]
> > +l2x_sync:
> 
>     I don't see where this label is used.
I thought it is an indication the following is for L2 cache synchronization. 

It is redundant, remove it.

> 
> > +	ldr	r0, [r2, #L2X0_CACHE_SYNC]
> > +	bic	r0, r0, #0x1
> > +	str	r0, [r2, #L2X0_CACHE_SYNC]
> > +sync:
> > +	ldr	r0, [r2, #L2X0_CACHE_SYNC]
> > +	ands	r0, r0, #0x1
> > +	bne	sync
> > +
> > +skip_l2disable:
> > +	ldmfd	sp!, {r4 - r12, pc}
> > +ENDPROC(at91_disable_l1_l2_cache)
> [...]
> 
> WBR, Sergei

Best Regards,
Wenyou Yang
