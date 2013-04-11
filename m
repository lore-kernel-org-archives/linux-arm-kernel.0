From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Apr 2013 12:24:07 +0100
Subject: [PATCH 1/4] Documentation: Add memory mapped ARM architected
 timer binding
In-Reply-To: <51662584.6070906@codeaurora.org>
References: <1365474623-29181-1-git-send-email-sboyd@codeaurora.org>
 <1365474623-29181-2-git-send-email-sboyd@codeaurora.org>
 <20130409090843.GS23725@e106331-lin.cambridge.arm.com>
 <516444FE.2080200@codeaurora.org>
 <20130410101336.GB8799@e106331-lin.cambridge.arm.com>
 <51662584.6070906@codeaurora.org>
Message-ID: <20130411112407.GD8259@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 03:52:52AM +0100, Stephen Boyd wrote:
> On 04/10/13 03:13, Mark Rutland wrote:
> >>>> +
> >>>> +- #size-cells : Must be 1.
> >>>> +
> >>>> +- ranges : Indicates parent and child bus address space are the same.
> >>>> +
> >>> Similarly, what if someone wants to write a more complex mapping for some
> >>> reason?
> >>>
> >>> We should be able to handle it if we use the standard accessors.
> >> Maybe I should just leave this part out? They are standard DT properties
> >> so I could assume DT writers know what to do.
> > I'd be happy with that. It may be worth describing them as "as necessary" or
> > something to that effect.
> 
> Ok. I added this and removed the property descriptions:
> 
> Note that #address-cells, #size-cells, and ranges shall be present to ensure
> the CPU can address a frame's registers.

Sounds good to me.

> 
> > I can see why we need to specify secure/non-secure, but I'm not sure why we
> > need to specify hyp/user/kernel usage. Could we not leave this up to the kernel
> > to figure out?
> >
> > A basic overveiew for those that don't know about the memory mapped timers:
> >
> > * There's one control frame CNTCTLBase. Some registers in this frame are only
> >   available for secure accesses, including CNTNSAR which sets whether the
> >   counter frames are accessible from the non-secure side.
> >
> > * There are up to 8 timer frames, which have their own CNTVOFF and
> >   physical/virtual timers. Each frame CNTBaseN is duplicated at CNTPL0BaseN
> >   with CNTVOFF and CNTPL0ACR (which controls PL0 accesses) inaccessible.
> >
> > I can see that we might have frames/registers we can't access (if we were
> > booted on the non-secure side), but I can't see anything limiting whether we
> > use a frame for kernel/hyp/user beyond that. Have I missed something?
> >
> > Could we not have something like the following for each frame:
> >
> > frame0 {
> > 	frame-id = <0>;
> > 	status = "disabled"; /* booted NS, secure firmware has not enabled access */
> > 	reg = <0x... 0x1000>, /* CNTBase0 */
> > 	      <0x... 0x1000>; /* CNTPL0Base0 */
> > };
> >
> 
> I don't think you're missing anything. Technically the second view is
> not always implemented though. Using the status property should be
> sufficient I think.

Could we say the reg for the second view is optional?

Might we have a hardware / firmware configuration where the kernel can only access
the secondary view?

> 
> >> Also to get the frame number, I was thinking maybe we should expand the
> >> reg property to have two address cells. Then we could have reg = <0
> >> 0xf0001000 0x1000>.
> > We could do that, but then you definitely need a more complex ranges property,
> > and additional parsing code to handle grabbing it out of the reg property. I
> > can't see what it buys us.
> 
> Ok. It would mandate node names like "frame at 0", "frame at 1", but I'll drop
> the idea unless someone else finds it useful.

I see. I'd prefer to use a separate property for the id. Placing it in the reg
and then requiring a mapping sounds like it's going to cause a lot of pain.

Cheers,
Mark.
