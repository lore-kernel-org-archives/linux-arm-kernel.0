From: clemens.gruber@pqgruber.com (Clemens Gruber)
Date: Wed, 11 Jan 2017 01:33:20 +0100
Subject: imx: RS-485 problems during TX, maybe DMA related
In-Reply-To: <CAOMZO5AYha+SwS4761XxOnUtT1DYhHH69UpXmQzcmEdfC++JKQ@mail.gmail.com>
References: <20170107134557.GA12299@archie.localdomain>
 <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
 <20170107153434.GA13307@archie.localdomain>
 <CAOMZO5CY3ys6moE133LwSKcS4egv56JdmhPMRG0TmAnfD+ZBAw@mail.gmail.com>
 <20170107205930.GA12367@archie.localdomain>
 <CAOMZO5D00YFLS=pddAqPo_FUoP6MF-juAef2H71-Wx_NQArdpw@mail.gmail.com>
 <20170107230624.GA21729@archie.localdomain>
 <CAOMZO5DedNURGV_k5Y=nt1O98SojsvrOd69PEPEzi8F7N3dJuw@mail.gmail.com>
 <20170108180609.GB24155@archie.localdomain>
 <CAOMZO5AYha+SwS4761XxOnUtT1DYhHH69UpXmQzcmEdfC++JKQ@mail.gmail.com>
Message-ID: <20170111003319.GA25265@archie.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Sun, Jan 08, 2017 at 07:46:29PM -0200, Fabio Estevam wrote:
> > What's the revision of the i.MX6Q on your board? Mine is 1.5 (TO 1.3)
> 
> Mine is a mx6solo rev1.1.

Could it be dependent upon SMP? Do you have an i.MX6Q board around to
try?

--

I made a few interesting discoveries in the meantime:

1) If I do not enable UCR4_TCEN, the data on TXD is fine. Of course the
TE pin does not toggle in that case, but it shows that the problem has
something to do with the actions taking place after the transmit
complete interrupt and not with the hardware or DMA internals.

2) I added a few custom printks when doing echo A > /dev/ttymxc4 in
RS-485 mode:

imx_start_tx
imx_dma_tx: tx_bytes=2, xmit->tail=0, xmit->head=2
imx_dma_tx: dma_tx_nents=1
imx-uart 21f4000.serial: TX: prepare to send 2 bytes by DMA
imx_transmit_buffer: xmit->tail set to 1, xmit->head=2
imx_transmit_buffer: xmit->tail set to 2, xmit->head=2
imx_stop_tx (returns immediately because dma_is_txing)
^ repeats multiple times
imx_stop_tx (goes through)
dma_tx_callback: xmit->tail=2 tx_bytes=2
dma_tx_callback: xmit->tail set to 4
imx-uart 21f4000.serial: we finish the TX DMA.
dma_tx_callback: xmit->tail=4 icount.tx=4
imx_dma_tx: tx_bytes=4094, xmit->tail=4, xmit->head=2		(!!)
imx_dma_tx: dma_tx_nents=2
..

That's why the data is garbled in that way: It wraps around the circular
buffer. xmit->tail jumps over xmit->head, which explains why I first see
the correct characters, then again followed by many zeros and at the end
again the correct characters.

Regards,
Clemens
