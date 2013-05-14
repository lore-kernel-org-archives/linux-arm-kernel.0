From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 14:47:19 +0200
Subject: [RFC 2/4] dma: add dmaengine driver for Samsung s3c24xx SoCs
In-Reply-To: <201305111331.25405.heiko@sntech.de>
References: <201305111330.05046.heiko@sntech.de>
 <201305111331.25405.heiko@sntech.de>
Message-ID: <CACRpkda-wQyo8aYxbW9RJNcR3Kwe2w5AhaAuUHfaxBksa_Pm2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 11, 2013 at 1:31 PM, Heiko St?bner <heiko@sntech.de> wrote:

> Conceptually the s3c24xx-dma feels like a distant relative of the pl08x
> with numerous virtual channels being mapped to a lot less physical ones.
> The driver therefore borrows a lot from the amba-pl08x driver in this
> regard. Functionality-wise the driver gains a memcpy ability in addition
> to the slave_sg one.
>
> The driver currently only supports the "newer" SoCs which can use any
> physical channel for any dma slave. Support for the older SoCs where
> each channel only supports a subset of possible dma slaves will have to
> be added later.
>
> Tested on a s3c2416-based board, memcpy using the dmatest module and
> slave_sg partially using the spi-s3c64xx driver.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

So have I understood correctly if I assume that *some* S3C
variants, i.e. this: arch/arm/mach-s3c64xx/dma.c
have a vanilla, unmodified, or just slightly modified
PL08x block, while this DMAC is something probably based on
the PL08x where some ASIC engineer has had a good time hacking
around in the VHDL code to meet some feature requirements.
Correct? Or plausible guess?

Exactly *how* far away from the pl08x hardware is it?

I guess you have already come to the conclusion that the
amba-pl08x.c driver cannot be augmented to handle this hardware
after some educated reading of that code?

But are really no parts reusable?

For example, if the LLIs have the same layout, could we split
out the LLI handling from amba-pl08x into a separate file and reuse
that?

The more you share with amba-pl08x the better for everyone,
I am positively sure. And please include Russell on the review
chain, he wrote the virtual channel abstraction.

If I was given the option amongst S3C work I would definatley
have augmented the amba-pl08x.c to handle the stuff in
arch/arm/mach-s3c64xx/dma.c *first* then started to work on
this driver, but I guess you might not be working on s3c64xx?

Yours,
Linus Walleij
