From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 15 Oct 2010 21:32:04 +0800
Subject: iwmmxt signal frame handling
In-Reply-To: <AANLkTimHyhLRZwR-FRtciu+0sGYYFkAh4WfLCWwu59JA@mail.gmail.com>
References: <201010141609.10889.arnd@arndb.de>
	<AANLkTimHyhLRZwR-FRtciu+0sGYYFkAh4WfLCWwu59JA@mail.gmail.com>
Message-ID: <AANLkTik3Brb-XbL1GkteVs_g9J3HtYsZMQogh+KR0LB0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 15, 2010, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, Oct 14, 2010 at 10:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Peter Maydell noticed during code review that the signal frame might
>> be written incorrectly for kernels with CONFIG_IWMMXT set running
>> processes without TIF_USING_IWMMXT, where the magic/size values
>> for the iwmmxt section of the frame are left uninitialized.
>> Instead of skipping this part of the frame, we should instead
>> write a valid header with zero data.
>>
>> This patch is compile-tested only since the problem was only
>> found in review and neither Peter nor myself have access to
>> IWMMXT capable hardware to test this on.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>
> Looks OK to me as well.
>
> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>

This also passes the internal iwmmxt test, Haojian please add your
Tested-by please.

>>
>> --- a/arch/arm/kernel/signal.c
>> +++ b/arch/arm/kernel/signal.c
>> @@ -154,7 +154,10 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe *frame)
>> ? ? ? ?kframe = (struct iwmmxt_sigframe *)((unsigned long)(kbuf + 8) & ~7);
>> ? ? ? ?kframe->magic = IWMMXT_MAGIC;
>> ? ? ? ?kframe->size = IWMMXT_STORAGE_SIZE;
>> - ? ? ? iwmmxt_task_copy(current_thread_info(), &kframe->storage);
>> + ? ? ? if (test_thread_flag(TIF_USING_IWMMXT))
>> + ? ? ? ? ? ? ? iwmmxt_task_copy(current_thread_info(), &kframe->storage);
>> + ? ? ? else
>> + ? ? ? ? ? ? ? memset(&kframe->storage, 0, sizeof(kframe->storage));
>> ? ? ? ?return __copy_to_user(frame, kframe, sizeof(*frame));
>> ?}
>>
>> @@ -429,7 +432,7 @@ setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
>> ? ? ? ? ? ? ? ?err |= preserve_crunch_context(&aux->crunch);
>> ?#endif
>> ?#ifdef CONFIG_IWMMXT
>> - ? ? ? if (err == 0 && test_thread_flag(TIF_USING_IWMMXT))
>> + ? ? ? if (err == 0)
>> ? ? ? ? ? ? ? ?err |= preserve_iwmmxt_context(&aux->iwmmxt);
>> ?#endif
>> ?#ifdef CONFIG_VFP
>>
>
