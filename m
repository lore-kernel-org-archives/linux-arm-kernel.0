From: ccross@google.com (Colin Cross)
Date: Sat, 4 Feb 2012 17:36:05 -0800
Subject: [RFC PATCH v4 1/4] cpuidle: Add time keeping and irq enabling
In-Reply-To: <CAJOA=zOhKtt5GohHfYp6=xVTODR2a_RGkDNTwozbusrBSsqE+w@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
 <1328065215-28108-2-git-send-email-rob.lee@linaro.org>
 <CAMbhsRQxgvRN0skteFxeDBqmUArTa3wu2uZPqowDnBTSWuqScg@mail.gmail.com>
 <CAJOA=zOhKtt5GohHfYp6=xVTODR2a_RGkDNTwozbusrBSsqE+w@mail.gmail.com>
Message-ID: <CAMbhsRR2Zsv7d+_iganMhz5WxDiUYd-zOCoVehz4yjzyH2q+wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 4, 2012 at 2:06 PM, Turquette, Mike <mturquette@ti.com> wrote:
> On Sat, Feb 4, 2012 at 11:02 AM, Colin Cross <ccross@google.com> wrote:
>> What's the point of the pre_enter call? ?This seems very similar to
>> the prepare call that was removed in 3.2. ?Drivers can already demote
>
> Hi Colin,
>
> I asked Rob to re-introduce the .prepare callback (not .pre_enter).
>
> The short version of why I requested this is so that I can experiment
> with modifying wake-up latency and theshold values dynamically based
> on PM QoS constraints. ?For an OMAP-specific example, I'd like to see
> our C-states no longer model both MPU and CORE power domains, and
> instead only model the MPU. ?Then when entering idle the PM QoS
> constraints against the CORE power domain's wake-up latency can be
> considered in the .prepare callback which will affect the C-state
> parameters as well as program the CORE low power target state.

prepare makes sense to adjust latencies, as long as it is not used for
state demotion as well.

> .pre_enter isn't really right for the above case so I'm happy for it
> to be dropped, but I'll probably re-introduce something like .prepare
> in the future...
>
> Regards,
> Mike
>
>> the target state in their enter call. ?The only thing you do between
>> pre_enter and enter is trace and account for the time. ?Is there some
>> long call you don't want included in the idle time? ?Some
>> documentation would help, and you need to very clearly define the
>> semantics of when post_enter gets called when pre_enter or enter
>> return errors.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
