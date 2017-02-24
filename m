From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Feb 2017 15:18:23 +0000
Subject: [RFC PATCH v1] iommu/io-pgtable-arm-v7s: Check for leaf entry
 right after finding it
In-Reply-To: <CAPD2p-nPoiSanU4jYvnaYtAbbERE8c=4mLjTC3NX2bGYkZM5UA@mail.gmail.com>
References: <1487253137-13792-1-git-send-email-olekstysh@gmail.com>
 <bc24299c-748a-4b86-fead-a9ed6b5e5b9f@arm.com>
 <CAPD2p-nPoiSanU4jYvnaYtAbbERE8c=4mLjTC3NX2bGYkZM5UA@mail.gmail.com>
Message-ID: <20170224151823.GH20130@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 03:31:26PM +0200, Oleksandr Tyshchenko wrote:
> On Tue, Feb 21, 2017 at 2:00 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> > Would it not be more logical (and simpler) to just check that the thing
> > we dereference is valid to dereference when we dereference it? i.e.:
> >
> > -----8<-----
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c
> > b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 0769276c0537..f3112f9ff494 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -418,8 +418,10 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable
> > *data, unsigned long iova,
> >                         pte |= ARM_V7S_ATTR_NS_TABLE;
> >
> >                 __arm_v7s_set_pte(ptep, pte, 1, cfg);
> > -       } else {
> > +       } else if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
> >                 cptep = iopte_deref(pte, lvl);
> > +       } else {
> > +               return -EEXIST;
> >         }
> >
> >         /* Rinse, repeat */
> > ----->8-----
> 
> Agree. Sounds reasonable.
> 
> >
> > I think the equivalent could be done in LPAE as well.
> 
> OK.
> 
> I will resend both modified patches without RFC prefix, right?

Sounds good to me.

Will
