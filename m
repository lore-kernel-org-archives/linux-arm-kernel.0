From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jun 2016 17:47:44 +0200
Subject: [PATCH 08/19] arm64: introduce is_a32_task and is_a32_thread (for
 AArch32 compat)
In-Reply-To: <mvmk2hipyfw.fsf@hawking.suse.de>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <576915B0.5040706@huawei.com> <mvmk2hipyfw.fsf@hawking.suse.de>
Message-ID: <4650742.YG7pOR48ul@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 21, 2016 1:34:59 PM CEST Andreas Schwab wrote:
> "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> writes:
> 
> >> @@ -78,9 +79,9 @@
> >>
> >>   #ifdef CONFIG_COMPAT
> >>   #define TASK_SIZE_32               UL(0x100000000)
> >> -#define TASK_SIZE           (test_thread_flag(TIF_32BIT) ? \
> >> +#define TASK_SIZE           (is_compat_task() ?             \
> >>                              TASK_SIZE_32 : TASK_SIZE_64)
> >> -#define TASK_SIZE_OF(tsk)   (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
> >> +#define TASK_SIZE_OF(tsk)   (is_compat_thread(tsk) ? \
> > It should be
> > +#define TASK_SIZE_OF(tsk)      (is_compat_thread(task_thread_info(tsk)) ? \
> > is_compat_thread takes "struct thread_info *thread" while TASK_SIZE_OF takes
> > "struct task_struct *tsk"tsk.
> 
> If that doesn't throw an error does that mean that TASK_SIZE_OF is
> unused?

I think that is correct. On some architectures, TASK_SIZE (which is used)
is defined as TASK_SIZE_OF(current), but the definition above doesn't
do that and there are no other users.

	Arnd
