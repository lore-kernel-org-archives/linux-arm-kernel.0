From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Feb 2011 21:05:25 +0900
Subject: [PATCH V3] ARM: S5PV310: Implement kernel timers using MCT
In-Reply-To: <20110131192241.GD32737@n2100.arm.linux.org.uk>
References: <1296205364-30175-1-git-send-email-kgene.kim@samsung.com>
	<20110131192241.GD32737@n2100.arm.linux.org.uk>
Message-ID: <007001cbc788$7a7e0530$6f7a0f90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Fri, Jan 28, 2011 at 06:02:44PM +0900, Kukjin Kim wrote:
> > +irqreturn_t s5pv310_mct_comp_isr(int irq, void *dev_id)
> 
Oops, I missed your reply :(

> static?
> 
> > +{
> > +	struct clock_event_device *evt;
> 
> 	struct clock_event_device *evt = dev_id;
> 
> > +
> > +	s5pv310_mct_write(0x1, S5PV310_MCT_G_INT_CSTAT);
> > +
> > +	evt = &mct_comp_device;
> > +	evt->event_handler(evt);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static struct irqaction mct_comp_event_irq = {
> > +	.name		= "mct_comp_irq",
> > +	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> > +	.handler	= s5pv310_mct_comp_isr,
> 
> 	.dev_id		= &mct_comp_device,
> 
Ok...will address comments from you :-)

> 
> > +static void s5pv310_mct_tick_init(struct clock_event_device *evt)
> > +{
> > +	unsigned int cpu = smp_processor_id();
> > +
> > +	evt = &mct_tick[cpu].evt;
> 
> Why do you want to overwrite the already provided event device?

Hmm...couldn't use just 'already provided event device' because can't get
'mct_clock_event_device' structure like following.

+	struct mct_clock_event_device *mevt =
+		container_of(evt, struct mct_clock_event_device, evt);

Do you have any idea for it?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
