From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Sat, 14 Dec 2013 16:51:15 +0100
Subject: [PATCHv6+ 01/13] of: introduce
 of_property_for_earch_phandle_with_args()
In-Reply-To: <20131212.141404.684884000513445038.hdoyu@nvidia.com>
References: <20131211.153338.2186623380643957232.hdoyu@nvidia.com><20131212113417.BDCD0C40637@trevor.secretlab.ca><20131212.141404.684884000513445038.hdoyu@nvidia.com>
Message-ID: <20131214.175115.1251935659998248370.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hiroshi Doyu <hdoyu@nvidia.com> wrote @ Thu, 12 Dec 2013 14:14:04 +0200 (EET):

> > > From 8f7c0404aa68f0e8dbe0babc240590f6528ecc1f Mon Sep 17 00:00:00 2001
> > > From: Hiroshi Doyu <hdoyu@nvidia.com>
> > > Date: Fri, 15 Nov 2013 10:52:53 +0200
> > > Subject: [PATCH] of: introduce of_property_for_each_phandle_with_args()
> > >
> > > Iterating over a property containing a list of phandles with arguments
> > > is a common operation for device drivers. This patch adds a new
> > > of_property_for_each_phandle_with_args() macro to make the iteration
> > > simpler.
> > >
> > > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > > Cc: Rob Herring <robherring2@gmail.com>
....
> > > ---
> > >  drivers/of/base.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/of.h | 32 ++++++++++++++++++++++++++++++++
> > >  2 files changed, 78 insertions(+)
> > >
> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > index f807d0e..cd4ab05 100644
> > > --- a/drivers/of/base.c
> > > +++ b/drivers/of/base.c
> > > @@ -1201,6 +1201,52 @@ void of_print_phandle_args(const char *msg, const struct of_phandle_args *args)
> > >       printk("\n");
> > >  }
> > >
> > > +const __be32 *of_phandle_iter_next(const char *cells_name, int cell_count,
> > > +                                const __be32 *cur, const __be32 *end,
> > > +                                struct of_phandle_args *out_args)
> > 
> > Having to pass in cells_name, cell_count, cur and end each time seems a
> > little odd. Can a state structure be used instead?
> > 
> > struct of_phandle_iter_state {
> >         const char *cells_name;
> >         int cells_count;
> >         const __be32 *cur;
> >         const __be32 *end;
> >         struct of_phandle_args out_args;
> > }
> > 
> > Make the caller provide one of those and fill it in with the init
> > function.
> 
> I rewrote this a few times and so now I have a few version of this
> implementations :-) The above proposal is similar to the version v6+++
> mentioned in the above patch note:
> 
> > > v6+++:
> > > Introduced a new struct "of_phandle_iter" to keep the state when
> > > iterating over the list.
> 
> which is:
> 
>   [RFC][PATCHv6+++ 01/13] of: introduce of_property_for_earch_phandle_with_args()
>     http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007087.html
> 
> Stephen seemed to prefer the version without state struct. I like the
> idea to not pass the same arguments repeatly. Instead, wrapping them
> in a struct with state may look better.
> 
> So if Stephen agrees, I'll rewrite the version with state struct
> again.

Stephen, let me know what you think.
