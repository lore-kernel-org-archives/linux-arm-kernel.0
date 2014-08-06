From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Wed, 6 Aug 2014 19:04:51 +0545
Subject: [PATCH v2] ARM: EXYNOS: Refactor the pm code to use DT based
 lookup
In-Reply-To: <53E229A9.4000302@samsung.com>
References: <1406288941-20792-1-git-send-email-vikas.sajjan@samsung.com>
 <53E1356F.40400@gmail.com>
 <CAGm_ybhFj12+tWEhBy=Z62HE6roWMDOXxyoaVsBC2KPMsrYq9A@mail.gmail.com>
 <53E229A9.4000302@samsung.com>
Message-ID: <CAGm_ybj=7uGJJv4yDJaM9bcpuA3ucH7Vtowbn9m-5C=-kOozNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Wed, Aug 6, 2014 at 6:57 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> On 06.08.2014 14:58, Vikas Sajjan wrote:
>> On Wed, Aug 6, 2014 at 1:35 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>> On 25.07.2014 13:49, Vikas Sajjan wrote:
>
> [snip]
>
>>
>>>> +
>>>> +     /* Disable USE_RETENTION of JPEG_MEM_OPTION */
>>>> +     tmp = pmu_raw_readl(EXYNOS5_JPEG_MEM_OPTION);
>>>> +     tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
>>>> +     pmu_raw_writel(tmp, EXYNOS5_JPEG_MEM_OPTION);
>>>
>>> This looks completely like a copy paste from a vendor tree needed to
>>> workaround some issues in early revisions of the SoC. Are you sure this
>>> is still needed in production versions of the silicon used on boards
>>> supported in mainline?
>>
>> This piece of code is NOT copy paste from my side, it is an already
>> existing code. I just moved it into the function
>> exynos5250_pm_prepare().
>
> Sure, I'm aware of this. It might be good to know though if this is
> really necessary, as I don't think we want useless code.
>
>> However I removed this piece of code and
>> made a common function for exynos4 and exynos5250, S2R works on 5250
>> well even without this piece of code.
>
> Thanks for checking this. I wonder if we could get some clarification
> about this from hardware guys. Kukjin, Jingoo, any ideas or people that
> might know what this is about?
>
> For now, I believe it could be handled the same way as Exynos4, in PMU
> register array as I suggested in my previous reply (quoted below).
>
>>
>>>
>>> Even if yes, Exynos4 handles such registers in PMU register array in
>>> pmu.c, so I wonder whether it shouldn't be moved there and allow
>>> handling of all Exynos SoCs uniformly in this file.
>>>
>>>> +
>>>> +     exynos_pm_enter_sleep_mode();
>>>> +}
>>>> +
>>>> +static void exynos4_pm_prepare(void)
>>>> +{
>>>> +     /* Set wake-up mask registers */
>>>> +     exynos_pm_set_wakeup_mask();
>>>> +
>>>> +     s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
>>>> +
>>>> +     exynos_pm_enter_sleep_mode();
>>>> +}
>>>
>>> In fact, exynos4_pm_prepare() is a direct subset of
>>> exynos5250_pm_prepare(). This just confirms that it might be a good idea
>>> to just merge both functions into a single generic one.
>>
>> Right, can be merged into a common function which can be used for
>> exynos4 and exynos5250.
>> But I am afraid we still need specific functions in case of 5420.
>
> Could you provide some details about Exynos5420 specific things?

Please refer my post [1] for 5420 PMU and S2R Support

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/269956.html

>
>>
>>>
>>>> +
>>>>  static void exynos_pm_central_suspend(void)
>>>>  {
>>>>       unsigned long tmp;
>
> [snip]
>
>>>> +
>>>>       /* Platform-specific GIC callback */
>>>>       gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
>>>>
>>>>       /* All wakeup disable */
>>>>       tmp = pmu_raw_readl(S5P_WAKEUP_MASK);
>>>> -     tmp |= ((0xFF << 8) | (0x1F << 1));
>>>> +     tmp |= pm_data->wake_disable_mask;
>>>
>>> Does this vary between SoCs?
>>
>> Yes, It is different in case of 5420.
>
> Could you provide more information about the difference?

In case of 5420, it is wake_disable_mask = (0x7F << 7) | (0x1F << 1)


>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
