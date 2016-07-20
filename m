From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 20 Jul 2016 06:23:33 -0700
Subject: SOC-specific action for irq_set_wake
In-Reply-To: <alpine.DEB.2.11.1607200759230.3564@nanos>
References: <20160719181804.GX3847@xsjsorenbubuntu>
 <alpine.DEB.2.11.1607200759230.3564@nanos>
Message-ID: <20160720132333.GK3847@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, 2016-07-20 at 08:28:35 +0200, Thomas Gleixner wrote:
> On Tue, 19 Jul 2016, S?ren Brinkmann wrote:
> > we are working on the PM solution for Zynq MPSOC and ran into some
> > problem when setting the wake source.
> > 
> > The situation is that when the A53 is in suspend, the GIC(v2) may be
> > powered down. In that state a companion core is handling wake
> > events/IRQs, but we expect the OS/Linux to notify the companion core
> > about what device/IRQ is a wake up source. Hence, my idea was to capture
> > enabling/disabling wake IRQs in our platform PM code and then
> > communicate with the FW as needed during suspend operations. The problem
> > is: I don't see a good way to notify the platform code about these
> > events.
> > 
> > My ideas were:
> > 1. Use the irq_chip irq_set_wake function
> >   My thought was to implement the irq_set_wake function in a
> >   SOC-specific way (could even be generic and call some notifier chain or
> 
> Don't even think about notifier chains.
> 
> >   similar) to notify the platform PM code when a device/IRQ is
> >   enabled/disabled as wake up source.
> >   My problem is that the SKIP_IRQ_SET_WAKE flag is set in the generic
> >   driver (drivers/irqchip/irq-gic.c) and platforms cannot implement
> >   irq_set_wake without changes in the common code.
> 
> So and because it requires changes in the common code you think aboiut
> notifiers and other absurdities. Come on, common code is not a sacred cow. It
> can be modified and if you need for your particular platform that
> SKIP_IRQ_SET_WAKE is cleared, then there are a gazillion of sane ways to do
> that.

I'm not afraid of changing it, but I was hoping to get an idea of what
an acceptable solution would look like, as I don't want to run of into
any of the directions that are not sane and have it shoot down in the
end (like my notifier approach apparently would). I remembered the mentioned
extensions mechanism which disappeared. Hence, I thought it might be a
better idea to check beforehand why and what happened and what
alternative approach may be an acceptable solution for that problem.

	Thanks,
	S?ren
