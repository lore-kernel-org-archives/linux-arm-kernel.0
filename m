From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 16 Nov 2010 13:35:40 -0700
Subject: [PATCH v5 01/12] misc: add driver for sequencer serial port
In-Reply-To: <4CE2AE3C.4040805@ti.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-2-git-send-email-cyril@ti.com>
	<20101116071047.GE4074@angua.secretlab.ca>
	<4CE2AE3C.4040805@ti.com>
Message-ID: <AANLkTik76EY8Xh01YP2Tep6k1ETPO+3idmNuk3pVikJG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 9:15 AM, Cyril Chemparathy <cyril@ti.com> wrote:
> On 11/16/2010 02:10 AM, Grant Likely wrote:
>> On Mon, Nov 15, 2010 at 02:12:03PM -0500, Cyril Chemparathy wrote:
>>> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
>>> device. ?It has a built-in programmable execution engine that can be programmed
>>> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
>>>
>>> This patch adds a driver for this controller device. ?The driver does not
>>> expose a user-land interface. ?Protocol drivers built on top of this layer are
>>> expected to remain in-kernel.
>>>
> [...]
>>> +static inline void ssp_write(struct ti_ssp *ssp, int reg, u32 val)
>>> +{
>>> + ? ? __raw_writel(val, ssp->regs + reg);
>>> +}
>>
>> I'm pretty sure it was resolved that __raw_ versions should not be
>> used here.
>
> The endian-swap done by writel/readl are incorrect since these devices
> are meant to be accessed native-endian at all times.
>
> See [1] below for Russell King's earlier response on this. ?In this
> case, I don't think memory-device ordering matters, and therefore the
> __raw_ variants should be ok. ?Should I just insert barriers into the
> read/write wrappers here?

I'll let Russel make the decision here; but I must admit I'm puzzled.
Are you running an ARMEB machine?  the le32_to_cpu macros should be
no-ops on little endian.  If you do still use the __raw variants, then
at the very least the reason for doing so must be well documented.

Personally, I'd rather see the appropriate macros added to io.h
ioread32be()/iowrite32be() perhaps?  Or am I missing something subtle
about the hardware behaviour?

g.
