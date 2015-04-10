From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Apr 2015 14:44:29 +0200
Subject: [PATCH 5/6] drm/armada: gem: Use drm_clflush_*() functions
In-Reply-To: <20150410120802.GE12732@n2100.arm.linux.org.uk>
References: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
 <1428590049-20357-5-git-send-email-thierry.reding@gmail.com>
 <20150410120802.GE12732@n2100.arm.linux.org.uk>
Message-ID: <20150410124427.GA32473@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 01:08:02PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 09, 2015 at 04:34:08PM +0200, Thierry Reding wrote:
> > diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
> > index 580e10acaa3a..c2d4414031ab 100644
> > --- a/drivers/gpu/drm/armada/armada_gem.c
> > +++ b/drivers/gpu/drm/armada/armada_gem.c
> > @@ -453,19 +453,14 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
> >  			sg_set_page(sg, page, PAGE_SIZE, 0);
> >  		}
> >  
> > -		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0) {
> > -			num = sgt->nents;
> > -			goto release;
> > -		}
> > +		drm_clflush_sg(sgt);
> >  	} else if (dobj->page) {
> >  		/* Single contiguous page */
> >  		if (sg_alloc_table(sgt, 1, GFP_KERNEL))
> >  			goto free_sgt;
> >  
> >  		sg_set_page(sgt->sgl, dobj->page, dobj->obj.size, 0);
> > -
> > -		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
> > -			goto free_table;
> > +		drm_clflush_sg(sgt);
> >  	} else if (dobj->linear) {
> >  		/* Single contiguous physical region - no struct page */
> >  		if (sg_alloc_table(sgt, 1, GFP_KERNEL))
> > @@ -480,7 +475,6 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
> >   release:
> >  	for_each_sg(sgt->sgl, sg, num, i)
> >  		page_cache_release(sg_page(sg));
> > - free_table:
> >  	sg_free_table(sgt);
> >   free_sgt:
> >  	kfree(sgt);
> > @@ -494,9 +488,6 @@ static void armada_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
> >  	struct armada_gem_object *dobj = drm_to_armada_gem(obj);
> >  	int i;
> >  
> > -	if (!dobj->linear)
> > -		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
> > -
> 
> I'm really wonder where this is the right thing to do.

I think it isn't the right thing to do in this case indeed. Both Tegra
and MSM were using this pattern to make sure that caches are invalidated
upon allocation of memory from shmemfs, but I now realize that for the
Armada driver this isn't the case.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150410/629c796e/attachment.sig>
