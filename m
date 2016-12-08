From: slash.tmp@free.fr (Mason)
Date: Thu, 8 Dec 2016 13:41:29 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1xshpyzk6p.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com> <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com> <20161208103921.GC6408@localhost>
 <yw1x60mu1w7e.fsf@unicorn.mansr.com>
 <CAMuHMdUEXJtWF3S8yK5RY5e60nOnb-Wc9U2E_L553hZvsijvcw@mail.gmail.com>
 <yw1xshpyzk6p.fsf@unicorn.mansr.com>
Message-ID: <a865e7d0-4247-657e-25db-9093731005d3@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2016 13:20, M?ns Rullg?rd wrote:

> The only problem we have is that nobody envisioned hardware where the
> dma engine indicates completion slightly too soon.  I suspect there's a
> fifo or such somewhere, and the interrupt is triggered when the last
> byte has been placed in the fifo rather than when it has been removed
> which would have been more correct.

As I (tried to) explain here:
https://marc.info/?l=dmaengine&m=148007808418242&w=2

A *read* MBUS agent raises its IRQ when it is safe for the memory
to be overwritten (i.e. every byte has been pushed into the pipe).

A *write* MBUS agent raises its IRQ when it is safe for another
agent to read any one of the transferred bytes.

The issue comes from the fact that, for a memory-to-device transfer,
the system will receive the read agent's IRQ, but most devices
(NFC, SATA) don't have an IRQ line to signal that their part of the
operation is complete.

As I explained, if one sets up a memory-to-memory DMA copy, then
the system will actually receive *two* IRQs.

Regards.
