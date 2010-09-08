From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 8 Sep 2010 09:27:43 +0300
Subject: [PATCH 1/2] s3c24xx: DMA: don't use autoreload feature
In-Reply-To: <4C86CC9C.9070506@fluff.org>
References: <1283872143-32492-1-git-send-email-anarsoul@gmail.com>
	<1283901799-20461-1-git-send-email-anarsoul@gmail.com>
	<4C86CC9C.9070506@fluff.org>
Message-ID: <201009080927.49861.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 8 ???????? 2010 02:37:00 ????? Ben Dooks ???????:
> On 08/09/10 00:23, Vasily Khoruzhick wrote:
> > Some integrated DMA-capable hardware doesn't like autoreload
> > feature of s3c24xx DMA-engine, that's why s3cmci driver
> > didn't work with DMA transfers enabled.
> > 
> > I rewrote DMA driver not to use autoreload feature and removed
> > all pre-loading features. Buffer re-load is fast enought to perform
> > it in IRQ handler, and anyway I don't see any reason to waste CPU
> > cycles on waiting for buffer load. Driver is much simplier now,
> > it was tested with s3cmci and s3c24xx-i2s drivers on s3c2442 and
> > s3c2410 SoCs and works just nice.
> 
> I found this really necessary, especially on systems where some
> drivers can keep the cpu irq load high, such as pio hard-discs.
> 
> Can this be changed to a flag that is set to control the behaviour
> on a per driver basis?

Well, that's not easy and result will be a bit complicated :) Your 
implementation has 4 states and actively uses autoreload flag, but when 
there's no autoreload/pre-loading there's only 2 states. Btw, all DMA-capable 
HW on S3C24xx has FIFO, so missing pre-loading should not give big impact, as 
HW can be fed from FIFO for some time. Can you test if this patch causes some 
problems on your HW with pio hard-discs?

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100908/0e46a31b/attachment.sig>
