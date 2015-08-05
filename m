From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Wed, 5 Aug 2015 19:53:59 +0000
Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
In-Reply-To: <CALRxmdA32xiSX7DDKAJPLR8=bh_9j-6MN124u4KjYGRT8bAKNg@mail.gmail.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-3-git-send-email-mark.rutland@arm.com>
 <CALRxmdA32xiSX7DDKAJPLR8=bh_9j-6MN124u4KjYGRT8bAKNg@mail.gmail.com>
Message-ID: <CY1PR0301MB07486794749E499F71BDFCD287750@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Mark Rutland <mark.rutland@arm.com>
> Date: Thu, Jul 23, 2015 at 11:52 AM

[cut]

> diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt
> b/Documentation/devicetree/bindings/pci/pci-msi.txt
> new file mode 100644
> index 0000000..9b3cc81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
> @@ -0,0 +1,220 @@
> +This document describes the generic device tree binding for describing the
> +relationship between PCI devices and MSI controllers.
> +
> +Each PCI device under a root complex is uniquely identified by its Requester ID
> +(AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
> +Function number.
> +
> +For the purpose of this document, when treated as a numeric value, a RID is
> +formatted such that:
> +
> +* Bits [15:8] are the Bus number.
> +* Bits [7:3] are the Device number.
> +* Bits [2:0] are the Function number.
> +* Any other bits required for padding must be zero.
> +
> +MSIs may be distinguished in part through the use of sideband data accompanying
> +writes. In the case of PCI devices, this sideband data may be derived from the
> +Requester ID. A mechanism is required to associate a device with both the MSI
> +controllers it can address, and the sideband data that will be associated with
> +its writes to those controllers.
> +
> +For generic MSI bindings, see
> +Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> +
> +
> +PCI root complex
> +================
> +
> +Optional properties
> +-------------------
> +
> +- msi-map: Maps a Requester ID to an MSI controller and associated
> +  msi-specifier data. The property is an arbitrary number of tuples of
> +  (rid-base,msi-controller,msi-base,length), where:
> +
> +  * rid-base is a single cell describing the first RID matched by the entry.
> +
> +  * msi-controller is a single phandle to an MSI controller
> +
> +  * msi-base is an msi-specifier describing the msi-specifier produced for the
> +    first RID matched by the entry.
> +
> +  * length is a single cell describing how many consecutive RIDs are matched
> +    following the rid-base.
> +
> +  Any RID r in the interval [rid-base, rid-base + length) is associated with
> +  the listed msi-controller, with the msi-specifier (r - rid-base + msi-base).
> +
> +- msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
> +  to an msi-specifier per the msi-map property.

Can we extend the msi-map-mask definition to say:  "A mask value of 0x0 is valid
and indicates that no RIDs are _currently_ mapped to any msi-specifier."

We have an SoC with a programmable hardware table in the PCI controller that maps
requester ID to stream ID, so the overall msi-map (and iommu-map) definition fit
into that scheme.  But, we would like to be able make the RID->stream-ID mapping
decision _lazily_, in Linux, based on actual usage of PCI devices.

      pcie at 3600000 {
              compatible = "fsl,ls2085a-pcie", "snps,dw-pcie";
              device_type = "pci";
              ...
              msi-map = <0x0 &msi_a 0x7 4>,
              msi-map-mask = <0x0>
      };

That specifies the there are 4 stream IDs starting at stream ID 0x7, 
but the requester ID's are not mapped (because the mask is 0x0).
This tells the PCI controller driver that there are 4 msi-specifiers
(e.g. stream IDs) available and what they are.

(same definition would apply to the iommu-map-mask)

Thanks,
Stuart
