From: amit.kachhap@linaro.org (Amit Kachhap)
Date: Mon, 22 Aug 2011 22:25:03 +0530
Subject: [RFC PATCH 3/4] ARM: EXYNOS4: Add support AFTR mode cpuidle state
	on EXYNOS4210
In-Reply-To: <20110821171851.GG28546@n2100.arm.linux.org.uk>
References: <1313759340-31319-1-git-send-email-amit.kachhap@linaro.org>
	<1313759400-31347-3-git-send-email-amit.kachhap@linaro.org>
	<20110821171851.GG28546@n2100.arm.linux.org.uk>
Message-ID: <CAK44p21rEqj=JL5PLmFQe0L62UUUJb_ogRpp-vdA3HjwK_+XHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 August 2011 22:48, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Aug 19, 2011 at 06:39:59PM +0530, Amit Daniel Kachhap wrote:
>> +ENTRY(exynos4_enter_lp)
>> + ? ? stmfd ? sp!, { r3 - r12, lr }
>> +
>> + ? ? adr ? ? r0, sleep_save_misc
>> +
>> + ? ? mrc ? ? p15, 0, r2, c15, c0, 0 ?@ read power control register
>> + ? ? str ? ? r2, [r0], #4
>> +
>> + ? ? mrc ? ? p15, 0, r2, c15, c0, 1 ?@ read diagnostic register
>> + ? ? str ? ? r2, [r0], #4
>> +
>> + ? ? ldr ? ? r3, =resume_with_mmu
>> + ? ? bl ? ? ?cpu_suspend
>> +
>> + ? ? mov ? ? r0, sp
>> + ? ? bl ? ? ?exynos4_cpu_lp
>> +
>> + ? ? /* Restore original sp */
>> + ? ? mov ? ? r0, sp
>> + ? ? add ? ? r0, r0, #4
>> + ? ? ldr ? ? sp, [r0]
>> +
>> + ? ? mov ? ? r0, #0
>> + ? ? b ? ? ? early_wakeup
>
> This is based upon old kernel code. ?Clearly hasn't been tested with
> anything later than 3.0.
>
You are right. I will rebase it to the latest tree in the next
version. The main intention of the patch series (mostly patch 4) is to
collect information or issues on samsung platform with the new common
cpuidle framework.
