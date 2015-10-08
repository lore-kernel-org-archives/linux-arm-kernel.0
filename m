From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 08 Oct 2015 17:02:27 +0100
Subject: [PATCH 2/5] irqchip/gic-v3: Make gic_enable_sre an inline function
In-Reply-To: <20151008155404.GN17192@e104818-lin.cambridge.arm.com>
References: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
 <1443803874-9566-3-git-send-email-marc.zyngier@arm.com>
 <20151008155404.GN17192@e104818-lin.cambridge.arm.com>
Message-ID: <56169393.5050606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/15 16:54, Catalin Marinas wrote:
> On Fri, Oct 02, 2015 at 05:37:51PM +0100, Marc Zyngier wrote:
>> +static inline bool gic_enable_sre(void)
>> +{
>> +	u64 val;
>> +
>> +	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
>> +	if (val & ICC_SRE_EL1_SRE)
>> +		return true;
>> +
>> +	val |= ICC_SRE_EL1_SRE;
>> +	asm volatile("msr_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" (val));
>> +	isb();
>> +	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
>> +
>> +	return !!(val & ICC_SRE_EL1_SRE);
>> +}
> 
> I don't think !! is needed ;). Apparently, from ISO C99: "When any
> scalar value is converted to _Bool, the result is 0 if the value
> compares equal to 0; otherwise, the result is 1."

Are you going to break my fingers? ;-)

>From my very own PoV, !! acts as a reminder that I have realised what
the return type is. Yeah, that's how bad my brain is these days :-)

	M.
-- 
Jazz is not dead. It just smells funny...
