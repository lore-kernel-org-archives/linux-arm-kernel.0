From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Wed, 21 Sep 2016 15:45:32 +0200
Subject: [PATCH 2/3] i2c: bcm2835: Add support for combined write-read
 transfer
In-Reply-To: <DF457EB8-D1B8-4BA4-B79C-AF01AF7CAA3B@martin.sperl.org>
References: <1474298777-5858-1-git-send-email-noralf@tronnes.org>
 <1474298777-5858-2-git-send-email-noralf@tronnes.org>
 <c47a0a10-4e0b-9025-8d38-af299d5f55da@martin.sperl.org>
 <fb5e8e93-c6af-0050-1e7d-a69b722feadb@tronnes.org>
 <4990930f-6d69-89c6-4b23-deae3d6713ed@martin.sperl.org>
 <8053bf5c-7ddc-b4f7-1961-93f161731b16@tronnes.org>
 <DF457EB8-D1B8-4BA4-B79C-AF01AF7CAA3B@martin.sperl.org>
Message-ID: <e141d8bb-e313-a8a5-1d3e-e2b46bd797c9@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 20.09.2016 13:29, skrev kernel at martin.sperl.org:
>> On 20.09.2016, at 12:56, Noralf Tr?nnes <noralf@tronnes.org> wrote:
>>
>>
>> Den 20.09.2016 12:15, skrev Martin Sperl:
>>>
>>> On 20.09.2016 10:41, Noralf Tr?nnes wrote:
>>>> Den 20.09.2016 09:19, skrev Martin Sperl:
>>>>> Hi Noralf!
>>>>>
>>>>> On 19.09.2016 17:26, Noralf Tr?nnes wrote:
>>>>>> Some SMBus protocols use Repeated Start Condition to switch from write
>>>>>> mode to read mode. Devices like MMA8451 won't work without it.
>>>>>>
>>>>>> When downstream implemented support for this in i2c-bcm2708, it broke
>>>>>> support for some devices, so a module parameter was added and combined
>>>>>> transfer was disabled by default.
>>>>>> See https://github.com/raspberrypi/linux/issues/599
>>>>>> It doesn't seem to have been any investigation into what the problem
>>>>>> really was. Later there was added a timeout on the polling loop.
>>>>>>
>>>>>> One of the devices mentioned to partially stop working was DS1307.
>>>>>>
>>>>>> I have run thousands of transfers to a DS1307 (rtc), MMA8451 (accel)
>>>>>> and AT24C32 (eeprom) in parallel without problems.
>>>>>>
>>>>>> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
>>>>>> ---
>>>>>>   drivers/i2c/busses/i2c-bcm2835.c | 107
>>>>>> +++++++++++++++++++++++++++++++++++----
>>>>>>   1 file changed, 98 insertions(+), 9 deletions(-)
>>>>> ...
>>>>>> @@ -209,8 +289,17 @@ static int bcm2835_i2c_xfer(struct i2c_adapter
>>>>>> *adap, struct i2c_msg msgs[],
>>>>>>       int i;
>>>>>>       int ret = 0;
>>>>>>   +    /* Combined write-read to the same address (smbus) */
>>>>>> +    if (num == 2 && (msgs[0].addr == msgs[1].addr) &&
>>>>>> +        !(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
>>>>>> +        (msgs[0].len <= 16)) {
>>>>>> +        ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[0], &msgs[1]);
>>>>>> +
>>>>>> +    return ret ? ret : 2;
>>>>>> +    }
>>>>>> +
>>>>>>       for (i = 0; i < num; i++) {
>>>>>> -        ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i]);
>>>>>> +        ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[i], NULL);
>>>>>>           if (ret)
>>>>>>               break;
>>>>>>       }
>>>>> This does not seem to implement the i2c_msg api correctly.
>>>>>
>>>>> As per comments in include/uapi/linux/i2c.h on line 58 only the last
>>>>> message
>>>>> in a group should - by default - send a STOP.
>>>>>
>>>> Apparently it's a known problem that the i2c controller doesn't support
>>>> Repeated Start. It will always issue a Stop when it has transferred DLEN
>>>> bytes.
>>>> Refs:
>>>> http://www.circuitwizard.de/raspi-i2c-fix/raspi-i2c-fix.html
>>>> http://raspberrypi.stackexchange.com/questions/31728/has-anyone-successfully-used-i2c-repeated-starts-on-the-pi2-my-scope-says-they
>>>>
>>>>
>>>> UNLESS: a Start Transfer (ST) is issued after Transfer Active (TA) is set
>>>> and before DONE is set (or the last byte is shifted, I don't know excatly).
>>>> Refs:
>>>> https://github.com/raspberrypi/linux/issues/254#issuecomment-15254134
>>>> https://www.raspberrypi.org/forums/viewtopic.php?p=807834&sid=2b612c7209f2175bf1a266359c72ae6c#p807834
>>>>
>>>>
>>>> I found this answer/report by joan that the downstream combined support
>>>> isn't reliable:
>>>> http://raspberrypi.stackexchange.com/questions/31728/has-anyone-successfully-used-i2c-repeated-starts-on-the-pi2-my-scope-says-they
>>>>
>>>>
>>>> My implementation differs from downstream in that I use local_irq_save()
>>>> to protect the polling loop. But that only protects from missing the TA
>>>> (downstream can miss the TA and issue a Stop).
>>>>
>>>> So currently in mainline we have a driver that says it support the standard
>>>> (I2C_FUNC_I2C), but it really only supports one message transfers since it
>>>> can't do ReStart.
>>>>
>>>> What I have done in this patch is to support ReStart for transfers with
>>>> 2 messages: first write, then read. But maybe a better solution is to just
>>>> leave this alone if it is flaky and use bitbanging instead. I don't know.
>>> I have not said that the approach you have taken is wrong or bad.
>>>
>> I didn't take it as such, I'm just not sure what's the best approach here,
>> so I added and looked up some more information
>>
>>> I was only telling you that the portion inside the bcm2835_i2c_xfer:
>>> +    /* Combined write-read to the same address (smbus) */
>>> +    if (num == 2 && (msgs[0].addr == msgs[1].addr) &&
>>> +        !(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
>>> +        (msgs[0].len <= 16)) {
>>> +        ret = bcm2835_i2c_xfer_msg(i2c_dev, &msgs[0], &msgs[1]);
>>> +
>>> +        return ret ? ret : 2;
>>> +    }
>>> is very specific and maybe could be done in a "generic" manner
>>> supporting more cases.
>>>
>> It has to be specific when it comes to number of messages. We can only
>> support ReStart after the first message unless we use polling for the
>> whole transfer. And in that case we can't disable interrupts for such
>> a long period and we will end up sometimes loosing Transfer Active,
>> resulting in Stop Condition between the messages.
>> So we can only do transfers with 2 messages if we want Restart.
>>
>> It is possible to support more than 16 bytes for the first message,
>> filling the FIFO after polling TA, but I'm not sure that is common.
>> Mostly it's 1 or 2 bytes to set a register.
>> The write-read restriction isn't absolutely necessary either, but it's the
>> most common case I think. So it was about reusing bcm2835_i2c_xfer_msg().
>> A less restrictive approach would require a dedicated function I think.
>>
>>> At least add a dev_warn_once for all num > 1 cases not handled by the
>>> code above.
>>>
>>> This gives people an opportunity to detect such a situation if they
>>> find something is not working as expected.
>>>
>> I agree.
>>
>> After reading joan's report I wonder if it would be best to add a module
>> parameter like downstream has, so it can be disabled. What do you think?
>>
> I guess let us start simple:
> * get warning in place about always issuing a stop for num > 1
>    - instead we may just want to set max_num_msgs = 1 in quirks.
> * apply your patch for the write (<=16) then read case.
>    - maybe by setting quirks I2C_AQ_COMB_WRITE_THEN_READ
>      plus max_comb_1st_msg_len = 16 and max_num_msgs = 2
>
> If this becomes too restrictive for some specific HW, then someone
> may want to add the missing features.
>
> As for the module parameters: no idea if this is acceptable
> or sensible.
>
> But that?s just my 2c...

It suddenly struct me that I had seen the TA bit set when I debugged the
interrupt function. And it turns out that if I don't prefill the FIFO,
then I can use the TXW interrupt to know when the transfer is active,
no need for polling. It looks promising so far, need to run my testcases
to be sure.

Thanks,
Noralf.
