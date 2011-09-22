From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 22 Sep 2011 13:19:57 +0100
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4E7A2334.7020904@firmworks.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
	<4E79E588.6010703@gmail.com>
	<CACxGe6sTYYXbpXvPb4C+y4JX0eRxLvwjbFycXA8Mjc-XWS1QUA@mail.gmail.com>
	<4E7A12E2.9040107@gmail.com> <20110921171545.GG2872@arm.com>
	<4E7A2334.7020904@firmworks.com>
Message-ID: <20110922121951.GA2026@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 07:47:32AM -1000, Mitch Bradley wrote:
> On 9/21/2011 7:15 AM, Dave Martin wrote:
> >On Wed, Sep 21, 2011 at 11:37:54AM -0500, Rob Herring wrote:
> >>On 09/21/2011 09:57 AM, Grant Likely wrote:
> >>>On Wed, Sep 21, 2011 at 7:24 AM, Rob Herring<robherring2@gmail.com>  wrote:
> >>>>On 09/21/2011 04:19 AM, Dave Martin wrote:
> >>>>>       * arm,amba-bus -- widely used by other boards and patchsets, but
> >>>>>         seems not to be documented.
> >>>>>
> >>>>
> >>>>This should be dropped. There's not really any bus component to an amba
> >>>>bus. All the probing info is within the primecell peripherals.
> >>>
> >>>No, if it is an AMBA bus, then it is entirely appropriate to declare
> >>>it as an amba bus, but to also be compatible with "simple-bus".  In
> >>>fact, it would be better to use a compatible string that specifies the
> >>>specific implementation of AMBA bus since there are several versions
> >>>of the spec.
> >>
> >>And type of AMBA bus as the spec includes AXI, AHB, and APB. None of
> >>which have any sort of programmability or software view.
> >>
> >>If this is required, then the policy should be simple-bus should never
> >>be allowed alone as every bus has some underlying type. Seems like
> >>overkill for buses like this.
> >
> >The key question is _where_ to draw the line between generic and specific.
> >By definition, the DT can never be a comprehensive description of the
> >hardware -- rather a good DT is a description of those details of the hardware
> >which could relevant to any hypothetical OS.
> >
> >The flipside is that details which were thought to be irrelevant at
> >design/implementation time can turn out to be relevant in practice, due
> >to errata and implementation issues etc.  So taking the description slightly
> >beyond what the OS needs to know can still have some merit.
> >
> >
> >I still don't know how to say where the line should be drawn in this particular
> >case though.
> 
> Here are some criteria:
> 
> If the controller for the bus itself has registers, include the bus node
> 
> If it is possible to plug new stuff into the bus, include the bus node
> 
> If the base address for the bus can be changed, thereby changing all
> the addresses of its subordinates by the same offset, include the
> bus node (this usually goes along with "has registers".)
> 
> ARM buses typically don't have any of those attributes, but there
> are some weaker criteria that can be used to justify including a bus
> node. The SoC on which I'm currently working has some peripherals on
> AXI and others on APB.  That doesn't matter from that addressing
> standpoint - the individual peripherals can each be viewed as having
> an address, end of story - but it does matter from a power
> management standpoint.  The clock tree is quite related to the bus
> layout.  Including bus nodes in the device tree might provide useful
> place-holders for properties describing power or clock domains.
> 
> So, on the whole, I'm in favor of including bus nodes for ARM
> standard buses.  There is little down side to doing so, and a fair
> chance that it might come in handy in the future.

I'm guessing that that would motivate describing most of the bus layout,
with the possible exception of bus adaptors which exist solely for the
purpose of integrating a single slave with the parent bus -- providing
such adaptors are transparent to software.

I'll have a think about what we would need to add...

Cheers
---Dave
