From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 2 Sep 2011 08:59:58 +0800
Subject: [PATCH 0/3] RFC: addition to DMA API
In-Reply-To: <Pine.LNX.4.44L0.1109011244340.1896-100000@iolanthe.rowland.org>
References: <CACVXFVOSCS-J8iXcRpCN9TD41pWqcJOiPahtGjBmPpXBLozZyA@mail.gmail.com>
	<Pine.LNX.4.44L0.1109011244340.1896-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVO6PhfgH_90B7AvWxSReCeJJ8D+jpgrk065MPHok7jzhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 2, 2011 at 12:48 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 1 Sep 2011, Ming Lei wrote:
>
>> > Suppose A and B are _both_ part of the dma descriptor. ?The device
>> > might see A==1 and B==0, if the memory accesses occur like this:
>> >
>> > ? ? ? ?CPU ? ? ? ? ? ? device
>> > ? ? ? ?--- ? ? ? ? ? ? ------
>> > ? ? ? ?A = 1;
>> > ? ? ? ?wmb();
>> > ? ? ? ? ? ? ? ? ? ? ? ?read B
>> > ? ? ? ? ? ? ? ? ? ? ? ?read A
>> > ? ? ? ?B = 2;
>> >
>> > When this happens, the device will observe a non-atomic update of the
>> > descriptor. ?There's no way to prevent this.
>>
>> If device doesn't find that B is 2, it will not fetch descriptor of A,
>> and will observe
>> a atomic update, which is just EHCI does for many cases(such as 4.10.2).
>
> You didn't read what I wrote above. ?Suppose A and B are _both_ part of
> the same descriptor, like hw_token and hw_qtd_next.

I think the case(keep writing order between parts in a same dma descriptor)
is only in constant dma-poll master case, just like ehci/uhci.

General case is that memory barrier is required before linking one dma
descriptor into hardware queue but after the dma descriptor is prepared.

>
>> > The memory barrier in your qh_link_async() example can make sure that
>> > the device always sees consistent data. ?It doesn't guarantee that the
>> > write to head->hw->hw_next will be flushed to memory in a reasonably
>> > short time, which is the problem you are trying to solve.
>>
>> Yes, up to now, it is the only case in which the flush can address to,
>> and in which kind of cases device will poll DMA coherent memory contiguously,
>> I am not sure if there are other devices except for EHCI(maybe have uhci/ohci).
>
> Yes: UHCI, OHCI, EHCI, and XHCI all poll memory constantly.

In fact, the flush may be not required for ohci and xhci case, since there is
already one mmio register writing at the end of .enqueue path in ohci/xhci
driver.(just a glance at the code of ohci/xhci, please correct if I am wrong)

For UHCI, looks like it has not been used on ARM, so maybe can ignore it.
UHCI is to support a slow usb 1.1 transfer, so I am wondering if the flush
can produce a obvious performance boost.

So looks like the flush only makes sense on EHCI.

If the above is not wrong, is it really needed to introduce a general DMA API
only for EHCI?


thanks,
--
Ming Lei
