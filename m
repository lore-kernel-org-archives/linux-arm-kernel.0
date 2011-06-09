From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 10 Jun 2011 00:28:25 +0530
Subject: [RFC] dmaengine: add new api for preparing simple slave transfer
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2DED@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2DED@dbde02.ent.ti.com>
Message-ID: <BANLkTikvURS7aQEBax0xEfcFZMg3-cUPow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 9, 2011 at 6:09 PM, Raju, Sundaram <sundaram@ti.com> wrote:

> Generic buffer description:
> A generic buffer can be split into number of frames which contain number of chunks inside them. The frames need not be contiguous, nor do the chunks inside a frame.
>
> ? ? ? ?-------------------------------------------------------------------
> ? ? ? ?| Chunk 0 |ICG| Chunk 1 |ICG| ... |ICG| Chunk n | ? ? ? Frame 0
> ? ? ? ?-------------------------------------------------------------------
> ? ? ? ?| ? ? ? ? ? ? ? ? ? ? ? Inter Frame Gap ? ? ? ? ? ? ? ? ? ? |
> ? ? ? ?-------------------------------------------------------------------
> ? ? ? ?| Chunk 0 |ICG| Chunk 1 |ICG| ... |ICG| Chunk n | ? ? ? Frame 1
> ? ? ? ?-------------------------------------------------------------------
> ? ? ? ?| ? ? ? ? ? ? ? ? ? ? ? Inter Frame Gap ? ? ? ? ? ? ? ? ? ? |
> ? ? ? ?-------------------------------------------------------------------
> ? ? ? ?| ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ........ ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?|
> ? ? ? ?-------------------------------------------------------------------
> ? ? ? ?| ? ? ? ? ? ? ? ? ? ? ? Inter Frame Gap ? ? ? ? ? ? ? ? ? ? |
> ? ? ? ?-------------------------------------------------------------------
> ? ? ? ?| Chunk 0 |ICG| Chunk 1 |ICG| ... |ICG| Chunk n | ? ? ? Frame m
> ? ? ? ?-------------------------------------------------------------------

IIUC the above figure, the work done by DMA controller remains the
same, either by
passing this as a transfer of the new type or as a normal sg-list  - unless
the DMAC driver attempts to reorder the transfers or the DMAC h/w
natively supports
some form of sg-list.
For DMACs, that have no special support, different representation
wouldn't make a
difference.
And if the DMAC does support the kind of fancy scatter-gather, it
should be possible for
the dma api driver to analyze the submitted 'normal' sg-list and
program the transfers at one go.
Besides, it should be possible to have a 'template' sequence of
requests prepared
already because usually, for above mentioned scenario, the parameters
don't change across
items in a list.
