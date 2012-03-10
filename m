From: stigge@antcom.de (Roland Stigge)
Date: Sat, 10 Mar 2012 23:29:18 +0100
Subject: [PATCH v5 3/3] USB: ohci-nxp: Support for LPC32xx
In-Reply-To: <20120310204955.GA14564@pengutronix.de>
References: <1331408166-11607-1-git-send-email-stigge@antcom.de>
 <1331408166-11607-4-git-send-email-stigge@antcom.de>
 <20120310204955.GA14564@pengutronix.de>
Message-ID: <4F5BD5BE.3000808@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/12 21:49, Wolfram Sang wrote:
>> -static void isp1301_configure(void) +static u16 i2c_read16(u8
>> subaddr) +{ +	u16 data; + +	i2c_master_send(isp1301_i2c_client,
>> &subaddr, 1); +	i2c_master_recv(isp1301_i2c_client, (u8 *) &data,
>> 2); + +	return data; +}
> 
> Won't i2c_smbus_read_word_data(isp1301_i2c_client, reg) do?

Yes, thank you for the hint! Replaced i2c_read16() with
i2c_smbus_read_word_data() calls.

> And while we are at it: Could you also try replacing i2c_write()
> with i2c_smbus_write_byte_data(isp1301_i2c_client, reg, val)?

Interestingly now, replacing i2c_write() calls with
i2c_smbus_write_byte_data() did _not_ work (hardware initialization
failure). I guess this is due to the differences between i2c and
smbus, and the hardware only handles the former correctly?

Roland
