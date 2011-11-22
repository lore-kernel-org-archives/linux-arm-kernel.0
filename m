From: rabin@rab.in (Rabin Vincent)
Date: Tue, 22 Nov 2011 23:30:11 +0530
Subject: [PATCH 1/4] ARM: ftrace: use canonical Thumb-2 wide instruction
 format
In-Reply-To: <20111122120242.GD2066@localhost.localdomain>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <20111122120242.GD2066@localhost.localdomain>
Message-ID: <CAH+eYFBfcpKYrq-kyV4RZ-s1En5Q2wy6dhuEsk6KNgk-zb7wDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 17:32, Dave Martin <dave.martin@linaro.org> wrote:
> On Mon, Nov 21, 2011 at 08:43:46PM +0530, Rabin Vincent wrote:
>> +#ifndef __ARMEB__
>> + ? ? if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
>> + ? ? ? ? ? ? old = (old >> 16) | (old << 16);
>> + ? ? ? ? ? ? new = (new >> 16) | (new << 16);
>
> I think swahw32() in <linux/swab.h> can be used for this operation.

Yes.

> Really though, we need a common set of "load and store instruction"
> macros, rather than duplicating this knowledge everywhere.

Yes, though this ftrace code may not be able to use them directly since
it uses probe_kernel_read()/write().

> In particular, we really want those macros to encapsulate the
> #ifdef __ARMEB__ stuff.

The ifdef for ARMEB is a bit jarring, especially since now we can even
get rid of ifdefs for CONFIG_THUMB2_KERNEL.  An arm_is_bigendian() or
somesuch macro in a header would be preferable for this, I think.

>
>
>> + ? ? }
>> +#endif
>>
>> - ? ? if (replaced != old)
>> - ? ? ? ? ? ? return -EINVAL;
>> + ? ? if (old) {
>> + ? ? ? ? ? ? if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
>> + ? ? ? ? ? ? ? ? ? ? return -EFAULT;
>> +
>> + ? ? ? ? ? ? if (replaced != old)
>> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>> + ? ? }
>>
>> ? ? ? if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
>> ? ? ? ? ? ? ? return -EPERM;
>> @@ -141,23 +150,21 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
>>
>> ?int ftrace_update_ftrace_func(ftrace_func_t func)
>> ?{
>> - ? ? unsigned long pc, old;
>> + ? ? unsigned long pc;
>> ? ? ? unsigned long new;
>> ? ? ? int ret;
>>
>> ? ? ? pc = (unsigned long)&ftrace_call;
>> - ? ? memcpy(&old, &ftrace_call, MCOUNT_INSN_SIZE);
>> ? ? ? new = ftrace_call_replace(pc, (unsigned long)func);
>>
>> - ? ? ret = ftrace_modify_code(pc, old, new);
>> + ? ? ret = ftrace_modify_code(pc, 0, new);
>>
>> ?#ifdef CONFIG_OLD_MCOUNT
>> ? ? ? if (!ret) {
>> ? ? ? ? ? ? ? pc = (unsigned long)&ftrace_call_old;
>> - ? ? ? ? ? ? memcpy(&old, &ftrace_call_old, MCOUNT_INSN_SIZE);
>> ? ? ? ? ? ? ? new = ftrace_call_replace(pc, (unsigned long)func);
>>
>> - ? ? ? ? ? ? ret = ftrace_modify_code(pc, old, new);
>> + ? ? ? ? ? ? ret = ftrace_modify_code(pc, 0, new);
>> ? ? ? }
>> ?#endif
>
> Why don't we check the old value any more?

The ftrace_modify_code() checks the location its modifying to ensure
that the old value was what it expected it to be -- this is useful for
example if we have problems with the recordmcount code that makes it
record wrong locations.

In this particular case however, what we're modifying is not code at an
mcount location but some of the code in entry-common.S which is at the
location of a known symbol.  The safety check for the old value was
quite useless in this case because we were just memcpy()ing the content
of the location and passing that in as the old value.

The reason it's done in this patch is that because of converting to the
canonical format, we'd need an additional ifdef-ARMEB/swahw32() here
after doing the memcpy(), for the memcmp() in ftrace_modify_code() to
succeed.  Instead, we just avoid the comparison for this case.

> It would be good to see something in comments or the commit log
> clarifying this.

Agreed.  Perhaps it should even be done in a separate patch.

>
> To what extent can this be unified with the kprobes functionality?
> (if you've already done that, ignore this comment -- I confess I
> don't understand all the details of these patches...)

With this patch series:
 - kprobes and jump labels use the common text patching code
 - jump labels and ftrace use the common instruction generation code

kprobes and ftrace, however, don't share anything.  We could make ftrace
use __patch_text(), although that would only save half-a-dozen lines of
code and also remove the use of probe_kernel_write(), which all the
other arch ftrace implementations use.
