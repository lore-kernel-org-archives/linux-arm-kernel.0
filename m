From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 18 Nov 2012 11:50:30 +0100
Subject: [PATCH] Device Tree binding for the 'mv_xor' XOR engine DMA driver
In-Reply-To: <20121118103626.GE11717@lunn.ch>
References: <1353000034-30567-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121118103626.GE11717@lunn.ch>
Message-ID: <20121118115030.017857d0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 18 Nov 2012 11:36:26 +0100, Andrew Lunn wrote:

> I tested on kirkwood, both old style and DT. I tested using the
> dmatest kernel module. That shows up an old issue, pre-dating your
> patchset. It dmatest dereferences a NULL pointer during cleanup, due
> to a missing function in the driver. I will submit a patch for this
> soon.

Ok.

> The dmatest shows up a second issue:
> 
> root at qnap:~# insmod ./dmatest.ko iterations=100
> dmatest: Started 2 threads using dma0chan0
> dmatest: Started 2 threads using dma1chan0
> dmatest: Started 2 threads using dma2chan0
> dmatest: Started 2 threads using dma3chan0
> dma3chan0-xor0: #3: prep error with src_off=0x13c2 dst_off=0x2c7c len=0x5d
> dma1chan0-copy0: #16: prep error with src_off=0x1f50 dst_off=0x904 len=0x33
> dma3chan0-copy0: #22: prep error with src_off=0x14c2 dst_off=0x389b len=0x6f
> dma0chan0-copy0: #31: prep error with src_off=0x10b6 dst_off=0x323c len=0x2f
> dma3chan0-copy0: #49: prep error with src_off=0x17b5 dst_off=0x3eca len=0x29
> 
> The driver refuses any operation where the buffer is less than 128
> bytes. The datasheet for Kirkwood says the buffer length must be 8
> bytes or more. So maybe we should reduce this 128 limit down to 8?
> 
> But is the driver allowed to refuse small copies? Is the caller
> expected to fall back to software? Does the dma core implement this
> fallback? Lots of questions i don't know the answers to.

Thanks a lot for all this testing. I guess we can try to sort out those
issues as follow-up patches. I'll add bug tracker entries for those
items so that we remember to get to them at some point.

> Anyway, you can add a 
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> 
> since with your patches it works just as well as before your patches.

Excellent, thanks!

I'll try to fix the few issues found by Sebastian tomorrow, integrate
your two patches and send a formal pull request to Jason if you're OK.

Best regards, 

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
