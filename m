From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Oct 2013 13:07:44 -0600
Subject: [PATCH v7 5/5] clk: Implement clk_unregister()
In-Reply-To: <5272A7A0.7020800@samsung.com>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
 <1383076268-8984-6-git-send-email-s.nawrocki@samsung.com>
 <5272A24A.30800@wwwdotorg.org> <5272A7A0.7020800@samsung.com>
Message-ID: <5272AA80.1030804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2013 12:55 PM, Sylwester Nawrocki wrote:
> On 31/10/13 19:32, Stephen Warren wrote:
>> On 10/29/2013 01:51 PM, Sylwester Nawrocki wrote:
>>>> clk_unregister() is currently not implemented and it is required when
>>>> a clock provider module needs to be unloaded.
>>>>
>>>> Normally the clock supplier module is prevented to be unloaded by
>>>> taking reference on the module in clk_get().
>>>>
>>>> For cases when the clock supplier module deinitializes despite the
>>>> consumers of its clocks holding a reference on the module, e.g. when
>>>> the driver is unbound through "unbind" sysfs attribute, there are
>>>> empty clock ops added. These ops are assigned temporarily to struct
>>>> clk and used until all consumers release the clock, to avoid invoking
>>>> callbacks from the module which just got removed.
>>
>> This patch is now in Mike's clk-next and hence next-20131031, and causes
>> both a WARN and an OOPS when booting the Tegra Dalmore board. (See log
>> below)
>>
>> If I do the following to fix some other issues:
>>
>> 1) Apply:
>> http://www.spinics.net/lists/arm-kernel/msg283619.html
>> clk: fix boot panic with non-dev-associated clocks
>>
>> 2) Merge some Tegra-specific bug-fixes:
>> https://lkml.org/lkml/2013/10/29/771
>> Re: pull request for Tegra clock rework and Tegra124 clock support
>>
>> ... then revert this patch a336ed7 "clk: Implement clk_unregister()",
>> everything works again.
> 
> Does it still crash when you apply this patch
> http://www.spinics.net/lists/arm-kernel/msg283550.html ?

Yes, that seems to work, thanks.
