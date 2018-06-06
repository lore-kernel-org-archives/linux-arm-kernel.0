From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 6 Jun 2018 11:16:26 +0100
Subject: [PATCH 01/20] coresight: Fix memory leak in coresight_register
In-Reply-To: <b0100f00-c706-3a41-ca55-3c1329c53aa3@gmail.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-2-git-send-email-suzuki.poulose@arm.com>
 <b0100f00-c706-3a41-ca55-3c1329c53aa3@gmail.com>
Message-ID: <16154816-2760-8582-23f1-da607b344db6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2018 07:44 AM, Arvind Yadav wrote:
> Hi Suzuki,
> 
> 
> On Wednesday 06 June 2018 03:13 AM, Suzuki K Poulose wrote:
>> commit 6403587a930c ("coresight: use put_device() instead of kfree()")
>> introduced a memory leak where, if we fail to register the device
>> for coresight_device, we don't free the "coresight_device" object,
>> which was allocated via kzalloc(). Fix this by jumping to the
>> appropriate error path.
> put_device() will decrement the last reference and then
> free the memory by calling dev->release.? Internally
> put_device() -> kobject_put() -> kobject_cleanup() which is
> responsible to call 'dev -> release' and also free other kobject
> resources. If you will see the coresight_device_release. There
> we are releasing all allocated memory. Still if you call kfree() again
> then it'll be redundancy.

You're right. I think it would be good to have a comment explaining this
to prevent this fix popping up in the future :-). I will add it

Thanks
Suzuki
