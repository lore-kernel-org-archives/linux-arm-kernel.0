From: masami.hiramatsu@linaro.org (Masami Hiramatsu)
Date: Thu, 22 Feb 2018 14:45:18 +0900
Subject: [PATCH 1/2] arm64: kprobes: Remove unneeded address sanity check
In-Reply-To: <5A8E52CA.3020206@linaro.org>
References: <20180201093459.20477-1-takahiro.akashi@linaro.org>
 <20180201093459.20477-2-takahiro.akashi@linaro.org>
 <5A84EB83.7070807@linaro.org>
 <20180215154759.47dd4cc8a64f0e99d9e8695f@kernel.org>
 <5A8E52CA.3020206@linaro.org>
Message-ID: <CAA93ih2e7tQyyiBALM_AZwsdcRha75=p-PY13s9-8ZJ20CLZYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

2018-02-22 14:19 GMT+09:00 David Long <dave.long@linaro.org>:
> On 02/15/2018 01:47 AM, Masami Hiramatsu wrote:
>>
>> Hi David,
>>
>> On Wed, 14 Feb 2018 21:08:03 -0500
>> David Long <dave.long@linaro.org> wrote:
>>
>>> On 02/01/2018 04:34 AM, AKASHI Takahiro wrote:
>>>>
>>>> From: Masami Hiramatsu <mhiramat@kernel.org>
>>>>
>>>> Remove unneeded address sanity check in arch_prepare_kprobe().
>>>> Since do_debug_exception() is already blacklisted for kprobes, no need
>>>> to reject all __exception functions. Also, since generic kprobe
>>>> framework already ensures the address is in kernel text, no need to
>>>> check it is in rodata again.
>>>>
>>>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>> ---
>>>>    arch/arm64/kernel/probes/kprobes.c | 8 --------
>>>>    1 file changed, 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/probes/kprobes.c
>>>> b/arch/arm64/kernel/probes/kprobes.c
>>>> index d849d9804011..3c487a389252 100644
>>>> --- a/arch/arm64/kernel/probes/kprobes.c
>>>> +++ b/arch/arm64/kernel/probes/kprobes.c
>>>> @@ -78,8 +78,6 @@ static void __kprobes arch_simulate_insn(struct kprobe
>>>> *p, struct pt_regs *regs)
>>>>    int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>>>    {
>>>>         unsigned long probe_addr = (unsigned long)p->addr;
>>>> -       extern char __start_rodata[];
>>>> -       extern char __end_rodata[];
>>>>
>>>>         if (probe_addr & 0x3)
>>>>                 return -EINVAL;
>>>> @@ -87,12 +85,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>>>         /* copy instruction */
>>>>         p->opcode = le32_to_cpu(*p->addr);
>>>>
>>>> -       if (in_exception_text(probe_addr))
>>>> -               return -EINVAL;
>>>> -       if (probe_addr >= (unsigned long) __start_rodata &&
>>>> -           probe_addr <= (unsigned long) __end_rodata)
>>>> -               return -EINVAL;
>>>> -
>>>>         /* decode instruction */
>>>>         switch (arm_kprobe_decode_insn(p->addr, &p->ainsn)) {
>>>>         case INSN_REJECTED:     /* insn not supported */
>>>>
>>>
>>> I have tested this change on v4.15 using kprobes events and I find it
>>> allows kprobes to be placed in exception text when they were previously
>>> rejected. Is there some other recent change I need to test this with for
>>> the previous behavior to be preserved?
>>
>>
>> Hmm, the latest change is to avoid retpoline thunk functions on x86. Since
>> the
>> retpoline may not be applied on aarch64, it can be ignored.
>> However, I found there were still many "__kprobes" tags under arch/arm64.
>> That
>> was replaced with NOKPROBE_SYMBOL() (and nokprobe_inline for inline
>> function).
>> It should be done on arm/arm64 too because the functions marked with
>> NOKPROBE_SYMBOL are listed in <debugfs>/kprobes/blacklist.
>
>
> My bad for not reading the whole patch set before commenting. I understand
> the goal now.
>
> I see NOKPROBE_SYMBOL is only used for a few architectures so far, with
> arm64 widely using both methods. I'm presuming this is work in progress.
>
> I verified do_debug_exception is still rejected by kprobes. The other global
> functions in there are accepted after the change. Do we think that's safe? I
> can't immediately come up with a reason it wouldn't be. Has it been tested,
> beyond the IRQ stuff?

Yeah, it is reasonable concern. We already have ftrace/kprobe
interface in debugfs (tracefs)
so we can start testing it now with, something like below shell script;

n=0
cd /sys/kernel/debug/tracing
cut -f 3 -d " " /proc/kallsyms | while read sym; do
  echo "probing $sym"
  echo "p $sym" >> kprobe_events
  n=$((n+1))
  [ $n -gt 3000 ] && break
done

I think it could be enough to test first 2-3k syms since most of arch
dependent code are placed there.

See my old slide.
https://events.static.linuxfound.org/sites/events/files/slides/Handling%20the%20Massive%20Multiple%20Kprobes%20v2_1.pdf

Unfortunately, kpcache and hash-table expansion (most critical
features) were not accepted, so take care of performance degradation.

> I remember adding the rodata test. Seems to me there was a reason for that
> at the time, but I've verified that probes in rodata are still rejected
> after the patch.

Yes, because kernel/kprobes.c accepts the probes probing the kernel .text.

Thank you,


-- 
Masami Hiramatsu
