From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Aug 2016 10:16:03 +0100
Subject: [PATCH v1 1/5] dma: Add QorIQ qDMA engine driver support
In-Reply-To: <1471502328-28305-2-git-send-email-yao.yuan@freescale.com>
References: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
 <1471502328-28305-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <20160818091603.GT1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 02:38:44PM +0800, Yuan Yao wrote:
> +			spin_lock(&fsl_comp->qchan->vchan.lock);
> +			if (status == DMA_COMPLETE)
> +				vchan_cookie_complete(&fsl_comp->vdesc);
> +			fsl_comp->qchan->status = status;

This is buggy - if the DMA has finished processing it, even if it
finished in error, it must _complete_ the transaction.  Completion is
not the same as being successful - it means that the DMA is no longer
processing the cookie.

The issue here is that when the _following_ transaction completes
successfully, _this_ transaction will effectively be marked as complete
due to the way the cookie system works.

So... to get this straight - "completion" means "I have finished
processing this transaction".  It does not mean "I successfully
processed this transaction without any errors."

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
