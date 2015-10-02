From: broonie@kernel.org (Mark Brown)
Date: Fri, 2 Oct 2015 18:03:11 +0100
Subject: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop transferring issue
In-Reply-To: <00f401d0fbf0$65f32220$31d96660$@tangramtek.com>
References: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
 <20150930182219.GU15635@sirena.org.uk>
 <00f401d0fbf0$65f32220$31d96660$@tangramtek.com>
Message-ID: <20151002170311.GW12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 10:24:42AM +0800, yitian wrote:

> I think maybe two reasons:
> 1. designware I2S IP in my chipset(new design) is using tx empty and rx
> available signal as the DMA handshaking signal, but it may be not true
> for all chipsets. If I2S has separate signal as DMA handshaking signal, mask
> irq should not impact DMA transfer. But Synopsys's engineer recommend us to
> use
> tx and rx irq signal as the DMA handshaking signal, meanwhile we cannot find
> separate DMA handshaking signal from designware's IP spec, that's why tx/rx
> irq
> will impact DMA transfer.

If that's what the Synopsis engineers recommend I'd guess that other
integrations are doing the same thing.

> 2. I am using a FPGA for test, the cpu frequency of it is only 26MHz, that
> means
> XRUN is very easy to happen on my board. But I guess most of the developers
> are using real chipset which can have at least 600MHz frequency so XRUN is
> not easy to be reproduced. As my test, No XUN, no this bug...

Ah, that might be it - it might just be that other systems are working
due to race conditions.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/bd2aa600/attachment.sig>
