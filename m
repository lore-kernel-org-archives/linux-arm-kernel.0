From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 24 Aug 2013 01:33:31 +0200
Subject: [PATCH v8 1/7] irqchip: vic: Parse interrupt and resume masks
 from device tree
In-Reply-To: <5217EE16.6020702@wwwdotorg.org>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <2159266.zeHHUDxisq@flatron> <5217EE16.6020702@wwwdotorg.org>
Message-ID: <1874369.t457ToAVgC@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 of August 2013 17:19:50 Stephen Warren wrote:
> On 08/23/2013 05:04 PM, Tomasz Figa wrote:
> > On Friday 23 of August 2013 16:11:18 Stephen Warren wrote:
> >> On 08/22/2013 05:22 PM, Tomasz Figa wrote:
> >>> This patch extends vic_of_init to parse valid interrupt sources
> >>> and resume sources masks from device tree.
> >>> 
> >>> If mask values are not specified in device tree, all sources
> >>> are assumed to be valid, as before this patch.
> >> 
> >> Can you explain further why the VIC needs this information up-front?
> >> Presumably it can accumulate it as devices request interrupts.
> > 
> > It does not need this information just for operation, but this makes
> > the hardware description more detailed and allows better sanity
> > checking of interrupts being requested.
> 
> Ah, OK. It may be worth mentioning the intent of the properties.

Right, a bit more detailed description will be nice indeed. I didn't think 
such thing like this is so uncommon to need such.

> I
> suppose this is purely a representation of HW then, so it's reasonable
> to include it in the binding. I'm not sure /quite/ how useful it is;
> after all the error-checking that it enables will never trigger assuming
> the rest of the DT is written to "request" the correct interrupts.
> However, I guess there is little harm in allowing these properties.

Well, the valid-mask is indeed a bit redundant (although might let you 
spot errors in interrupt specification in your device tree faster), but 
wakeup-mask is something that prevents drivers from incorrectly thinking 
that an interrupt can wake the system up, while it can't. Otherwise 
enable_irq_wake() wouldn't know when to return an error.

> Bikeshedding a bit, but perhaps rename wakeup-mask to valid-wakeup-mask
> (and perhaps valid-mask to valid-source-mask for consistency, although I
> see you already renamed that to be consistent with other bindings...)?
> To me, wakeup-mask sounds like a configuration of which sources should
> be configured to wakeup the system; something to do with
> configuration/policy rather than HW capabilities.

Yes, valid-wakeup-mask sounds reasonably to me. The valid-mask property 
has been taken from bindings/arm/versatile-fpga-irq.txt, as suggested by 
Linus Walleij.

> Either way, the binding,
> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks.

> (I assume those 2 new properties always have 1 cell since the controller
> can only support up to 32 IRQ sources? If not, then perhaps add wording
> to describe how long the properties should be).

Correct, one VIC can support up to 32 interrupt sources. A word on this in 
binding description will be nice indeed.

Best regards,
Tomasz
