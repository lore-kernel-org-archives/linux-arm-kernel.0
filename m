From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jun 2014 15:53:27 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140604134400.GE28484@ulmo>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <4462924.8iRbdkOPp7@wuerfel> <20140604134400.GE28484@ulmo>
Message-ID: <5349895.mRr9cbXPnm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 June 2014 15:44:03 Thierry Reding wrote:
> > Well, the iommu specific binding could allow a variable #address-cells.
> > That way, you just need to know the number of stream IDs for that instance
> > of the iommu.
> 
> That sounds fairly complicated to me. I don't see what that buys us over
> the clarity and simplicity that the above explicit notation gives us. Is
> it not more common for a device to have a single master rather than a
> whole bunch of them?

If I understood the problem right, the case that people want to handle
is not actually multiple masters but instead multiple IOMMU contexts, which
you can have in a GPU to handle multiple processes drawing on different
parts of the screen, or in a NIC with virtual functions assigned to KVM
guests or user processes. I don't know what the number of contexts per
device would be here, but I assume it may be large enough to become
a nuisance to list them individually.

Then again, I also don't know how IOMMUs would show those. In the cases
I've seen before, you actually have an ID for the master that is separate
from the context ID, but apparently SMMU isn't that smart.

	Arnd
