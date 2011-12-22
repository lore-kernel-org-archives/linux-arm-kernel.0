From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 22 Dec 2011 22:22:17 +0800
Subject: [PATCH] regulator: max8925: fix enabled/disabled judgement mistake
In-Reply-To: <20111222134415.GU4546@opensource.wolfsonmicro.com>
References: <1324543892-32540-1-git-send-email-haojian.zhuang@marvell.com>
 <20111222105357.GC4546@opensource.wolfsonmicro.com>
 <CAN1soZy+hgW2iaQad9gbis7bHLCnfQhMKx-JTJc1j2++eRrJyw@mail.gmail.com>
 <20111222134415.GU4546@opensource.wolfsonmicro.com>
Message-ID: <CAN1soZwBX3x5fiLrLwcC_xTSPMuXw4=u5Rj_CF_R_V3attNzYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 9:44 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Dec 22, 2011 at 09:31:22PM +0800, Haojian Zhuang wrote:
>> On Thu, Dec 22, 2011 at 6:53 PM, Mark Brown
>
>> > Does this mean that the register for enabling and disabling the register
>> > doesn't always work? ?If it does then doesn't that mean that the enable
>> > and disable functions need to be updated as well to either put the
>> > regulator into I2C mode or return an error when it isn't in I2C mode?
>
>> According to the logic in above, we need check both registers to figure out
>> whether LDO is on or off.
>> Return error if it isn't in I2C mode doesn't make sense. If sequence is in one
>> of power-on sequence, the LDO is already ON by default.
>
> I don't understand how your reply follows on from my comment here? ?If
> the enable register doesn't control if the regulator is enabled and
> disabled and it's always on then it seems fairly clear that the enable
> and disable functions ought to know about this.

Mark,

The logic I mentioned is pasted by me. In order to make it clear, let
me copy the logic again.

> If power-sequence is power-on sequence:
>     enable LDO
> else if power-sequence is i2c mode:
>     if enable bit of control register is on:
>            enable LDO
>     else:
>            disable LDO
> else:
>      disable LDO
>
> If the LDO default state is OFF, software needs to set sequence
> to I2C mode first. Then software can enable LDO via control register.

I'm sorry that there's an error in the comments. There's only one enable
register. Power sequence is bit[4:2], and enable bit is bit[0].

While we enable/disable the LDO in software, we'll force LDO into I2C mode
and enable/disable the control bit. So there's no risk in the
enable/disable function.

There's only potential issue of checking whether LDO is enabled. If
sequence matches
the power sequence (not I2C mode), LDO will be enabled even the
control bit is OFF.
So this patch is necessary.

Best Regards
Haojian
