From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Jan 2015 12:35:51 +0000
Subject: [PATCH v3 2/3] mfd: lubbock_io: add lubbock_io board
In-Reply-To: <87y4owedx1.fsf@free.fr>
References: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
 <1421406010-14851-2-git-send-email-robert.jarzmik@free.fr>
 <20150119091705.GG21886@x1> <87ppaah9k5.fsf@free.fr>
 <20150120102919.GP5767@x1>
 <20150120115658.GJ26493@n2100.arm.linux.org.uk>
 <873874fuei.fsf@free.fr> <20150121081645.GC9258@x1>
 <87y4owedx1.fsf@free.fr>
Message-ID: <20150121123551.GD9258@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Jan 2015, Robert Jarzmik wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > On Wed, 21 Jan 2015, Robert Jarzmik wrote:
> >> > > > platform_get_irq()?
> >> > > No. I need the flags.
> >> > Where are they used?
> >> A couple of lines below, using local "irqflags" variable :
> >>        ret = devm_request_irq(&pdev->dev, cot->irq, lubbock_irq_handler,
> >>                               irqflags, dev_name(&pdev->dev), cot);
> >
> > No, I mean where are they _used_?
> I don't get your point.
> 
> For you, isn't it "using" irqflags by passing them as an argument to devm_request_irq()

No, this is where the argument is being _passed_.

> ??? And if you think ahead, then there are used all around in
> kernel/irq/manage.c, as you probably know.

Perhaps some context would help.

Looking at one of the other patches in the series it appears the flag
you're trying to capture is IORESOURCE_IRQ_LOWEDGE.  When I grep for
where this is being _used_ (think 'consumed, rather than passed.  I
only see a single entry in drivers/pnp/interface.c.

That's what got me thinking... are you sure you're a) making use of
this flag and b) assuming the answer to 'a' is "no" and if everyting's
working correctly in the code's current state, are you sure you need
them at all? 

I think to set an edge trigger on an IRQ, you should instead do so via
irq_set_irq_type(), or have a missed a line or two?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
