From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Jun 2013 09:25:17 -0600
Subject: [PATCH v2 1/3] ARM: tegra: basic support for Trusted Foundations
In-Reply-To: <CAAVeFuLc57pV=To5yaE5x9mrVy1yknH2e90QockCiNbEXRm0WQ@mail.gmail.com>
References: <1371114745-24710-1-git-send-email-acourbot@nvidia.com>
 <1371114745-24710-2-git-send-email-acourbot@nvidia.com>
 <51BA1B41.6030002@wwwdotorg.org>
 <CAAVeFuLc57pV=To5yaE5x9mrVy1yknH2e90QockCiNbEXRm0WQ@mail.gmail.com>
Message-ID: <51BB35DD.4030004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2013 02:27 AM, Alexandre Courbot wrote:
> On Fri, Jun 14, 2013 at 4:19 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/13/2013 03:12 AM, Alexandre Courbot wrote:
>>> Add basic support for booting secondary processors on Tegra devices
>>> using the Trusted Foundations secure monitor.

>>> diff --git a/arch/arm/mach-tegra/firmware.c b/arch/arm/mach-tegra/firmware.c
>>
>>> +void __init tegra_init_firmware(void)
...
>>> +     node = of_find_compatible_node(NULL, NULL, "tl,trusted-foundations");
>>> +     if (node && !IS_ENABLED(CONFIG_TEGRA_TRUSTED_FOUNDATIONS))
>>> +             pr_warn("Trusted Foundations detected but support missing!\n");
>>> +#if IS_ENABLED(CONFIG_TEGRA_TRUSTED_FOUNDATIONS)
>>> +     else if (node)
>>> +             register_firmware_ops(&tegra_trusted_foundations_ops);
>>> +#endif
>>> +}
>>
>> Is it worth continuing on in the node && !IS_ENABLED case here? After
>> all, we can be pretty certain that the write to the CPU reset vector is
>> immediately going to trap...
> 
> That's what was happening until 3.9, but from 3.10 on the trap is
> apparently handled and the boot completes (although with only one
> processor).

Why does that happen; surely the kernel shouldn't be ignoring failures?
How does it recover?
