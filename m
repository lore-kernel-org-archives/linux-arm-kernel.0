From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 30 May 2016 10:30:11 +0200
Subject: [RFC PATCH 0/2] scpi: Add SCPI framework to handle vendors
 variants
In-Reply-To: <574802AF.2080909@baylibre.com>
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
 <57472450.4000709@arm.com> <574802AF.2080909@baylibre.com>
Message-ID: <574BFA13.40009@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2016 10:17 AM, Neil Armstrong wrote:
> Hi,
> On 05/26/2016 06:29 PM, Sudeep Holla wrote:
>> Hi Neil,
>>
>> On 26/05/16 10:38, Neil Armstrong wrote:
>>> Since the current SCPI implementation, based on [0]:
>>> - is (at leat) JUNO specific
>>
>> Agreed.
>>
>>> - does not specify a strong "standard"
>>
>> Not exactly, it's extensible. Refer section 3.2.2. Get SCP capability
>> Extended Set Enabled bit.
> 
> Well, I was not thinking about an extension, but this should be upstreamed for sure.
> 
>>
>>> - does not specify a strong MHU interface specification
>>>
>>
>> Not really required, any mailbox must do.
>>
>>> SoC vendors could implement a variant with slight changes in message
>>> indexes,
>>
>> I assume you mean command index here
>>
>>> new messages types,
>>
>> Also fine with extended command set.
>>
>>> different messages data format or
>>
>> you mean the header or payload ? If they don't follow the header, then
>> how can be group them as same protocol ?
>>
>>> different MHU communication scheme.
>>
>> Not a problem as I mentioned above.
>>
>>>
>>> To keep the spirit of the SCPI interface, add a thin "register" layer to get
>>> the ops from the parent node and switch the drivers using the ops to use
>>> the new of_scpi_ops_get() call.
>>>
>>
>> All I can see is that you share the code to register such drivers which
>> is hardly anything. It's hard to say all drivers use same protocol or
>> interface after this change. I may be missing to see something here so
>> it would be easy to appreciate/review this change with one user of this.
> 
> I'm actually working on an "SCPI" implementation from Amlogic for their arm64 plaform,
> and their implementation is slightly different but enough to need a separate driver.
> 
> For instance, the differences are :
> - they do not implement virtual channels
> - they pass the command word by the mailbox interface
> - they use the "sender id" to group the command in a sort of "class"
> - the payload size is shifted by 20 instead of 16
> - the command word is not in the SRAM, so we cannot use a rx command queue, only a single command by channel at a single time
> - the command indexes are slightly shifted
> - in clk_set_value, "rate" is first instead of last entry
> - in sensor_value, they only use a 32bit entry
> - some commands are only accepted on the high priority channel, the others only on the low priority
> - MAX_DVFS_DOMAINS is 3 instead of 8
> - MAX_DVFS_OPPS is 16 instead of 8
> 
> But, It's still a "SCPI" interface by design and usage because :
> - they implement 90% of the same commands, in the same way
> - the usage is exactly the same and architecture is similar
> - they use the same error code scheme
> 
> Finally, it would be stupid to add an exact copy of the scpi-sensors and scpi-clocks !
> The scpi-cpufreq is another story since they only have a single A53 cluster, it's not adapted.
> 
> This is why I wrote a very thin layer, and it can also clean up the arm_scpi and the scpi driver to use a cleaner registry interface.
> It would also be a good point to add a private_data to the ops and pass it to the scpi callbacks, to completely remove the global variables.
> 
> I found an issue with scpi-cpufreq, since the device is created by the scpi-clocks probe, it does not have a proper node and my current of_scpi_ops_get won't work...
> The scpi-cpufreq should have a proper DT node and use the deffered probe to register after the scpi-clocks.
> 
>>
>> My idea of extending this driver if vendor implements extensions based
>> on SCPI specification is something like below:
>>

While looking for other ARMv8 based platform, I found that the RK3368 platform has the same SCPI implementation as Amlogic.

They extended it with DDR, system and thermal commands.

Look at :
https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/drivers/mailbox/scpi_cmd.h
https://github.com/geekboxzone/mmallow_kernel/blob/geekbox/drivers/mailbox/scpi_protocol.c

So the SCPI must have a framework to allow different protocol versions, and must allow command extension.
Grouping Rockchip and Amlogic should be done, thus needing a generic name like vendor_scpi or with a version.

Sudeep, could you somehow find out which version of the protocol AmLogic and Rockchip based their SCPI development ?


Thanks !
Neil

> Neil
> 
