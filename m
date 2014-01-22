From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Jan 2014 12:47:58 -0800
Subject: [PATCH v2 5/7] ARM: perf_event: Fully support Krait CPU PMU events
In-Reply-To: <52DEBE6B.7000904@codeaurora.org>
References: <1389808535-23852-1-git-send-email-sboyd@codeaurora.org>
 <1389808535-23852-6-git-send-email-sboyd@codeaurora.org>
 <20140121180711.GN30706@mudshark.cambridge.arm.com>
 <52DEBE6B.7000904@codeaurora.org>
Message-ID: <52E02E7E.4050203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/14 10:37, Stephen Boyd wrote:
> On 01/21/14 10:07, Will Deacon wrote:
>> Do you need isbs to ensure the pmresrn side-effects have happened, or are
>> the registers self-synchronising? Similarly for your other IMP DEF
>> registers.
> There aren't any isbs in the downstream android sources so I assume
> they're self synchronizing. I'll confirm with the CPU designers to make
> sure.
>

CPU folks say no need for isb. They mentioned that the lack of an isb
after the armv7_pmnc_enable_counter() call will leave the action of
enabling the counter "in-flight". The window is probably pretty short on
an SMP kernel because of the spin_unlock right after with the barriers
in it, but the same can't be said for a UP kernel.

Also, the fuzzer didn't find anything else, but I found a bug in the
bitmap logic, updated and reran the fuzzer this morning. Everything
looks good.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
