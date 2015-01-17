From: rjui@broadcom.com (Ray Jui)
Date: Sat, 17 Jan 2015 13:26:41 -0800
Subject: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150117211017.GD22880@pengutronix.de>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de> <54B98C18.4080807@broadcom.com>
 <20150117160113.GA22880@pengutronix.de> <54BABEE9.8070801@broadcom.com>
 <20150117201849.GC22880@pengutronix.de> <54BACB66.6040909@broadcom.com>
 <20150117211017.GD22880@pengutronix.de>
Message-ID: <54BAD391.9080909@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/17/2015 1:10 PM, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Sat, Jan 17, 2015 at 12:51:50PM -0800, Ray Jui wrote:
>> On 1/17/2015 12:18 PM, Uwe Kleine-K?nig wrote:
>>> Hello,
>>>
>>> On Sat, Jan 17, 2015 at 11:58:33AM -0800, Ray Jui wrote:
>>>> On 1/17/2015 8:01 AM, Uwe Kleine-K?nig wrote:
>>>>> On Fri, Jan 16, 2015 at 02:09:28PM -0800, Ray Jui wrote:
>>>>>> On 1/15/2015 12:41 AM, Uwe Kleine-K?nig wrote:
>>>>>>> On Wed, Jan 14, 2015 at 02:23:32PM -0800, Ray Jui wrote:
>>>>>>>> +	 */
>>>>>>>> +	val = 1 << M_CMD_START_BUSY_SHIFT;
>>>>>>>> +	if (msg->flags & I2C_M_RD) {
>>>>>>>> +		val |= (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
>>>>>>>> +		       (msg->len << M_CMD_RD_CNT_SHIFT);
>>>>>>>> +	} else {
>>>>>>>> +		val |= (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
>>>>>>>> +	}
>>>>>>>> +	writel(val, iproc_i2c->base + M_CMD_OFFSET);
>>>>>>>> +
>>>>>>>> +	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
>>>>>>>
>>>>>>> When the interrupt fires here after the complete timed out and before
>>>>>>> you disable the irq you still throw the result away.
>>>>>> Yes, but then this comes down to the fact that if it has reached the
>>>>>> point that is determined to be a timeout condition in the driver, one
>>>>>> should really treat it as timeout error. In a normal condition,
>>>>>> time_left should never reach zero.
>>>>> I don't agree here. I'm not sure there is a real technical reason,
>>>>> though. But still if you're in a "success after timeout already over"
>>>>> situation it's IMHO better to interpret it as success, not timeout.
>>>>>
>>>> The thing is, the interrupt should never fire after
>>>> wait_for_completion_timeout returns zero here. If it does, then the
>>>> issue is really that the timeout value set in the driver is probably not
>>>> long enough. I just checked other I2C drivers. I think the way how
>>>> timeout is handled here is consistent with other I2C drivers.
>>> In the presence of Clock stretching there is no (theorethical) upper
>>> limit for the time needed to transfer a given message, is there? So
>>> (theoretically) you can never be sure not to interrupt an ongoing
>>> transfer.
>>>
>> Yes. No theoretical upper limit in the case when clock is stretched by
>> the slave. But how would adding an additional interrupt completion check
>> below help? I assume you want the the check to be like the following?
>>
>> 	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
>>
>> 	/* disable all interrupts */
>> 	writel(0, iproc_i2c->base + IE_OFFSET);
>>
>> 	if (!time_left && !completion_done()) {
>> 		dev_err(iproc_i2c->device, "transaction timed out\n");
>>
>> 		/* flush FIFOs */
>> 		val = (1 << M_FIFO_RX_FLUSH_SHIFT) |
>> 		      (1 << M_FIFO_TX_FLUSH_SHIFT);
>> 		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
>> 		return -ETIMEDOUT;
>> 	}
> No, I want:
> 
> 	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
> 
> 	if (!transfer_was_complete) {
> 		handle_error();
> 		...
> 
> 	}
> 
> 	handle_successful_transfer();
> 
> and time_left == 0 is not a reliable indicator that the transfer failed.
> 
> Best regards
> Uwe
> 
Okay I'll check both time_left and transfer_was_done:
	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);

	/* disable all interrupts */
	writel(0, iproc_i2c->base + IE_OFFSET);

	if (!time_left && !atomic_read(&iproc_i2c->transfer_is_successful)) {
		dev_err(iproc_i2c->device, "transaction timed out\n");

		/* flush FIFOs */
		val = (1 << M_FIFO_RX_FLUSH_SHIFT) |
		      (1 << M_FIFO_TX_FLUSH_SHIFT);
		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
		return -ETIMEDOUT;
	}
