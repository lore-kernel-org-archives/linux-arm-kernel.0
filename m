From: yao.yuan@freescale.com (Yao Yuan)
Date: Fri, 17 Jul 2015 05:41:55 +0000
Subject: [PATCH] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <20150716132411.GX5086@localhost>
References: <1436952778-28000-1-git-send-email-yao.yuan@freescale.com>
 <1436952778-28000-2-git-send-email-yao.yuan@freescale.com>
 <20150716132411.GX5086@localhost>
Message-ID: <BL2PR03MB338CBF3F98AFF7E93AA78C183980@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

eDMA sullpies the data transmission service for other IPs, so it should be suspended later and resumed earlier.
For example:
Synchronous Audio Interface (SAI), SAI use DMA to transfer the data.
When suspend:
1, SAI using suspend handlers to stop the DMA transmission.
2, DMA using suspend_late  handlers to check whether DMA chan is idle.
When resume:
1, DMA using resume_early   to enable. And then can servicing for others.
2, SAI using resume and then can use DMA to data transmission.

We must sure the order is right, so I think DMA should using early/late handlers.

Thanks.

Best Regards,
Yuan Yao

On Thursday, July 16, 2015 9:24 PM, Vinod wrote:
> On Wed, Jul 15, 2015 at 05:32:58PM +0800, Yuan Yao wrote:
> > +
> > +static const struct dev_pm_ops fsl_edma_pm_ops = {
> > +	.suspend_late   = fsl_edma_suspend_late,
> > +	.resume_early   = fsl_edma_resume_early,
> any reason why you are using early/late handlers?
> 
> --
> ~Vinod
