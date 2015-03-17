From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 17 Mar 2015 15:49:53 +0530
Subject: [PATCH v7 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 engine driver
In-Reply-To: <CAFd313zJHP2PbN=Xa48GRmyQ6EvH=3wrZPBngtsZ2djo4ka96A@mail.gmail.com>
References: <1426158921-8987-1-git-send-email-rsahu@apm.com>
 <1426158921-8987-2-git-send-email-rsahu@apm.com>
 <20150316092756.GH32683@intel.com>
 <CAFd313y3avndJ_jDbOSWsbBOYapto_HpDUa+eR7Qy2FO2qLDYg@mail.gmail.com>
 <20150316112730.GN32683@intel.com>
 <CAFd313yeXL2sd4qzh_-6iANQf=w0k4p_tXEmrk_QZ-baKgKG8Q@mail.gmail.com>
 <20150316162613.GO32683@intel.com>
 <CAFd313xG4EZdoS4vMxq4TW7v+xc_OEd3uC1R4LW3=Xs3+JzY9w@mail.gmail.com>
 <CAFd313zJHP2PbN=Xa48GRmyQ6EvH=3wrZPBngtsZ2djo4ka96A@mail.gmail.com>
Message-ID: <20150317101953.GC32683@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 03:03:14PM +0530, Rameshwar Sahu wrote:
> Hi Vinod,
> 
> On Mon, Mar 16, 2015 at 11:01 PM, Rameshwar Sahu <rsahu@apm.com> wrote:
> > Hi Vinod,
> >
> > On Mon, Mar 16, 2015 at 9:56 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> >> On Mon, Mar 16, 2015 at 05:24:34PM +0530, Rameshwar Sahu wrote:
> >>> >> >> +static void xgene_dma_free_desc_list_reverse(struct xgene_dma_chan *chan,
> >>> >> >> +                                          struct list_head *list)
> >>> >> > do we really care about free order?
> >>> >>
> >>> >> Yes it start dellocation of descriptor by tail.
> >>> > and why by tail is not clear.
> >>> We can free allocated descriptor in forward order from head or in
> >>> reverse order, I just followed here fsldma.c driver.
> >>> Does this make sense ??
> >> No, you have two APIs to free list. Why do you need two?
> >
> > Yes, basically we have tow API to free list.
> > xgene_dma_free_desc_list_reverse will call if any failure in
> > allocation of memory from DMA pool in prep routines.
> > Like e.g. in prep routing we have some descriptors allocated and still
> > need to get descriptor to complete the DMA request and failure happen,
> > so we need to free all allocated descriptor.
> >
> >>
> >>>
> >>>
> >>> >
> >>> >> > where are you mapping dma buffers?
> >>> >>
> >>> >>  I didn't get you here. Can you please explain me here what you mean.
> >>> >> As per my understanding client should map the dma buffer and give the
> >>> >> physical address and size to this callback prep routines.
> >>> > not for memcpy, that is true for slave transfers
> >>> >
> >>> > For mempcy the idea is that drivers will do buffer mapping
> >>>
> >>> Still I am clear here, why memcpy will do buffer mapping, I see other
> >>> drivers and also async_memcpy.c , they only map it and pass mapped
> >>> physical dma address to driver.
> >>>
> >>> Buffer mapping mean you here is dma_map_xxx ?? Am I correct.
> >> Yes
> >
> > I have confusion here, I don't see any driver dma buffer mapping in
> > prep_dma_memcpy.
> > Can you please clear me here if driver does this on behalf of client,
> > like any example so that I can proceed further.
> 
> Any comment here ??
The advise typically is that for memcpy the dma mapping should be done by
client. For now this is okay as we have precedence, let me check with Dan.
> 
> >>
> >>>
> >>> >
> >>> >> > why are you calling this here, status check shouldnt do this...
> >>> >>
> >>> >> Okay, I will remove it.
> >>> >>
> >>> >>
> >>> >> >> +                     spin_unlock_bh(&chan->lock);
> >>> >> >> +                     return DMA_IN_PROGRESS;
> >>> >> > residue here is size of transacation.
> >>> >>
> >>> >> We can't calculate here residue size. We don't have any controller
> >>> >> register which will tell about remaining transaction size.
> >>> > Okay if you cant calculate residue why do we have this fn?
> >>>
> >>> So basically case here for me is completion of dma descriptor
> >>> submitted to hw is not same as order of submission to hw.
> >>> So scenario coming in multithread running :e.g. let's assume we have
> >>> submitted two descriptors first has cookie 1001 and second has 1002,
> >>> now 1002 is completed first, so updated last_completed_cookie as 1002
> >>> but not yer checked for dma_tx_status, and then first cookie completes
> >>> and update last_completed_cookie as 1001, now second transaction check
> >>> for tx_status and it get DMA_IN_PROGRESS, because
> >>> last_completed_cookie(1001) is less than second transaction's
> >>> cookie(1002).
> >>>
> >>> Due to this issue I am traversing that transaction in pending list and
> >>> running list, if not there means we are done.
> >>>
> >>> Does this make sense??
> >> That only convinces me that there is something not so correct.
> >>
> >> To help me understand pls let me know if below is fine:
> >> - for a physical channel, do you submit multiple transactions?
> >
> > Yes
> >
> >> - if yes, how does DMA deal with multiple transactions, how does it schedule
> >>   them?
> >
> > So , basically we submit multiple descriptor to dma physical channel,
> > and dma engine execute it one by one and give us completion callback.
> > So in this way we expect callback on same order as submission order
> > and it does also, no issue.
> >
> > But problem is with supporting p+q offload, here we have P
> > functionality supports in dma physical channel 0 and Q functionality
> > supports in dma physical channel 1. So for pq we need to submit two
> > descriptor, one to channel 0 and second to channel1, in this case we
> > can't expect the completion order, because channnel 0 can finish P
> > before Q or vice versa, and we need to wait to complete both before
> > calling client callback() and completing cookie.
> > Second thing we submit memcpy and sg on same channel, and can complete
> > before even though if it submitted after PQ.
> 
> So our SoC dma engine hw design idea was to get more throughput while
> running two channel concurrent and calculating the P and Q together,
> but somehow now today we came to scenario where running P and Q on
> different channel causing hang to dmaengine, some hw bug, So now I am
> going to support P and Q generation in same channel, so above
> mentioned cookie status scenario will never come.
> I will send you the patch for review.
Okay, so I am going to expect the status callback will do as per API
expectations and these kinds of hacks will be absent in the code :)

-- 
~Vinod
> 
> Thanks,
> >
> >>
> >> --
> >> ~Vinod
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> >> the body of a message to majordomo at vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
