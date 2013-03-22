From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 22 Mar 2013 11:12:39 +0100
Subject: [PATCH v5 01/17] of/pci: Provide support for parsing PCI DT
 ranges property
In-Reply-To: <1363887025-19931-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1363887025-19931-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1363887025-19931-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130322101238.GA22929@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 06:30:09PM +0100, Thomas Petazzoni wrote:
> From: Andrew Murray <Andrew.Murray@arm.com>
> 
> This patch factors out common implementations patterns to reduce overall kernel
> code and provide a means for host bridge drivers to directly obtain struct
> resources from the DT's ranges property without relying on architecture specific
> DT handling. This will make it easier to write archiecture independent host bridge
> drivers and mitigate against further duplication of DT parsing code.
> 
> This patch can be used in the following way:
> 
> 	struct of_pci_range_iter iter;
> 	for_each_of_pci_range(&iter, np) {
> 
> 		//directly access properties of the address range, e.g.:
> 		//iter.pci_space, iter.pci_addr, iter.cpu_addr, iter.size or
> 		//iter.flags
> 
> 		//alternatively obtain a struct resource, e.g.:
> 		//struct resource res;
> 		//range_iter_fill_resource(iter, np, res);
> 	}
> 
> Additionally the implementation takes care of adjacent ranges and merges them
> into a single range (as was the case with powerpc and microblaze).
> 
> The modifications to microblaze, mips and powerpc have not been tested.
> 
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> 
> Compared to the v2 sent by Andrew Murray, Thomas Petazzoni did:
> 
>  * Add a memset() on the struct of_pci_range_iter when starting the
>    for loop in for_each_pci_range(). Otherwise, with an uninitialized
>    of_pci_range_iter, of_pci_process_ranges() may crash.

This sounds like you're trying to do too much within the for loop. When
we discussed this previously I had a vague idea that this functionality
could be wrapped into something a bit more object-like.

What I had in mind was something like:

	struct of_pci_range_parser;
	struct of_pci_range;

	struct of_pci_range_parser parser;
	struct of_pci_range range;

	err = of_pci_range_parser(&parser, np);
	if (err < 0)
		return err;

	for_each_of_pci_range(range, parser) {
		struct resource res;

		...
		usage of range similar to iterator
		...

		of_pci_range_to_resource(&res, &range);
	}

In the above the of_pci_range structure pretty much replaces the
iterator and the whole is wrapped up within a parser structure to give
some extra flexibility and provides for easier (or more structured)
setup compared to doing all of it within the loop statement.

But aside from the (perceived?) increased robustness there's not a lot
of technical benefit over your implementation, so it isn't a very hard
objection. I find it to be a little more encapsulated and therefore
easier to work with, but that's possibly just a matter of taste.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/2d6a0f6d/attachment.sig>
