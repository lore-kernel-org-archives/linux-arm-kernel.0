From: zonque@gmail.com (Daniel Mack)
Date: Thu, 15 Aug 2013 05:44:24 +0200
Subject: [v3 1/2] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <CADApbegKj=AMGx4OFOBVsyk71BGis97Gw9QM_-0EsNi90pS+Hw@mail.gmail.com>
References: <1376497189-21298-1-git-send-email-zonque@gmail.com>
 <CADApbegKj=AMGx4OFOBVsyk71BGis97Gw9QM_-0EsNi90pS+Hw@mail.gmail.com>
Message-ID: <520C4E98.6020001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chao,

On 15.08.2013 03:57, Chao Xie wrote:
> On Thu, Aug 15, 2013 at 12:19 AM, Daniel Mack <zonque@gmail.com> wrote:

>> +static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan)
>> +{
>> +       struct mmp_pdma_desc_sw *sw;
>> +       u32 curr, done = 0;
>> +
>> +       if (chan->dir == DMA_DEV_TO_MEM)
>> +               curr = readl(chan->phy->base + DTADR(chan->phy->idx));
>> +       else
>> +               curr = readl(chan->phy->base + DSADR(chan->phy->idx));
>> +
>> +       list_for_each_entry(sw, &chan->chain_running, node) {
>> +               u32 start;
>> +               u32 len = sw->desc.dcmd & DCMD_LENGTH;
>> +
>> +               if (chan->dir == DMA_DEV_TO_MEM)
>> +                       start = sw->desc.dtadr;
>> +               else
>> +                       start = sw->desc.dsadr;
>> +
>> +               if (curr >= start && curr <= (start + len)) {
>> +                       done += curr - start;
>> +                       break;
>> +               }
>> +
>> +               done += len;
>> +       }
>> +
>> +       return chan->total_len - done;
>> +}
>> +
> 
> It seems that you will get all the residue bytes in the channel.
> For DMA transfer, user may submit many trasaction.
> The transaction will be composed by mutiple desctiptors. So it means
> that chan->chain_running includes
> the descriptors from all ongoing transactions.
> When user try to get the tx_status, user will pass the cookie to
> identify which transaction it want to get the status.
> So for mmp_pdma_residue, it need care about the cookie, and find out
> the transaction, then calculate the residue bytes.

Ok, right.

> The orignal driver has a issue, it will assign cookie for all
> descriptors, not the transaction. I think that need to be changed.

Not necessarily. If all the linked descriptors are assigned the same
cookie, we can as well just walk all entries in chain_running and ignore
the ones that don't match the cookie we're looking for,

The problem with your proposed approach is that the driver will
currently dispose desc->tx_list via list_splice_tail_init() once the
transaction has been submitted, so we can't access it later. But what I
have in mind should work equally well. I'll post an updated patch later.


Thanks for the review,
Daniel
