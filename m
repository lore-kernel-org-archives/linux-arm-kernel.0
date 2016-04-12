From: sricharan@codeaurora.org (Sricharan)
Date: Tue, 12 Apr 2016 20:57:11 +0530
Subject: [PATCH V2 1/5] iommu/msm: Add DT adaptation
In-Reply-To: <6297087.btlKtGepct@avalon>
References: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
 <1459952975-1250-2-git-send-email-sricharan@codeaurora.org>
 <6297087.btlKtGepct@avalon>
Message-ID: <009e01d194cf$cd101760$67304620$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,
  Thanks for the review.


> +  - #iommu-cells: This is the total number of stream ids that a
> > + master
> > would
> > +		  use during transactions which will be specified as a list
> > +		  as a part of iommus property below.
> 
> That's not correct. #iommu-cells, as defined in the core IOMMU DT
bindings,
> is "the number of cells in an IOMMU specifier needed to encode an address"
> (address being a stream id here).
> 
> Can the number of cells differ from instance to instance, or is it always
2 ?

    Ah, you are right.  For this and the below, this should be ideally '1'
as the
    Stream ids for a master here are represented by a single cell.  I should
    change my xlate function to take care of this.
 
> 
> > +  - ncb: The total number of context banks in the IOMMU.
> 
> Should this be qcom,ncb ?
> 
  Ya, will change this.

> > +  - clocks	: List of clocks to be used during SMMU register access. See
> > +		  Documentation/devicetree/bindings/clock/clock-
> bindings.txt
> > +		  for information about the format. For each clock specified
> > +		  here, there must be a corresponding entry in clock-names
> > +		  (see below).
> > +
> > +  - clock-names	: List of clock names corresponding to the clocks
> specified
> > in
> > +		  the "clocks" property (above). See
> > +		  Documentation/devicetree/bindings/clock/clock-
> bindings.txt
> > +		  for more info.
> > +
> > +Each bus master connected to an IOMMU must reference the IOMMU in
> its
> > device
> > +node with the following property:
> > +
> > +  - iommus: A reference to the IOMMU in multiple cells. The first cell
is a
> > +	    phandle to the IOMMU and the second cell is the list of the
> > +	    stream ids used by the device.
> 
> You mention in your cover letter that a master device can be connected to
> multiple iommus, shouldn't that be stated here ? On the same topic, do
your
> masters need to selectively enable/disable memory ports to IOMMUs, or can
> they all be enabled/disabled together ?
>
 They are connected to all iommus and ports and enabled/disabled together.
 I will add little more description here for this here.

> Also, the second cell can't be a list of stream ids, as one cell stores
one value.
> A master device using multiple stream ids should use multiple entries in
the
> iommus property.
> 
 Yes, true. Wrong usage here and as I said above should be corrected.
  
> > +Example: mdp iommu and its bus master
> > +
> > +                mdp_port0: qcom,iommu at 7500000 {
> 
> I think you can use iommu instead of qcom,iommu.
    Ok, right.

Regards,
 Sricharan
