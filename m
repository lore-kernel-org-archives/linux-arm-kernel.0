From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 24 Sep 2015 15:31:08 +0100
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <20150924140157.GB30475@red-moon>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <1443033714.74600.18.camel@infradead.org> <560310EA.2070805@intel.com>
 <1443042212.74600.30.camel@infradead.org> <56033C10.2040708@linaro.org>
 <1443082579.74600.48.camel@infradead.org>
 <20150924103152.GG13823@e104818-lin.cambridge.arm.com>
 <1443095558.74600.84.camel@infradead.org> <20150924140157.GB30475@red-moon>
Message-ID: <1443105068.74600.104.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-09-24 at 15:01 +0100, Lorenzo Pieralisi wrote:
> On Thu, Sep 24, 2015 at 12:52:38PM +0100, David Woodhouse wrote:
> 
> [...]
> 
> > And think about it... we *really* don't want a given peripheral device
> > to have *different* bindings depending on whether it's discovered with
> > a specific ACPI HID, vs. when it's discovered via DT or the PRP0001
> > HID. That way lies complete insanity.
> 
> There are "devices" that we do _not_ want to discover at all when
> booting with ACPI (eg drivers/clk, drivers/regulator) because the way
> they interact with ACPI standard power management AML methods may
> definitely clash.

So it would be quite clearly a firmware bug to *expose* those things in
that way, when also exposing AML methods which make use of them.

But those really aren't what I'm looking at converting, anyway. The
target of the Coccinelle script would be leaf-node drivers, like the
one in this thread. Not subsystem code.

We have, for example, a generic method for 'get the GPIO' which works
equally well whether the actual information is given in the DT form, or
whether it's done through the ACPI GPIO abstraction as described in
 Documentation/acpi/gpio-properties.txt.

We certainly shouldn't be looking at a na?ve 1:1 literal
transliteration of properties. But on the other hand, we *do* want a
direct and automatic bijective mapping between the ACPI and DT
representations.


> PRP0001 allows to pull everything in (depending on what the Coccinelle
> script will look like, because AFAIK that's the only thing that stops
> people from enabling eg drivers/clk drivers in ACPI systems with PRP0001,
> namely the OF to FW node API conversion).
> 
> > In some ways, your proposal would be actively *counterproductive*. You
> > say you want to train people *not* to keep patching the kernel. But
> > where they *could* have just used PRP0001 and used a pre-existing
> > kernel, you then tell them "oh, but now you need to patch the kernel
> > because we want you to make up a new HID and not be compatible with
> > what already exists."
> 
> We do not want people to reuse DT drivers that are handled in ACPI with
> existing methods (again, power management is a prime example).

> I do not think we want to enable DT PCI host controllers drivers either
> since the ACPI model for PCI works differently already.
> 
> Should I mention CPUfreq and CPUidle DT drivers ?

No. Except to note that those are prime examples of the parts that
*don't* want to be converted.

> > Fundamentally, that DT vs. ACPI distinction has gone away with the
> > introduction of _DSD. We *need* the flexibility that we gain from being
> > able to provide device properties rather than inventing a new HID for
> > every permutation, and with that flexibility comes a certain amount of
> > responsibility to do things sensibly.
> 
> How do you enforce that apart from limiting the number of drivers you
> convert to the FW node API ? What drivers are we going to convert and
> on what basis ?

To start with, as I said, just leaf-node device drivers. None of the
things like the above, which you are quite right don't really want a
trivial conversion.

It's insane to talk of "enforcement", so let's not go there. Anyone
taking an existing driver and adding an ACPI HID to it would need to
start with *precisely* the same patches for those properties anyway.
Just as shown in the example in this thread.

> I think that's a debate worth having before making a tree-wide conversion
> of OF API calls to the generic FW node API.

Well, if that's true, that's a debate worth having before introducing
the generic FW node API. That having been kind of the *point* of the
generic FW node API ? to give code which doesn't *need* to be
gratuitously firmware-specific, an API that works everywhere.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/044ce685/attachment-0001.bin>
