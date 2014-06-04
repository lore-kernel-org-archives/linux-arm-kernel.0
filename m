From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Jun 2014 15:44:03 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <4462924.8iRbdkOPp7@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <4545972.cM7IP1qTXQ@wuerfel> <87tx87rrp2.fsf@nvidia.com>
 <4462924.8iRbdkOPp7@wuerfel>
Message-ID: <20140604134400.GE28484@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 09:54:37PM +0200, Arnd Bergmann wrote:
> On Friday 30 May 2014 22:29:13 Hiroshi Doyu wrote:
> > 
> > IIUC the original problem, "a master with 8 streamIDs" means something
> > like below, where some devices have multiple IDs but some have a
> > single. A sinle #address-cells cannot afford those 2 masters at once.
> > 
> >        iommu {
> >                /* the specifier represents the ID of the master */
> >                #address-cells = <1>;
> >                #size-cells = <0>;
> >        };
> > 
> >         master at a {
> >                 ...
> >                 iommus = <&smmu 1 2 3>; # 3 IDs
> >         };
> > 
> >         master at b {
> >                 ...
> >                 iommus = <&smmu 4>;     # 1 ID
> >         };
> 
> This would not be the usual format really. It should instead be
> 
> 		iommus = <&smmu 1>, <&smmu 2>, <&smmu 3>;
> 
> which can be tedious to type.

"Tedious to type" doesn't sound like a good argument to me. I don't see
why the above would necessarily be a bad notation. It's very much up to
the point and very explicit. This very obviously translates to:

	This device has three master interfaces, one for smmu ID 1, one
	for smmu ID 2 and one for smmu ID 3.

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

That sounds fairly complicated to me. I don't see what that buys us over
the clarity and simplicity that the above explicit notation gives us. Is
it not more common for a device to have a single master rather than a
whole bunch of them?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/8714474f/attachment.sig>
