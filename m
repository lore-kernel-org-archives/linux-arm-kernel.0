From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 15 Mar 2013 19:16:52 -0500
Subject: ep93xx irq-vic regression
In-Reply-To: <5143AAB4.6020406@gmail.com>
References: <ADE657CA350FB648AAC2C43247A983F0020980106C9F@AUSP01VMBX24.collaborationhost.net>
 <5143AAB4.6020406@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020980106CB7@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 15, 2013 4:12 PM, Ryan Mallon wrote:
> On 16/03/13 08:46, H Hartley Sweeten wrote:
>
>>  Hello all,
>> 
>> Yesterday I tried upgrading my ep93xx system from 3.6.6 to 3.8.3.
>> The kernel compiles fine but the machine would not boot. It just
>> hangs when the bootloader (RedBoot) tries to exec the kernel.
>> 
>> I then tried 3.7.0 and it works fine.
>> 
>> I did a bisect and got down to this commit:
>> 
>> $ git bisect bad
>> 07c9249f1fa90cc8189bed44c0bcece664596a72 is the first bad commit
>> commit 07c9249f1fa90cc8189bed44c0bcece664596a72
>> Author: Linus Walleij <linus.walleij@linaro.org>
>> Date:   Tue Oct 16 18:50:00 2012 +0100
>> 
>>     ARM: 7554/1: VIC: use irq_domain_add_simple()
>> 
>> Any ideas on what might be the problem?
>
>
> I don't know the code very well, but looking at the change we go
> from being having the first vic bank being registered with
> irq_domain_add_legacy to irq_domain_add_linear (since first_irq
> is zero). It looks like the linear domain needs to have it's
> revmap initialised with a call to either irq_domain_associate_many
> or irq_create_strict_mappings, which I can't find a call to. Are
> we left with the first vic bank having no revmap? That's from a
> ten minute, uninformed glance at the code though, so I might be
> off base :-).

Grrr... chasing my tail...

It looks like the commit above _did_ have a couple bugs but they were
fixed:

commit 07c9249f1fa90cc8189bed44c0bcece664596a72
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Tue Oct 16 18:50:00 2012 +0100

    ARM: 7554/1: VIC: use irq_domain_add_simple()

commit 946c59a08a2497303750c0fee4367ca32009155c
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Thu Nov 8 10:48:30 2012 +0000

    ARM: vic: fix build warning caused by previous commit

commit 5ced33bc06e7e76cb8a236f15bff49eb6155b618
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Wed Dec 26 01:39:16 2012 +0100

    ARM: 7611/1: VIC: fix bug in VIC irqdomain code

It appears the reason my system was hanging is due to this
commit:

commit 210dce5faf89c9677ac1a6273bc53f130843539f
Author: Florian Fainelli <florian@openwrt.org>
Date:   Mon Dec 10 22:21:19 2012 +0100

    ARM: ep93xx: properly wait for UART FIFO to be empty

Reverting that one allows my system to boot with 3.9.0-rc2.

Instead of removing the wait loop completely I propose this
patch instead. I can repost this patch in a new thread if
necessary.

Regards,
Hartley

---

From: H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH] arm: ep93xx: fix wait for UART FIFO to be empty

commit 210dce5f "ARM: ep93xx: properly wait for UART FIFO to be empty"

Removed the timeout loop while waiting for the uart transmit fifo to
empty. Some bootloaders leave the uart in a state where there might
be bytes in the uart that are not transmitted when execution is handed
over to the kernel. This results in a deadlocked system while waiting
for the fifo to empty.

Add back the timeout wait to prevent the deadlock.

Increase the wait time to hopefully prevent the decompressor corruption
that lead to commit 210dce5f. This corruption was probably due to a
slow uart baudrate. The 10* increase in the wait time should be enough
for all cases.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/include/mach/uncompress.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index d2afb4d..b5cc77d 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -47,9 +47,13 @@ static void __raw_writel(unsigned int value, unsigned int ptr)
 
 static inline void putc(int c)
 {
-	/* Transmit fifo not full?  */
-	while (__raw_readb(PHYS_UART_FLAG) & UART_FLAG_TXFF)
-		;
+	int i;
+
+	for (i = 0; i < 10000; i++) {
+		/* Transmit fifo not full? */
+		if (!(__raw_readb(PHYS_UART_FLAG) & UART_FLAG_TXFF))
+			break;
+	}
 
 	__raw_writeb(c, PHYS_UART_DATA);
 }
-- 
1.8.1.4
