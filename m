From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Dec 2014 13:23:06 +0000
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
 <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
Message-ID: <20141226132306.GC17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 24, 2014 at 05:18:15PM +0000, Catalin Marinas wrote:
> On Fri, Oct 17, 2014 at 02:37:14PM +0100, Hanjun Guo wrote:

> > +ACPI drivers should only look at one specific ASL object -- the _DSD object
> > +-- for device driver parameters (known in DT as "bindings", or "Device
> > +Properties" in ACPI).  Not all DT bindings will be recognized. 

> This last sentence kind of implies that many of the DT bindings will be
> recognised. While it is useful to have some commonalities, I think this
> gives the wrong message that _DSD is a copy of DT. We should avoid this.

> > +so that they may be used on any operating system supporting ACPI.  Device
> > +properties that have not been registered with the UEFI Forum should not be
> > +used.

> More about this further down.

Indeed...

> > +Drivers should look for device properties in the _DSD object ONLY; the _DSD
> > +object is described in the ACPI specification section 6.2.5, but more
> > +specifically, use the _DSD Device Properties UUID:

> > +   -- UUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301

> > +   -- http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf)

> > +The kernel has an interface for looking up device properties in a manner
> > +independent of whether DT or ACPI is being used and that interface should
> > +be used;

> I haven't followed the _DSD kernel support but does it provide a common
> API to be shared with DT? I'm not entirely convinced it's a good idea.

Yes, it does.  I'm not entirely convinced about that either but it
really meets the goals of some of the users.  Right now I'm seeing
several user communities:

 - x86 server
 - x86 laptop
 - x86 embedded 
 - ARM server

The _DSD/DT abstraction API is intended to meet the needs of the x86
embedded community, they are really only interested in Linux and just
want to be able to pick up Linux drivers that have been developed with
DT in mind and use them with the minimum fuss.  They are, to a good
approximation, not really interested in UEFI and ACPI per se.

> > it can eliminate some duplication of code paths in driver probing
> > +functions and discourage divergence between DT bindings and ACPI device
> > +properties.

> Given the current different mechanism of reviewing/approving bindings
> between DT and ACPI (kernel community vs UEFI forum), I don't see how we

Right now there is no real way of reviewing and approving bindings for
_DSD.

> encourage convergence (unless we state that _DSD are Linux-only, Windows
> should use a different mechanism like .inf files).

No, I don't think we want to encourage that.  It's what's happening
right now for the x86 laptop case and it's making things miserable for
people working with audio, what we end up with on the Linux side is
needing to have per-machine quirk tables which means that Linux has
little chance of working out of the box with unknown hardware.  It's bad
for users and not a lot of fun for developers.  What you're saying is
fine for the x86 embedded people but as soon as we want to run both
Windows and Linux on the same system we want to try to make sure that
the firmware itself describes the hardware.

Note also that there are already some non-_DSD ways of passing platform
data to ACPI devices (you can read at least integer properties easily)
so it's not just _DSD we have to consider here.

> > +The _DSD object is a very flexible mechanism in ACPI, as are the registered
> > +Device Properties.  This flexibility allows _DSD to cover more than just the
> > +generic server case and care should be taken in device drivers not to expect
> > +it to replicate highly specific embedded behaviour from DT.

> While this is all good, we need to be more specific on what "embedded
> behaviour" means. Maybe not for this document but the UEFI approval
> process for new properties doesn't give any hint on what is and is not
> sane (and I already disagree with some of the examples on uefi.org).

Right, though we also don't want the UEFI approval process to set down
standards that are too heavily tied to a specific view for ARM servers
since ARM servers are not the only users.

> My problems with _DSD:

> a) no clear guidance on what a good property means, whether it covers
>    just device specific information or it may include Linux behaviour
>    (like "linux,default-trigger", I don't think it should)

Right, though some people are going to want to do that.

> b) the Linux kernel community does not seem to be involved in the UEFI
>    forum _DSD review process. This means that we'll be faced with
>    patches against drivers to support UEFI-published _DSD properties.
>    I want to avoid such arguments, rejecting kernel code is too late
>    after _DSD properties have been published

I've been very concerned about this and chasing it up myself.  As far as
I have been able to tell there essentially is no UEFI forum _DSD review
process at this point, the brief bits that are there are essentially
placeholders rather than actual practical things which people expect to
be viable long term and were placed there in the interests of getting
the actual stuff that goes into the tables approved.  There was some
indication that there was an intention to have some discussion early
next year about doing it properly.

It'd certainly be good to get wider involvement from the kernel
community in that discussion, right now I'm a bit concerned that the
standardisation isn't going to be terribly effective in reaching
everyone it needs to or relevant to them.

Personally I'm mainly interested in making sure we can ideally
facilitate conversation with the Windows driver people and at worst can
set good practice standards for them which make life easier for Linux
when followed even if there's a degree of reverse engineerinng involved.

> The alternative to _DSD would be to program the hardware to some sane
> state. For example, I'm sure a MAC address can be written by firmware to
> some register and the driver can read and store it locally (I'm not even
> sure why we need MAC address in ACPI tables, this is not really a
> property of the hardware but a configuration that could be done in
> firmware).

On the other hand something like a MAC address is a useful placeholder
for discussion since there's no real debate about the technical aspects
of representing it allowing everyone to focus on the process.

> > +ASWG
> > +----
> > +The following areas are not yet fully defined for ARM in the 5.1 version
> > +of the ACPI specification and are expected to be worked through in the
> > +UEFI ACPI Specification Working Group (ASWG):

> > +   -- ACPI based CPU topology
> > +   -- ACPI based Power management
> > +   -- CPU idle control based on PSCI
> > +   -- CPU performance control (CPPC)
> > +   -- ACPI based SMMU
> > +   -- ITS support for GIC in MADT

> In addition to the above and _DSD requirements/banning, I would also add
> some clear statements around:

I'd not go that far with _DSD, I am unhappy with the current state of
the world but I'm not sure how relevant the process is going to be and
that anything more than a very strong disrecommendation is going to make
sense.

> Compatibility with older kernels: ACPI firmware must work, even though
> not fully optimal, with the earliest kernel version implementing the
> targeted ACPI spec. There may be a need for new drivers but otherwise
> adding things like CPU power management should not break older kernel
> versions. In addition, the ACPI firmware must also work with the latest
> kernel version.

The backwards compatibility thing sounds a bit strongly worded - I think
that's something the customers would probably sort out anyway to the
extent it's important.  It's obviously good to recommend that people
keep as much backwards compatibility as they can since if nothing else
it makes it easier for people to use their hardware but it doesn't seem
unreasonable to decide that supporting older kernels (or more to the
point older distro releases) isn't that interesting for whatever reason.

> I strongly consider that we need to be very strict with the Linux ACPI
> firmware and hardware requirements to avoid the need for supporting
> non-standard implementations as much as possible. This is, however, a
> live document, so we can relax it as we see fit (e.g. _DSD process
> clarified).

To the extent that it is specific to ARM server that should be fine,
however when it comes to actually enforcing standards for how the kernel
behaves then that's a different story - there are other communities with
different goals and interests.  This in turn means that there will be
things that actually practically work and that have become an ABI for
another community.  Once that happens I'm not sure it's constructive to
try to enforce not using them on ARM, and if people manage to ship
systems we care about it's game over anyway.

I don't know that it's reasonable to expect people to enforce this from
the kernel side - with my subsystem maintainer hat on I really don't
know that I care if some ACPI thing is being done for the benefit of an
ARM server or if it's being done for the benefit of an x86 embedded box
and I'm actually interested.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141226/8cd03b17/attachment-0001.sig>
