From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Thu, 15 Oct 2009 12:22:23 +0900
Subject: [PATCH 16/16] i2c-designware: Add I2C_FUNC_SMBUS_* bits
In-Reply-To: <20091014185327.GD11789@tarshish>
References: <4AD3E974.8080200@necel.com> <4AD3EBDD.50105@necel.com>
	<20091014185327.GD11789@tarshish>
Message-ID: <4AD6956F.4050605@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

Baruch Siach wrote:
> On Tue, Oct 13, 2009 at 11:54:21AM +0900, Shinya Kuribayashi wrote:
>> This will ease our testing a bit with i2c-tools.  Note that DW I2C core
>> doesn't support I2C_FUNC_SMBUS_QUICK, as it's not capable of slave-
>> addressing-only I2C transactions.
> 
> Is this supposed to be applied to mainline?

Yes, I hope so.  But I have to admit I blindly added several flags for
my testing, and should have audited them before submitting patches.

>> @@ -529,7 +529,14 @@ done:
>>
>> static u32 i2c_dw_func(struct i2c_adapter *adap)
>> {
>> -	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
>> +	return	I2C_FUNC_I2C |
>> +		I2C_FUNC_10BIT_ADDR |
>> +		I2C_FUNC_SMBUS_BYTE |
>> +		I2C_FUNC_SMBUS_BYTE_DATA |
>> +		I2C_FUNC_SMBUS_WORD_DATA |
>> +		I2C_FUNC_SMBUS_BLOCK_DATA |
>> +		I2C_FUNC_SMBUS_I2C_BLOCK |
>> +		I2C_FUNC_SMBUS_I2C_BLOCK_2;
>> }

As far as I confirmed the requirements for having I2C_FUNC_SMBUS_*
from drivers/i2c/,

>> +		I2C_FUNC_SMBUS_BLOCK_DATA |

>> +		I2C_FUNC_SMBUS_I2C_BLOCK_2;

should be removed.  About the former, we have not implemented proper
I2C_M_RECV_LEN handling yet [ I'm not sure what it's for ... ], and
the latter doesn't seem to be used anywhere in the kernel.
As for the rest, BYTE/WORD/I2C_BLOCK transaction works for me.

So the resulting func() would be,

static u32 i2c_dw_func(struct i2c_adapter *adap)
{
	return	I2C_FUNC_I2C |
		I2C_FUNC_10BIT_ADDR |
		I2C_FUNC_SMBUS_BYTE |
		I2C_FUNC_SMBUS_BYTE_DATA |
		I2C_FUNC_SMBUS_WORD_DATA |
		I2C_FUNC_SMBUS_I2C_BLOCK;
}

and will be fixed up in the next patchset.
-- 
Shinya Kuribayashi
NEC Electronics
