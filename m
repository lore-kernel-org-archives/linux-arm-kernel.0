From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 13:04:01 +0200
Subject: [PATCH V2 4/4] ARM64 LPC: support earlycon for UART connected to
 LPC
In-Reply-To: <57D137AF.9070306@gmail.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <4291379.IHAA72aKCk@wuerfel> <57D137AF.9070306@gmail.com>
Message-ID: <7585762.SZVHZyJdka@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 6:04:31 PM CEST zhichang wrote:
> Hi, Arnd,
> 
> On 2016?09?07? 22:52, Arnd Bergmann wrote:
> > On Wednesday, September 7, 2016 9:33:53 PM CEST Zhichang Yuan wrote:
> >> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> >>
> >> This patch support the earlycon for UART connected to LPC on Hip06.
> >> This patch is depended on the LPC driver.
> >>
> >> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> >>
> > 
> > I'm skeptical about this too. Is this just needed because the 8250
> > earlycon support comes before the lpc bus initialization?
> I think you wonder why early_serial8250_setup can not be used direclty for this earlycon of LPC uart.
> 
> 1. the earlycon kernel parameter format of LPC uart is different from 8250. something like that
> "earlycon=hisilpcuart,mmio,0xa01b0000,0,0x2f8". You see, there is one more parameter after the baudrate.

We should never need to specify the addresses manually like this,
it's actually supposed to work if you just list "earlycon" here.

The first membase is apparently only used during setup:

+       writel(LPC_IRQ_CLEAR, device->port.membase + LPC_REG_IRQ_ST);
+       /* ensure the LPC is available */
+       while (!(readl(device->port.membase + LPC_REG_OP_STATUS) &
+                       LPC_STATUS_IDLE))

Why doesn't the firmware do this before handing off control of
the kernel to the console?

> Hip06 LPC uart need two base addresses for earlycon.
> 2. the IO type is mmio to introduce a memory base address to access LPC register file. But the real uart
> IO type is UPIO_PORT. This is spcial...

This sounds like a deficiency in the of_setup_earlycon() function,
which can only handle MMIO addresses, and won't actually
be able to understand nodes without a "ranges" property like
you have here.

I think we need to add a special case for port ranges here.

	Arnd
