From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 10 Aug 2017 17:26:13 -0500
Subject: [PATCH v4 0/7] PCI: MediaTek: Add host controller support for
 mt2712 and mt7622
In-Reply-To: <cover.1502336769.git.honghui.zhang@mediatek.com>
References: <cover.1502336769.git.honghui.zhang@mediatek.com>
Message-ID: <20170810222613.GA4142@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 02:34:53PM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> MediaTek's PCIe host controller has two generation HWs, MT2712 and MT7622
> using the new generation HW, which has two root ports. They share most
> probing flow with MT2701/MT7623. But the read/write config space logical
> is different. The per-port registers must be touched for read/write
> configuration space.
> 
> This patchset abstract the common probing flow, and add support for the
> new generation controller.
> 
> Changes since v3:
>  - Unify the macro define's names with PCIE_ prefix.
>  - Use lower/upper_32_bits macro and remove AHB2PCIE_BASEL/AHB2PCIE_BASEH.
>  - Factor out mtk_pcie_find_port to eliminate duplicate code.
>  - Use list_for_each_entry instead of list_for_each_entry_safe when search list.
>  - Simplify the mtk_pcie_hw_rd_cfg flow.
>  - Split a new patch to rename the parameter and function names.
>  - Update the subject and changelog to include specific SoC IDs.
> 
> Changes since v2:
>  - Split the Gen2 training change to a separate patch.
>  - Simplify the config_read/write logical and get rid of mtk_pcie_find_port.
>  - Using bus->sysdata to simplify the code.
>  - Rebase to commit 65b83b13204a ("PCI: mediatek: Explicitly request exclusive
>    reset control")[1].
>  - Fix some misspells.
>  - Add review tags in commit message.
> 
> Changes since v1:
>  - Fix build warnings in arm arch.
>  - Using SoC specific compatible instead of generic compatible.
>  - Add devicetree binding example for mt7622.
>  - Unified the register define names with PCIE_ prefix.
>  - Cleanup some un-necessary condition determine when starup port.
>  - minor code cleanups.
> 
> [1] https://patchwork.kernel.org/patch/9852591/
> 
> Honghui Zhang (2):
>   PCI: mediatek: make the parameter and function names more accurate
>   PCI: mediatek: Add a structure to abstract the controller generations
> 
> Ryder Lee (5):
>   PCI: mediatek: Using readl_poll_timeout to wait Gen2 training
>   PCI: mediatek: switch to use platform_get_resource_byname()
>   dt-bindings: PCI: rename and cleanup MediaTek binding text
>   PCI: mediatek: Add controller support for mt2712 and mt7622
>   dt-bindings: PCI: add support for mt2712 and mt7622
> 
>  .../bindings/pci/mediatek,mt7623-pcie.txt          | 130 -----
>  .../devicetree/bindings/pci/mediatek-pcie.txt      | 284 ++++++++++
>  drivers/pci/host/Kconfig                           |   5 +-
>  drivers/pci/host/pcie-mediatek.c                   | 598 ++++++++++++++++++---
>  4 files changed, 820 insertions(+), 197 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7623-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie.txt

I applied these on pci/host-mediatek for v4.14, thanks!

I did split the rename/cleanup DT patch into two to make the changes more
obvious.
