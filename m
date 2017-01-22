From: guy.shapiro@mobi-wize.com (Guy Shapiro)
Date: Sun, 22 Jan 2017 12:46:07 +0200
Subject: imx6ul: power-up using the RTC
In-Reply-To: <20170120121210.gm3wcg4yyvrigpn3@earth>
References: <b516070d-6539-98d1-c832-d79ac89e8d43@mobi-wize.com>
 <20170120121210.gm3wcg4yyvrigpn3@earth>
Message-ID: <665a40b1-33f5-74bc-49cc-85b01964ae0d@mobi-wize.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/2017 14:12, Sebastian Reichel wrote:
> Hi, > > On Wed, Jan 18, 2017 at 04:49:11PM +0200, Guy Shapiro wrote: >> I'm
trying to use the low power RTC of the i.MX6UL to start from >>
power-off state. >> >> I started by hopefully running: # echo +30 > >>
/sys/class/rtc/rtc0/wakealarm && shutdown -h now The system was >>
powered down, but it didn't come up after 30 seconds as expected. >> >>
So I dug into the datasheet and the source... >> To activate the power
on alarm, the flags SRTC_ENV, LPTA_EN and LPWUI_EN on >> the SNVS_LP
Control register (LPCR) should be asserted. The wakeup time >> should be
written to the SNVS_LP Time alarm register (LPTA). The code that >> does
this is on drivers/rtc/rtc-snvs.c:snvs_rtc_set_alarm(). >> >> The first
problem I found was with the use of the syscon-poweroff driver. >> The
"Turn off System Power" flag is part of the same register (LPCR). The >>
current code of syscon-poweroff set the register to the "mask" property
from >> the device tree on power off, overriding all the existing flags.
>> After setting the "mask" property on the device tree to 0x6b instead
of >> 0x60 (asserting the mentioned bits), the system do power up on
timer, as >> expected. >> >> However, I didn't like the idea of keeping
those flags on even when no one >> set the alarm. >> As a quick test, I
modified the syscon-poweroff driver to ignore the bits >> that are not
on the mask: >> >> diff --git a/drivers/power/reset/syscon-poweroff.c >>
b/drivers/power/reset/syscon-poweroff.c >> index b683383..a5da02b 100644
>> --- a/drivers/power/reset/syscon-poweroff.c >> +++
b/drivers/power/reset/syscon-poweroff.c >> @@ -33,7 +33,7 @@ static u32
mask; >> static void syscon_poweroff(void) >> { >>         /* Issue the
poweroff */ >> -       regmap_write(map, offset, mask); >> +      
regmap_update_bits(map, offset, mask, mask); >>         mdelay(1000); >>
>> >> After applying this fix, the wake up alarm didn't work. Strangely,
when I >> added some debug prints to investigate the case, it worked
again >> (sometimes... depends on the exact places I add the prints). >>
I suspect that some other driver clears the flags during the power down,
but >> I couldn't find such driver. >> >> Do you have any clue what code
may change this register during the shutdown >> process? Any other
insights are welcomed as well :) > To summarize it looks like this? > >
| regmap_write       | 0x60 | broken                     | > |
regmap_write       | 0x6b | works stable               | > |
regmap_update_bits | 0x60 | works only with dbg prints |
Yes, though I managed to add some useful debug prints while keeping the code
broken.

> > For me it looks like the debug prints may delay the poweroff driver >
long enough, that some other driver (rtc?) writes the 0x0b bits.
The problem happens even if I add a long sleep between the RTC setting
and the
power down command.

> > FWIW we can't switch from regmap_write to regmap_update_bits in the >
syscon driver, since that may break other users. I guess we need to >
introduce a DT property providing the update mask. Unfortunately the >
register value property is already named mask :/
I agree. After fixing the bug, I'll start a discussion about this with
the DT
list.
