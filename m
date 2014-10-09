From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Thu, 09 Oct 2014 15:45:05 -0700
Subject: [PATCH v4 1/2] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <vnkwoatngwmo.fsf@mitchelh-linux.qualcomm.com> (Mitchel
 Humpherys's message of "Tue, 07 Oct 2014 18:47:59 -0700")
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
 <1412126893-15796-2-git-send-email-mitchelh@codeaurora.org>
 <23910474.oJQUXZsx4W@wuerfel>
 <vnkwoatngwmo.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <vnkwppe07thq.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07 2014 at 06:47:59 PM, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
>>> +#define readl_poll_timeout_atomic(addr, val, cond, max_reads, time_between_us) \
>>> +({ \
>>> +       int count; \
>>> +       for (count = (max_reads); count > 0; count--) { \
>>> +               (val) = readl(addr); \
>>> +               if (cond) \
>>> +                       break; \
>>> +               udelay(time_between_us); \
>>> +       } \
>>> +       (cond) ? 0 : -ETIMEDOUT; \
>>> +})
>>
>> udelay has a large variability, I think it would be better to also use
>> ktime_compare here and make the interface the same as the other one.
>> You might want to add a warning if someone tries to pass more than a few
>> microseconds as the timeout.
>
> Sounds good, will update in v5.

Except I'll probably hold off on adding a warning about udelay since
udelay already includes a "warning" (a compile error, actually) when
exceedingly large delays are requested.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
