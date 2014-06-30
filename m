From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Jun 2014 14:21:25 +0200
Subject: [PATCH 2/5] ARM: smp_scu: Add the enable speculative linefills
 operation
In-Reply-To: <20140628170216.0c1965cf@free-electrons.com>
References: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>	<1403822608-31158-3-git-send-email-gregory.clement@free-electrons.com>
 <20140628170216.0c1965cf@free-electrons.com>
Message-ID: <53B15645.9000200@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,>> + */
>> +void scu_spec_linefills_enable(void __iomem *scu_base, bool enable)
>> +{
>> +	u32 scu_ctrl;
>> +
>> +	scu_ctrl = readl_relaxed(scu_base + SCU_CTRL);
>> +	/* already enabled? */
> 
> Comment not needed, since SCU_CTRL_ENABLE already documents what's
> happening. Or a more useful comment would be: "We cannot change the SCU
> configuration while it is enabled".

Right, however I need to figure out if it is really the case. Because in
ARM documentation about the SCU control register, I didn't find any mention
of this restriction.

> 
>> +	if (scu_ctrl & SCU_CTRL_ENABLE)
>> +		return;
> 
> Return an error in this case maybe?

If it failed we just don't benefit of an optimization, it won't prevent the
system working. And also, we can't do anything more if it failed. However
it could be nice to let the calling function know that it failed.

> 
>> +	if (enable)
>> +		scu_ctrl |= SCU_CTRL_SPEC_LINEFILLS;
>> +	else
>> +		scu_ctrl &= ~SCU_CTRL_SPEC_LINEFILLS;
>> +
>> +	writel_relaxed(scu_ctrl, scu_base + SCU_CTRL);
>> +}
> 
> Instead of having a separate function to do this (and the standby
> operation), what about doing that directly in scu_enable() ? Either
> unconditionally if that is fine for all SCU users, or through a flags
> argument?

OK using a flag argument makes sens indeed. About setting it unconditionally,
I would prefer not taking the risk to break the other platforms.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
