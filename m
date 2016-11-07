From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 7 Nov 2016 22:40:12 +0530
Subject: [PATCH 1/4] ARM: EXYNOS: Remove smp_init_cpus hook from platsmp.c
In-Reply-To: <CAJKOXPfuN7sdj+C=ccb18TspS_QmvJF-OS1keBsXt8a4w51TUg@mail.gmail.com>
References: <1478230764-13748-1-git-send-email-pankaj.dubey@samsung.com>
 <1478230764-13748-2-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161105154127epcas1p1316e4c558b8442426db131ce7bb87bd2@epcas1p1.samsung.com>
 <20161105154119.GA8183@kozik-lap> <581FF706.3050502@samsung.com>
 <CAJKOXPfuN7sdj+C=ccb18TspS_QmvJF-OS1keBsXt8a4w51TUg@mail.gmail.com>
Message-ID: <CAGcde9FXcRRvEc2FYhN7d3FXuRf0CRgYCa8z=62pLsFuGnM7sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 7 November 2016 at 12:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Nov 7, 2016 at 5:37 AM, pankaj.dubey <pankaj.dubey@samsung.com> wrote:
>> Hi Krzysztof,
>>
>> On Saturday 05 November 2016 09:11 PM, Krzysztof Kozlowski wrote:
>>> On Fri, Nov 04, 2016 at 09:09:21AM +0530, Pankaj Dubey wrote:
>>>> We can safely remove exynos_smp_init_cpus() hook from mach-exynos/platsmp.c,
>>>> as all SMP platforms in mach-exynos can rely on DT for CPU core description
>>>> instead of determining number of cores from the SCU.
>>>>
>>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>> ---
>>>>  arch/arm/mach-exynos/platsmp.c | 31 -------------------------------
>>>>  1 file changed, 31 deletions(-)
>>>>
>>>
>>>
>>> Thanks, applied. Somehow your patchset did not reach linux-samsung-soc's
>>> Parchwork. I don't have a clue why... It is on linux-arm-kernel's
>>> Patchwork.
>>>
>>
>> Thanks for looking into this series.
>>
>> I am also not sure why its not reflecting for you on linux-samsung-soc's
>> Patchwork, but I can see this series in linux-samsung-soc Patchwork at
>> below links:
>
> Hmmm... it is weird. Why I didn't see them before? It seems that I
> even updated their status. Confusing...
>
>
>> Will you please review other two patches (3/4 and 4/4) in this series?
>
> 4/4 is okay but it depends on 3/4 which already has a valid comment -
> what will happen when DT node is not present (which first of all will
> happen because DTS is applied on separate branch... and anyway the
> code must be prepared for different DTSes). Initially I thought there
> will be NULL pointer exception on of_iomap() but after looking at the
> code it might work, I mean fail in a reasonable way.
>

Yes, you are right, even we do not add check for NULL on "np" it won't
cause NULL pointer exception on of_iomap(), and it handles it
gracefully, I have given explanation about this on patch [4/4] as
reply to Alim.

So we can safely avoid check for NULL on "np" without assuming
anything, but at the same time I noticed that in case of_iomap returns
NULL, we can't move ahead and configure secondary startup address in
exynos_smp_prepare_cpus, so I will resubmit [3/4] and [4/4] with
appropriate changes to take care of this case. If you see any other
concern please let me know.

Thanks,
Pankaj Dubey
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
