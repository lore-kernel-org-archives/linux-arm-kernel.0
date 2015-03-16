From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 16 Mar 2015 21:56:13 +0530
Subject: [PATCH v7 1/3] dmaengine: Add support for APM X-Gene SoC DMA
 engine driver
In-Reply-To: <CAFd313yeXL2sd4qzh_-6iANQf=w0k4p_tXEmrk_QZ-baKgKG8Q@mail.gmail.com>
References: <1426158921-8987-1-git-send-email-rsahu@apm.com>
 <1426158921-8987-2-git-send-email-rsahu@apm.com>
 <20150316092756.GH32683@intel.com>
 <CAFd313y3avndJ_jDbOSWsbBOYapto_HpDUa+eR7Qy2FO2qLDYg@mail.gmail.com>
 <20150316112730.GN32683@intel.com>
 <CAFd313yeXL2sd4qzh_-6iANQf=w0k4p_tXEmrk_QZ-baKgKG8Q@mail.gmail.com>
Message-ID: <20150316162613.GO32683@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 05:24:34PM +0530, Rameshwar Sahu wrote:
> >> >> +static void xgene_dma_free_desc_list_reverse(struct xgene_dma_chan *chan,
> >> >> +                                          struct list_head *list)
> >> > do we really care about free order?
> >>
> >> Yes it start dellocation of descriptor by tail.
> > and why by tail is not clear.
> We can free allocated descriptor in forward order from head or in
> reverse order, I just followed here fsldma.c driver.
> Does this make sense ??
No, you have two APIs to free list. Why do you need two?

> 
> 
> >
> >> > where are you mapping dma buffers?
> >>
> >>  I didn't get you here. Can you please explain me here what you mean.
> >> As per my understanding client should map the dma buffer and give the
> >> physical address and size to this callback prep routines.
> > not for memcpy, that is true for slave transfers
> >
> > For mempcy the idea is that drivers will do buffer mapping
> 
> Still I am clear here, why memcpy will do buffer mapping, I see other
> drivers and also async_memcpy.c , they only map it and pass mapped
> physical dma address to driver.
> 
> Buffer mapping mean you here is dma_map_xxx ?? Am I correct.
Yes

> 
> >
> >> > why are you calling this here, status check shouldnt do this...
> >>
> >> Okay, I will remove it.
> >>
> >>
> >> >> +                     spin_unlock_bh(&chan->lock);
> >> >> +                     return DMA_IN_PROGRESS;
> >> > residue here is size of transacation.
> >>
> >> We can't calculate here residue size. We don't have any controller
> >> register which will tell about remaining transaction size.
> > Okay if you cant calculate residue why do we have this fn?
> 
> So basically case here for me is completion of dma descriptor
> submitted to hw is not same as order of submission to hw.
> So scenario coming in multithread running :e.g. let's assume we have
> submitted two descriptors first has cookie 1001 and second has 1002,
> now 1002 is completed first, so updated last_completed_cookie as 1002
> but not yer checked for dma_tx_status, and then first cookie completes
> and update last_completed_cookie as 1001, now second transaction check
> for tx_status and it get DMA_IN_PROGRESS, because
> last_completed_cookie(1001) is less than second transaction's
> cookie(1002).
> 
> Due to this issue I am traversing that transaction in pending list and
> running list, if not there means we are done.
> 
> Does this make sense??
That only convinces me that there is something not so correct.

To help me understand pls let me know if below is fine:
- for a physical channel, do you submit multiple transactions?
- if yes, how does DMA deal with multiple transactions, how does it schedule
  them?

-- 
~Vinod
