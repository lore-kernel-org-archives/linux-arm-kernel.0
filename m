From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 20 Sep 2016 12:15:33 +0200
Subject: [PATCH 2/3] i2c: bcm2835: Add support for combined write-read
 transfer
In-Reply-To: <fb5e8e93-c6af-0050-1e7d-a69b722feadb@tronnes.org>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
 <1474298777-5858-2-git-send-email-noralf@tronnes.org>
 <c47a0a10-4e0b-9025-8d38-af299d5f55da@martin.sperl.org>
 <fb5e8e93-c6af-0050-1e7d-a69b722feadb@tronnes.org>
Message-ID: <4990930f-6d69-89c6-4b23-deae3d6713ed@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20.09.2016 10:41, Noralf Tr?nnes wrote:
>
> Den 20.09.2016 09:19, skrev Martin Sperl:
>> Hi Noralf!
>>
>> On 19.09.2016 17:26, Noralf Tr?nnes wrote:
>>> Some SMBus protocols use Repeated Start Condition to switch from write
>>> mode to read mode. Devices like MMA8451 won't work without it.
>>>
>>> When downstream implemented support for this in i2c-bcm2708, it broke
>>> support for some devices, so a module parameter was added and combined
>>> transfer was disabled by default.
>>> See https://github.com/raspberrypi/linux/issues/599
>>> It doesn't seem to have been any investigation into what the problem
>>> really was. Later there was added a timeout on the polling loop.
>>>
>>> One of the devices mentioned to partially stop working was DS1307.
>>>
>>> I have run thousands of transfers to a DS1307 (rtc), MMA8451 (accel)
>>> and AT24C32 (eeprom) in parallel without problems.
>>>
>>> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
>>> ---
>>>   drivers/i2c/busses/i2c-bcm2835.c | 107
>>> +++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 98 insertions(+), 9 deletions(-)
>> ...
>>> @@ -209,8 +289,17 @@ static int bcm2835_i2c_xfer(struct i2c_adapter
>>> *adap, struct i2c_msg msgs[],
>>>       int i;
>>>       int ret = 0;
>>>   +    /* Combined write-read to the same address (smbus) */
>>> +    if (num == 2 && (msgs[0].addr == msgs[1].addr) &&
>>> +        !(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
>>> +        (msgs[0].len <= 16)) {
>>> +        ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[0], &msgs[1]);
>>> +
>>> +    return ret ? ret : 2;
>>> +    }
>>> +
>>>       for (i = 0; i < num; i++) {
>>> -        ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i]);
>>> +        ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i], NULL);
>>>           if (ret)
>>>               break;
>>>       }
>> This does not seem to implement the i2c_msg api correctly.
>>
>> As per comments in include/uapi/linux/i2c.h on line 58 only the last
>> message
>> in a group should - by default - send a STOP.
>>
>
> Apparently it's a known problem that the i2c controller doesn't support
> Repeated Start. It will always issue a Stop when it has transferred DLEN
> bytes.
> Refs:
> http://www.circuitwizard.de/raspi-i2c-fix/raspi-i2c-fix.html
> http://raspberrypi.stackexchange.com/questions/31728/has-anyone-successfully-used-i2c-repeated-starts-on-the-pi2-my-scope-says-they
>
>
> UNLESS: a Start Transfer (ST) is issued after Transfer Active (TA) is set
> and before DONE is set (or the last byte is shifted, I don't know excatly).
> Refs:
> https://github.com/raspberrypi/linux/issues/254#issuecomment-15254134
> https://www.raspberrypi.org/forums/viewtopic.php?p=807834&sid=2b612c7209f2175bf1a266359c72ae6c#p807834
>
>
> I found this answer/report by joan that the downstream combined support
> isn't reliable:
> http://raspberrypi.stackexchange.com/questions/31728/has-anyone-successfully-used-i2c-repeated-starts-on-the-pi2-my-scope-says-they
>
>
> My implementation differs from downstream in that I use local_irq_save()
> to protect the polling loop. But that only protects from missing the TA
> (downstream can miss the TA and issue a Stop).
>
> So currently in mainline we have a driver that says it support the standard
> (I2C_FUNC_I2C), but it really only supports one message transfers since it
> can't do ReStart.
>
> What I have done in this patch is to support ReStart for transfers with
> 2 messages: first write, then read. But maybe a better solution is to just
> leave this alone if it is flaky and use bitbanging instead. I don't know.
I have not said that the approach you have taken is wrong or bad.

I was only telling you that the portion inside the bcm2835_i2c_xfer:
+	/* Combined write-read to the same address (smbus) */
+	if (num == 2 && (msgs[0].addr == msgs[1].addr) &&
+	    !(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
+	    (msgs[0].len <= 16)) {
+		ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[0], &msgs[1]);
+
+		return ret ? ret : 2;
+	}
is very specific and maybe could be done in a "generic" manner
supporting more cases.

At least add a dev_warn_once for all num > 1 cases not handled by the
code above.

This gives people an opportunity to detect such a situation if they
find something is not working as expected.

Martin
