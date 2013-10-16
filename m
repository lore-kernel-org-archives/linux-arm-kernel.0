From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Oct 2013 10:20:40 +0200
Subject: [PATCH v2 08/10] of/platform: Resolve interrupt references at
 probe time
In-Reply-To: <20131015232436.19F61C40099@trevor.secretlab.ca>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-9-git-send-email-treding@nvidia.com>
 <20131015232436.19F61C40099@trevor.secretlab.ca>
Message-ID: <20131016082039.GA21963@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 12:24:36AM +0100, Grant Likely wrote:
> On Wed, 18 Sep 2013 15:24:50 +0200, Thierry Reding <thierry.reding@gmail.com> wrote:
> > Interrupt references are currently resolved very early (when a device is
> > created). This has the disadvantage that it will fail in cases where the
> > interrupt parent hasn't been probed and no IRQ domain for it has been
> > registered yet. To work around that various drivers use explicit
> > initcall ordering to force interrupt parents to be probed before devices
> > that need them are created. That's error prone and doesn't always work.
> > If a platform device uses an interrupt line connected to a different
> > platform device (such as a GPIO controller), both will be created in the
> > same batch, and the GPIO controller won't have been probed by its driver
> > when the depending platform device is created. Interrupt resolution will
> > fail in that case.
> 
> What is the reason for all the rework on the irq parsing return values?
> A return value of '0' is always an error on irq parsing, regardless of
> architecture even if NO_IRQ is defined as -1. I may have missed it, but
> I don't see any checking for specific error values in the return paths
> of the functions.
> 
> If the specific return value isn't required (and I don't think it is),
> then you can simplify the whole series by getting rid of the rework
> patches.

The whole reason for this patch set is to propagate the precise error
code so that when one of the top-level OF IRQ functions is called (such
as irq_of_parse_and_map()) the caller can actually make an reasonable
choice on how to handle the error.

More precisely, the goal of this series was to propagate failure to
create a mapping, due to an IRQ domain not having been registered yet
for the device node passed into irq_create_of_mapping(), back to the
caller, irq_of_parse_and_map(), which can then propagate it further.
Ultimately this will allow driver probing to fail with EPROBE_DEFER
when IRQ mapping fails and allow deferred probing to be triggered.

This cannot be done if all you have as error status is 0. Mapping of
IRQs can fail for a number of reasons, such as when an IRQ descriptor
cannot be allocated or when an IRQ domain's .xlate() fails. You don't
want to be deferring probe on all errors because some of them are
genuinely fatal and cannot be recovered from by deferring probe.

With the current implementation in the kernel, interrupt references are
resolved very early, usually when a device is instantiated from the
device tree. So unless all interrupt parents of all devices have been
probed by that time (which usually can only be done using explicit
initcall ordering, and even in that case doesn't always work) then many
devices will end up with an invalid interrupt number.

The typical case where this can happen is if you have a GPIO expander on
an I2C bus that provides interrupt services to other devices. With the
current implementation, the GPIO expander will be probed fairly late, at
which point many of its users will already have been instantiated and
assigned an invalid interrupt. Many drivers try to work around that by
explicitly calling irq_of_parse_and_map() within their .probe() function
because that's usually called sometime after the device's instantiation.
However even that isn't guaranteed to work. If the GPIO expander depends
itself on other resources that cause it to require deferred probing, or
if its driver is built as a module and therefore making the registration
of the corresponding IRQ domain is completely non-deterministic, then
this can fail just as easily.

With this patch series all of these issues should go away. All of the
dependencies should be resolvable by using deferred probing. Furthermore
the mechanism introduced to have the core resolve the IRQ references can
be used to request other standard resources as well. A particular one
that I'm aware of is how IOMMUs are associated with devices. Currently a
variety of quirks have been proposed to work around these issues, such
as reordering nodes in the device tree, which only work because the DTC
implementation that everybody uses happens to keep them ordered in the
same way in the DTB as they were in the DTS.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131016/211ce935/attachment-0001.sig>
