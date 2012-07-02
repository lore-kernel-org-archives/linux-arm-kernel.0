From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 2 Jul 2012 17:30:02 +0530
Subject: [PATCHv3 06/17] i2c: omap: split out [XR]DR and [XR]RDY
In-Reply-To: <20120702115620.GD2730@arwen.pp.htv.fi>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
 <1340964817-8599-7-git-send-email-shubhrajyoti@ti.com>
 <20120702115620.GD2730@arwen.pp.htv.fi>
Message-ID: <CAM=Q2cu+OBAEWvx_jPZXi2Z_9xrzWdh1T8fZ96xiz2Wbo_RbtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2012 at 5:26 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Jun 29, 2012 at 03:43:26PM +0530, Shubhrajyoti D wrote:
>> From: Felipe Balbi <balbi@ti.com>
>>
>> While they do pretty much the same thing, there
>> are a few peculiarities. Specially WRT erratas,
>> it's best to split those out and re-factor the
>> read/write loop to another function which both
>> cases call.
>>
>> This last part will be done on another patch.
>>
>> While at that, also avoid an unncessary register
>> read since dev->fifo_len will always contain the
>> correct amount of data to be transferred.
>
> this statement isn't valid anymore, but I'd like it to be. See below
>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |  126 ++++++++++++++++++++++++++++++----------
>>  1 files changed, 94 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 359ee08..45bd731 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -820,36 +820,64 @@ complete:
>>                       return IRQ_HANDLED;
>>               }
>>
>> -             if (stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR)) {
>> +             if (stat & OMAP_I2C_STAT_RDR) {
>>                       u8 num_bytes = 1;
>>
>> +                     if (dev->fifo_size)
>> +                             num_bytes = (omap_i2c_read_reg(dev,
>> +                                             OMAP_I2C_BUFSTAT_REG) >> 8)
>> +                                             & 0x3F;
>
> I wanted to avoid reading registers if we don't have to. This value will
> be sitting in dev->buf_len.

Yes will fix this and resend.

>
> --
> balbi
