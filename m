From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 2 Mar 2018 13:47:06 +0530
Subject: [PATCH v5 2/3] dmaengine: mediatek: Add MediaTek High-Speed DMA
 controller for MT7622 and MT7623 SoC
In-Reply-To: <1519973271.8089.166.camel@mtkswgap22>
References: <cover.1518857746.git.sean.wang@mediatek.com>
 <de4177cb2269c99f8d7c5738ac8a64f512122dfd.1518857747.git.sean.wang@mediatek.com>
 <20180301082329.GD15443@localhost>
 <1519900021.8089.136.camel@mtkswgap22>
 <20180301125649.GH15443@localhost>
 <1519973271.8089.166.camel@mtkswgap22>
Message-ID: <20180302081706.GL15443@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 02:47:51PM +0800, Sean Wang wrote:
> Hi, Vinod
> 
> On Thu, 2018-03-01 at 18:26 +0530, Vinod Koul wrote:
> > On Thu, Mar 01, 2018 at 06:27:01PM +0800, Sean Wang wrote:
> > > On Thu, 2018-03-01 at 13:53 +0530, Vinod Koul wrote:
> > > > On Sun, Feb 18, 2018 at 03:08:30AM +0800, sean.wang at mediatek.com wrote:
> > > > 
> > > > > @@ -0,0 +1,1054 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > // Copyright ...
> > > > 
> > > > The copyright line needs to follow SPDX tag line
> > > > 
> > > 
> > > okay, I will make it reorder and be something like that
> > > 
> > > // SPDX-License-Identifier: GPL-2.0
> > > /*
> > >  * Copyright (c) 2017-2018 MediaTek Inc.
> > >  * Author: Sean Wang <sean.wang@mediatek.com>
> > >  *
> > >  * Driver for MediaTek High-Speed DMA Controller
> > >  *
> > >  */
> > 
> > It needs to be:
> > 
> > // SPDX-License-Identifier: GPL-2.0
> > // Copyright (c) 2017-2018 MediaTek Inc.
> > 
> > /*
> >  * whatever else you want
> >  */
> > 
> > The first two lines are in C99 style comment and need to have SPDX tag and
> > Copyright info
> 
> Sure, I can do it using C99 style comments at the first two lines.
> 
> In addition, I'm really curious where we can find a reference to the
> rule and if it 's a strict rule for all the drivers.
> 
> Because I'm considering whether I should turn other driver into using
> the same rule.

Yes that seems to be the rule now https://lkml.org/lkml/2017/11/2/715

> > > > > +#define MTK_HSDMA_USEC_POLL		20
> > > > > +#define MTK_HSDMA_TIMEOUT_POLL		200000
> > > > > +#define MTK_HSDMA_DMA_BUSWIDTHS		BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED)
> > > > 
> > > > Undefined buswidth??
> > 
> > ??
> 
> Sorry for I didn't answer the question in the short time.
> 
> After spending some time on a confirmation with design, it is
> DMA_SLAVE_BUSWIDTH_4_BYTES and not be configurable. 

Then it should be DMA_SLAVE_BUSWIDTH_4_BYTES and not
DMA_SLAVE_BUSWIDTH_UNDEFINED...

> > > > shouldn't we check if next is in range, we can crash if we get bad value
> > > > from hardware..
> > > 
> > > okay, there are checks for next with ddone bit check and null check in
> > > the corresponding descriptor as the following.
> > 
> > what if you get bad next value
> > 
> 
> next is not hardware value. it's maintained by software which is always
> between 0 to MTK_DMA_SIZE - 1, and definitely doesn't get a bad value.
> 
> > > 
> > > > > +		rxd = &pc->ring.rxd[next];
> > 
> > resulting in bad ref here
> 
> rxd is also definitely a good ref

not if next is out of range, say you read -1 or 200000?

-- 
~Vinod
