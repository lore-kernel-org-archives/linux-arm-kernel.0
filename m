From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 28 Apr 2014 09:51:49 +0200
Subject: [PATCH] ARM: fix string functions on !MMU
In-Reply-To: <1398103808-24380-1-git-send-email-rabin@rab.in>
References: <1398103808-24380-1-git-send-email-rabin@rab.in>
Message-ID: <20140428075149.GB28564@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rabin,

On Mon, Apr 21, 2014 at 08:10:08PM +0200, Rabin Vincent wrote:
> 8c56cc8be5b38e ("ARM: 7449/1: use generic strnlen_user and
> strncpy_from_user functions") apparently broken those string operations
> for !MMU.  USER_DS == KERNEL_DS on !MMU, so user_addr_max() always
> restricts the addresses to TASK_SIZE.
> 
> TASK_SIZE has anyway no meaning on !MMU, so make user_addr_max() not
> restrict anything.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
I tested this on my efm32 machine and it booted just fine. Before I used
a patch that did:

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 02fa2558f662..f25c7f4c5a44 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -92,9 +92,12 @@
  * It is difficult to define and perhaps will never meet the original meaning
  * of this define that was meant to.
  * Fortunately, there is no reference for this in noMMU mode, for now.
+ *
+ * HACK: copy_from_user must even handle copying from flash. So don't impose a
+ * limit at all. Not sure this is correct ...
  */
 #ifndef TASK_SIZE
-#define TASK_SIZE              (CONFIG_DRAM_SIZE)
+#define TASK_SIZE              (~0UL)
 #endif
 
 #ifndef TASK_UNMAPPED_BASE

Regarding "TASK_SIZE has anyway no meaning on !MMU", there are a few
more usages of TASK_SIZE for no-MMU (tested by removing its definition
and compiling with my efm32 config, so I might have missed some usages):

- mm/nommu.c uses TASK_SIZE in validate_mmap_request:

        /* Careful about overflows.. */
        rlen = PAGE_ALIGN(len);
        if (!rlen || rlen > TASK_SIZE)
                return -ENOMEM;

  Maybe this should better be explicitly:

        if (!rlen || rlen > CONFIG_DRAM_SIZE)
                return -ENOMEM;

  ?
- kernel/sys.c uses TASK_SIZE in prctl_set_mm
  used for prctl syscall with option=PR_SET_MM. Maybe here it would be
  nice to have TASK_SIZE == ~0UL?

- fs/exec.c uses TASK_SIZE in setup_new_exec to assign
  current->mm->task_size. I didn't check if/how this is used.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
