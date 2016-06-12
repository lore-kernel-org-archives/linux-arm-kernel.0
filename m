From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 12 Jun 2016 20:56:44 +0300
Subject: [PATCH 13/23] arm64: introduce is_a32_task and is_a32_thread
 (for AArch32 compat)
In-Reply-To: <575D5ECC.4030000@huawei.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-14-git-send-email-ynorov@caviumnetworks.com>
 <575D53B0.5020408@huawei.com> <575D5ECC.4030000@huawei.com>
Message-ID: <20160612175644.GA12475@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 09:08:28PM +0800, Zhangjian (Bamvor) wrote:
> >>  #ifdef CONFIG_COMPAT
> >>  #define TASK_SIZE_32        UL(0x100000000)
> >>-#define TASK_SIZE        (test_thread_flag(TIF_32BIT) ? \
> >>+#define TASK_SIZE        (is_compat_task() ?        \
> >>                  TASK_SIZE_32 : TASK_SIZE_64)
> >>  #define TASK_SIZE_OF(tsk)    (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
> >>                  TASK_SIZE_32 : TASK_SIZE_64)
> >Should we update or delete this macro?
> >  #define TASK_SIZE_OF(tsk) (is_compat_task() ? \
> >TASK_SIZE_32 : TASK_SIZE_64)
> Sorry it should be:
> #define TASK_SIZE_OF(tsk)       ((is_a32_compat_thread(task_thread_info(tsk)) \
>                                   || is_ilp32_compat_thread(task_thread_info(tsk))) ? \
>                                 TASK_SIZE_32 : TASK_SIZE_64)

Thank you. I know about this, but always forget to fix. )
I think we'd introduce is_compat_thread() as well.

> >x86, sparc, mips, ppc, parisc, s390 define its own version. But
> >"include/linux/sched.h" will define it if
> >TASK_SIZE_OF does not exist:
> >#ifndef TASK_SIZE_OF
> >#define TASK_SIZE_OF(tsk)       TASK_SIZE
> >#endif
> >
> >
> >Regards
> >
> >Bamvor
> >
