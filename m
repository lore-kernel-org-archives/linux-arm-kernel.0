From: julien.chauveau@neo-technologies.fr (NEO-Technologies / Julien CHAUVEAU)
Date: Wed, 29 Oct 2014 10:50:37 +0100
Subject: [PATCH v2] ARM: dts: rockchip: use internal pull-up resistors
 on I2C busses
In-Reply-To: <CAD=FV=Vs9NT3hMS_Z0dOuwyBdxCsMddqohWFYOGYbM2ePm9PrQ@mail.gmail.com>
References: <1414492597-13566-1-git-send-email-julien.chauveau@neo-technologies.fr>
 <CAD=FV=Vs9NT3hMS_Z0dOuwyBdxCsMddqohWFYOGYbM2ePm9PrQ@mail.gmail.com>
Message-ID: <5450B86D.7060301@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Le 29/10/2014 05:45, Doug Anderson a ?crit :
> Julien,
>
> On Tue, Oct 28, 2014 at 3:36 AM, Julien CHAUVEAU
> <julien.chauveau@neo-technologies.fr> wrote:
>> According to the I2C bus specification, it is required to use pull-up resistors
>> on the clock and data lines. Probing the I2C busses with i2cdetect results in
>> bad results when no devices are connected and no external resistors are used.
>>
>> This patch configures the I2C busses to use the internal pull-up resistors
>> on the RK3066, RK3188 and RK3288 Rockchip processors. It should also be noted
>> that these default pull settings match the original configuration on these SoCs.
>>
>> Below is the results of using i2cdetect on a I2C bus with no devices connected
>> before (1) and after (2) applying this patch.
>>
>> (1) root at localhost:~# i2cdetect -y 3
>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
>> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
>> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
>> 30: -- -- -- -- -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x81, state: 2
>> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 2
>> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 2
>> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
>> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
>> -- rk3x-i2c 2005a000.i2c: timeout, ipd: 0x80, state: 3
>> ...
>>
>> (2) root at localhost:~# i2cdetect -y 3
>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
>>
>> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
>> ---
>> Changes since v1:
>> - fix the rk3066a pull settings (only available is pull_none/pull_default)
>> - remove the warnings in the results of i2cdetect
>>
>>   arch/arm/boot/dts/rk3066a.dtsi | 20 ++++++++++----------
>>   arch/arm/boot/dts/rk3188.dtsi  | 20 ++++++++++----------
>>   arch/arm/boot/dts/rk3288.dtsi  | 24 ++++++++++++------------
>>   3 files changed, 32 insertions(+), 32 deletions(-)
> I won't NAK this change myself, but I have to say I'm not a huge fan.
> On exynos boards the i2c has pulls by default, so there is precedent
> for what you're proposing at least.
>
> ...but I'll also say that most sane boards have external pulls on i2c
> and don't rely on the internal pulls.  If you've got a board where the
> internal pull works well enough (lucky you!) then I think you should
> override the pinctrl for just that board.

At the SoC level, it is IMHO better to enable the internal pull-up 
resistors.

Because the files rk3066a.dtsi, rk3188.dtsi and rk3288.dtsi are not 
board-specific, I think it is wrong to presume that correct pull-up 
resistors are applied to the I2C lines on the board.

Furthermore, as I explained to Addy on the linux-rockchip mailing list, 
it is harmless to enable the internal pull-up resistors on the SoC, but 
of course you need to keep the external pull-up resistors on the board 
(so, do not remove them!).

Moreover, if you absolutely want to disable the internal pull-up 
resistors for one or another board, it is IMHO better to do it at the 
board level, but not at the SoC level.

To each is own...

Julien/
//
/
