From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 Aug 2012 09:17:50 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120821165207.GX7995@opensource.wolfsonmicro.com>
References: <20120820125531.GA20242@gmail.com>
 <20120820162923.GF26991@opensource.wolfsonmicro.com>
 <20120820164949.GB22749@gmail.com>
 <20120820175155.GH26991@opensource.wolfsonmicro.com>
 <20120821085618.GA26899@gmail.com>
 <20120821095026.GU26991@opensource.wolfsonmicro.com>
 <20120821105413.GD26899@gmail.com>
 <20120821110329.GA7995@opensource.wolfsonmicro.com>
 <20120821120243.GF26899@gmail.com>
 <20120821165207.GX7995@opensource.wolfsonmicro.com>
Message-ID: <20120822081746.GA4089@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 05:52:07PM +0100, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 01:02:46PM +0100, Lee Jones wrote:
> > On Tue, Aug 21, 2012 at 12:03:29PM +0100, Mark Brown wrote:
> 
> > > > another way to get hold of the domain, because the only way to obtain
> > > > it without having direct access is via a device node.
> 
> > > This doesn't actually hold.
> 
> > Okay, besides irq_find_host(struct device_node *np), how else can you fetch
> > a domain from the irqdomain?
>
> I'm not sure I can parse the above, sorry - I'm not sure I can
> distinguish "domain" and "irqdomain".

Are you being intentionally awkward on this? Picking holes when you know
exactly what I'm trying to say? Not that it matters now, but just out of
principle, let me try to put it in a very clear way so there can be no
misinterpretation.

I was saying that in order for the MFD core to carry out the hwirq->virq
conversion, it needed to obtain the irqdomain pointer pertaining to the
provided hwirq. The only helper function the irqdomain subsystem provides
requires a device node pointer to be passed as an argument, hence the
mention of 'irq_find_host(struct device_node *np)'. Then the Device Tree
is traversed until a specified 'interrupt-controller' is stumbled upon
or is pointed to by the 'interrupt-parent' property. Hence, we have to 
find another way to find the irqdomain pointers for non-DT based MFDs. To
which we now have a solution.

> > What have you done already? 
> 
> Implemented a patch for this which I've now tested a bit and will
> probably post in the next hour or so.
> 
> > Why make suggestions if you're just going to do the work yourself?
> 
> I made the suggestion then later on realised that this was actively
> going to break things I care about so I actually need it fixing.

I'm a little taken aback and annoyed by this. In a previous email thread
you categorically requested that I discuss some of the important changes
with maintainers and people in-the-know prior to actually writing any
code. I was obviously actively working on, had put time into, and was in
the mist of discussing this with you. Then you just go ahead and code it
(the easy part) yourself, essentially wasting my time. Surely there's
some kind of etiquette surrounding such things?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
