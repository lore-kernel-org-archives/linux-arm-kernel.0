From: carlo@endlessm.com (Carlo Caione)
Date: Fri, 19 Feb 2016 14:25:20 +0100
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <3072897.5MMsyiojns@wuerfel>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <CAOQ7t2aqZj3STFsdTSQZMTK5U+8Oem8oFroxHKWkt=AeP+Zczg@mail.gmail.com>
 <CAD8Lp47LGUc3-MFpU+3iNjXJL0i4nLTY_49NUxFXeZ2SokDuaQ@mail.gmail.com>
 <3072897.5MMsyiojns@wuerfel>
Message-ID: <CAL9uMOG2gnGnxv9RmmKuHjc72xyyyEu3AW6pTyM2oA=aM171eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 1:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 February 2016 15:27:06 Daniel Drake wrote:
>>
>> Having a cbus bus node with child devices does sound like it would
>> reflect this particular view of the hardware design. How would we then
>> represent the hwrev registers under that?
>>
>
> The question is still how the CBUS is structured internally.
>
> https://github.com/endlessm/linux-meson/blob/master/arch/arm/mach-meson8b/include/mach/register.h
>
> seems to have a good list of registers, but it's a bit hard to
> read, so I reformatted it slightly and put it up at http://pastebin.com/GrzYM7Ti
>
> In many cases, the register name prefix gives a good idea of what things
> are. In particular, it seems that all registers numbers are between 0x1000
> and 0x2fff, which would be offsets 0x4000 through 0xbfff.
>
> The revisison register is in a block called ASSIST, which is mixed with two
> AC3 (audio?) regions, and the only other ASSIST register that is ever
> used is the ASSIST_POR_CONFIG.
>
> The METAL_REVISION is in the middle of some apparently all unrelated registers:
>
> #define PREG_ETH_REG0 0x2050
> #define PREG_ETH_REG1 0x2051
> #define PROD_TEST_REG1 0x2067
> #define PROD_TEST_REG0 0x2068
> #define METAL_REVISION 0x206a
> #define ADC_TOP_MISC 0x206b
> #define DPLL_TOP_MISC 0x206c
> #define ANALOG_TOP_MISC 0x206d
> #define AM_ANALOG_TOP_REG0 0x206e
> #define AM_ANALOG_TOP_REG1 0x206f
> #define PREG_STICKY_REG0 0x207c
> #define PREG_STICKY_REG1 0x207d
>
> This still really sounds like a mixed bag to me, which should better get represented
> as a syscon node, except that there are also some more structured areas in
> CBUS.
>
> Having just the registers between METAL_REVISION and HW_REV in a syscon
> is clearly wrong, as that would include the pinctrl area that already has
> a driver, but would not include some other parts that want the syscon.

Agree

> Maybe the best way is to make it compatible with both syscon and
> simple-bus and put the other nodes underneath. That is still rather
> ugly, but at least it works and can be extended.

This is a good idea actually. I'll prepare a patch.
Thank you for having spent time on this.

Cheers,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
