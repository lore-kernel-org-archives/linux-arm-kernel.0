From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Tue, 11 Sep 2018 20:45:23 +0200
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
In-Reply-To: <20180911183734.GA21976@roeck-us.net>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
Message-ID: <e16aadd4-09ee-19bf-f7ea-10dc1e491112@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2018 08:37 PM, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Aug 23, 2018 at 03:57:31PM -0700, Jae Hyun Yoo wrote:
>> In most of cases, interrupt bits are set one by one but there are
>> also a lot of other cases that Aspeed I2C IP sends multiple
>> interrupt bits with combining master and slave events using a
>> single interrupt call. It happens much more in multi-master
>> environment than single-master. For an example, when master is
>> waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
>> SLAVE_MATCH and RX_DONE interrupts could come along with the
>> NORMAL_STOP in case of an another master immediately sends data
>> just after acquiring the bus. In this case, the NORMAL_STOP
>> interrupt should be handled by master_irq and the SLAVE_MATCH and
>> RX_DONE interrupts should be handled by slave_irq. This commit
>> modifies irq hadling logic to handle the master/slave combined
>> events properly.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> This patch causes a boot stall when booting witherspoon-bmc with
> qemu v3.0, and all i2c device probes fail with error -110 (timeout).
> Bisect log is attached for reference.
> 
> With the same kernel configuration (aspeed_g5_defconfig),
> ast2500-evb and romulus-bmc are still able to boot.
> palmetto-bmc with aspeed_g4_defconfig also appears to work.
> 
> Is this a problem with qemu ? Should I drop the qemu test
> for witherspoon-bmc starting with the next kernel release ?

The QEMU model for the Aspeed I2C controller does not support 
slave mode or DMA registers. That might be the issue. 

I will check what this patch does when I have sometime. 

Thanks, 


C.
