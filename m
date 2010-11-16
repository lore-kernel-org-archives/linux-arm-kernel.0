From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 16 Nov 2010 11:15:56 -0500
Subject: [PATCH v5 01/12] misc: add driver for sequencer serial port
In-Reply-To: <20101116071047.GE4074@angua.secretlab.ca>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-2-git-send-email-cyril@ti.com>
	<20101116071047.GE4074@angua.secretlab.ca>
Message-ID: <4CE2AE3C.4040805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2010 02:10 AM, Grant Likely wrote:
> On Mon, Nov 15, 2010 at 02:12:03PM -0500, Cyril Chemparathy wrote:
>> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
>> device.  It has a built-in programmable execution engine that can be programmed
>> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
>>
>> This patch adds a driver for this controller device.  The driver does not
>> expose a user-land interface.  Protocol drivers built on top of this layer are
>> expected to remain in-kernel.
>>
[...]
>> +static inline void ssp_write(struct ti_ssp *ssp, int reg, u32 val)
>> +{
>> +     __raw_writel(val, ssp->regs + reg);
>> +}
> 
> I'm pretty sure it was resolved that __raw_ versions should not be
> used here.

The endian-swap done by writel/readl are incorrect since these devices
are meant to be accessed native-endian at all times.

See [1] below for Russell King's earlier response on this.  In this
case, I don't think memory-device ordering matters, and therefore the
__raw_ variants should be ok.  Should I just insert barriers into the
read/write wrappers here?

[...]

Regards
Cyril.

[1] http://kerneltrap.org/mailarchive/linux-kernel/2010/10/22/4636289
