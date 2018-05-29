From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 29 May 2018 13:56:05 +0200
Subject: [PATCH v9 00/12] Support PPTT for ARM64
In-Reply-To: <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com>
Message-ID: <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 29/05/18 11:48, Geert Uytterhoeven wrote:
>> On Thu, May 17, 2018 at 7:05 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>>> On Fri, May 11, 2018 at 06:57:55PM -0500, Jeremy Linton wrote:
>>>> Jeremy Linton (12):
>>>>   drivers: base: cacheinfo: move cache_setup_of_node()
>>>>   drivers: base: cacheinfo: setup DT cache properties early
>>>>   cacheinfo: rename of_node to fw_token
>>>>   arm64/acpi: Create arch specific cpu to acpi id helper
>>>>   ACPI/PPTT: Add Processor Properties Topology Table parsing
>>>>   ACPI: Enable PPTT support on ARM64
>>>>   drivers: base cacheinfo: Add support for ACPI based firmware tables
>>>>   arm64: Add support for ACPI based firmware tables
>>>>   arm64: topology: rename cluster_id
>>>>   arm64: topology: enable ACPI/PPTT based CPU topology
>>>>   ACPI: Add PPTT to injectable table list
>>>>   arm64: topology: divorce MC scheduling domain from core_siblings
>>>
>>> Queued for 4.18 (without Sudeep's latest property_read_u64 cacheinfo
>>> patch - http://lkml.kernel.org/r/20180517154701.GA20281 at e107155-lin; I
>>> can add it separately).
>>
>> This is now commit 37c3ec2d810f87ea ("arm64: topology: divorce MC
>> scheduling domain from core_siblings") in arm64/for-next/core, causing
>> system suspend on big.LITTLE systems to hang after shutting down the first
>> CPU:
>>
>>     $ echo mem > /sys/power/state
>>     PM: suspend entry (deep)
>>     PM: Syncing filesystems ... done.
>>     Freezing user space processes ... (elapsed 0.001 seconds) done.
>>     OOM killer disabled.
>>     Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>>     Disabling non-boot CPUs ...
>>     CPU1: shutdown
>>     psci: CPU1 killed.
>>
>
> Is it OK to assume the suspend failed just after shutting down one CPU
> or it's failing during resume ? It depends on whether you had console
> disabled or not.

I have no-console-suspend enabled.
It's failing during suspend, the next lines should be:

    CPU2: shutdown
    psci: CPU2 killed.
    ...

>> For me, it fails on the following big.LITTLE systems:
>>
>>     R-Car H3 ES2.0 (4xCA57 + 4xCA53)
>>     R-Car M3-W (2xCA57 + 4xCA53)
>>
>
> Interesting, is it PSCI based system suspend ?

Yes it is.

Suspend-to-idle, which doesn't offline CPUs, still works.

>> System supend still works fine on systems with big cores only:
>>
>>     R-Car H3 ES1.0 (4xCA57 (4xCA53 disabled in firmware))
>>     R-Car M3-N (2xCA57)
>>
>> Reverting this commit fixes the issue for me.
>
> I can't find anything that relates to system suspend in these patches
> unless they are messing with something during CPU hot plug-in back
> during resume.

It's only the last patch that introduces the breakage.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
