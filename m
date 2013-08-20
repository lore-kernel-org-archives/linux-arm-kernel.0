From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Aug 2013 17:56:02 +0200
Subject: [PATCH v5 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <20130815121340.GB17155@katana>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <1376039158-1896-2-git-send-email-gregory.clement@free-electrons.com>
 <20130815121340.GB17155@katana>
Message-ID: <52139192.5070507@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/2013 14:13, Wolfram Sang wrote:
> 
>> +	if ((msg->flags & I2C_M_RD) == 0) { +		for (i = 0; i < 4 && i < msg->len; i++) +			data_reg_lo = data_reg_lo | +					(msg->buf[i] << ((i & 0x3) * 8)); + +		for (i = 4; i < 8 && i <
>> msg->len; i++) +			data_reg_hi = data_reg_hi | +					(msg->buf[i] << ((i & 0x3) * 8));
> 
> Same comment as in the last version: What about be32_to_cpu and friends instead of the loops (here and later)?
> 

We can't use be32_to_cpu and friends, because one of the stop condition of this
loop is the length of the msg.

For reading from msg->buf we could consider to mask the irrelevant part.But for
writing to msg->buf it would imply to write outside of the allocated buffer!

Do you agree to not change anything on this patch?

Thanks,


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
