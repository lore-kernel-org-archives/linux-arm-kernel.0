From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Jun 2012 18:22:14 -0700
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <201206181410.39267.arnd@arndb.de>
References: <20120611051502.GA24030@july>
 <CAOesGMgGQMwQTUy2g-XSYFrQ-p+x9g2q8kAd-ZYq=TBgVFu0Zw@mail.gmail.com>
 <CAH9JG2X=15G6wDX5SGJkDEVohkQQkzfBoL3Qv7HVuBUMqYnwRg@mail.gmail.com>
 <201206181410.39267.arnd@arndb.de>
Message-ID: <4FE125C6.3030401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/12 07:10, Arnd Bergmann wrote:
> On Monday 18 June 2012, Kyungmin Park wrote:
>>> I would prefer to see this handled by using the smp_ops patchset that
>>> Marc Zyngier has been posting instead, replacing the boot_secondary
>>> function pointer during early boot depending on whether trustzone is
>>> enabled or not.
>> I understand your request, but it's not only boot_secondary but also
>> exynos pm common code and so on.even more it's used at devfreq to
>> adjust the RAM bus timings.
>>
>> Now these files are covered.
>>
> Would it help to have a trustzone_ops structure with pointers to
> functions if needed, similar to but separate from smp_ops?
>
> Instead of checking for trustzone_enabled() in each place where
> we call into smc, we can have a generic implementation that
> we call for the disabled case, and provide a vendor specific
> version of that struct with functions that call into smp 
> where necessary.
>
>

What if we tried to read the SCR.NS bit to determine if we're running in
secure state or not? It looks like reading SCR is UNDEFINED (i.e. causes
an undefined instruction exception) if we're running in the non-secure
state so I propose we set up an undef hook that traps the SCR access and
lies about the value of the NS bit to indicate we're non-secure.
Basically this:

static int scr_trap(struct pt_regs *regs, unsigned int instr)
{
        int reg = (instr >> 12) & 15;
        if (reg == 15)
                return 1;
        regs->uregs[reg] = BIT(0); /* Trapped = non-secure */
        regs->ARM_pc += 4;
        return 0;
}

static struct undef_hook scr_hook = {
        .instr_mask     = 0x0fff0fff,
        .instr_val      = 0x0e110f11,
        .fn             = scr_trap,
};

int in_secure_state(void)
{
        unsigned int scr;

	register_undef_hook(&scr_hook);

        asm volatile(
        "       mrc p15, 0, %0, c1, c1, 0\n"
        : "=r" (scr)
        :
        : "cc");

	unregister_undef_hook(&scr_hook);

        return !(scr & BIT(0));
}
EXPORT_SYMBOL(in_secure_state);


It seems to mostly work, although I haven't figured out what you do
about the hypervisor case when the hypervisor has disabled the smc
instruction entirely (SCR.SCD=1). At that point I throw up my hands.
Maybe Will has some idea.

At the least I would hope we read the cpuid registers to see if the
processor supports the SMC instruction so that we can't say
trustzone_set_enable() on a CPU that doesn't even support it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
