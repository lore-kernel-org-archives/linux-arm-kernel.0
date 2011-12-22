From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 22 Dec 2011 21:31:22 +0800
Subject: [PATCH] regulator: max8925: fix enabled/disabled judgement mistake
In-Reply-To: <20111222105357.GC4546@opensource.wolfsonmicro.com>
References: <1324543892-32540-1-git-send-email-haojian.zhuang@marvell.com>
 <20111222105357.GC4546@opensource.wolfsonmicro.com>
Message-ID: <CAN1soZy+hgW2iaQad9gbis7bHLCnfQhMKx-JTJc1j2++eRrJyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 6:53 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Dec 22, 2011 at 04:51:32PM +0800, Haojian Zhuang wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> The judgement should depend on the power up/down sequence select.
>> With flexible power sequence, regulator is always enabled after boot up.
>> With i2c enabled, regulator enable/disable according to output enable bit.
>
> I'm sorry but I'm having a hard time understanding what this changelog
> means, please clarify.
>
There're two registers to control LDO enable or disable. They're
power-sequence register
and control register.

There're eight modes in power-sequence register. 0x7 means I2C mode.
The rest means
sequence in power-on.

The hardware logic of enabling/disabling LDO is in below.

If power-sequence is power-on sequence:
      enable LDO
else if power-sequence is i2c mode:
      if enable bit of control register is on:
             enable LDO
      else:
             disable LDO
else:
       disable LDO

If the LDO default state is OFF, software needs to set sequence
to I2C mode first. Then software can enable LDO via control register.

>> - ? ? return ret & (1 << info->enable_bit);
>> + ? ? ldo_seq = (ret >> LDO_SEQ_SHIFT) & LDO_SEQ_MASK;
>> + ? ? if (ldo_seq != LDO_SEQ_I2C_EN)
>> + ? ? ? ? ? ? return 1 << info->enable_bit;
>> + ? ? else
>> + ? ? ? ? ? ? return ret & (1 << info->enable_bit);
>
> Does this mean that the register for enabling and disabling the register
> doesn't always work? ?If it does then doesn't that mean that the enable
> and disable functions need to be updated as well to either put the
> regulator into I2C mode or return an error when it isn't in I2C mode?
>
According to the logic in above, we need check both registers to figure out
whether LDO is on or off.
Return error if it isn't in I2C mode doesn't make sense. If sequence is in one
of power-on sequence, the LDO is already ON by default.
