From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 19 May 2014 22:32:33 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140519172113.GA13858@e103592.cambridge.arm.com>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <4391809.OTRCiJQXS4@wuerfel> <20140519125336.GA9466@ulmo>
 <20140519172113.GA13858@e103592.cambridge.arm.com>
Message-ID: <20140519203232.GD30737@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 06:22:31PM +0100, Dave Martin wrote:
> On Mon, May 19, 2014 at 01:53:37PM +0100, Thierry Reding wrote:
[...]
> > My understanding here is mostly based on the OpenFirmware working group
> > proposal for the dma-ranges property[0]. I'll give another example to
> > try and clarify how I had imagined this to work:
> > 
> > 	/ {
> > 		#address-cells = <2>;
> > 		#size-cells = <2>;
> > 
> > 		iommu {
> > 			/*
> > 			 * This is somewhat unusual (or maybe not) in that we
> > 			 * need 2 cells to represent the size of an address
> > 			 * space that is 32 bits long.
> > 			 */
> > 			#address-cells = <1>;
> > 			#size-cells = <2>;
> > 
> > 			#iommu-cells = <1>;
> > 		};
> > 
> > 		master {
> > 			iommus = <&/iommu 42>;
> 
> Comparing this with the other discussion thread, we have a similar
> concept here, in that the iommu is made a logical parent, however...
> 
> Firstly, there's an implicit assumption here that the only kind of
> thing the master could possibly be connected to is an IOMMU, with
> no non-trivial interconnect in between.  I'm not sure this is going
> to scale to complex SoCs.

Here we go again. We're now in the very same bad spot that we've been in
so many times before. There are at least two SoCs that we know do not
require anything fancy, yet we're blocking adding support for those use
cases because we think that at some point some IOMMU may require more
than that. But at the same time it seems like we don't have enough data
about what exactly that is, so we keep speculating. At this rate we're
making it impossible to get a reasonable feature set supported upstream.

That's very frustrating.

> If a range of Stream IDs may be issued (especially from something like
> a PCIe RC where the stream ID may be a many-bit value), describing
> the IDs individually may be impractical.

The IOMMU specifier is completely specific to the IOMMU. If an IOMMU has
a need to represent the stream IDs as a range there's nothing keeping it
from defining the specifier accordingly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/b4ae2897/attachment.sig>
