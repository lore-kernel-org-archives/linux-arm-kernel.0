From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 20 Jun 2012 22:45:04 +0800
Subject: [RFC PATCH 1/1] ARM: imx: enable SPARSE_IRQ for imx
In-Reply-To: <20120620125718.GA2253@S2101-09.ap.freescale.net>
References: <20120619130145.GD10387@shlinux2.ap.freescale.net>
 <1340111993-6676-1-git-send-email-b29396@freescale.com>
 <20120619140613.GH21951@S2101-09.ap.freescale.net>
 <20120620022313.GE10387@shlinux2.ap.freescale.net>
 <20120620054015.GB1568@S2100-06.ap.freescale.net>
 <20120620063959.GH10387@shlinux2.ap.freescale.net>
 <20120620125718.GA2253@S2101-09.ap.freescale.net>
Message-ID: <20120620144503.GN10387@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 08:57:21PM +0800, Shawn Guo wrote:
> The conversation becomes really tedious.  I promise this is my last
> round reply to this.  In any case, what you proposed here is nothing
> imx specific.  If you want to go this way, please have it supported
> at driver core level.
> 
Anyway, i appreciate to your replies on my questions.
I will consider support in driver core level.

> On Wed, Jun 20, 2012 at 02:40:00PM +0800, Dong Aisheng wrote:
> > It's not about how struct resource defined.
> > It's about why you directly define linux irq for device rather than
> > using standard api irq_find_mapping to get the correct linux virt irq
> > for device after using irqdomain.
> > 
> It's all about that the irq in resource is defined as Linux irq.
> Whether you like it or not, that's a fact of Linux today.  I do not
> think I can repeat myself any more.
> 
I'm afraid you're missing my point.
I never said the irq in resource shouldn't be defined as linux irq.
My point is that irq number should be get via standard irqdomain api
rather than directly defining it yourself.

> > So you agree they're issues for non-dt?
> 
> No, not at all, because:
> 
> * non-DT should always use legacy domain.
> 
>   http://thread.gmane.org/gmane.linux.ports.arm.kernel/151860/focus=152072
> 
> * The SoC internal IRQs will always be allocated right after the
>   preallocated ones.
> 
> So the only thing that could impact those Linux irq numbering is the
> irqs preallocated by irq core.  I do not see why that preallocated
> number need to change from time to time.  The bottom line is that
We never konw what the future maybe, right?
And you may note even currently the irq core also provides an interface
to machine to define the preallocated irqs in machine_desc->nr_irqs.
That's changeable.

> all those Linux irqs are not open-coded but macros, which can be
> easily updated without any change to the users.
Using NR_IRQS_LEGACY as offset is not safe.

> > Hmm, how can you say NO one?
> > 
> Prove me wrong by proposing the change to driver core then, please.
> 
We can do it in core, but i still did not find enough reasons to do like that.
IMHO the device core may not want to know the mapping between hw irq and
linux virtual irq, that's all the work of iqr and irqdomain layer.
The device core may only want the user to tell him the linux irq(virtual),
that seems enough.
I would like to see if other people have different options.

Regards
Dong Aisheng
