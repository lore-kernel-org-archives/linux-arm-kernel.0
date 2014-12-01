From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 01 Dec 2014 18:37:31 +0900
Subject: [PATCH v3 0/5] ARM64: Add kernel probes(Kprobes) support
In-Reply-To: <CAPvkgC0ELPPWfa-8kQ4H_e_O5G1ER4KEKuSWLxh_u-VZgh7W6A@mail.gmail.com>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <20141120135851.GA32528@linaro.org> <54759041.9080105@hitachi.com>
 <20141126100325.GA9157@linaro.org> <5476120D.9030703@linaro.org>
 <CAPvkgC3eVOZEn79C9PC9c7TqC_-yCtDhw5LL6ZWUJxr+oQFaow@mail.gmail.com>
 <5476BFB4.2020705@hitachi.com>
 <CAPvkgC0ELPPWfa-8kQ4H_e_O5G1ER4KEKuSWLxh_u-VZgh7W6A@mail.gmail.com>
Message-ID: <547C36DB.7060903@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/11/29 1:01), Steve Capper wrote:
> On 27 November 2014 at 06:07, Masami Hiramatsu
> <masami.hiramatsu.pt@hitachi.com> wrote:
>> (2014/11/27 3:59), Steve Capper wrote:
>>> The crash is extremely easy to reproduce.
>>>
>>> I've not observed any missed events on a kprobe on an arm64 system
>>> that's still alive.
>>> My (limited!) understanding is that this suggests there could be a
>>> problem with how missed events from a recursive call to memcpy are
>>> being handled.
>>
>> I think so too. BTW, could you bisect that? :)
>>
> 
> I can't bisect, but the following functions look suspicious to me
> (again I'm new to kprobes...):
> kprobes_save_local_irqflag
> kprobes_restore_local_irqflag
> 
> I think these are breaking somehow when nested (i.e. from a recursive probe).

Agreed. On x86, prev_kprobe has old_flags and saved_flags, this
at least must have saved_irqflag and save/restore it in
save/restore_previous_kprobe().

What about adding this?

 struct prev_kprobe {
 	struct kprobe *kp;
 	unsigned int status;
+	unsigned long saved_irqflag;
 };

and

 static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
 	kcb->prev_kprobe.status = kcb->kprobe_status;
+	kcb->prev_kprobe.saved_irqflag = kcb->saved_irqflag;
 }

 static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
 	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->saved_irqflag = kcb->prev_kprobe.saved_irqflag;
 }



> That would explain why the state of play of the interrupts is in an
> unexpected state in the crash I reported:
> "The point of failure in the panic was:
> fs/buffer.c:1257
> 
> static inline void check_irqs_on(void)
> {
> #ifdef irqs_disabled
>         BUG_ON(irqs_disabled());
> #endif
> }
> "
> 
> This is all new to me so I'm still at the head-scratching stage.

Ah, I see.

Thank you,

> 
> David,
> Does the above make sense to you? Have you managed to reproduce the crash I get?
> 
> Cheers,
> --
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
