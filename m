From: dave.long@linaro.org (David Long)
Date: Wed, 08 Apr 2015 07:01:05 -0400
Subject: [PATCH v5 3/6] arm64: Kprobes with single stepping support
In-Reply-To: <CAHM4w1=84w40VCKyEtGfqYEziZaqgRWG6O7TGn+w1CeQuPyVPg@mail.gmail.com>
References: <1424214701-4899-1-git-send-email-dave.long@linaro.org>	<1424214701-4899-4-git-send-email-dave.long@linaro.org>
 <CAHM4w1=84w40VCKyEtGfqYEziZaqgRWG6O7TGn+w1CeQuPyVPg@mail.gmail.com>
Message-ID: <55250A71.6060200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/15 02:07, Pratyush Anand wrote:
> Hi Dave,
>
> On Wed, Feb 18, 2015 at 4:41 AM, David Long <dave.long@linaro.org> wrote:
>>
>> From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>>
>> Add support for basic kernel probes(kprobes) and jump probes
>> (jprobes) for ARM64.
>>
>
> [...]
>
>>
>> +#ifdef CONFIG_KPROBES
>> +static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
>> +{
>> +       int ret = 0;
>> +
>> +       /* kprobe_running() needs smp_processor_id() */
>> +       if (!user_mode(regs)) {
>> +               preempt_disable();
>> +               if (kprobe_running() && kprobe_fault_handler(regs, esr))
>> +                       ret = 1;
>> +               preempt_enable();
>> +       }
>> +
>> +       return ret;
>> +}
>> +#else
>> +static inline int notify_page_fault(struct pt_regs *regs)
>
> Please fix this definition in next revision, other wise there would be
> a build error
> if CONFIG_KPROBES is not defined.
>
>
> should be:
>
> +static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
>
>
> ~Pratyush
>

Yes, the fix is already in the v6 version I'm working on.

-dl
