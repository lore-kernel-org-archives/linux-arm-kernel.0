From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 15 Mar 2010 20:43:32 +0800
Subject: [PATCH] pxa: fix for UART reference in section text for a number
	of platforms.
In-Reply-To: <4B953773.6050904@jic23.retrosnub.co.uk>
References: <4B94DC52.1040201@cam.ac.uk>
	<f17812d71003080348k7ff5cd77lf5e1262ce1ccf14@mail.gmail.com>
	<f17812d71003080410y7d5dad83t28e6855aa4ad5cfc@mail.gmail.com>
	<4B953773.6050904@jic23.retrosnub.co.uk>
Message-ID: <f17812d71003150543o24b4d3e0sd94aca7f53d535fe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 9, 2010 at 1:44 AM, Jonathan Cameron
<arm@jic23.retrosnub.co.uk> wrote:
> On 03/08/10 12:10, Eric Miao wrote:
>> On Mon, Mar 8, 2010 at 7:48 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> What's the background?
>>>
>>
>> OK, I saw the thread. So this is basically going to move the "UART" to
>> bss, which doesn't get discarded. However, my 'devel' branch has been
>> modified a bit to support off chip UART decompressing messages to be
>> displayed, I'm afraid this needs to be updated a bit.
>
> The same problem will occur with the other two variables changed by
> this function, so how about the following (against your tree, but tested
> against mainline with a couple of patches lifted from your tree). Builds
> fine for imote2, startgate2 and arcom_zeus. Just testing a full build
> of all pxa platforms to see if anything similar is hiding elsewhere.
>
> [PATCH] pxa: fix for uart_base and friends reference in section.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Merged with some minor changes as below, let me know if you
are OK with this.

commit 11f4f3150254477bbe19a847c5aed747f3eeff2a
Author: Jonathan Cameron <arm@jic23.retrosnub.co.uk>
Date:   Mon Mar 8 17:44:19 2010 +0000

    [ARM] pxa: fix for variables in uncompress.h being discarded

    Due to commit:

        5de813b  ARM: Eliminate decompressor -Dstatic= PIC hack

    The data section will be discarded for the decompressor, thus move the
    static variables into BSS section by initializing them at run-time.

    Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h
b/arch/arm/mach-pxa/include/mach/uncompress.h
index 5ef91d9..759b851 100644
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
@@ -56,6 +56,11 @@ static inline void flush(void)

 static inline void arch_decomp_setup(void)
 {
+	/* initialize to default */
+	uart_base = FFUART_BASE;
+	uart_shift = 2;
+	uart_is_pxa = 1;
+
 	if (machine_is_littleton() || machine_is_intelmote2()
 	    || machine_is_csb726() || machine_is_stargate2()
 	    || machine_is_cm_x300() || machine_is_balloon3())
