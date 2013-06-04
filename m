From: jiada_wang@mentor.com (Jiada Wang)
Date: Tue, 4 Jun 2013 16:29:04 +0900
Subject: [PATCH v3] clk: implement clk_unregister
In-Reply-To: <857E9EDCA6C0904DB3357321AA9123EB6246498A@NA-MBX-03.mgc.mentorg.com>
References: <1370248626-3760-1-git-send-email-jiada_wang@mentor.com>
 <20130603091116.GB23140@pengutronix.de>
 <857E9EDCA6C0904DB3357321AA9123EB6246498A@NA-MBX-03.mgc.mentorg.com>
Message-ID: <51AD9740.6080208@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe

Wang, Jiada (ESD) wrote:
> -----Original Message-----
> From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> Sent: Monday, June 03, 2013 6:11 PM
> To: Wang, Jiada (ESD)
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3] clk: implement clk_unregister
>
> Hello,
>
> On Mon, Jun 03, 2013 at 05:37:06PM +0900, Jiada Wang wrote:
>> Currently clk_unregister is unimplemented, it is required in case sub
>> modules want actually remove clk device registered by clk_register.
>> This patch adds the implementation of clk_unregister.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   drivers/clk/clk.c | 59
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 57 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c index
>> 934cfd1..0b9e13c 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -342,6 +342,25 @@ out:
>>   	return ret;
>>   }
>>
>> + /**
>> + * clk_debug_unregister - remove a clk node from the debugfs clk tree
>> + * @clk: the clk being removed from the debugfs clk tree
>> + *
>> + * Dynamically removes a clk and all it's children clk nodes from the
>> + * debugfs clk tree if clk->dentry points to debugfs created by
>> + * clk_debug_register in __clk_init.
>> + *
>> + * Caller must hold prepare_lock.
>> + *
>> + */
>> +static void clk_debug_unregister(struct clk *clk) {
>> +	if (!clk || !clk->dentry)
>> +		return;
> !clk can never trigger because clk_unregister doesn't call it in this case and debugfs_remove_recursive checks for dentry being NULL itself.
> So you can drop this check. Maybe you can even call debugfs_remove_recursive even in the case where CONFIG_COMMON_CLK_DEBUG is off?
>
Yes, check of clk->dentry is not necessary, will remove it,
although currently clk_debug_unregister() is only called by 
clk_unregister(), but for future-proof, better to check !clk before call 
debugfs_remove_recursive(), what do you think?
>> +
>> +	debugfs_remove_recursive(clk->dentry);
>> +}
>> +
>>   /**
>>    * clk_debug_reparent - reparent clk node in the debugfs clk tree
>>    * @clk: the clk being reparented
>> @@ -432,6 +451,9 @@ static inline int clk_debug_register(struct clk
>> *clk) { return 0; }  static inline void clk_debug_reparent(struct clk
>> *clk, struct clk *new_parent)  {  }
>> +static inline void clk_debug_unregister(struct clk *clk) { }
>>   #endif
>>
>>   /* caller must hold prepare_lock */
>> @@ -1790,9 +1812,42 @@ EXPORT_SYMBOL_GPL(clk_register);
>>    * clk_unregister - unregister a currently registered clock
>>    * @clk: clock to unregister
>>    *
>> - * Currently unimplemented.
>>    */
>> -void clk_unregister(struct clk *clk) {}
>> +void clk_unregister(struct clk *clk)
>> +{
>> +	int i;
>> +
>> +	if (!clk)
>> +		return;
>> +
>> +	mutex_lock(&prepare_lock);
>> +	if (clk->prepare_count) {
>> +		pr_debug("%s: can't unregister clk %s, it is prepared\n",
>> +				__func__, clk->name);
>> +		goto out;
> Hmm, there is no way for the caller to detect this error. Probably it cannot do anything about it most of the time, but still it would be nice to signal the problem by letting clk_unregister return an int instead of void.
>
> Best regards
> Uwe
>
yes, it makes sense, although all callers of clk_unregister() is not 
checking return value now, but it wont prevent us to change it to "int".

Thanks,
jiada
>> +	}
>> +
>> +	if (!hlist_empty(&clk->children)) {
>> +		pr_debug("%s: clk %s has registered children\n",
>> +				__func__, clk->name);
>> +		goto out;
>> +	}
>> +
>> +	clk_debug_unregister(clk);
>> +
>> +	hlist_del_init(&clk->child_node);
>> +
>> +	kfree(clk->parents);
>> +	i = clk->num_parents;
>> +	while (--i >= 0)
>> +		kfree(clk->parent_names[i]);
>> +	kfree(clk->parent_names);
>> +	kfree(clk->name);
>> +	kfree(clk);
>> +out:
>> +	mutex_unlock(&prepare_lock);
>> +	return;
>> +}
>>   EXPORT_SYMBOL_GPL(clk_unregister);
>>
>>   static void devm_clk_release(struct device *dev, void *res)
>> --
>> 1.8.1.1
>>
>>
>
