From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 6 Apr 2017 18:45:06 +0800
Subject: [PATCH v23 06/11] clocksource: arm_arch_timer: refactor MMIO
 timer probing.
In-Reply-To: <20170405184229.GA29338@leverpostej>
References: <20170331175105.8370-1-fu.wei@linaro.org>
 <20170331175105.8370-7-fu.wei@linaro.org>
 <20170405184229.GA29338@leverpostej>
Message-ID: <CADyBb7tjLRYHsrB3V579RGxGS0jM51x628AqKomV_VFm+0b0ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 6 April 2017 at 02:42, Mark Rutland <mark.rutland@arm.com> wrote:
> On Sat, Apr 01, 2017 at 01:51:00AM +0800, fu.wei at linaro.org wrote:
>> +     arch_timer_mem_freq = arch_timer_mem_get_cntfrq(base);
>> +     if (!arch_timer_rate && arch_timer_mem_freq) {
>> +             arch_timer_rate = arch_timer_mem_freq;
>> +     } else if (!arch_timer_rate || arch_timer_rate != arch_timer_mem_freq) {
>> +             pr_err(FW_BUG "invalid MMIO frequency.\n");
>> +             iounmap(base);
>> +             return -EINVAL;
>> +     }
>
> I thought I had previously mentioned that this last check has the
> potential to break DT systems, which may be inadvertently relying on the
> probe order.
>
> I agree we must do this check for ACPI, but I think that for DT it needs
> to be relaxed.
>
> I'm happy to rework that locally, if you can address my comments on
> patch 9.

yes, you suggested that we keep the current frequency probing approach for DT,
and use the new approach for ACPI.

Because we try to merge the common code for MMIO timer. this become a little
problem, sorry for that.

I thinks for this code, maybe we can do :

arch_timer_mem_freq = arch_timer_mem_get_cntfrq(base);
if (!arch_timer_rate && arch_timer_mem_freq) {
arch_timer_rate = arch_timer_mem_freq;
} else if (!acpi_disabled && arch_timer_rate != arch_timer_mem_freq) {
pr_err(FW_BUG "invalid MMIO frequency.\n");
iounmap(base);
return -EINVAL;
}

Please correct me, if I miss something.

Thanks :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
