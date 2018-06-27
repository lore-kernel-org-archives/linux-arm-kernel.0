From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 27 Jun 2018 11:01:53 -0700
Subject: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
In-Reply-To: <60d0dad1-b735-0650-47b4-40c57b1a5209@linux.intel.com>
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <60d0dad1-b735-0650-47b4-40c57b1a5209@linux.intel.com>
Message-ID: <c1c361de-32a7-83b6-4d48-ad0750c6218b@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jarkko,

Thanks for the review. Please see my answer below.

On 6/27/2018 12:48 AM, Jarkko Nikula wrote:
> Hi
> 
> On 06/26/2018 07:58 PM, Jae Hyun Yoo wrote:
>> BMC firmware should support some multi-master use cases such as 
>> multi-node,
>> IPMB, BMC-ME link and so on but the current ASPEED I2C driver is a bit
>> unstable for the multi-master use case. So this patch improves ASPEED I2C
>> driver to support the multi-master use case stably.
>>
>> Changes:
>> * Added XFER_MODE status register checking logic into
>> ?? aspeed_i2c_master_xfer to improve the current bus busy checking logic.
>> * Changed the order of enum aspeed_i2c_master_state and
>> ?? enum aspeed_i2c_slave_state defines to make their initial values 
>> set to
>> ?? ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
>> ?? In case of multi-master use with previous code, if a slave data comes
>> ?? ahead of the first master xfer, master_state starts from an invalid
>> ?? state. This change fixed the issue.
>> * Adjusted spin_lock scope to make it wrap the whole irq handler using
>> ?? a single lock and unlock pair covers both master and slave handlers.
>> * Added irq_status variable as a member of the struct aspeed_i2c_bus to
>> ?? collect handled interrupt bits throughout the master and the slave irq
>> ?? handlers.
>> * Added control logic to put an order on calling the master and the slave
>> ?? irq handlers based on their current states.
>>
> This does many unrelated looking changes in one patch making it more 
> vulnerable for potential multiple regressions. For instance busy 
> checking goes from single read to loop with 250 ms timeout in this patch 
> while changing also spin lock logic and interrupt handling.
> 
> Now if there is some regression it might be difficult to find what 
> change in this patch is causing it and more over things goes more 
> complicated if some other kind of regressions are found pointing into 
> the same commit.
> 
> I suggest splitting this into multiple smaller patches. For instance 
> having first simple conversions patches that are unlikely to cause a 
> regression like one patch adding '\n' to error print, another moving 
> irq_status variable into struct aspeed_i2c_bus and so on followed by 
> patches that change logic like busy checking, spin lock change and then 
> patch or more for multi-master support.
> 

Yes, that makes sense and I agree with you. I'll split out this patch
into multiple smaller patches as you suggested.

Thanks,

Jae
