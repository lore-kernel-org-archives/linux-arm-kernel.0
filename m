From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 11 Jan 2010 07:27:01 -0800
Subject: [PATCH 12/35] davinci: clock framework: remove spinlock usage
In-Reply-To: <20100108170601.GH32558@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri\, 8 Jan 2010 17\:06\:01 +0000")
References: <1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<20100108170601.GH32558@n2100.arm.linux.org.uk>
Message-ID: <87d41gr7ay.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Jan 06, 2010 at 10:31:54AM -0800, Kevin Hilman wrote:
>> From: Sekhar Nori <nsekhar@ti.com>
>> 
>> Currently, the spinlock in DaVinci clock framework is being
>> used to:
>> 
>> 1) Protect clock structure variables usecount and rate against
>> concurrent modification.
>> 
>> 2) Protect against simultaneous PSC enables/disables ie.
>> serialize davinci_psc_config().
>> 
>> 3) Serialize clk_set_rate():
>> 	i.	Prevent simultaneous setting of clock rates
>> 	ii.	Ensure clock list remains sane during rate
>> 		propagation (also in clk_set_parent).
>> 
>> Remove the spinlock usage in clock framework by:
>> 
>> 1) Making clock rate and usecount as atomic variables.
>> 
>> 2) Making davinci_psc_config() protect itself instead of
>> relying on serialization by caller.
>> 
>> 3) (i) Allowing the clk->set_rate to serialize itself. There
>> should be no need to serialize all clock rate settings.
>> Currently the only user of rate setting is cpufreq driver on
>> DA850. cpufreq naturally serializes the calls to set CPU rate.
>> Also, there appears no need to lock IRQs during CPU rate
>> transtitions. If required, IRQs can be locked in the actual
>> set_rate function.
>> 
>> 3) (ii) Use the mutex already in place for serialzing clock list
>> manipulation for serializing clock rate propagation as well.
>> 
>> Apart from the general benefit of reducing locking granurlarity,
>> the main motivation behind this change is to enable usage of
>> clock framework for off-chip clock synthesizers. One such
>> synthesizer, CDCE949, is present on DM6467 EVM. Access to the
>> synthesizer happens through I2C bus - accessing which can lead to
>> CPU sleep. Having IRQs locked in clk_set_rate prevents the
>> clk->set_rate function from sleeping.
>
> This patch is extremely bogus.  Just because something is called 'atomic'
> does not make it so.

Russell,

Thanks for the feedback.  I'll drop this patch while we rework this in
a different way.

Thanks,

Kevin

> atomic_set()..atomic_read() are NOT atomic.  They are just plain write
> and read of the underlying atomic value - the former is intended for
> one-time initialization, and the latter is intended for debugging.
>
>> @@ -41,15 +40,16 @@ static void __clk_enable(struct clk *clk)
>>  {
>>  	if (clk->parent)
>>  		__clk_enable(clk->parent);
>> -	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
>> +	if (atomic_read(&clk->usecount) == 0 && (clk->flags & CLK_PSC))
>>  		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc, 1);
>> +	atomic_inc(&clk->usecount);
>
> This is wrong on two levels.  Firstly, consider a simultaneous clk_enable
> and clk_disable.
>
> CPU0						CPU1
> __clk_disable
>
> atomic_dec_and_test(&clk->usecount) -> true
>
> 						__clk_enable
> 						atomic_read(&clk->usecount) returns zero
> 						davinci_psc_config(..., 1);
> 						atomic_inc(&clk->usecount);
> davinci_psc_config(..., 0);
>
> The result is that we now have the situation where the usecount is nonzero
> but the clock is disabled.
>
> Similar bogosities can arise when an already enabled clock tries to be
> simultaneously enabled for a second time and disabled.
>
> Secondly, davinci_psc_config() does a lot of read-modify-writing.  With
> the spinlock gone, what's the protection against simultaneous r-m-w on
> these registers?
>
>> @@ -88,7 +80,7 @@ unsigned long clk_get_rate(struct clk *clk)
>>  	if (clk == NULL || IS_ERR(clk))
>>  		return -EINVAL;
>>  
>> -	return clk->rate;
>> +	return atomic_read(&clk->rate);
>
> atomic here doesn't make clk->rate magically right.  This is precisely
> equivalent to reading clk->rate directly.
>
>>  int clk_set_rate(struct clk *clk, unsigned long rate)
>>  {
>> -	unsigned long flags;
>>  	int ret = -EINVAL;
>>  
>>  	if (clk == NULL || IS_ERR(clk))
>>  		return ret;
>>  
>> -	spin_lock_irqsave(&clockfw_lock, flags);
>>  	if (clk->set_rate)
>>  		ret = clk->set_rate(clk, rate);
>>  	if (ret == 0) {
>>  		if (clk->recalc)
>> -			clk->rate = clk->recalc(clk);
>> +			atomic_set(&clk->rate, clk->recalc(clk));
>
> This atomic_set does nothing to protect you from races.  You might as
> well be writing directly to clk->rate.
