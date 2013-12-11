From: zonque@gmail.com (Daniel Mack)
Date: Wed, 11 Dec 2013 16:09:06 +0100
Subject: [PATCH v5 4/5] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <20131210161138.GO29580@intel.com>
References: <1377086938-29145-1-git-send-email-zonque@gmail.com>
 <1377086938-29145-5-git-send-email-zonque@gmail.com>
 <20130825163337.GD2748@intel.com> <522F3ECB.3070307@gmail.com>
 <20130913045135.GI17188@intel.com> <52A61363.7060500@gmail.com>
 <20131210161138.GO29580@intel.com>
Message-ID: <52A88012.6070107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/10/2013 05:11 PM, Vinod Koul wrote:
> On Mon, Dec 09, 2013 at 08:00:51PM +0100, Daniel Mack wrote:

>> I looked into your idea and implemented it, but I really feel having an
>> explicit chain pointer for each descriptor is redundant information.
>>
>> Hence, let me summarize again how the driver currently works:
>>
>> * Any of the prep_* function will allocate a number of descriptors to
>> accommodate the payload, and link them all together via the 'node'
>> list_head, forming a transaction.
>>
>> * The last descriptor in a transaction has the DCMD_ENDIRQEN flag set.
>>
>> * When tx_submit() is called, each descriptor in the linked list will be
>> assigned a cookie, and then entire list of the transaction is appended
>> to the chain_pending list. At this point, the information of where a
>> transaction ends is no longer visible in the 'node' list head.
>>
>> * start_pending_queue() moves the chain_pending entries to chain_running.
>>
>> When determining the channel's residue, we need to find the transaction
>> currently in progress, and then count upwards until we reach the end of
>> the transaction chain.
> ah here is the catch! You dont get reside for a channel. You get for the
> respetive transaction represented by the descriptor!

Yes, exactly. I think part of the reason why we're not on the same page
is a misleading wording on my side. Let me try and explain.

> So lets establish few rules:
> - Assume you have transactions A, B, C and D in a list
> - on sumbmit (assume serial), you get descriptor 1, 2, 3 and 4 respectively

You're referring to dma_async_tx_descriptor, while I was talking about
mmp_pdma_desc_sw. IOW: what's handed out by the driver from any of its
prep_* functions are dma_async_tx_descriptors, which consist of N
chained mmp_pdma_desc_sw descriptors internally.

Another specialty of this particular driver is that each
mmp_pdma_desc_sw is assigned a dma_cookie_t, but only the last one in a
chained list is handed out to the user.

Following your example, the transaction-cookie matching could look like
this, for example:

  A:  1, 2, 3, 4
  B:  5
  C:  6, 7, 8
  D:  9, 10

So the only cookies the user 'knows' about and query the residue for,
are 4, 5, 8 and 10.

> - Now residue is for a descriptor, not a series of descriptors!, so
>   - If DMA is started and currently 1 is being transferred, then
>     - residue on 1 will give remaining bytes of 1
>     - residue on 2 will give full length
> 
> At client, you can sum up and decide how much is remianing for your point of
> interest.

Absolutely. I understand that concept :)

In this driver, however, I have to deal with multiple mmp_pdma_desc_sw
descriptors that are all chained up in the channel's running list.
Hence, my implementation goes as follows:

 * Walk the list of all mmp_pdma_desc_sw until we find the end of a
transaction chain; IOW: find the end of one dma_async_tx_descriptor.
This end entry has the DCMD_ENDIRQEN flag set.

 * Check if that mmp_pdma_desc_sw corresponds with the cookie the user
wants to know the residue for, and if it does, return the residue that
was calculated during the iteration.

 * Otherwise, reset the internal state and carry on.

>> I rebased the residue patch on top of Joe's cleanup work, and I can
>> resubmit if you want me to. Maybe that serves as a better foundation for
>> the ongoing discussion :)
> Sure pls do post...

Will do.


Thanks,
Daniel
