From: satish.patel@ti.com (Satish Patel)
Date: Thu, 29 May 2014 14:26:55 +0530
Subject: [PATCH v3 1/5] sc_phy:SmartCard(SC) PHY interface to SC controller
In-Reply-To: <20140528184408.GC30031@kroah.com>
References: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
 <1401267437-22489-2-git-send-email-satish.patel@ti.com>
 <20140528184408.GC30031@kroah.com>
Message-ID: <5386F657.9040805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/29/2014 12:14 AM, Greg KH wrote:
> On Wed, May 28, 2014 at 02:27:13PM +0530, Satish Patel wrote:
>> +/**
>> + * struct sc_phy - The basic smart card phy structure
>> + *
>> + * @dev: phy device
>> + * @pdata: pointer to phy's private data structure
>> + * @set_config: called to set phy's configuration
>> + * @get_config: called to get phy's configuration
>> + * @activate_card: perform smart card activation
>> + * @deactivate_card: perform smart card de-activation
>> + * @warm_reset: execute smart card warm reset sequence
>> + * @register_card_activity_cb: register call back to phy device.
>> + * This call back will be called on card insert or remove event
>> + *
>> + * smart card controller uses this interface to communicate with
>> + * smart card via phy.Some smart card phy has multiple slots for
>> + * cards. This inerface also enables controller to communicate with
>> + * one or more smart card connected over phy.
>> + */
>> +struct sc_phy {
>> +	/* phy's device pointer */
>> +	struct device *dev;
>
> So this is the "parent", right?  Why not embed a struct device into this
> structure as well, further streaching out the device tree.
>
Do you mean to use "dev->p" for pdata ?
I have kept it outside, to give easeness/pragmatic focal for new phy 
driver development. Driver can make this pointer null and use above pointer.
>> +
>> +	/* phy's private data */
>> +	void *pdata;
>
> If you do the above, then this pointer is not needed.
>
>
>> +
>> +	/* notify data, passed by interface user as a part of
>> +	 * register_notify API. Data should be passed back when
>> +	 * notification raised to the interface user
>> +	 */
>> +	void *notify_data;
>
> What makes this different from the pdata?
pdata is phy's private data, while notify_data is something phy will 
send to smart card controller on some event, like card 
remove/insert/timeout etc..
>
>
>> +
>> +	int	(*set_config)(struct sc_phy *phy, u8 slot,
>> +			enum sc_phy_config attr, int value);
>> +	int	(*get_config)(struct sc_phy *phy, u8 slot, enum
>> +			sc_phy_config attr);
>> +	int	(*activate_card)(struct sc_phy *phy, u8 slot);
>> +	int	(*deactivate_card)(struct sc_phy *phy, u8 slot);
>> +	int	(*get_syncatr)(struct sc_phy *phy, u8 slot, u8 len, char *atr);
>> +	int	(*warm_reset)(struct sc_phy *phy, u8 slot);
>> +	int	(*register_notify)(struct sc_phy *phy,
>> +			 struct	notifier_block *nb, void *notify_data);
>> +	int	(*unregister_notify)(struct sc_phy *phy,
>> +			struct	notifier_block *nb);
>> +};
>> +
>> +#endif /* __SC_PHY_H__ */
>> --
>> 1.7.9.5
