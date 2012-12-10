From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Dec 2012 10:04:33 +0000
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <1354902347.8263.12.camel@linaro1.home>
References: <1354821581.17101.17.camel@gandalf.local.home>
 <1354872138.3176.15.camel@computer5.home>
 <1354888985.17101.41.camel@gandalf.local.home>
 <1354892111.13000.50.camel@linaro1.home>
 <1354894134.17101.44.camel@gandalf.local.home>
 <20121207162346.GW14363@n2100.arm.linux.org.uk>
 <1354898200.17101.50.camel@gandalf.local.home>
 <20121207164530.GX14363@n2100.arm.linux.org.uk>
 <1354900436.17101.58.camel@gandalf.local.home>
 <1354902347.8263.12.camel@linaro1.home>
Message-ID: <20121210100433.GB6624@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

Back-pedalling a bit here, but I'm confused by one of your points below:

On Fri, Dec 07, 2012 at 05:45:47PM +0000, Jon Medhurst (Tixy) wrote:
> On Fri, 2012-12-07 at 12:13 -0500, Steven Rostedt wrote:
> > I'll make my question more general:
> > 
> > If I have a nop, that is a size of a call (branch and link), which is
> > near the beginning of a function and not part of any conditional, and I
> > want to convert it into a call (branch and link), would adding a
> > breakpoint to it, modifying it to the call, and then removing the
> > breakpoint be possible? Of course it would require syncing in between
> > steps, but my question is, if the above is possible on a thumb2 ARM
> > processor?
> 
> I believe so. The details are (repeating your earlier explanation) ...
> 
> 1. Replace first half of nop with 16bit 'breakpoint' instruction.

Sort of -- you'd actually need 2x16-bit nops to make this work.

> 2. Sync.(cache flush to PoU + IPIs to make other cores invalidate the
> icache for changed part of the nop instruction).

Why do you need to use IPIs for I-cache invalidation on other cores? For
ARMv7 SMP (i.e. the multi-processing extensions) doing I-cache invalidation
by MVA to PoU will be broadcast to the applicable domain for the
shareability attributes of the address. So if you do icimvau with an
inner-shareable virtual address, it will be broadcast by the hardware.

> However, wouldn't we need any of this breakpoint malarkey, why not just
> just use a 16-bit branch instruction which branches over the second half
> of the nop? :-)

Yes, and I think if you do use two 16-bit nops, you can even get rid of all
the intermediate `sync' operations (I guess you might want one at the end if
you want the call to become visible at a particular point).

Will
