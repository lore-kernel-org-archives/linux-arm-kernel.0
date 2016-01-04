From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 04 Jan 2016 11:38:29 +0100
Subject: Odroid U3 mutex deadlock.
In-Reply-To: <CANAwSgTrz8=9r9jkKQY_ZN3fsvBs9QpeTxLG1Ac_8SfAULoyHw@mail.gmail.com>
References: <CANAwSgSE4UE5jn4Rp0LfVhDcSP=ynDsbCaUSHmM31_MF849bSw@mail.gmail.com>
 <566E0319.6040100@samsung.com>
 <CANAwSgTrz8=9r9jkKQY_ZN3fsvBs9QpeTxLG1Ac_8SfAULoyHw@mail.gmail.com>
Message-ID: <568A4BA5.3090203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anand,

On 2016-01-02 06:14, Anand Moon wrote:
> Hi Krzysztof
>
> On 14 December 2015 at 05:15, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> On 12.12.2015 13:32, Anand Moon wrote:
>>> Hi Krzysztof,
>>>
>>> I am just observing this deadlock om my Odroid U3.
>> This is not a deadlock yet, just a report from lockdep. Could be a real
>> issue, could be false positive, maybe some locks miss nesting annotations.
>>
>> Typical information for bug report would be useful, like the exact
>> version (it is mentioned in lockdep report but is it really correct?)
>> and reproducibility. And of course git-bisect would be nice to have, see:
>> Documentation/BUG-HUNTING
>>
>> Best regards,
>> Krzysztof
>>
>>
> Thanks for your inputs. I narrowed down to this commit.
> ----------------------------------------------------------------------------------
> commit ec459c0c77faca53cf161830cb264e51bb1abba6
> Author: Marek Szyprowski <m.szyprowski@samsung.com>
> Date:   Wed Feb 4 23:44:15 2015 +0900
>
>      ARM: dts: add dependency between TV and LCD0 power domains for exynos4
>
>      TV Mixer needs both TV and LCD0 domains enabled to be fully operational.
>      This dependency is modelled by making TV power domains a sub-domain of
>      LCD0 power domain.
>
>      Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>      Signed-off-by: Kukjin Kim <kgene@kernel.org>
> -------------------------------------------------------------------------------------
> After reverting this I am not observing below lockdep warning report.
> But after reverting this patch I observer another bug.

The mentioned lockdep warning is a false positive. Such warning is 
reported for
every subdomain present in a system. As you noticed that removing dependency
between power domains also removes this warning, but it will introduce real
problems with power on/off sequences of graphics devices.

I will send a patch for genpd core fixing the deplock warning. Thanks for
reporting the issue and pointing a good place to start digging in the 
source :)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
