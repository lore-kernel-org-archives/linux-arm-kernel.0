From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Jun 2012 20:57:21 +0800
Subject: [RFC PATCH 1/1] ARM: imx: enable SPARSE_IRQ for imx
In-Reply-To: <20120620063959.GH10387@shlinux2.ap.freescale.net>
References: <20120619130145.GD10387@shlinux2.ap.freescale.net>
 <1340111993-6676-1-git-send-email-b29396@freescale.com>
 <20120619140613.GH21951@S2101-09.ap.freescale.net>
 <20120620022313.GE10387@shlinux2.ap.freescale.net>
 <20120620054015.GB1568@S2100-06.ap.freescale.net>
 <20120620063959.GH10387@shlinux2.ap.freescale.net>
Message-ID: <20120620125718.GA2253@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The conversation becomes really tedious.  I promise this is my last
round reply to this.  In any case, what you proposed here is nothing
imx specific.  If you want to go this way, please have it supported
at driver core level.

On Wed, Jun 20, 2012 at 02:40:00PM +0800, Dong Aisheng wrote:
> It's not about how struct resource defined.
> It's about why you directly define linux irq for device rather than
> using standard api irq_find_mapping to get the correct linux virt irq
> for device after using irqdomain.
> 
It's all about that the irq in resource is defined as Linux irq.
Whether you like it or not, that's a fact of Linux today.  I do not
think I can repeat myself any more.

> So you agree they're issues for non-dt?

No, not at all, because:

* non-DT should always use legacy domain.

  http://thread.gmane.org/gmane.linux.ports.arm.kernel/151860/focus=152072

* The SoC internal IRQs will always be allocated right after the
  preallocated ones.

So the only thing that could impact those Linux irq numbering is the
irqs preallocated by irq core.  I do not see why that preallocated
number need to change from time to time.  The bottom line is that
all those Linux irqs are not open-coded but macros, which can be
easily updated without any change to the users.

> IMHO moving to dt is not an excuse to do wrong things for non-dt.
> 
There is nothing wrong to me, really.

> I did not see your point, for soc specific setup, it definitely does not have
> such issue. The issue happens in a common function shared by many SoCs.
> And without dev_id as used by drivers, how do we do it in machine code
> in a better way than cpu_is_xx for non-dt?
> 
You need to think about it a little bit further.  You can define
a function pointer and have it assigned to avic_irq_find_mapping or
avic_irq_find_mapping in soc specific init function.  Then you use
the function pointer in imx_add_platform_device.  Wouldn't that save
you those cpu_is_xxx and #ifdef ugliness?

Or even simpler, you can define a global domain variable and have it
assigned with the avic/tzic domain in their init function.

> Hmm, how can you say NO one?
> 
Prove me wrong by proposing the change to driver core then, please.

-- 
Regards,
Shawn
