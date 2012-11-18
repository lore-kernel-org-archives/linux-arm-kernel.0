From: alior@marvell.com (Lior Amsalem)
Date: Sun, 18 Nov 2012 14:16:11 +0200
Subject: [PATCH] Device Tree binding for the 'mv_xor' XOR engine DMA driver
In-Reply-To: <20121118103626.GE11717@lunn.ch>
References: <1353000034-30567-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121118103626.GE11717@lunn.ch>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56BA6A7E7@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: Sunday, November 18, 2012 12:36 PM
> To: Thomas Petazzoni
> Cc: Vinod Koul; Dan Williams; Saeed Bishara; Jason Cooper; Andrew Lunn;
> Gregory Clement; Lior Amsalem; Maen Suleiman; linux-arm-
> kernel at lists.infradead.org; Sebastian Hesselbarth
> Subject: Re: [PATCH] Device Tree binding for the 'mv_xor' XOR engine DMA
> driver
> 
> On Thu, Nov 15, 2012 at 06:20:05PM +0100, Thomas Petazzoni wrote:
> > Hello,
> >
> > This patch set adds a Device Tree binding for the Marvell XOR engine
> > driver, which allows to support these XOR engines in the Armada 370
> > and Armada XP SoCs.
> 
> Hi Thomas
> 
> I tested on kirkwood, both old style and DT. I tested using the dmatest kernel
> module. That shows up an old issue, pre-dating your patchset. It dmatest
> dereferences a NULL pointer during cleanup, due to a missing function in the
> driver. I will submit a patch for this soon.
> 
> The dmatest shows up a second issue:
> 
> root at qnap:~# insmod ./dmatest.ko iterations=100
> dmatest: Started 2 threads using dma0chan0
> dmatest: Started 2 threads using dma1chan0
> dmatest: Started 2 threads using dma2chan0
> dmatest: Started 2 threads using dma3chan0
> dma3chan0-xor0: #3: prep error with src_off=0x13c2 dst_off=0x2c7c
> len=0x5d
> dma1chan0-copy0: #16: prep error with src_off=0x1f50 dst_off=0x904
> len=0x33
> dma3chan0-copy0: #22: prep error with src_off=0x14c2 dst_off=0x389b
> len=0x6f
> dma0chan0-copy0: #31: prep error with src_off=0x10b6 dst_off=0x323c
> len=0x2f
> dma3chan0-copy0: #49: prep error with src_off=0x17b5 dst_off=0x3eca
> len=0x29
> 
> The driver refuses any operation where the buffer is less than 128 bytes. The
> datasheet for Kirkwood says the buffer length must be 8 bytes or more. So
> maybe we should reduce this 128 limit down to 8?

This limitation (128B) is only in memset operations (set in registers and not descriptors).
If I recall correctly the limit is 16B and not 8B.

In any way, this 128 bytes seems like a good logical boundary for XOR HW enabling. (performance wise)

> 
> But is the driver allowed to refuse small copies? Is the caller expected to fall
> back to software? Does the dma core implement this fallback? Lots of
> questions i don't know the answers to.
> 
> Anyway, you can add a
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> since with your patches it works just as well as before your patches.
> 
>       Andrew

Regards,
Lior Amsalem
