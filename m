From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Wed, 10 Oct 2018 11:56:37 +0200
Subject: [PATCH] config: arm: exynos: remove PROVE_LOCKING from defconfig
In-Reply-To: <CAJKOXPeSLxeHR-n0yAqbYMi4y9sZhX0Omk=C6-8du7x27X4aWA@mail.gmail.com>
References: <CGME20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a@eucas1p1.samsung.com>
 <20181009153439eucas1p19956dc093074fb7603ad4b39d7cd215a~b_qPT4nMA1415514155eucas1p16@eucas1p1.samsung.com>
 <CAJKOXPeSLxeHR-n0yAqbYMi4y9sZhX0Omk=C6-8du7x27X4aWA@mail.gmail.com>
Message-ID: <20181010095639eucas1p2aa4f4906cac34deb0cfb14383199e3c5~cNsaskok62622626226eucas1p2n@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Is it still valid that the Exynos has locking issues?
Or is it enabled 'just-in-case'?
On arm64 the config misses that setting.
Should be enabled there as well?
You have introduced this entry a year ago, probably during bug 
investigation.

The issue is in lockdep, the setting which enables it in Exynos
is prove_locking. For now, just get rid of the second.
My tests showed lockdep impact and not other minor debug features
enabled.

Regards,
Lukasz

On 10/10/2018 11:18 AM, Krzysztof Kozlowski wrote:
> On Tue, 9 Oct 2018 at 17:34, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
>> bus transactions.
>>
>> On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
>> The overhead can be measures using hackbench test which will speed up
>> by x3 times (11sec -> 3.4sec).
>> When you check transaction on cache or buses, the results are way higher
>> than normal for the same hackbench test:
>> L1d cache invalidations: 26mln vs 4mln
>> L2u cache invalidations: 42mln vs 12mln
>> bus cyc/access: 30cyc/access vs. 20cyc/access
>> context switch is x3 times cheaper
>>
>> Enable this option only when you have some locking issue to investigate.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/configs/exynos_defconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index 27ea6dfc..fbf52f3 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -324,7 +324,6 @@ CONFIG_MAGIC_SYSRQ=y
>>   CONFIG_DEBUG_KERNEL=y
>>   CONFIG_SOFTLOCKUP_DETECTOR=y
>>   # CONFIG_DETECT_HUNG_TASK is not set
>> -CONFIG_PROVE_LOCKING=y
> 
> You just disabled all debugging around locks (so also basic checks).
> You did not describe this in the message... and it also makes me
> wonder what were you testing? Kernel without any lock debugging (so
> this patch) or kernel without lockdep only (not this patch).
> 
> As for the reason behind this change, I am not sure. We had locking
> issues and this change really helped us to spot them. Most of the
> issues are solved so maybe this is not needed anymore but on the other
> hand - this is development/debugging config, not a distro-ready. It
> might serve as a reference for distro configs but clearly it is not
> for production.
> 
> Best regards,
> Krzysztof
> 
>>   CONFIG_DEBUG_ATOMIC_SLEEP=y
>>   CONFIG_DEBUG_USER=y
>>   CONFIG_CRYPTO_RSA=m
>> --
>> 2.7.4
>>
> 
> 
