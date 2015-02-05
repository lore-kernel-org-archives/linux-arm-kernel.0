From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 5 Feb 2015 12:11:18 -0800
Subject: [PATCH v5 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 engine driver
In-Reply-To: <CAFd313yBS3KOdtKbnaeTKehmC_f5ZaB-nx299QoLeMm279=Jsg@mail.gmail.com>
References: <1422968107-23125-1-git-send-email-rsahu@apm.com>
 <1422968107-23125-2-git-send-email-rsahu@apm.com>
 <20150205015031.GK4489@intel.com>
 <CAFd313yBS3KOdtKbnaeTKehmC_f5ZaB-nx299QoLeMm279=Jsg@mail.gmail.com>
Message-ID: <20150205201118.GB16547@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 05:29:06PM +0530, Rameshwar Sahu wrote:
> Hi Vinod,
> 
> Thanks for reviewing this patch.
> 
> Please see inline......
Please STOP top posting

> >
> >> +}
> >> +
> >> +static void xgene_dma_issue_pending(struct dma_chan *channel)
> >> +{
> >> +     /* Nothing to do */
> >> +}
> > What do you mean by nothing to do here
> > See Documentation/dmaengine/client.txt Section 4 & 5
> This docs is only applicable on slave DMA operations, we don't support
> slave DMA, it's only master.
> Our hw engine is designed in the way that there is no scope of
> flushing pending transaction explicitly by sw.
> We have circular ring descriptor dedicated to engine. In submit
> callback  we are queuing descriptor and informing to engine, so after
> this it's internal to hw to execute descriptor one by one.
But the API expectations on this are _same_ 

No the API expects you to maintain a SW queue, then push to your ring buffer
when you get issue_pending. Issue pending is the start of data transfer, you
client will expect accordingly.

> >> +     /* Run until we are out of length */
> >> +     do {
> >> +             /* Create the largest transaction possible */
> >> +             copy = min_t(size_t, len, DMA_MAX_64BDSC_BYTE_CNT);
> >> +
> >> +             /* Prepare DMA descriptor */
> >> +             xgene_dma_prep_cpy_desc(chan, slot, dst, src, copy);
> >> +
> > This is wrong. The descriptor is supposed to be already prepared and now it
> > has to be submitted to queue
> 
> Due to the race in tx_submit call from the client, need to serialize
> the submission of H/W DMA descriptors.
>  So we are making  shadow copy in prepare DMA  routine and  preparing
> actual descriptor during tx_submit call.
Thats an abuse of API and I dont see a reason why this race should happen in
the first place.

So you get a prep call, you prepare a desc in SW. Then submit pushes it to a
queue. Finally in issue pending you push them to HW. Simple..?

-- 
~Vinod
