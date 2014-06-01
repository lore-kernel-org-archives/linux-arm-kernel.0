From: will.deacon@arm.com (Will Deacon)
Date: Sun, 1 Jun 2014 10:55:46 +0100
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <4462924.8iRbdkOPp7@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <4545972.cM7IP1qTXQ@wuerfel> <87tx87rrp2.fsf@nvidia.com>
 <4462924.8iRbdkOPp7@wuerfel>
Message-ID: <20140601095546.GA8625@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 08:54:37PM +0100, Arnd Bergmann wrote:
> On Friday 30 May 2014 22:29:13 Hiroshi Doyu wrote:
> > Tegra,SMMU has a similar problem and we have used a fixed size bitmap(64
> > bit) to afford 64 stream IDs so that a single device can hold multiple
> > IDs. If we apply the same bitmap to the above exmaple:
> > 
> >        iommu {
> >                /* the specifier represents the ID of the master */
> >                #address-cells = <1>;
> >                #size-cells = <0>;
> >        };
> > 
> >         master at a {
> >                 ...
> >                 iommus = <&smmu (BIT(1) | BIT(2) | BIT(3))>; # IDs 1 2 3
> >         };
> > 
> >         master at b {
> >                 ...
> >                 iommus = <&smmu BIT(4)>;     # ID 4
> >         };
> > 
> > The disadvantage of this is that this limits the max number of streamIDs
> > to support. If # of streamID is increased later more than 64, this
> > format cannot cover any more. You have to predict the max # of streamIDs
> > in advance if steamID is statically assigned.
> > 
> 
> Well, the iommu specific binding could allow a variable #address-cells.
> That way, you just need to know the number of stream IDs for that instance
> of the iommu.

In general, though, the SMMU will be able to support a large number of
stream IDs (say a 16-bit space). The restriction we're interested in here is
how many different stream IDs can be emitted by a single master device
coming into the SMMU. *That* is a property of the master, not the SMMU.

In the current arm,smmu binding I have a #stream-id-cells property in each
master. I can then feed that straight into of_parse_phandle_with_args to
enumerate the IDs for that master. The problem with that is we're
artificially restricted by MAX_PHANDLE_ARGS.

Will
