From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 May 2013 14:20:49 +0200
Subject: [RFC 2/4] dma: add dmaengine driver for Samsung s3c24xx SoCs
In-Reply-To: <201305152231.52423.heiko@sntech.de>
References: <201305111330.05046.heiko@sntech.de>
 <201305111331.25405.heiko@sntech.de>
 <CACRpkdaT195McX9NeccJYpmWbuYK-AZUTHr9AXKHnJdkf+Qzuw@mail.gmail.com>
 <201305152231.52423.heiko@sntech.de>
Message-ID: <CACRpkdaGBjUfhfT2zCEeNmMh3KhouOMjKSB7H6_cu_uDM6cm=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 10:31 PM, Heiko St?bner <heiko@sntech.de> wrote:

> If I understand the writel semantics and the thread from you from 2011 [0]
> correctly, only the writel to DMASKTRIG mustn't be relaxed to make sure the
> settings registers are written to before, so like:
>
>        writel_relaxed(txd->src_addr, phy->base + DISRC);
>        writel_relaxed(txd->disrcc, phy->base + DISRCC);
>        writel_relaxed(txd->dst_addr, phy->base + DIDST);
>        writel_relaxed(txd->didstc, phy->base + DIDSTC);
>        writel_relaxed(dcon, phy->base + DCON);
>
>        val = readl_relaxed(phy->base + DMASKTRIG);
>        val &= ~DMASKTRIG_STOP;
>        val |= DMASKTRIG_ON;
>        writel(val, phy->base + DMASKTRIG);

Yep. That will drain write buffers etc and make sure all outstanding writes hit
the hardware.

Yours,
Linus Walleij
