From: arm@jic23.retrosnub.co.uk (Jonathan Cameron)
Date: Mon, 08 Mar 2010 17:44:19 +0000
Subject: [PATCH] pxa: fix for UART reference in section text for a number
	of platforms.
In-Reply-To: <f17812d71003080410y7d5dad83t28e6855aa4ad5cfc@mail.gmail.com>
References: <4B94DC52.1040201@cam.ac.uk>	<f17812d71003080348k7ff5cd77lf5e1262ce1ccf14@mail.gmail.com>
	<f17812d71003080410y7d5dad83t28e6855aa4ad5cfc@mail.gmail.com>
Message-ID: <4B953773.6050904@jic23.retrosnub.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/10 12:10, Eric Miao wrote:
> On Mon, Mar 8, 2010 at 7:48 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> What's the background?
>>
> 
> OK, I saw the thread. So this is basically going to move the "UART" to
> bss, which doesn't get discarded. However, my 'devel' branch has been
> modified a bit to support off chip UART decompressing messages to be
> displayed, I'm afraid this needs to be updated a bit.

The same problem will occur with the other two variables changed by
this function, so how about the following (against your tree, but tested
against mainline with a couple of patches lifted from your tree). Builds
fine for imote2, startgate2 and arcom_zeus. Just testing a full build
of all pxa platforms to see if anything similar is hiding elsewhere.

[PATCH] pxa: fix for uart_base and friends reference in section.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 arch/arm/mach-pxa/include/mach/uncompress.h |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 5ef91d9..03914e4 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -16,9 +16,9 @@
 #define BTUART_BASE	(0x40200000)
 #define STUART_BASE	(0x40700000)
 
-static unsigned long uart_base = FFUART_BASE;
-static unsigned int uart_shift = 2;
-static unsigned int uart_is_pxa = 1;
+static unsigned long uart_base;
+static unsigned int uart_shift;
+static unsigned int uart_is_pxa;
 
 static inline unsigned char uart_read(int offset)
 {
@@ -58,14 +58,20 @@ static inline void arch_decomp_setup(void)
 {
 	if (machine_is_littleton() || machine_is_intelmote2()
 	    || machine_is_csb726() || machine_is_stargate2()
-	    || machine_is_cm_x300() || machine_is_balloon3())
+	    || machine_is_cm_x300() || machine_is_balloon3()) {
 		uart_base = STUART_BASE;
-
-	if (machine_is_arcom_zeus()) {
+		uart_shift = 2;
+		uart_is_pxa = 1;
+	} else if (machine_is_arcom_zeus()) {
 		uart_base = 0x10000000;	/* nCS4 */
 		uart_shift = 1;
 		uart_is_pxa = 0;
+	} else {
+		uart_base = FFUART_BASE;
+		uart_shift = 2;
+		uart_is_pxa = 1;
 	}
 }
 
 /*
-- 
1.6.4.4
