From: keescook@chromium.org (Kees Cook)
Date: Fri, 24 Mar 2017 10:46:41 -0700
Subject: [PATCH] lkdtm: add bad USER_DS test
In-Reply-To: <a1ab8afa-5462-dc24-2106-0a6b43773c5b@de.ibm.com>
References: <20170323203419.GA62859@beast> <20170324081450.GA5891@osiris>
 <CAJcbSZHJ1WFcE7QY6qLM9RMUJbGXxTpp3WsCNJBX4h1U-4HEjA@mail.gmail.com>
 <a1ab8afa-5462-dc24-2106-0a6b43773c5b@de.ibm.com>
Message-ID: <CAGXu5jJxNjdz3x1M3t9nhy590Bk67xwGxidYqJWytETb_PFgKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 8:24 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 03/24/2017 04:17 PM, Thomas Garnier wrote:
>> On Fri, Mar 24, 2017 at 1:14 AM, Heiko Carstens
>> <heiko.carstens@de.ibm.com> wrote:
>>> On Thu, Mar 23, 2017 at 01:34:19PM -0700, Kees Cook wrote:
>>>> This adds CORRUPT_USER_DS to check that the get_fs() test on syscall return
>>>> still sees USER_DS during the new VERIFY_PRE_USERMODE_STATE checks.
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>
>>> ...
>>>
>>>> +void lkdtm_CORRUPT_USER_DS(void)
>>>> +{
>>>> +     /*
>>>> +      * Test that USER_DS has been set correctly on exiting a syscall.
>>>> +      * Since setting this higher than USER_DS (TASK_SIZE) would introduce
>>>> +      * an exploitable condition, we lower it instead, since that should
>>>> +      * not create as large a problem on an unprotected system.
>>>> +      */
>>>> +     mm_segment_t lowfs;
>>>> +#ifdef MAKE_MM_SEG
>>>> +     lowfs = MAKE_MM_SEG(TASK_SIZE - PAGE_SIZE);
>>>> +#else
>>>> +     lowfs = TASK_SIZE - PAGE_SIZE;
>>>> +#endif
>>>> +
>>>> +     pr_info("setting bad task size limit\n");
>>>> +     set_fs(lowfs);
>>>> +}
>>>
>>> This won't work on architectures where the set_fs() argument does not
>>> contain an address but an address space identifier. This is true e.g. for
>>> s390 and as far as I know also for sparc.
>>> On s390 we have complete distinct address spaces for kernel and user space
>>> that each start at address zero.
>>>
>>
>> The patch that enforce USER_DS is disabled on s390 anyway. I guess, we
>> can just do a set_fs(KERNEL_DS) for the others.
>
> that would enable the test, but it would also mean that lkdtm can be used by
> a program to escalate its rights. I think that is the reason why Kees did this
> lowfs things.

Yeah, but it seems like getting this right for all architectures isn't
sane. I'm going to change it to use KERNEL_DS but also post a SIGKILL
to the process. That way it'll still trigger the syscall return
checking, but will be unable to continue running with a potentially
uncaught KERNEL_DS.

-Kees

-- 
Kees Cook
Pixel Security
