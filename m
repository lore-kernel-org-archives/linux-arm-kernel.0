From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 11 Jan 2013 05:02:10 +0100
Subject: [PATCH 01/14] of/pci: Provide support for parsing PCI DT ranges
 property
In-Reply-To: <50EF5798.6040405@wwwdotorg.org>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-2-git-send-email-thierry.reding@avionic-design.de>
 <50EF5798.6040405@wwwdotorg.org>
Message-ID: <20130111040210.GC28094@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 05:06:48PM -0700, Stephen Warren wrote:
> On 01/09/2013 01:43 PM, Thierry Reding wrote:
> > From: Andrew Murray <andrew.murray@arm.com>
> > 
> > DT bindings for PCI host bridges often use the ranges property to describe
> > memory and IO ranges - this binding tends to be the same across architectures
> > yet several parsing implementations exist, e.g. arch/mips/pci/pci.c,
> > arch/powerpc/kernel/pci-common.c, arch/sparc/kernel/pci.c and
> > arch/microblaze/pci/pci-common.c (clone of PPC). Some of these duplicate
> > functionality provided by drivers/of/address.c.
> > 
> > This patch provides a common iterator-based parser for the ranges property, it
> > is hoped this will reduce DT representation differences between architectures
> > and that architectures will migrate in part to this new parser.
> ...
> 
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> 
> > +const __be32 *of_pci_process_ranges(struct device_node *node,
> 
> > +	while (from + np <= end) {
> > +		u64 cpu_addr, size;
> > +
> > +		cpu_addr = of_translate_address(node, from + na);
> > +		size = of_read_number(from + na + pna, ns);
> > +		res->flags = bus->get_flags(from);
> > +		from += np;
> > +
> > +		if (cpu_addr == OF_BAD_ADDR || size == 0)
> > +			continue;
> 
> Hmmm. That seems to just ignore bad entries in the ranges property. Is
> that really the right thing to do? At least printing a diagnostic might
> be a good idea, even if the code does just soldier on in the hope
> everything still works.

That's true. However, erroring out here wouln't be useful either since a
NULL return value is used to mark the end of the iteration and the
caller would have to assume that no more ranges are present. Maybe
that's better than continuing anyway, even if a message is printed.

Alternatively, the of_pci_process_ranges() could be changed to return an
ERR_PTR() encoded errno. This is one case where it makes a lot of sense.
I have a feeling that Grant won't like that very much, though.

Another possibility would be to change away from an iterator-based
approach and return an integer for the number of ranges and negative
error code on failure while returning an allocated array of resources
through an output parameter.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/362dd519/attachment.sig>
