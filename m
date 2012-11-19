From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Nov 2012 07:40:42 +0100
Subject: [PATCH] Device Tree binding for the 'mv_xor' XOR engine DMA driver
In-Reply-To: <EE71107DF0D1F24FA2D95041E64AB9E801A56BA6A7E7@IL-MB01.marvell.com>
References: <1353000034-30567-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121118103626.GE11717@lunn.ch>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56BA6A7E7@IL-MB01.marvell.com>
Message-ID: <20121119064042.GO14643@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The dmatest shows up a second issue:
> > 
> > root at qnap:~# insmod ./dmatest.ko iterations=100
> > dmatest: Started 2 threads using dma0chan0
> > dmatest: Started 2 threads using dma1chan0
> > dmatest: Started 2 threads using dma2chan0
> > dmatest: Started 2 threads using dma3chan0
> > dma3chan0-xor0: #3: prep error with src_off=0x13c2 dst_off=0x2c7c
> > len=0x5d
> > dma1chan0-copy0: #16: prep error with src_off=0x1f50 dst_off=0x904
> > len=0x33
> > dma3chan0-copy0: #22: prep error with src_off=0x14c2 dst_off=0x389b
> > len=0x6f
> > dma0chan0-copy0: #31: prep error with src_off=0x10b6 dst_off=0x323c
> > len=0x2f
> > dma3chan0-copy0: #49: prep error with src_off=0x17b5 dst_off=0x3eca
> > len=0x29
> > 
> > The driver refuses any operation where the buffer is less than 128 bytes. The
> > datasheet for Kirkwood says the buffer length must be 8 bytes or more. So
> > maybe we should reduce this 128 limit down to 8?
> 
> This limitation (128B) is only in memset operations (set in registers and not descriptors).
> If I recall correctly the limit is 16B and not 8B.
> 
> In any way, this 128 bytes seems like a good logical boundary for XOR HW enabling. (performance wise)

Hi Lior

Agreed. Anything smaller than that, and you spend more time setting up
the hardware and dealing with interrupts when its finished than doing
it in software.

I had quick look at some of the call sites. Users of the DMA API under
the crypto directory all fall back to software operations when the DMA
API returns an error. Also, raid uses the crypto API for memcpy and
XOR. So raid seems O.K. I could not find any other users of the DMA
API for _xor, _copy, or _memset. So it seems safe to return an error
for inefficient usage.

      Andrew
