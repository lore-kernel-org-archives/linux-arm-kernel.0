From: andy.green@linaro.org (Andy Green)
Date: Thu, 05 Jul 2012 11:20:31 +0800
Subject: [PATCH 4 2/4] NET ethernet introduce mac_platform helper
In-Reply-To: <1341457963.2058.13.camel@joe2Laptop>
References: <20120705024259.26317.16000.stgit@build.warmcat.com>
 <20120705024446.26317.49693.stgit@build.warmcat.com>
 <1341457963.2058.13.camel@joe2Laptop>
Message-ID: <4FF507FF.3000604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/12 11:12, the mail apparently from Joe Perches included:

Thanks for the comments.

>> This introduces a small helper in net/ethernet, which registers a network
>> notifier at core_initcall time, and accepts registrations mapping expected
>> asynchronously-probed network device paths (like, "usb1/1-1/1-1.1/1-1.1:1.0")
>> and the MAC that is needed to be assigned to the device when it appears.
>
> The mac prefix is poor.  I think eth_mac is better.

OK.

>> diff --git a/net/ethernet/mac-platform.c b/net/ethernet/mac-platform.c
> []
>> +static int mac_platform_netdev_event(struct notifier_block *this,
>> +						unsigned long event, void *ptr)
>
> alignment to parenthesis please.

OK.  Although different places in the kernel seem to have different 
expectations about that.

>> +int mac_platform_register_device_macs(const struct mac_platform *macs)
>> +{
> []
>> +		next = kmalloc(sizeof(struct mac_platform), GFP_KERNEL);
>> +		if (!next) {
>> +			ret = -ENOMEM;
>> +			goto bail;
>> +		}
>> +
>> +		next->device_path = kmalloc(strlen(macs->device_path) + 1,
>> +								   GFP_KERNEL);
>> +		if (!next->device_path) {
>> +			ret = -ENOMEM;
>> +			goto bail;
>> +		}
>> +
>> +		strcpy(next->device_path, macs->device_path);
>> +		memcpy(next->mac, macs->mac, sizeof macs->mac);
>
> kmemdup and kstrdup()

OK

>> +		list_add(&next->list, &mac_platform_list);
>> +
>> +		macs++;
>> +	}
>> +
>> +bail:
>> +	mutex_unlock(&mac_platform_mutex);
>> +
>> +	return ret;
>> +}
>
> leaking memory on failures.

Right... I'll fix these and wait for more comments.

Thanks again for the review.

-Andy

-- 
Andy Green | TI Landing Team Leader
Linaro.org ? Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  - 
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
