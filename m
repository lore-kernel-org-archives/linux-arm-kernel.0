From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Fri, 15 Nov 2013 19:23:41 +0900
Subject: [PATCH v2 10/13] kprobes: Remove uneeded kernel dependency
 on struct arch_specific_insn
In-Reply-To: <52853389.7080105@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-11-git-send-email-dave.long@linaro.org>
 <1384362833.3392.42.camel@linaro1.home> <52842F2C.1030701@hitachi.com>
 <1384438551.3388.78.camel@linaro1.home> <52853389.7080105@linaro.org>
Message-ID: <5285F62D.5010407@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2013/11/15 5:33), David Long wrote:
> On 11/14/13 09:15, Jon Medhurst (Tixy) wrote:
>> On Thu, 2013-11-14 at 11:02 +0900, Masami Hiramatsu wrote:
>>> (2013/11/14 2:13), Jon Medhurst (Tixy) wrote:
>>>> On Tue, 2013-10-15 at 17:04 -0400, David Long wrote:
>>>>> From: "David A. Long" <dave.long@linaro.org>
>>>>>
>>>>> Instead of depending on include/asm/kprobes.h to provide a dummy definition
>>>>> for struct arch_specific_insn, do so in include/linux/kprobes.h.
>>>>
>>>> That change description doesn't quite seem to quite make sense to me.
>>>>
>>>> Anyway, what we're trying to do with this patch is to allow us to use
>>>> arch_specific_insn for purposes additional to implementing kprobes. This
>>>> patch enables that but I'm wary that the kprobes code assumes that ainsn
>>>> is a struct arch_specific_insn, e.g. in linux/kernel/kprobes.c we have:
>>>>
>>>> 	memcpy(&p->ainsn, &ap->ainsn, sizeof(struct arch_specific_insn));
>>>>
>>>> Now, that code isn't compiled when kprobes isn't configured, but it
>>>> seams to me to be safer if that was also changed to
>>>>
>>>> 	memcpy(&p->ainsn, &ap->ainsn, sizeof(p->ainsn));
>>>
> 
> That does look like an important improvement.

Agreed.

>>> This kind of cleanup looks good for me, but I don't agree to change
>>> the type of the member (removing is OK) by Kconfig.
>>
>> Wouldn't that still require an #ifdef CONFIG_KPROBES around ainsn?
>> Admittedly a less ugly one than one to change its type to an int.
>>
> 
> It is also possible to make the include of asm/kprobes.h unconditional, 
> although that might only cause the #ifdef to appear in more than one 
> include file.

Good point!

>>> Srikar, Oleg, I think it's a good time to merge such arch_specific mechanism
>>> of uprobes and kprobes. Would you think we can do similar thing on x86 too?
>>
> 
> I welcome input from people who have experience in this area.  I have no 
> desire to complicate efforts that might be attempted on other 
> architectures, but the existing code was unique to ARM and the goal here 
> was just to share it on ARM in implementing the currently non-existant 
> ARM uprobes feature.  It seems to me the leakage of these changes into 
> generic kprobes code is exceedingly small, and unlikely to be a 
> hinderance to any future work (if any is even needed or planned) 
> supporting uprobes or kprobes on other architectures.  In the meantime 
> we have ARM users who have been asking for uprobes support for a while 
> and this is, IMHO, a fairly clean approach to providing it.

I see. I'd just like to suggest you that your improvement on ONE arch
can also be useful idea for the other archs. In that case, there would be
better, more efficient way to do that.
Since we are on the same (or, next) track, we can learn many things each other. :)

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
