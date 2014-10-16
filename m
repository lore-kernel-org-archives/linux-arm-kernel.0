From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 16 Oct 2014 21:42:33 +0530
Subject: [PATCH v6 1/3] dma: at_xdmac: creation of the atmel eXtended
 DMA Controller driver
In-Reply-To: <20141016141048.GC2367@ldesroches-Latitude-E6320>
References: <1412175565-810-1-git-send-email-ludovic.desroches@atmel.com>
 <1412175565-810-2-git-send-email-ludovic.desroches@atmel.com>
 <20141015133004.GP1638@intel.com>
 <20141016141048.GC2367@ldesroches-Latitude-E6320>
Message-ID: <20141016161233.GJ1638@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 04:10:48PM +0200, Ludovic Desroches wrote:
> > This is pretty odd, I dont see a reason why we can have proper case values
> > and converted ones. It would have made sense if we use this for conversion
> > but in case values in quite puzzling
> > 
> > > +	case 1:
> > > +		csize = AT_XDMAC_CC_CSIZE_CHK_2;
> > and looking at values this can be ffs(maxburst) - 1 for valid cases
> 
> Yes I can return ffs(maxburst) - 1 for valid cases.
> 
> > > +		break;
> > > +	case 2:
> > > +		csize = AT_XDMAC_CC_CSIZE_CHK_4;
> > > +		break;
> > > +	case 3:
> > > +		csize = AT_XDMAC_CC_CSIZE_CHK_8;
> > > +		break;
> > > +	case 4:
> > > +		csize = AT_XDMAC_CC_CSIZE_CHK_16;
> > > +		break;
> > > +	default:
> > > +		csize = AT_XDMAC_CC_CSIZE_CHK_1;
> > why?
> 
> Because some devices don't set maxburst, for example, our serial driver.
Then pls send a patch against that as well. returniung error here will
ensure that they fix that as well

> > > +
> > > +		prev = desc;
> > > +		if (!first)
> > > +			first = desc;
> > > +
> > > +		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
> > > +			 __func__, desc, first);
> > > +		list_add_tail(&desc->desc_node, &first->descs_list);
> > > +	}
> > > +
> > > +	spin_unlock_bh(&atchan->lock);
> > > +
> > > +	first->tx_dma_desc.cookie = -EBUSY;
> > why are you init cookie here
> 
> Inspired by other driver. What is the right place so?
You dont. Cookie will be set to correct value when the descriptor is
submitted

> > For memcpy why should we need slave_config. The system memory source and
> > destination width could be assumed to relastic values and then burst sizes
> > maxed for performance. These values make more sense for periphral where we
> > have to match up with the periphral
> 
> I don't tell I need slave_config. We have already talked about this. I don't
> see the problem. It is only a comment, a reminder. The only information
> I may need, one day, is the direction because we have to set src and dst
> interfaces. At the moment, all our products are done in a way nand flash
> and DDR are on the same interface so we don't have to care about
> direction.
> Since we don't have the direction, two solutions:
> - remember this limitation for next products, that's why there is this reminder,
> - change our nand driver in order to see nand as a peripheral instead of
>   a memory. 
I think treating NAND as memory may not be a right model. It should be
treated as periphral with incrementing and decrementing address value. That
way you should be able to set the right properties for it.

The system memory copy is right model for memcpy.

-- 
~Vinod
