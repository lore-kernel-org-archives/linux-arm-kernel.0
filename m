From: sre@debian.org (Sebastian Reichel)
Date: Tue, 24 Sep 2013 01:46:56 +0200
Subject: [RFCv2 3/3] ARM: dts: N900: Add SSI information
In-Reply-To: <5240A617.1010208@wwwdotorg.org>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-4-git-send-email-sre@debian.org>
 <5240A617.1010208@wwwdotorg.org>
Message-ID: <20130923234656.GB24781@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 23, 2013 at 02:35:35PM -0600, Stephen Warren wrote:
> On 09/15/2013 02:44 PM, Sebastian Reichel wrote:
> > Add SSI device tree data for OMAP34xx and Nokia N900.
> 
> What is an "SSI" device, ...

Synchronous Serial Interface (SSI), which is an interface from
the OMAP3 for modem connection. It's a legacy variant of
High-speed Synchronous Serial Interface (HSI). This in turn
is a standard from MIPI:

http://www.mipi.org/specifications/high-speed-synchronous-serial-interface-hsi

> 
> > diff --git a/Documentation/devicetree/bindings/hsi/omap_ssi.txt b/Documentation/devicetree/bindings/hsi/omap_ssi.txt
> 
> ... and what is the "HSI" subsystem?

A framework for HSI devices living in drivers/hsi.

> > +OMAP SSI controller bindings
> > +
> > +Required properties:
> > +- compatible:		Should be set to the following value
> > +                        ti,omap3-ssi (applicable to OMAP34xx devices)
> 
> I think that'd be better phrased as:
> 
> 	Should include "ti,omap3-ssi".
> 
> The binding should not preclude other compatibel values being present
> (e.g. a SoC-specific compatible value, to allow SoC-specific quirks to
> be enabled later).

Right. Will be fixed in the next RFC.

> > +- ti,hwmods:		Name of the hwmod associated to the controller, which
> > +			is "ssi".
> 
> I don't think we should add any more of that, for new bindings.

That basically means not adding new drivers until hwmod is completly
removed, since no new drivers not using DT are accepted anymore.

hwmod still holds some information, which are not yet mapped to DT.

> > +- reg:			Contains SSI register address range (base address and
> > +			length).
> > +- reg-names:		Contains the names of the address ranges. It's
> > +                        expected, that "sys" and "gdd" address ranges are
> > +			provided.
> 
> Why two entries in reg-names but only one in reg?
> 
> I think it'd be better to write:
> 
> reg-names:	Contains the values "sys" and "gdd".
> reg:		Contains a register specifier for each entry in
> 		reg-names.
> 
> A similar re-ordering/-wording would apply to interrupts/interrupt-names.

OK. Will be fixed in the next RFC.

> > +- ranges		Required as an empty node
> 
> s/node/property/
> 
> Why must ranges be empty? As long as the content correctly represents
> the bus setup, why does the content matter at all. How about:
> 
> ranges		Represents the bus address mapping between the main
> 		controller node and the child nodes below.

OK. Will be fixed in the next RFC.

> > +Each port is represented as a sub-node of the ti,omap3-ssi device.
> > +
> > +Required Port sub-node properties:
> > +- compatible:		Should be set to the following value
> > +                        ti,omap3-ssi-port (applicable to OMAP34xx devices)
> 
> Hmm. Is it really the case that there is 1 controller with n ports?

Yes with n=2.

> Are the ports really dependent upon some shared resource?

Yes and runtime power management.

> Couldn't the ports be represented as separate top-level SSI
> controllers?

Maybe with some phandles. The current layout is cleaner IMHO.
The ports are part of the controller and actually most boards
only use one of them.

In the original driver only the controller hat platform data
with memory areas called "port1_rx" etc.

> > +- interrupts:		Contains the interrupt information for the port.
> > +- interrupt-names:	Contains the names of the interrupts. It's expected,
> > +			that "mpu_irq0" and "mpu_irq1" are provided.
> 
> What exactly are those interrupts? "MPU" sounds like an external
> micro-controller/processor...
> 
> > +- ti,ssi-cawake-gpio:	Defines which GPIO pin is used to signify CAWAKE
> > +			events for the port. This is an optional board-specific
> > +			property. If it's missing the port will not be
> > +			enabled.
> 
> That also sounds like something that's a higher-level protocol, rather
> than whatever low-level transport "SSI" implements. Should this be part
> of a child node that represents the device attached to the SSI controller?

Both the interrupts and the cawake-gpio are used as irqs for
starting data transfers. As far as I understand it none of
them are specific to the attached device.

NOTE: I do not have documentation for the chip. I just ported the
old patch from Carlos Chinea (who developed the initial driver for
Nokia) to the new kernel frameworks, since I want to use the
modem of my Nokia N900.

> Does the SSI controller (or its ports) not need any clocks, resets,
> regulators, ...?

The only other stuff needed is taken care of by hwmod, which can
be seen in this patch:

https://lkml.org/lkml/2013/9/15/97

As far as I understand it, this kind of information is not yet
supported by DT on OMAP boards. On the other hand new OMAP drivers
are not allowed to add further board code, so temporarily the
ti,hwmod hack must be used.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130924/38525852/attachment-0001.sig>
