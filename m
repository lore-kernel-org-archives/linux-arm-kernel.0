From: nm@ti.com (Nishanth Menon)
Date: Mon, 27 Sep 2010 09:25:30 -0500
Subject: [PATCH v4] power: introduce library for device-specific OPPs
In-Reply-To: <20100926005636.GB3396@linux.vnet.ibm.com>
References: <1285332640-16736-1-git-send-email-nm@ti.com>
	<20100924193742.GJ2375@linux.vnet.ibm.com>
	<201009252255.20933.rjw@sisk.pl>
	<20100926005636.GB3396@linux.vnet.ibm.com>
Message-ID: <4CA0A95A.4000408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul E. McKenney had written, on 09/25/2010 07:56 PM, the following:
> On Sat, Sep 25, 2010 at 10:55:20PM +0200, Rafael J. Wysocki wrote:
>> On Friday, September 24, 2010, Paul E. McKenney wrote:
>>> On Fri, Sep 24, 2010 at 07:50:40AM -0500, Nishanth Menon wrote:
>> ...
>>> Looks like a good start!!!  Some questions and suggestions about RCU
>>> usage interspersed below.
>> ...
>>>> + * Locking: RCU reader.
>>>> + */
>>>> +int opp_get_opp_count(struct device *dev)
>>>> +{
>>>> +	struct device_opp *dev_opp;
>>>> +	struct opp *temp_opp;
>>>> +	int count = 0;
>>>> +
>>>> +	dev_opp = find_device_opp(dev);
>>>> +	if (IS_ERR(dev_opp))
>>>> +		return PTR_ERR(dev_opp);
>>>> +
>>>> +	rcu_read_lock();
>>>> +	list_for_each_entry_rcu(temp_opp, &dev_opp->opp_list, node) {
>>>> +		if (temp_opp->available)
>>>> +			count++;
>>>> +	}
>>>> +	rcu_read_unlock();
>>> This one is OK as well.  You are returning a count, so if all of the
>>> counted structures are freed at this point, no problem.  The count was
>>> valid when it was accumulated, and the fact that it might now be obsolete
>>> is (usually) not a problem.
>> However, it looks like it should run rcu_read_lock() before calling
>> find_device_opp(dev), shouldn't it?
> 
> Indeed it does appear that you are right -- good catch!!!
> 
> 							Thanx, Paul
dev_opp as discussed before is safe as it is never freed 
(find_device_opp uses it's own rcu_read_lock, the rcu_read_lock in this 
context is for the opp list. what am I missing?

ack on Paul's comments w.r.t risk on opp structures itself.. will look 
to fix that in v5.

-- 
Regards,
Nishanth Menon
