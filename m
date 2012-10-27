From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 27 Oct 2012 15:59:29 +0000 (UTC)
Subject: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
In-Reply-To: <508BBC59.60504@ti.com>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.00.1210262251020.11258@utopia.booyaka.com>
 <508BBC59.60504@ti.com>
Message-ID: <alpine.DEB.2.00.1210271545390.16409@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Oct 2012, Santosh Shilimkar wrote:

> Another alternative, which I will recommend to just make use of the
> read*/wrire* instead __raw versions. The barriers are taken care
> already and driver point of view, it is transparent.

Those barriers will disappear if CONFIG_ARM_DMA_MEM_BUFFERABLE is set to 
N, so that's probably not the right thing to do in this case.  The barrier 
here isn't DMA-related, it's needed due to the design of the driver.

In fact the wmb() is probably overkill, since only a compiler reordering 
barrier is needed.  It can probably just be barrier().


- Paul
