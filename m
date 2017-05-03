From: robh@kernel.org (Rob Herring)
Date: Wed, 3 May 2017 15:06:27 -0500
Subject: [PATCH 3/3] PCI/of fix of_dma_get_range;
 get PCI specific dma-ranges
In-Reply-To: <1493786795-28153-3-git-send-email-oza.oza@broadcom.com>
References: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
 <1493786795-28153-3-git-send-email-oza.oza@broadcom.com>
Message-ID: <CAL_JsqL+rK1QZD12cHWwWL9=wrwQ34FiaQ7syz4YVs571X5mKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 2, 2017 at 11:46 PM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
> current device framework and of framework integration assumes
> dma-ranges in a way where memory-mapped devices define their
> dma-ranges. (child-bus-address, parent-bus-address, length).
>
> of_dma_configure is specifically written to take care of memory
> mapped devices. but no implementation exists for pci to take
> care of pcie based memory ranges.
>
> for e.g. iproc based SOCs and other SOCs(suc as rcar) have PCI
> world dma-ranges.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
>
> this patch fixes this patch fixes the bug in of_dma_get_range,
> which with as is, parses the PCI memory ranges and return wrong
> size as 0.
>
> in order to get largest possible dma_mask. this patch also
> retuns the largest possible size based on dma-ranges,
>
> for e.g.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
> we should get dev->coherent_dma_mask=0x7fffffffff.
>
> based on which iova allocation space will honour PCI host
> bridge limitations.
>
> Bug: SOC-5216
> Change-Id: I4c534bdd17e70c6b27327d39d1656e8ed0cf56d6
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-on: http://gerrit-ccxsw.broadcom.net/40762
> Reviewed-by: vpx_checkpatch status <vpx_checkpatch@broadcom.com>
> Reviewed-by: CCXSW <ccxswbuild@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Tested-by: vpx_autobuild status <vpx_autobuild@broadcom.com>
> Tested-by: vpx_smoketest status <vpx_smoketest@broadcom.com>
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 02b2903..f7734fc 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -6,6 +6,7 @@
>  #include <linux/ioport.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/pci_regs.h>
>  #include <linux/sizes.h>
> @@ -830,6 +831,54 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>         int ret = 0;
>         u64 dmaaddr;
>
> +#ifdef CONFIG_PCI
> +       struct resource_entry *window;
> +       LIST_HEAD(res);
> +
> +       if (!node)
> +               return -EINVAL;
> +
> +       if (of_bus_pci_match(np)) {

You are not following what I'm saying. Let me spell it out:

- Add a get_dma_ranges() function to of_bus struct. Or maybe should
cover ranges too (e.g. get_ranges). I'm not sure.
- Convert existing contents of this function to
of_bus_default_dma_get_ranges and add that to the default of_bus
struct.
- Make of_dma_get_range call of_bus_match() and then bus->get_dma_ranges.

Rob
