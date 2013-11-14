From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Thu, 14 Nov 2013 11:02:20 +0900
Subject: [PATCH v2 10/13] kprobes: Remove uneeded kernel dependency
 on struct arch_specific_insn
In-Reply-To: <1384362833.3392.42.camel@linaro1.home>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-11-git-send-email-dave.long@linaro.org>
 <1384362833.3392.42.camel@linaro1.home>
Message-ID: <52842F2C.1030701@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2013/11/14 2:13), Jon Medhurst (Tixy) wrote:
> On Tue, 2013-10-15 at 17:04 -0400, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Instead of depending on include/asm/kprobes.h to provide a dummy definition
>> for struct arch_specific_insn, do so in include/linux/kprobes.h.
> 
> That change description doesn't quite seem to quite make sense to me.
> 
> Anyway, what we're trying to do with this patch is to allow us to use
> arch_specific_insn for purposes additional to implementing kprobes. This
> patch enables that but I'm wary that the kprobes code assumes that ainsn
> is a struct arch_specific_insn, e.g. in linux/kernel/kprobes.c we have:
> 
> 	memcpy(&p->ainsn, &ap->ainsn, sizeof(struct arch_specific_insn));
> 
> Now, that code isn't compiled when kprobes isn't configured, but it
> seams to me to be safer if that was also changed to 
> 
> 	memcpy(&p->ainsn, &ap->ainsn, sizeof(p->ainsn));

This kind of cleanup looks good for me, but I don't agree to change
the type of the member (removing is OK) by Kconfig. If you want to
change the framework of kprobes and uprobes itself (unification),
I'm appreciate to discuss with you and uprobes people, because it
will involve all arch dependent code change, *NOT ONLY* the ARM issue.

> However, I also wonder if we should instead leave arch_specific_insn as
> a kprobes specific structure and on ARM define it in terms of a new more
> generic 'struct probe_insn'? The drawback with that is that we'd
> probably end up with a struct just containing a single member which
> seems a bit redundant:
>
> struct arch_specific_insn {
> 	struct probe_insn pinsn;
> };

I also disagree it. If you have a plan to integrate uprobes and kprobes
arch specific code, please share it with us. I'm happy to work with you.
There are already many maintainers on each feature who is responsible for
it (even it is a piece of code), and scripts/get_maintainers.pl gives you
who are.

Srikar, Oleg, I think it's a good time to merge such arch_specific mechanism
of uprobes and kprobes. Would you think we can do similar thing on x86 too?

Thank you,


-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
