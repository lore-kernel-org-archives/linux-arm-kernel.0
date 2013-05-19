From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 19 May 2013 16:31:56 -0400
Subject: [PATCHv10 2/9] of/pci: Provide support for parsing PCI DT
 ranges property
In-Reply-To: <1368719725-21265-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368719725-21265-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130519203156.GO11137@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 05:55:17PM +0200, Thomas Petazzoni wrote:
> From: Andrew Murray <Andrew.Murray@arm.com>
> 
> This patch factors out common implementation patterns to reduce overall kernel
> code and provide a means for host bridge drivers to directly obtain struct
> resources from the DT's ranges property without relying on architecture specific
> DT handling. This will make it easier to write archiecture independent host bridge
> drivers and mitigate against further duplication of DT parsing code.
> 
> This patch can be used in the following way:
> 
> 	struct of_pci_range_parser parser;
> 	struct of_pci_range range;
> 
> 	if (of_pci_range_parser_init(&parser, np))
> 		; //no ranges property
> 
> 	for_each_of_pci_range(&parser, &range) {
> 
> 		/*
> 			directly access properties of the address range, e.g.:
> 			range.pci_space, range.pci_addr, range.cpu_addr,
> 			range.size, range.flags
> 
> 			alternatively obtain a struct resource, e.g.:
> 			struct resource res;
> 			of_pci_range_to_resource(&range, np, &res);
> 		*/
> 	}
> 
> Additionally the implementation takes care of adjacent ranges and merges them
> into a single range (as was the case with powerpc and microblaze).
> 
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/of/address.c       |   67 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_address.h |   48 +++++++++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)

patches 2, 3, and 4 applied to mvebu/of_pci to facilitate others
(LinusW) basing their work off of it.

thx,

Jason.
