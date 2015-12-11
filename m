From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 13:18:10 +0900
Subject: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
In-Reply-To: <20151211041349.GO3612@ubuntu>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu> <566A4231.9050608@osg.samsung.com>
 <20151211033253.GN3612@ubuntu> <566A4A60.8060402@samsung.com>
 <20151211041349.GO3612@ubuntu>
Message-ID: <566A4E82.3040203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.12.2015 13:13, Viresh Kumar wrote:
> On 11-12-15, 13:00, Krzysztof Kozlowski wrote:
>> It wasn't working like this. The cpu0 got the index from booting cpu, so
>> on 5420 cpu0 was A15 and on 5422 it was A7.
>>
>> Maybe I am not aware of some changes recently in the kernel but how do
>> you want to assign the booting CPU proper number (not CPU0)?
> 
> Okay, this is how it works and I don't think you need to change the
> order of CPUs based on machines.
> 
> The boot CPU isn't controlled by the DT file but your bootloader, so
> it will be A15 on 5420 and A7 on 5422.
> 
> Now if you keep the order in DT as: 0-3 A7 and 4-7 A15 irrespective of
> the SoCs, then this is how they will be assigned.
> 
> Linux CPU numbers               Actual CPU assigned to them
>                                 5420            5422
> 
> CPU0                            A15-0 (boot)    A7-0 (boot)
> CPU1                            A7-0            A7-1
> CPU2                            A7-1            A7-2
> CPU3                            A7-2            A7-3
> CPU4                            A7-3            A15-0
> CPU5                            A15-1           A15-1
> CPU6                            A15-2           A15-2
> CPU7                            A15-3           A15-3
> 
> This happens because all non-boot CPUs will be added in the order they
> are present in DT.
> 
> Now, there should be no *real* reason for you to want your CPUs to be
> always contiguous, isn't it?
> 
> In the case of 5420, cpufreq will show related CPUs as:
> Policy0: CPU0,5-7, Policy1: CPU1-4
> 
> and in the case of 5422, cpufreq will show related CPUs as:
> Policy0: CPU0-3, Policy1: CPU4-7
> 
> And I think you should really fix this now..

We had such configuration before (before df09df6f9ac3). I don't see any
benefit in what you described. Where is the "thing" to be fixed? It is
mixed up. The contiguous ordering is easier to read and more natural.

Best regards,
Krzysztof
