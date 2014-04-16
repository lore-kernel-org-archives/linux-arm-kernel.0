From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 16 Apr 2014 11:01:52 -0400 (EDT)
Subject: [PATCH v3 0/4] Allow OHCI/EHCI drivers to override more hub
 operations
In-Reply-To: <1397654215-23699-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <Pine.LNX.4.44L0.1404161101090.1334-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Apr 2014, Laurent Pinchart wrote:

> Hello,
> 
> The PXA27x OHCI implementation doesn't perform automatic control of port power
> supplies for all ports. While the PPS and LSDA bits of the HcRhPortStatus
> register are implemented, only a subset of ports have an external power enable
> pin controlled by the port status register. Other ports need their power supply
> to be controlled manually.
> 
> In order to do so I've implemented manual regulator control in the ohci-pxa27x
> driver. This requires overriding the default behaviour of the CLEAR_FEATURE
> and SET_FEATURE requests for USB_PORT_FEAT_POWER with a custom hub control
> operation. In turn this requires calling the currently static ohci_hub_control
> function from the ohci-pxa27x driver.
> 
> The ohci-at91 and ohci-s3c2410 drivers already implement a similar feature,
> and access the ohci_hub_control and ohci_hub_status_data functions by saving
> the struct hc_driver hub_control and hub_status_data values to a variables
> right after calling ohci_init_driver. This vtable-like implementation can be
> optimized by exporting the ohci_hub_control and ohci_hub_status_data functions
> and calling them directly. As the ohci-pxa27x driver needs to override hub
> control operations as well I've decided to export the functions.
> 
> For the sake of completeness I've also exported the ehci_hub_control function
> and modified the ehci-tegra driver to call it directly.
> 
> As a side note regarding the ohci-at91 driver, the "atmel,vbus-gpio" DT
> property should really have referenced a regulator instead of a GPIO. Fixing
> this in a backward-compatible way would be messy :-(
> 
> Please note that I haven't been able to test the third and fourth patches due
> to lack of hardware. I've however tested a similar implementation for OHCI on
> an out of tree PXA270 board.
> 
> Changes compared to v2:
> 
> - Export ohci_hub_status_data()
> - Call ohci_hub_status_data() directly from ohci-at91 and ohci-s3c2410
> 
> Changes compared to v1:
> 
> - Export ehci_hub_control()
> - Call ehci_hub_control() directly from ehci-tegra
> - Call ohci_hub_control() directly from ohci-at91

For patches 1 and 2:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Comments on patch 3 sent separately.

Alan Stern
