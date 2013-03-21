From: smoch@web.de (Soeren Moch)
Date: Thu, 21 Mar 2013 18:04:59 +0100
Subject: [PATCH] USB: EHCI: fix for leaking isochronous data
In-Reply-To: <Pine.LNX.4.44L0.1303171320560.26486-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1303171320560.26486-100000@netrider.rowland.org>
Message-ID: <514B3DBB.3060302@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/13 18:36, Alan Stern wrote:
> On Sun, 17 Mar 2013, Soeren Moch wrote:
>
>> For each device only one isochronous endpoint is used (EP IN4, 1x 940
>> Bytes, Interval 1).
>> When the ENOMEM error occurs, a huge number of iTDs is in the free_list
>> of one stream. This number is much higher than the 2*M entries, which
>> should be there according to your description.
>
> Okay, but how did they get there?  With each URB requiring 9 iTDs, and
> about 5 URBs active at any time, there should be about 5*9 = 45 iTDs in
> use and 2*9 = 18 iTDs on the free list.  By the time each URB
> completes, it should have released all 9 iTDs back to the free list,
> and each time an URB is submitted, it should be able to acquire all 9
> of the iTDs that it needs from the free list -- it shouldn't have to
> allocate any from the DMA pool.
>
> Looks like you'll have to investigate what's going on inside
> itd_urb_transaction().  Print out some useful information whenever the
> size of stream->free_list is above 50, such as the value of num_itds,
> how many of the loop iterations could get an iTD from the free list,
> and the value of itd->frame in the case where the "goto alloc_itd"
> statement is followed.
>
> It might be a good idea also to print out the size of the free list in
> itd_complete(), where it calls ehci_urb_done(), and include the value
> of ehci->now_frame.
>

Now I found out what is going on here:

In itd_urb_transaction() we allocate 9 iTDs for each URB with 
number_of_packets == 64 in my case. The iTDs are added to 
sched->td_list. For a frame-aligned scheduling we need 8 iTDs, the 9th 
one is released back to the front of the streams free_list in 
iso_sched_free(). This iTD was cleared after allocation and has a frame 
number of 0 now. So for each allocation when now_frame == 0 we allocate 
from the dma_pool, not from the free_list. The attached patch 
invalidates the frame number in each iTD before it is sent to the 
scheduler. This fixes the problem without the need to iterate over a iTD 
list.

Signed-off-by: Soeren Moch <smoch@web.de>



-------------- next part --------------
A non-text attachment was scrubbed...
Name: ehci.diff
Type: text/x-patch
Size: 603 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130321/5c488fe2/attachment.bin>
