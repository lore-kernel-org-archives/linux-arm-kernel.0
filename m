From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 08 Dec 2016 13:39:31 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <68bbe77a-c991-4e64-c189-fafbcda8e7ae@free.fr> (Mason's message
 of "Thu, 8 Dec 2016 14:29:17 +0100")
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com> <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com> <20161208103921.GC6408@localhost>
 <yw1x60mu1w7e.fsf@unicorn.mansr.com>
 <CAMuHMdUEXJtWF3S8yK5RY5e60nOnb-Wc9U2E_L553hZvsijvcw@mail.gmail.com>
 <yw1xshpyzk6p.fsf@unicorn.mansr.com>
 <a865e7d0-4247-657e-25db-9093731005d3@free.fr>
 <yw1xfulyzj2b.fsf@unicorn.mansr.com>
 <68bbe77a-c991-4e64-c189-fafbcda8e7ae@free.fr>
Message-ID: <yw1xbmwmzgj0.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 08/12/2016 13:44, M?ns Rullg?rd wrote:
>
>> Mason <slash.tmp@free.fr> writes:
>> 
>>> On 08/12/2016 13:20, M?ns Rullg?rd wrote:
>>>
>>>> The only problem we have is that nobody envisioned hardware where the
>>>> dma engine indicates completion slightly too soon.  I suspect there's a
>>>> fifo or such somewhere, and the interrupt is triggered when the last
>>>> byte has been placed in the fifo rather than when it has been removed
>>>> which would have been more correct.
>>>
>>> As I (tried to) explain here:
>>> https://marc.info/?l=dmaengine&m=148007808418242&w=2
>>>
>>> A *read* MBUS agent raises its IRQ when it is safe for the memory
>>> to be overwritten (i.e. every byte has been pushed into the pipe).
>>>
>>> A *write* MBUS agent raises its IRQ when it is safe for another
>>> agent to read any one of the transferred bytes.
>>>
>>> The issue comes from the fact that, for a memory-to-device transfer,
>>> the system will receive the read agent's IRQ, but most devices
>>> (NFC, SATA) don't have an IRQ line to signal that their part of the
>>> operation is complete.
>> 
>> SATA does, actually.  Nevertheless, it's an unusual design.
>
> Thanks, I was mistaken about the SATA controller.
>
> On tango3 (and also tango4, I assume)
>
> IRQ 41 = Serial ATA #0
> IRQ 42 = Serial ATA DMA #0
> IRQ 54 = Serial ATA #1
> IRQ 55 = Serial ATA DMA #1
>
> But in the end, whether there is a device interrupt (SATA)
> or not (NFC), for a memory-to-device transfer, the DMA
> driver will get the read agent notification (which should
> be ignored) and the client driver should either spin until
> idle (NFC) or wait for its completion IRQ (SATA).
>
> Correct?

Yes, and when the client device is finished, the driver needs to signal
this to the dma driver so it can reuse the channel.  It's this last
piece that's missing.

-- 
M?ns Rullg?rd
