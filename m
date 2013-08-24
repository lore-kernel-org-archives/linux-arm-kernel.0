From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 24 Aug 2013 18:57:13 +0200
Subject: [PATCH v8 1/7] irqchip: vic: Parse interrupt and resume masks
 from device tree
In-Reply-To: <5218E0B7.4020701@gmail.com>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <11592715.CyyL3y3PT6@flatron> <5218E0B7.4020701@gmail.com>
Message-ID: <2823496.bR7bMWMK3l@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 of August 2013 11:35:03 Rob Herring wrote:
> On 08/24/2013 10:31 AM, Tomasz Figa wrote:
> > On Saturday 24 of August 2013 10:25:26 Rob Herring wrote:
> >> On Fri, Aug 23, 2013 at 6:04 PM, Tomasz Figa <tomasz.figa@gmail.com>
> > 
> > wrote:
> >>> On Friday 23 of August 2013 16:11:18 Stephen Warren wrote:
> >>>> On 08/22/2013 05:22 PM, Tomasz Figa wrote:
> >>>>> This patch extends vic_of_init to parse valid interrupt sources
> >>>>> and resume sources masks from device tree.
> >>>>> 
> >>>>> If mask values are not specified in device tree, all sources
> >>>>> are assumed to be valid, as before this patch.
> >>>> 
> >>>> Can you explain further why the VIC needs this information
> >>>> up-front?
> >>>> Presumably it can accumulate it as devices request interrupts.
> >>> 
> >>> It does not need this information just for operation, but this makes
> >>> the hardware description more detailed and allows better sanity
> >>> checking of interrupts being requested.
> >>> 
> >>> To clarify, this is a mask of valid interrupt sources of the VIC,
> >>> where
> >>> set bit indicates that given signal is wired and clear bit that it
> >>> is
> >>> not.
> >> 
> >> I agree with Stephen here. The valid interrupts are the ones in the
> >> DT. The reserved ones are the ones not present. If it is not needed
> >> for the operation of the VIC, then remove it. The argument of sanity
> >> checking could apply to all interrupt controllers.
> > 
> > Sorry, but I don't get what's wrong in having a more detailed
> > description than required just for operation of the hardware.
> > 
> > The feature of sanity checks based on interrupt_mask (here now called
> > valid-mask) has been present in the VIC driver since a long time
> > already (if not from the beginning of existence of this driver) and
> > before we started using DT, the mask was being passed from platform
> > code as VIC init function argument.
> 
> So we should base the binding on the Linux software design?

I would put it different way: The binding should provide information 
detailed enough to allow any features allowed by Linux software design.

Well, anyway, I don't believe that existing, pre-ARM, bindings wasn't 
influenced by how things worked on PowerPC platforms and software running 
on them (including OpenFirmware and OS'es like Linux).

> > I'd prefer this feature to be available when using DT as well, unless
> > we really want to move things backwards, just because we want to use
> > DT...
> As I mentioned all these arguments apply to ALL interrupt controllers
> except ones which a mask does not work. So IF this makes sense, then
> this should be a generic property and generic code to support.

Isn't a binding of particular device free to define a private property? 
Anyway, I wouldn't be opposed to making it generic.

> You simply have the same information twice. One is distributed

Assuming you have it specified correctly under client nodes.

> and one
> is centralized. While it adds a way to validate things it also adds a
> way to introduce errors. Suppose someone writes a dts such that
> valid-mask matches the irq lines present in that dts (simply because
> they were lazy or don't have documentation of all interrupt lines).

That's why this property is optional. If you don't know how this is set up 
on your hardware then you don't fill it with a random value, but just skip 
it instead.

> Then
> you go add a node with a new interrupt (because the initial dts was not
> complete). Updating the valid-mask could very easily be forgotten. Yes,
> this should all be found by testing, but people don't always have
> access to all the h/w.

Adding a node with a new interrupt usually means adding support for new 
hardware. This is something I wouldn't really want to see submitted 
untested...

Anyway, since I'd like this series to be merged ASAP and this patch is not 
strictly necessary, especially this optional sanity check, let me just 
drop this property and move on with other things...

Best regards,
Tomasz
