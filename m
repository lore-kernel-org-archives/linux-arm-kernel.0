From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Jul 2014 14:49:28 +0100
Subject: [RFC 01/10] iommu: Add IOMMU device registry
In-Reply-To: <20140704134709.GA4203@ulmo>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-2-git-send-email-thierry.reding@gmail.com>
 <20140704110529.GF13434@8bytes.org> <20140704134709.GA4203@ulmo>
Message-ID: <20140704134928.GA25714@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 02:47:10PM +0100, Thierry Reding wrote:
> On Fri, Jul 04, 2014 at 01:05:30PM +0200, Joerg Roedel wrote:
> > On Thu, Jun 26, 2014 at 10:49:41PM +0200, Thierry Reding wrote:
> > > Add an IOMMU device registry for drivers to register with and implement
> > > a method for users of the IOMMU API to attach to an IOMMU device. This
> > > allows to support deferred probing and gives the IOMMU API a convenient
> > > hook to perform early initialization of a device if necessary.
> > 
> > Can you elaborate on why exactly you need this? The IOMMU-API is
> > designed to hide any details from the user about the available IOMMUs in
> > the system and which IOMMU handles which device. This looks like it is
> > going in a completly different direction from that.
> 
> I need this primarily to properly serialize device probing order.
> Without it the IOMMU may be probed later than its clients, in which case
> the client drivers will assume that there is no IOMMU (iommu_present()
> for the parent bus fails).

I can also vouch for needing *a* solution to this problem. The ARM SMMU (and
I think others) rely on initcall ordering rather than the driver probing
model to ensure the IOMMU is probed before any of its masters.

Will
