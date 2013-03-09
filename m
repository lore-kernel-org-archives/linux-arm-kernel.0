From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 9 Mar 2013 15:02:54 +0100
Subject: s3c24xx pinctrl help
In-Reply-To: <1825121.bbMz1G1oeT@flatron>
References: <201303081538.04877.heiko@sntech.de>
 <201303091356.25912.heiko@sntech.de> <1825121.bbMz1G1oeT@flatron>
Message-ID: <201303091502.55079.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 9. M?rz 2013, 14:31:53 schrieb Tomasz Figa:
> On Saturday 09 of March 2013 13:56:25 Heiko St?bner wrote:
> > Am Freitag, 8. M?rz 2013, 19:57:09 schrieb Tomasz Figa:
> > > Hi Heiko,
> > > 
> > > On Friday 08 of March 2013 15:38:04 Heiko St?bner wrote:
> > > > Hi Thomas,
> > > > 
> > > > taking you up on your offer of helping, I would be cool if you could
> > > > simply give me a push in the right direction :-) .
> > > > 
> > > > 
> > > > From what I've seen so far, the bank handling itself is very similar
> > > > between exynos and s3c24xx as the underlying structures already
> > > > handle
> > > > multiple widths of the register contents. More interesting is the
> > > > eint
> > > > handling around which I couldn't wrap my head yet.
> > > > 
> > > > The basic structure is again similar with special eint registers,
> > > > but
> > > > adds some quirks. EINT banks are gpf (8 eints) and gpg (8 or 16
> > > > eints
> > > > depending on the SoC).
> > > > 
> > > > The current way on Exynos seems to be to mark the offset in the eint
> > > > register and attach an irq_domain to the bank, which gets mapped to
> > > > the
> > > > eints starting at the offset. The eints seem to have a parent
> > > > interrupt
> > > > that is provided via the dt.
> > > > 
> > > > On the S3C24xx the gpg bank is doing this similar but gpf is very
> > > > strange.
> > > > 
> > > > The first half of the bank (gpf0 to gpf3) is not handled in eintpend
> > > > registers but in the main interrupt controller (bits 0 to 3), while
> > > > the
> > > > second half of gpf is handled in eintpend. The new interrupt
> > > > declaration might show this better, which can be found at [0].
> > > > 
> > > > An exception is the s3c2412 which adds still another quirk where
> > > > each
> > > > interrupt of gpf0 to gpf3 is represented in both the normal intc and
> > > > eint registers, again for reference probably easier to see in [1].
> > > > 
> > > > 
> > > > So I'm still quite stumped on how this could fit into the current
> > > > framework and would be really glad for some small pointers :-)
> > > 
> > > I wonder if some of my patches for pinctrl on S3C64xx might be
> > > helpful:
> > > 
> > > https://github.com/tom3q/linux/commits/v3.8-s3c64xx-dt-pinctrl
> > 
> > Partially ... I got to know the (new to me) interrupt-map part of dt :-)
> > .
> > 
> > But on the S3C64XX you also have the benefit of all eints being in
> > dedictated eint registers. I'm still thinking on the best way to
> > integrate the eints that live directly in the main interrupt
> > controller.
> > 
> > One option I could think of, would be to add an optional to_irq callback
> > to the bank definition and then do something like the following to
> > handle the special case:
> > 
> > static int samsung_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
> > {
> > 
> > 	struct samsung_pin_bank *bank = gc_to_pin_bank(gc);
> > 	unsigned int virq;
> > 	
> > 	if (bank->to_irq)
> > 	
> > 		return bank->to_irq(bank, offset);
> > 	
> > 	if (!bank->irq_domain)
> > 	
> > 		return -ENXIO;
> > 	
> > 	virq = irq_create_mapping(bank->irq_domain, offset);
> > 	
> > 	return (virq) ? : -ENXIO;
> > 
> > }
> > 
> > The GPG bank could simply use the existing mechanisms, as it follows the
> > generic paradigm, and for GPF the callback would handle the distinction
> > between eints handled in the eint regs or in the main interrupt
> > controller.
> 
> Right, I checked how EINTs work on S3C2440A in documentation and indeed it
> is a bit different than I initially thought.
> 
> However this is still similar to S3C64xx in some aspects. On S3C64xx there
> is following hierarchy of interrupts in EINT0 group:
> 
> EINT0
> ...     -------> VIC0 INT0
> EINT3
> 
> EINT4
> ...     -------> VIC0 INT1
> EINT11
> 
> EINT12
> ...     -------> VIC1 INT0
> EINT19
> 
> EINT20
> ...     -------> VIC1 INT1
> EINT27
> 
> On S3C24xx it would look like this:
> 
> EINT0  -------> INT0
> 
> EINT1  -------> INT1
> 
> EINT2  -------> INT2
> 
> EINT3  -------> INT3
> 
> EINT4
> ...    -------> INT4
> EINT7
> 
> EINT8
> ...    -------> INT5
> EINT23
> 
> So you can look at all EINTs as being multiplexed, just with some groups
> consisting only of single interrupt signal.
> 
> The only thing that differs here is that, at least on S3C2440, there are
> no pending and mask bits for EINTs 0-3.

Yep, that's the standard handling for all s3c24xx except the s3c2412 which 
does the eint0 ---> eint0, eint1 ---> eint1 mapping and contains the necessary 
bits in eintpend.


> Missing pending bits are not a
> problem here, since receiving INT0 would mean receiving EINT0, but no mask
> bits means that masking would have to be handled on interrupt controller
> level, probably by using enable_irq and disable_irq_nosync. This could be
> solved by assigning different irq chip to EINTs 0-3 and EINTs 4-7 in
> domain map callback.

This thought is really intriguing, as it would solve a lot of problems. 


[from the second mail]:
> I forgot one more thing in my previous reply. Your solution would not
> allow GPIO bank-based specification of EINTs 0-3 in device tree.
> 
> Consider following example:
> 
> device-0 {
> 	...
> 	interrupt-parent = <&gpf>;
> 	interrupts = <2 0>;
> 	...
> };
> 
> This would explicitly go through irq_create_mapping() without calling
> gpio_to_irq.
> 
> Of course you could say that this kind of specification is not valid for
> EINTs0-3 and interrupt contoller has to be specified in interrupt-parent
> specifier, not gpf bank. I guess it's just a matter of preference, though.

Yep, that was also one of my concerns, especially, as the handling of the 
extint settings would then also need to be done in both the pinctrl and 
interrupt controller for the respective parts, not to speak of the access to 
the eint setting-registers needed from the interrupt controller code.

Also, I like the idea above (having everything in the pinctrl driver) a lot 
better, which would solve all this quite cleanly :-) .


Heiko
