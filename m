From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 22 Oct 2015 10:21:58 +0200
Subject: [PATCH 1/2] can: xilinx: use readl/writel instead of
 ioread/iowrite
In-Reply-To: <4061693.oBld7AKBIp@wuerfel>
References: <1445489163-11045-1-git-send-email-appanad@xilinx.com>
 <4061693.oBld7AKBIp@wuerfel>
Message-ID: <56289CA6.1060809@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2015 10:14 AM, Arnd Bergmann wrote:
> On Thursday 22 October 2015 10:16:02 Kedareswara rao Appana wrote:
>> The driver only supports memory-mapped I/O [by ioremap()],
>> so readl/writel is actually the right thing to do, IMO.
>> During the validation of this driver or IP on ARM 64-bit processor
>> while sending lot of packets observed that the tx packet drop with iowrite
>> Putting the barriers for each tx fifo register write fixes this issue
>> Instead of barriers using writel also fixed this issue.
>>
>> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> 
> The two should really do the same thing: iowrite32() is just a static inline
> calling writel() on both ARM32 and ARM64. On which kernel version did you
> observe the difference? It's possible that an older version used
> CONFIG_GENERIC_IOMAP, which made this slightly more expensive.
> 
> If there are barriers that you want to get rid of for performance reasons,
> you should use writel_relaxed(), but be careful to synchronize them correctly
> with regard to DMA. It should be fine in this driver, as it does not
> perform any DMA, but be aware that there is no big-endian version of
> writel_relaxed() at the moment.

We don't have DMA in CAN drivers, but usually a certain write triggers
sending. Do we need a barrier before triggering the sending?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/b2643a57/attachment.sig>
