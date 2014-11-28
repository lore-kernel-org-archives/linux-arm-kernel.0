From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 28 Nov 2014 16:01:15 +0000
Subject: [PATCH v3 0/5] ARM64: Add kernel probes(Kprobes) support
In-Reply-To: <5476BFB4.2020705@hitachi.com>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <20141120135851.GA32528@linaro.org> <54759041.9080105@hitachi.com>
 <20141126100325.GA9157@linaro.org> <5476120D.9030703@linaro.org>
 <CAPvkgC3eVOZEn79C9PC9c7TqC_-yCtDhw5LL6ZWUJxr+oQFaow@mail.gmail.com>
 <5476BFB4.2020705@hitachi.com>
Message-ID: <CAPvkgC0ELPPWfa-8kQ4H_e_O5G1ER4KEKuSWLxh_u-VZgh7W6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 November 2014 at 06:07, Masami Hiramatsu
<masami.hiramatsu.pt@hitachi.com> wrote:
> (2014/11/27 3:59), Steve Capper wrote:
>> The crash is extremely easy to reproduce.
>>
>> I've not observed any missed events on a kprobe on an arm64 system
>> that's still alive.
>> My (limited!) understanding is that this suggests there could be a
>> problem with how missed events from a recursive call to memcpy are
>> being handled.
>
> I think so too. BTW, could you bisect that? :)
>

I can't bisect, but the following functions look suspicious to me
(again I'm new to kprobes...):
kprobes_save_local_irqflag
kprobes_restore_local_irqflag

I think these are breaking somehow when nested (i.e. from a recursive probe).

That would explain why the state of play of the interrupts is in an
unexpected state in the crash I reported:
"The point of failure in the panic was:
fs/buffer.c:1257

static inline void check_irqs_on(void)
{
#ifdef irqs_disabled
        BUG_ON(irqs_disabled());
#endif
}
"

This is all new to me so I'm still at the head-scratching stage.

David,
Does the above make sense to you? Have you managed to reproduce the crash I get?

Cheers,
--
Steve
