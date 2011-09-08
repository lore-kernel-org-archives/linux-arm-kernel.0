From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 8 Sep 2011 10:06:29 -0700
Subject: [PATCH v2 3/3] ARM: pxa/pj4: Port problematic pj4 support code to
	v7/Thumb-2
In-Reply-To: <201109081844.21371.arnd@arndb.de>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-4-git-send-email-dave.martin@linaro.org>
	<201109081844.21371.arnd@arndb.de>
Message-ID: <CAMPhdO-JG7yuSP45HH1tvbDoeL27J9onj=LK=8bEw3cea6SW0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 9:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 08 September 2011, Dave Martin wrote:
>> ? ? ? ? __asm__ __volatile__ (
>> ? ? ? ? ? ? ? ? "mcr ? ?p15, 0, %1, c1, c0, 2\n\t"
>> +#ifdef __LINUX_ARM_ARCH__ >= 7
>> + ? ? ? ? ? ? ? "isb\n\t"
>> +#else
>> ? ? ? ? ? ? ? ? "mrc ? ?p15, 0, %0, c1, c0, 2\n\t"
>> ? ? ? ? ? ? ? ? "mov ? ?%0, %0\n\t"
>> ? ? ? ? ? ? ? ? "sub ? ?pc, pc, #4\n\t"
>> +#endif
>> ? ? ? ? ? ? ? ? : "=r" (temp) : "r" (value));
>> ?}
>
> I thought we had concluded that we don't actually need the #else
> path because there is no pre-v7 support for pj4 any more.

Or if isb() works fine, will the below change be cleaner:

diff --git a/arch/arm/kernel/pj4-cp0.c b/arch/arm/kernel/pj4-cp0.c
index a4b1b07..dc4272d 100644
--- a/arch/arm/kernel/pj4-cp0.c
+++ b/arch/arm/kernel/pj4-cp0.c
@@ -62,14 +62,10 @@ static u32 __init pj4_cp_access_read(void)

 static void __init pj4_cp_access_write(u32 value)
 {
-       u32 temp;
-
        __asm__ __volatile__ (
-               "mcr    p15, 0, %1, c1, c0, 2\n\t"
-               "mrc    p15, 0, %0, c1, c0, 2\n\t"
-               "mov    %0, %0\n\t"
-               "sub    pc, pc, #4\n\t"
-               : "=r" (temp) : "r" (value));
+               "mcr    p15, 0, %0, c1, c0, 2\n\t"
+               : : "r" (value));
+       isb();
 }
