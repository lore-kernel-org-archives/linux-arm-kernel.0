From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Jan 2013 13:27:51 +0000
Subject: [PATCH 2/2] ARM: hyp: simplify __hyp_stub_install epilog
In-Reply-To: <20130107121807.GA2050@linaro.org>
References: <1357321455-9264-1-git-send-email-marc.zyngier@arm.com>
 <1357321455-9264-3-git-send-email-marc.zyngier@arm.com>
 <20130107121807.GA2050@linaro.org>
Message-ID: <50EACD57.5000001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/13 12:18, Dave Martin wrote:
> On Fri, Jan 04, 2013 at 05:44:15PM +0000, Marc Zyngier wrote:
>> __hyp_stub_install duplicates quite a bit of safe_svcmode_maskall
>> by forcing the CPU back to SVC. This is unnecessary, as
>> safe_svcmode_maskall is called just after.
>>
>> Furthermore, the way we build SPSR_hyp is buggy as we fail to mask
>> the interrupts, leading to interesting behaviours on TC2 + UEFI.
>>
>> The fix is to simply remove this code and rely on safe_svcmode_maskall
>> to do the right thing.
>>
>> Cc: Dave Martin <dave.martin@linaro.org>
>> Reported-by: Harry Liebel <harry.liebel@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Although there is clearly a bug here, it looks like interrupts will
> promptly get masked afterwards due to save_svcmode_maskall.  This would
> only fail if there is an interrupts asserted during this hazard ...?

That's exactly the failure case. It's been observed on TC2 with UEFI,
where the secondaries are woken up with a SGI. When they get out of WFI,
the interrupt is still pending. After reaching this code and doing an
eret, the interrupt fires immediately, with deadly consequences.

> Anyway, There's certainly no sense in trying to drop down to SVC mode
> twice, so I agree that it is better to delegate that to the
> save_svcmode_maskall macro.
> 
> Reviewed-by: Dave Martin <dave.martin@linaro.org>

Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
