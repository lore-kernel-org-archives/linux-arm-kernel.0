From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 27 May 2016 17:17:48 +0200
Subject: [RFC PATCH 0/2] scpi: Add SCPI framework to handle vendors
 variants
In-Reply-To: <574802AF.2080909@baylibre.com>
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
 <57472450.4000709@arm.com> <574802AF.2080909@baylibre.com>
Message-ID: <5748651C.9060901@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2016 10:17 AM, Neil Armstrong wrote:
> Hi,
> On 05/26/2016 06:29 PM, Sudeep Holla wrote:
>> Hi Neil,
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
> I'm actually working on a "SCPI" implementation from Amlogic for their arm64 platform,
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

Actually I managed to make the Amlogic SCPI SCPI implementation work using a separate driver and the registry layer just fine.
The cpufreq works, like the scpi-dvfs-clocks and the scpi-hwmon drivers.

You can have a look at my github tree :
https://github.com/superna9999/linux/compare/28165ec7a99be98123aa89540bf2cfc24df19498...superna9999:amlogic/v4.7/scpi+fw-v0

The Amlogic SCPI implementation lies on top of this RFC patchset.
The current patchset need a fix in scpi-hwmon and for scpi-cpufreq but it works like a charm.

Neil
