From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 24 Sep 2015 19:10:38 +0100
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <20150924151546.GJ13823@e104818-lin.cambridge.arm.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <1443033714.74600.18.camel@infradead.org> <560310EA.2070805@intel.com>
 <1443042212.74600.30.camel@infradead.org> <56033C10.2040708@linaro.org>
 <1443082579.74600.48.camel@infradead.org>
 <20150924103152.GG13823@e104818-lin.cambridge.arm.com>
 <1443095558.74600.84.camel@infradead.org>
 <20150924151546.GJ13823@e104818-lin.cambridge.arm.com>
Message-ID: <1443118238.74600.117.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-09-24 at 16:15 +0100, Catalin Marinas wrote:

> With "PRP0001", they can skip the _DSD properties review process (not
> that they bother much currently) as long as the existing DT support
> covers their needs.

So no change there then. I take it the smsc911x bindings didn't go
through this mythical _DSD properties review process either, right?

>  However, we don't want to emulate DT in ACPI but > first try the
> established ACPI methods and only use _DSD where these are
> insufficient. Automatically converting existing drivers and encouraging
> people to use "PRP0001" does not provide them with any incentive to try
> harder and learn the "ACPI way".

But again, we're *not* looking at a simplistic transliteration of
properties. Where there *is* an "ACPI way", such as the GPIO example I
gave, that should absolutely be used. And there should be sufficiently
high-level access functions that it shouldn't *matter* to the driver
whether the information is coming from ACPI or DT.

> > In that sense, the HID is entirely orthogonal.
> > 
> > And think about it... we *really* don't want a given peripheral device
> > to have *different* bindings depending on whether it's discovered with
> > a specific ACPI HID, vs. when it's discovered via DT or the PRP0001
> > HID. That way lies complete insanity.
> 
> I'm fine with reusing the same property names between _DSD and DT but I
> strongly consider that _DSD should only cover a _subset_ of the DT
> bindings and they should be reviewed independently.
> 
> Take the smsc911x driver for example: the DT bindings for the ARM Juno
> platform include things like "clocks", "vdd33a-supply". Such concepts
> are not available in ACPI (but we've seen people trying to emulate
> them), so rather than enabling such clocks in firmware, vendors will be
> tempted to do things the DT way, possibly with "PRP0001" HIDs covering
> the clock devices (though I think they currently require some kernel
> changes).

Aren't those optional? If nothing is provided, they are basically a
no-op. AFAICT the existing patches for smsc911x don't touch that code
at all. So whatever motivation you imagine there is for ACPI firmware
vendors to "do things the DT way" is still there with the existing
patches.

Again, this is *orthogonal* to the question of whether the device is
matched by PRP0001 + its compatible string, vs. a newly-invented HID.


> > In some ways, your proposal would be actively *counterproductive*. You
> > say you want to train people *not* to keep patching the kernel. But
> > where they *could* have just used PRP0001 and used a pre-existing
> > kernel, you then tell them "oh, but now you need to patch the kernel
> > because we want you to make up a new HID and not be compatible with
> > what already exists."
> 
> I gave an example above with the clocks but let's take a simpler,
> device-specific property like "smsc,irq-active-high". Is this documented
> anywhere apart from the kernel driver and the in-kernel DT smsc911x.txt?
> No. Are other non-Linux OS vendors going to look in the kernel source
> tree to implement support in their drivers? I doubt it and we could end
> up with two different paths in firmware for handling the same device.
> ACPI probably never was truly OS agnostic but with "PRP0001" we don't
> even try.

Where is the documentation for the INT_CFG_IRQ_POL_ bit in the INT_CFG
register, that it controls? The documentation on the bindings really
ought to live near that, in an ideal world.

But that's still a non-sequitur in the context of this particular
discussion. The patch that was posted *already* keeps that very same
(optional) smsc,irq-active-high property. 

Again, it isn't relevant to the question of whether the driver is
matched via PRP0001 or a newly-allocated HID.

The driver, as the patch was posted, *does* have the same set of
properties with the same meanings ? because anything else would be
insane.

> The idea of registering a HID is to also have a process for getting
> corresponding _DSD properties approved, published. Some of them like
> "mac-address" would be more generic and not require further review but
> we'll have more specific properties.
> 
> Patching a kernel driver to support a new HID is a (weak) method of
> keeping track of which devices are used with ACPI. Given how quickly
> these two patches were merged while still under discussion, I doubt that
> arch maintainers would be in a position to review/reject drivers using
> non-approved _DSD properties.

Again, nothing has changed there.

> Apart from a _DSD properties review process, what we need is (main) OS
> vendors enforcing it, possibly with stricter ACPI test suite. Disabling
> PRP0001 for ARM wouldn't solve the problem but at least it would make
> people think about what _DSD properties they need registered for their
> device (or I'm over optimistic and I should just stop caring ;)).

I'm all for requiring pre-existing DT bindings to be "vetted" by the
nascent _DSD review process, before their use with PRP0001 can be
'blessed'.

But in a world where people *are* going to go off and do their own
insane thing, we really might as well let them use the *same* thing
that we already had ? in as many cases as possible ? rather than
actually *making* them come up with a new insane thing all of their
very own.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/f2d6e027/attachment-0001.bin>
