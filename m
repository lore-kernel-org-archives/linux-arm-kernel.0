From: robherring2@gmail.com (Rob Herring)
Date: Tue, 03 Apr 2012 21:50:47 -0500
Subject: linux-3.4-rc1 PXA2xx PCMCIA possible regression
In-Reply-To: <1333504642.26202.YahooMailClassic@web29009.mail.ird.yahoo.com>
References: <1333504642.26202.YahooMailClassic@web29009.mail.ird.yahoo.com>
Message-ID: <4F7BB707.8000701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2012 08:57 PM, Paul Parsons wrote:
> On linux-3.3 the PCMCIA/CF on my hx4700 worked OK.
> 
> On linux-3.4-rc1 the PCMCIA/CF has stopped working:
> 
> pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
> pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 156)
> pata_pcmcia: probe of 0.0 failed with error -12
> 
> I've traced the -ENOMEM error back to pcmcia_init_one() in
> drivers/ata/pata_pcmcia.c:
> 
>    237		/* iomap */
>    238		ret = -ENOMEM;
>    239		io_addr = devm_ioport_map(&pdev->dev, io_base, 8);
>    240		ctl_addr = devm_ioport_map(&pdev->dev, ctl_base, 1);
>    241		if (!io_addr || !ctl_addr)
>    242			goto failed;
> 
> Both calls to devm_ioport_map() return NULL.
> 
> The ultimate source of both NULL values appears to be __io() and
> thence __typesafe_io(), both defined in arch/arm/include/asm/io.h

I broke it with the io.h clean-up. It seems PCMCIA drivers rely on
__io() just being a cast. The easy fix is just restore that behavior for
PCMCIA:

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index df0ac0b..1b50c28 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -118,6 +118,8 @@ static inline void __iomem *__typesafe_io(unsigned
long addr)
  */
 #ifdef CONFIG_NEED_MACH_IO_H
 #include <mach/io.h>
+#elif defined(CONFIG_PCMCIA)
+#define __io(a)                __typesafe_io(a)
 #else
 #define __io(a)                ({ (void)(a); __typesafe_io(0); })
 #endif


Can you please test this change. This is what we'll have to do for 3.4,
but this is not really the right solution. io_base should not be a
virtual address here, but an i/o address in the range of 0-64K. We need
to move PCMCIA to the fixed i/o mapping I've posted:

http://www.spinics.net/lists/arm-kernel/msg162547.html

I've been trying to get PCMCIA to work on spitz in QEMU to test out
fixes, but haven't had much luck. I'm not getting a card detected even
though QEMU thinks one is present.

Rob

> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
