From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 20 Sep 2012 14:16:27 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <alpine.DEB.2.02.1209201333460.29232@kaball.uk.xensource.com>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1348136222.26501.19.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1209201240110.29232@kaball.uk.xensource.com>
 <1348143533.26501.28.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1209201333460.29232@kaball.uk.xensource.com>
Message-ID: <1348146987.26501.40.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-20 at 13:39 +0100, Stefano Stabellini wrote:
> On Thu, 20 Sep 2012, Ian Campbell wrote:
> > > Versatile Express is flexible enough to be a good base for our own
> > > virtual machine platform, especially if the maintainers keep an eye on
> > > getting everything through DT and not expecting devices just to be there
> > > ;-)
> > 
> > Perhaps what we want is a stricter subset of the stuff in mach-vexpress
> > then. But if so then this should be expressed both in the DT and in the
> > code, not just papered over by declaring things compatible when they are
> > not.
> 
> But it is already expressed in the DT, by removing all the device nodes
> we don't emulated. And it is already expressed in the code, by fully
> discovering peripherals via DT, therefore not trying to initialize
> non-present devices.

Sorry on second look most of the non-DT stuff is part of the non-DT
vexpress support code in the same file.

There are some exceptions though:

v2m_reset and v2m_power_off don't refer to DT and touch system
peripherals directly.

v2m_dt_map_io falls back to v2m_io_desc if there is no rs1 node (which I
think we don't have?) 

v2m_clk_init is called from v2m_dt_timer_init (I think you may have
fixed this one).

> 
> 
> > > > > +	gic: interrupt-controller at 2c001000 {
> > > > > +		compatible = "arm,cortex-a9-gic";
> > > > 
> > > > Don't we mean "arm,cortex-a15-gic" here? That's what we actually
> > > > provide. I'm not sure how the a9 and a15 differ.
> > > 
> > > The GIC that comes with vexpress is a9 compatible.
> > 
> > The GIC which Xen emulates is the one which matters here though, and
> > that is an a15.
> 
> The a15 gic is still a9 compatible. OK to be precise I am going to add
> "arm,cortex-a15-gic", but I cannot really remove "arm,cortex-a9-gic".

I think A9 is GIC v1 and A15 is GIC v2, with the primary difference
being the alignment of the memory mapped registers, but I'm not totally
sure of that.

A bunch of places do use "arm,cortex-a15-gic", "arm,cortex-a9-gic" so
you are probably right that this is the proper answer.

Ian.
