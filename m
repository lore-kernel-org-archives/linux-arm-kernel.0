From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Jan 2013 22:04:55 -0700
Subject: [v3 2/2] ARM: tegra: Skip scu_enable(scu_base) if not Cortex
 A9
In-Reply-To: <50FFA620.50008@ti.com>
References: <1358833924-24535-1-git-send-email-hdoyu@nvidia.com>
 <1358833924-24535-2-git-send-email-hdoyu@nvidia.com> <50FE2CA8.20100@ti.com>
 <50FEC503.2080602@wwwdotorg.org>
 <CAOesGMgtaCkiv285TU_vbAokN5M2MrANQ9piDcyXu5YMmbQq3A@mail.gmail.com>
 <50FFA620.50008@ti.com>
Message-ID: <5100C0F7.9080101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2013 01:58 AM, Santosh Shilimkar wrote:
> On Tuesday 22 January 2013 10:34 PM, Olof Johansson wrote:
>> On Tue, Jan 22, 2013 at 8:57 AM, Stephen Warren
>> <swarren@wwwdotorg.org> wrote:
>>> On 01/21/2013 11:07 PM, Santosh Shilimkar wrote:
>>>> On Tuesday 22 January 2013 11:22 AM, Hiroshi Doyu wrote:
>>>>> Skip scu_enable(scu_base) if CPU is not Cortex A9 with SCU.
>>>>>
>>>>> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
>>>>> ---
>>>> Looks fine. I will also update OMAP code with the new
>>>> interface. Thanks.
>>>
>>> OK, so patch 1/2 at least needs to get into a stable arm-soc branch
>>> then. Unless there are violent objections, I'll forward patch 1/2 to
>>> arm-soc and request it be added into a branch so that Tegra and OMAP can
>>> both merge it into their branches as a dependency. I guess patch 2/2
>>> could also be included; I don't think it has any complex dependencies
>>> that'd prevent that, and would help to show how patch 1/2 gets used.
>>>
>>> Hiroshi, is this series the only dependency you need for your Tegra114
>>> series? So, I could merge your Tegra114 series once this series is
>>> applied?
>>
>> For something like this, it might make more sense for us to just apply
>> the patches for OMAP on top, i.e. we'll pull the short branch from
>> you, and then we can just apply patches (with maintainer acks) on top,
>> instead of doing a bunch of single-patch pulls.
>
> In case you decide to apply patches, you can use patch in the end
> of the email for OMAP. Attached the same in case mailer damages it.
> 
> Btw, I noticed the build error with patch 1/1. Since I wasn't using
> the first interface in OMAP code, I just bypassed it for testing.
> I might be missing some dependent patch which added
> read_cpuid_part_number().

Thanks for the OMAP patch. I have pushed a couple of temporary and
non-stable branches to:

git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git

Branch scu-base-rework contains just the SCU base address patches. After
the few things listed below, I'll rename this branch and send a pull
request to arm-soc.

1) Olof asked that Russell Ack or otherwise OK Hiroshi's latest versions
of the following two patches since he commented on previous versions:

ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9
ARM: Add API to detect SCU base address from CP15

2) Lorenzo's last comment on "ARM: tegra: Use DT /cpu node to detect
number of CPU core" was:

Please add missing punctuation, reword the commit log to make it clearer.

... so that patch needs a reworded commit log.

3) This branch needs testing on both Tegra30 and OMAP (I'm away from the
office at the moment and can only test on Tegra20 here),

Branch test-test-hdoyu-t114 contains the most recent version of the
Tegra114 series from Hiroshi, mainly for my local testing etc. Hiroshi
said he will repost an updated version based on the latest Tegra common
clock framework changes. For the record, what I plan to do when applying
this is:

1) Merge the renamed tmp/scu-base-rework into Tegra's for-3.9/soc.

2) Apply the new posting of the Tegra114 patch series.
