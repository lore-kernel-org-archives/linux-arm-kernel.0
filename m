From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 24 Sep 2015 12:52:38 +0100
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <20150924103152.GG13823@e104818-lin.cambridge.arm.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <1443033714.74600.18.camel@infradead.org> <560310EA.2070805@intel.com>
 <1443042212.74600.30.camel@infradead.org> <56033C10.2040708@linaro.org>
 <1443082579.74600.48.camel@infradead.org>
 <20150924103152.GG13823@e104818-lin.cambridge.arm.com>
Message-ID: <1443095558.74600.84.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

I understand your concerns, but I'm still not convinced of your
conclusion.

On Thu, 2015-09-24 at 11:31 +0100, Catalin Marinas wrote:
> PRP0001 opens the door to any DT-like properties in ACPI and, knowing
> how the ARM ecosystem works, I'm pretty sure we'll soon lose control (if
> we haven't already; not all the developments are done in the open).

No. That door is wide open already ? people can already do whatever
they like in _DSD properties. If they're going to screw up DT
properties, they'll screw up ACPI-only _DSD properties just the same.

You speak of maintaining "tight control of the _DSD properties that
are going to be used in ACPI tables"... but if you're going to
confiscate their crackpipe and stand over them while they work, you can
do that just as well whether they're using "PRP0001" or "FOO1234" as
their HID value.

In that sense, the HID is entirely orthogonal.

And think about it... we *really* don't want a given peripheral device
to have *different* bindings depending on whether it's discovered with
a specific ACPI HID, vs. when it's discovered via DT or the PRP0001
HID. That way lies complete insanity.

In some ways, your proposal would be actively *counterproductive*. You
say you want to train people *not* to keep patching the kernel. But
where they *could* have just used PRP0001 and used a pre-existing
kernel, you then tell them "oh, but now you need to patch the kernel
because we want you to make up a new HID and not be compatible with
what already exists."

If you go down this road, I predict we'll start seeing *separate*
drivers for identical components, because the bindings for DT vs. ACPI
properties are different. We really don't want that.

> The pro ARM ACPI camp has been very vocal against DT in the server
> space. I'd like to seem them as vocal about PRP0001, unless they find it
> acceptable (and should apologise for bashing DT ;)).

Fundamentally, that DT vs. ACPI distinction has gone away with the
introduction of _DSD. We *need* the flexibility that we gain from being
able to provide device properties rather than inventing a new HID for
every permutation, and with that flexibility comes a certain amount of
responsibility to do things sensibly.

People have not always designed their bindings sensibly. But that isn't
going to be magically solved in the ACPI world, unless you *do*
actually stand over them with their crackpipe in your hand, as I joked
above. And eschewing PRP0001 really doesn't help you with that. It just
makes things harder.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/3c02fec3/attachment-0001.bin>
