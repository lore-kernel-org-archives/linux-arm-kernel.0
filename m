From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Wed, 6 Nov 2013 16:35:44 +0530
Subject: [PATCH RFC 6/6] kprobes: Add cases for arm and arm64 in sample
 module
In-Reply-To: <20131025152428.GD10673@mudshark.cambridge.arm.com>
References: <1382008671-4515-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1382008671-4515-7-git-send-email-sandeepa.prabhu@linaro.org>
 <20131025152428.GD10673@mudshark.cambridge.arm.com>
Message-ID: <CA+b37P16kSi9Zja=oLRSCn74-ystxpcfKsy5A8r3eDEMfzZycQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 October 2013 20:54, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Oct 17, 2013 at 12:17:51PM +0100, Sandeepa Prabhu wrote:
>> Add info prints in sample kprobe handlers for ARM and ARM64
>> architecture.
>>
>> Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>> ---
>>  samples/kprobes/kprobe_example.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
>> index 366db1a..0521246 100644
>> --- a/samples/kprobes/kprobe_example.c
>> +++ b/samples/kprobes/kprobe_example.c
>> @@ -42,6 +42,14 @@ static int handler_pre(struct kprobe *p, struct pt_regs *regs)
>>                       " ex1 = 0x%lx\n",
>>               p->addr, regs->pc, regs->ex1);
>>  #endif
>> +#ifdef CONFIG_ARM
>> +     printk(KERN_INFO "pre_handler: p->addr = 0x%p, pc = 0x%lx\n",
>> +                     p->addr, regs->ARM_pc);
>> +#endif
>> +#ifdef CONFIG_ARM64
>> +     printk(KERN_INFO "pre_handler: p->addr = 0x%p, pc = 0x%lx\n",
>> +             p->addr, (long)regs->pc);
>> +#endif
>
> Huh? Why can't you combine these two together and either unconditionall cast
> to long, or use void * and %p?
pt_regs member names are different: regs->pc (arm64) vs. regs->ARM_pc
(arm32). It is still possible to use instruction_pointer(regs) for
both architectures, but this needs including asm/ptrace.h which I am
not sure good thing to do in samples/

Thanks,
Sandeepa
>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
