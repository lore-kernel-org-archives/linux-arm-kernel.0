From: dhdang@apm.com (Duc Dang)
Date: Thu, 17 Sep 2015 11:19:45 -0700
Subject: [PATCH v8 0/3] usb: xhci-platform: Configure 64-bit DMA mask if the
 platform is capable
In-Reply-To: <CADaLNDno0cLXH3_4NG75fk6T31Pe5BCrbcUpA0cGriCwSh6OyQ@mail.gmail.com>
References: <CADaLNDno0cLXH3_4NG75fk6T31Pe5BCrbcUpA0cGriCwSh6OyQ@mail.gmail.com>
Message-ID: <cover.1442513540.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xhci platform driver does not work with system that only supports
64-bit DMA as it requests 32-bit DMA mask during driver initialization.
This patch set addresses this issue and also adds XHCI-compliant USB
Controller ACPI identification into xhci-platform driver.

Changes from v7:
        - Only use dma_coerce_mask_and_coherent when
        dma_mask is NULL
        - Check the controller DMA capability and configure
        32-bit dma_mask if it only supports 32-bit DMA
        - Patches is generated over v4.3-rc1

Changes from v6:
        -Add WARN_ON if dma_mask is NULL
        -Use dma_coerce_mask_and_coherent to assign
        dma_mask and coherent_dma_mask

Change from v5:
        -Change comment to "XHCI-compliant USB Controller" as
        "PNP0D10" ID is not X-Gene specific
        -Change comment
        -Assign dma_mask to coherent_dma_mask if dma_mask is NULL
        to make sure dma_set_mask_and_coherent does not fail prematurely.

Changes from v4:
        -Remove #ifdef CONFIG_ACPI
        -Change comment
        -Assign dma_mask to coherent_dma_mask if dma_mask is NULL
        to make sure dma_set_mask_and_coherent does not fail prematurely.

Changes from v3:
        -Regenerate the patch over 4.2-rc5
        -No code change

Changes from v2
        -Replaced tristate with a boolean as the driver doesn't
                compile as a module
        -Correct --help-- to ---help---

Changes from v1
        -Consolidated to use dma_set_mask_and_coherent
        -Got rid of the check against sizeof(dma_addr_t)
        -Renamed from "add support for APM X-Gene to xhci-platform"
        -Removed changes to arm64/Kconfig
        -Made CONFIG_USB_XHCI_PLATFORM a user selectable config option

 drivers/usb/host/xhci-plat.c | 29 ++++++++++++++++++++++-------
 drivers/usb/host/xhci.c      | 10 ++++++++++
 2 files changed, 32 insertions(+), 7 deletions(-)

-- 
1.9.1
