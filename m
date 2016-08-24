From: yao.yuan@nxp.com (Yao Yuan)
Date: Wed, 24 Aug 2016 03:39:11 +0000
Subject: [PATCH v1 1/5] dma: Add QorIQ qDMA engine driver support
In-Reply-To: <20160818091603.GT1041@n2100.armlinux.org.uk>
References: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
 <1471502328-28305-2-git-send-email-yao.yuan@freescale.com>
 <20160818091603.GT1041@n2100.armlinux.org.uk>
Message-ID: <DB6PR0401MB240759E8AC4DEB23EBC1159389EA0@DB6PR0401MB2407.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 05:16 PM +0800, Russell King wrote:
> On Thu, Aug 18, 2016 at 02:38:44PM +0800, Yuan Yao wrote:
> > +			spin_lock(&fsl_comp->qchan->vchan.lock);
> > +			if (status == DMA_COMPLETE)
> > +				vchan_cookie_complete(&fsl_comp->vdesc);
> > +			fsl_comp->qchan->status = status;
> 
> This is buggy - if the DMA has finished processing it, even if it finished in error, it
> must _complete_ the transaction.  Completion is not the same as being
> successful - it means that the DMA is no longer processing the cookie.
> 
> The issue here is that when the _following_ transaction completes successfully,
> _this_ transaction will effectively be marked as complete due to the way the
> cookie system works.
> 
> So... to get this straight - "completion" means "I have finished processing this
> transaction".  It does not mean "I successfully processed this transaction
> without any errors."
> 

Thanks for your review.
So you mean that I should call vchan_cookie_complete no matter whether the error issue in QDMA?
I have some random DMA error test case, it seems work will.
