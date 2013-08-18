From: gnurou@gmail.com (Alexandre Courbot)
Date: Sun, 18 Aug 2013 17:37:08 +0900
Subject: [PATCH v3 4/5] ARM: tegra: set CPU reset handler with firmware op
In-Reply-To: <520BF94F.60907@wwwdotorg.org>
References: <1376360992-1508-1-git-send-email-acourbot@nvidia.com>
 <1376360992-1508-5-git-send-email-acourbot@nvidia.com>
 <520BF94F.60907@wwwdotorg.org>
Message-ID: <CAAVeFuJMPZpz4jV4y12P=h-fJ2RSSCrzLWW5Uwges0WZH1Zb2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 6:40 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/12/2013 08:29 PM, Alexandre Courbot wrote:
>> Use a firmware operation to set the CPU reset handler and only resort to
>> doing it ourselves if there is none defined.
>>
>> This supports the booting of secondary CPUs on devices using a TrustZone
>> secure monitor.
>
>> diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
>
>> +     err = call_firmware_op(set_cpu_boot_addr, 0, reset_address);
>> +     switch (err) {
>> +     case -ENOSYS:
>> +             tegra_cpu_reset_handler_set(reset_address);
>> +             /* pass-through */
>> +     case 0:
>> +             is_enabled = true;
>> +             break;
>> +     default:
>> +             pr_crit("Cannot set CPU reset handler: %d\n", err);
>> +             BUG();
>> +     }
>
> Instead of trying and failing, does it make sense to register
> tegra_cpu_reset_handler_set() as the set_cpu_boot_addr firmware op when
> there is no firmware present? That would simplify all call-sites of any
> firmware op.

We discussed that point in v2 already IIRC (that is some time ago).
The reason I did it this way is because I wanted to follow the way
Tomasz was using his interface with Exynos - it seemed appropriate
that all users of an interface use it the same way. But if you prefer
to use a "non-firmware" firmware_ops for Tegra, I have absolutely
nothing against this.

Thanks,
Alex.
