From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 13 Feb 2014 15:23:47 +0100
Subject: [PATCH] i2c: mv64xxx: Fix locked bus when offload is selected
 but not used on a message
In-Reply-To: <20140213094117.GA3934@katana>
References: <1391770588-1344-1-git-send-email-gregory.clement@free-electrons.com>
 <20140213094117.GA3934@katana>
Message-ID: <52FCD573.8070805@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thanks for you review,


On 13/02/2014 10:41, Wolfram Sang wrote:
>> --- a/drivers/i2c/busses/i2c-mv64xxx.c
>> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
>> @@ -461,8 +461,15 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>>  	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_START:
>>  		if (!mv64xxx_i2c_offload_msg(drv_data))
>>  			break;
>> -		else
>> +		else {
> 
> Here you break the coding style...
> 
>>  			drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
>> +			/*
>> +			 * Switch to the standard path, so we finally need to
>> +			 * prepare the io that have not been done in
>> +			 * mv64xxx_i2c_execute_msg
>> +			 */
>> +			mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
>> +		}
> 
> ... but more importantly, NACK. The code is already hard to follow which
> is the cause for this bug. This snipplet makes the code even harder to
> read, so it needs some simplification IMO. I'll fire up a counterpatch
> in a minute to explain what I mean.

OK, as long as we have a fix for this issue.

I am waiting for your patch.

Thanks,

Gregory



> 
>>  		/* FALLTHRU */
>>  	case MV64XXX_I2C_ACTION_SEND_START:
>>  		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
>> -- 
>> 1.8.1.2
>>


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
