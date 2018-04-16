From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 16 Apr 2018 19:15:37 -0400
Subject: [PATCH 1/2] parisc: use the asm-generic version for writeX()
In-Reply-To: <a727e74f-610c-4722-76e9-c1aca2f9e9bd@bell.net>
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
 <a727e74f-610c-4722-76e9-c1aca2f9e9bd@bell.net>
Message-ID: <a7b59f43-cea5-0ead-f528-61899570e353@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2018 7:09 PM, John David Anglin wrote:
> On 2018-04-16 6:01 PM, Sinan Kaya wrote:
>> parisc architecture seems to be mapping writeX() and writeX_relaxed() APIs
>> to __raw_writeX() API.
>>
>> __raw_writeX() API doesn't provide any kind of ordering guarantees.
>> commit 755bd04aaf4b ("io: define stronger ordering for the default writeX()
>> implementation") changed asm-generic implementation to use a more
>> conservative approach towards the writeX() API.
>>
>> Drop the arch specific version and rely on the asm-generic version for
>> parisc since parisc version doesn't seem to do anything special with these
>> macros.
> ? HOSTLD? scripts/mod/modpost
> In file included from ./arch/parisc/include/asm/hardirq.h:13:0,
> ???????????????? from ./include/linux/hardirq.h:9,
> ???????????????? from arch/parisc/kernel/asm-offsets.c:34:
> ./include/linux/irq.h: In function 'irq_reg_writel':
> ./include/linux/irq.h:1114:3: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
> ?? writel(val, gc->reg_base + reg_offset);
> ?? ^~~~~~
> ./include/linux/irq.h: In function 'irq_reg_readl':
> ./include/linux/irq.h:1123:10: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
> ?? return readl(gc->reg_base + reg_offset);
> ????????? ^~~~~
> cc1: some warnings being treated as errors
> make[1]: *** [Kbuild:58: arch/parisc/kernel/asm-offsets.s] Error 1
> 
> Dave
> 

Thanks for testing. Can you add this on top and see if it helps?

--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -259,6 +259,7 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
  * value for either 32 or 64 bit mode */
 #define F_EXTEND(x) ((unsigned long)((x) | (0xffffffff00000000ULL)))
 
+#include <asm-generic/io.h>
 #include <asm-generic/iomap.h>


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
