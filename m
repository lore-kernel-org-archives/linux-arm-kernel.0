From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Thu, 13 Sep 2018 18:35:38 +0200
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
In-Reply-To: <20180913155703.GA22605@roeck-us.net>
References: <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
 <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
 <f47b3050-3abd-caa4-cc71-4b13ef60e2c0@kaod.org>
 <20180913155703.GA22605@roeck-us.net>
Message-ID: <2c481986-7ee0-4887-5c9b-64e2cd9d8c04@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2018 05:57 PM, Guenter Roeck wrote:
> On Thu, Sep 13, 2018 at 05:48:59PM +0200, C?dric Le Goater wrote:
>> On 09/13/2018 03:33 PM, Guenter Roeck wrote:
> [ ... ]
>>>>> ? /*
>>>>> ?? * The state machine needs some refinement. It is only used to track
>>>>> ?? * invalid STOP commands for the moment.
>>>>> @@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>>>>> ? {
>>>>> ????? bus->cmd &= ~0xFFFF;
>>>>> ????? bus->cmd |= value & 0xFFFF;
>>>>> -??? bus->intr_status = 0;> +??? bus->intr_status &= I2CD_INTR_RX_DONE;
>>>>
>>>> it deserves a comment to understand which scenario we are trying to handle.
>>>> ?? 
>>>
>>> Ok. FWIW, I wonder if intr_status should be touched here in the first place,
>>> but I neither have the hardware nor a datasheet, so I don't know if any bits
>>> are auto-cleared.
>>
>> I just pushed a patch on my branch with some more explanation : 
>>
>> 	https://github.com/legoater/qemu/commits/aspeed-3.1
>>
> That seems to suggest that none of the status bits auto-clears, and that
> the above code clearing intr_status should be removed entirely.
> Am I missing something ?

You are right. I just pushed another version of the previous patch with this 
new hunk :

@@ -188,7 +200,6 @@ static void aspeed_i2c_bus_handle_cmd(As
 {
     bus->cmd &= ~0xFFFF;
     bus->cmd |= value & 0xFFFF;
-    bus->intr_status = 0;
 
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?


The QEMU palmetto and witherspoon machines seem to behave fine. Can you give 
it a try ?

Thanks,

C.
