From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sun, 25 Oct 2015 21:32:12 +0100
Subject: [PATCH 1/2] can: xilinx: use readl/writel instead of
 ioread/iowrite
In-Reply-To: <8460953.p47oezaZnR@wuerfel>
References: <1445489163-11045-1-git-send-email-appanad@xilinx.com>
 <4061693.oBld7AKBIp@wuerfel> <56289CA6.1060809@pengutronix.de>
 <8460953.p47oezaZnR@wuerfel>
Message-ID: <562D3C4C.60306@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2015 10:58 AM, Arnd Bergmann wrote:
>>> The two should really do the same thing: iowrite32() is just a static inline
>>> calling writel() on both ARM32 and ARM64. On which kernel version did you
>>> observe the difference? It's possible that an older version used
>>> CONFIG_GENERIC_IOMAP, which made this slightly more expensive.
>>>
>>> If there are barriers that you want to get rid of for performance reasons,
>>> you should use writel_relaxed(), but be careful to synchronize them correctly
>>> with regard to DMA. It should be fine in this driver, as it does not
>>> perform any DMA, but be aware that there is no big-endian version of
>>> writel_relaxed() at the moment.
>>
>> We don't have DMA in CAN drivers, but usually a certain write triggers
>> sending. Do we need a barrier before triggering the sending?
> 
> No, the relaxed writes are not well-defined across architectures. On
> ARM, the CPU guarantees that stores to an MMIO area are still in order
> with respect to one another, the barrier is only needed for actual DMA,
> so you are fine. I would expect the same to be true everywhere,
> otherwise a lot of other drivers would be broken too.

And the relaxed functions seem not to be available on all archs. This
driver should work on microblaze. Are __raw_writeX(), __raw_readX() an
alternative here?

> To be on the safe side, that last write() could remain a writel() instead
> of writel_relaxed(), and that would be guaranteed to work on all
> architectures even if they end relax the ordering between MMIO writes.
> If there is a measurable performance difference, just use writel_relaxed()
> and add a comment.

Thanks,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151025/b5fa83eb/attachment.sig>
