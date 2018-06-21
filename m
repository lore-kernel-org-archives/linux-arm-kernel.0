From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Jun 2018 13:02:11 +0100
Subject: [PATCH v3] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is
 observed before enabling
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A69F3B4A4@G01JPEXMBKW03>
References: <1521683929-15644-1-git-send-email-shankerd@codeaurora.org>
 <d1161c2d-e16d-14e6-5450-be26d348100d@arm.com>
 <8087e009-4eca-ab92-cbca-23ccfb3fafac@codeaurora.org>
 <86o9jf174o.wl-marc.zyngier@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69F37935@G01JPEXMBKW03>
 <86tvpy7s1g.wl-marc.zyngier@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69F3B4A4@G01JPEXMBKW03>
Message-ID: <e606924b-04e2-82df-0813-21c548259ff2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei,

On 21/06/18 11:57, Zhang, Lei wrote:
> Hi Marc
> 
>> - If EnableLPI is already set to 1, your redistributors are already
>>   potentially corrupting the memory by writing to the pending
>>   tables. Your system is now potentially unstable (single bit
>>   corruption, depending on what the ITS outputs).
>>
>> - If EnableLPI has become RES1, you cannot even turn it off to
>>   reprogram things so that the property and pending tables are under
>>   your control.
> Thanks for you reply.
> 
> One more question.
> If EnableLPIs bit becomes RES1 after EnableLPIs has been written to
> 1, DKUMP/KEXEC case will enter kernel with GICR_CTLR.EnableLPIs=1. In
> this case I do not think DKUMP/KEXEC can work well even use
> irqchip.gicv3_nolpi, if secondary kernel need to use LPI such as the
> disk is nvme. Am I right?

Absolutely. If you can only signal interrupts using LPIs, there isn't
much you can do if you cannot disable LPIs the first place to
reconfigure the interrupts. Your NVME device is pretty useless in that case.

What we could potentially do in the kdump case (and only in that case)
would be to try to reuse the programmed tables and IDbits settings if
EnableLPIs is RES1. This is absolutely awful, but it could get you
going. Maybe.

> I have seen the discussion as below URL, but I do not really
> understand the conclusion. 
> https://patchwork.kernel.org/patch/10281325/

The conclusion is that although RES1 is valid for EnableLPIs once it has
been set to 1 (because that is how it was initially specified), it is a
very bad idea to implement it like this. Allowing LPIs to be disabled is
absolutely essential in a modern computing environment.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
