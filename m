From: keescook@chromium.org (Kees Cook)
Date: Mon, 13 Aug 2018 23:10:12 -0700
Subject: [PATCH 2/6] ARM: vfp: use __copy_from_user() when restoring VFP
 state
In-Reply-To: <20180726123244.x7klflacdykdtjbj@lakrids.cambridge.arm.com>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctOq-0005us-Ar@rmk-PC.armlinux.org.uk>
 <20180726123244.x7klflacdykdtjbj@lakrids.cambridge.arm.com>
Message-ID: <CAGXu5jKYoqoFUEojawWQZAzCDMvtWTtW5AQB48OYTYVhm5nSfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 5:32 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jul 10, 2018 at 03:13:52PM +0100, Russell King wrote:
>> Use __copy_from_user() rather than __get_user_err() for individual
>> members when restoring VFP state.
>
> Same comment as for patch 1: I assume this is to amortize the cost of
> the __user pointer santiziation, and if so it'd be good to mention that
> in the commit message.
>
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> ---
>>  arch/arm/include/asm/thread_info.h |  2 +-
>>  arch/arm/kernel/signal.c           | 20 ++++++++------------
>>  arch/arm/vfp/vfpmodule.c           | 16 +++++++---------
>>  3 files changed, 16 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>> index e71cc35de163..341f6eb9b8be 100644
>> --- a/arch/arm/include/asm/thread_info.h
>> +++ b/arch/arm/include/asm/thread_info.h
>> @@ -123,7 +123,7 @@ struct user_vfp_exc;
>>
>>  extern int vfp_preserve_user_clear_hwstate(struct user_vfp __user *,
>>                                          struct user_vfp_exc __user *);
>> -extern int vfp_restore_user_hwstate(struct user_vfp __user *,
>> +extern int vfp_restore_user_hwstate(struct user_vfp *,
>>                                   struct user_vfp_exc __user *);
>>  #endif
>>
>> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
>> index 0ae74207e43e..db62c51250ad 100644
>> --- a/arch/arm/kernel/signal.c
>> +++ b/arch/arm/kernel/signal.c
>> @@ -150,22 +150,18 @@ static int preserve_vfp_context(struct vfp_sigframe __user *frame)
>>
>>  static int restore_vfp_context(char __user **auxp)
>>  {
>> -     struct vfp_sigframe __user *frame =
>> -             (struct vfp_sigframe __user *)*auxp;
>> -     unsigned long magic;
>> -     unsigned long size;
>> -     int err = 0;
>> -
>> -     __get_user_error(magic, &frame->magic, err);
>> -     __get_user_error(size, &frame->size, err);
>> +     struct vfp_sigframe frame;
>> +     int err;
>>
>> +     err = __copy_from_user(&frame, *auxp, sizeof(frame));
>>       if (err)
>> -             return -EFAULT;
>> -     if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
>> +             return err;

While this appears not to have a behavior change (everything is
checking non-zero), why return "err" here instead of -EFAULT?
__copy_from_user() is returning a count, not a negative return code.
Seems weird to mix that with the -EINVAL below...

>> +
>> +     if (frame.magic != VFP_MAGIC || frame.size != VFP_STORAGE_SIZE)
>>               return -EINVAL;
>
> I think that in a few cases, trying to load the whole vfp_sigframe size
> first means that we can now fault and return -EFAULT when previously
> we'd have returned -EINVAL.

-Kees

-- 
Kees Cook
Pixel Security
