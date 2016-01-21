From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 21 Jan 2016 17:23:23 -0300
Subject: [PATCH v2 00/10] rtc: max77686: Extend driver and add max77802 support
Message-ID: <1453407813-14646-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On a recent disussion [0] with Krzysztof Kozlowski and Laxman Dewangan,
we came to the conclusion that the max77686 and max77802 RTC are almost
the same with only a few differences so there shouldn't be two separate
drivers and is better to extend max77686 driver and delete rtc-max77802.

By making the driver more generic, other RTC IP blocks from Maxim PMICs
could be supported as well like the max77620.

This is a v2 of a series that do this, that address issues pointed out
by Krzysztof Kozlowski. The v1 can be found at [1].

I've tested this patch-set on an Exynos5800 Peach Pi Chromebook that has
a max77802 PMIC and the RTC was working correctly but I don't have a
machine with max77686 so I will really appreaciate if someone can test
that no regressions were introduced.

On an IRC conversation, Alexandre suggested to use the field support in
the regmap API to avoid needing a translation table. I spent some time
to look at it and I'm not so sure if it fits that well in this case.

It's true that we could model each register as if it has a single field
and provide a different reg address but I'm not sure if that would make
things more clear or cause more confusion for future code archaeologists.

In any case, I think this series are a move in the right direction since
removes code duplication and a complete driver and also allows others to
reuse the driver for another RTC chip. We can later simplify and use the
regmap field API or extend the regmap core if that could make things even
simpler but I propose to do it as a follow up.

[0]: http://www.spinics.net/lists/devicetree/msg110348.html
[1]: https://lwn.net/Articles/672568/

Changes in v2:
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #2.
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #3.
- Fix typo error in changelog. Suggested by Krzysztof Kozlowski.
- Add a max77686 prefix to rtc_driver_data. Suggested by Krzysztof Kozlowski.
- Comment about the .delay and .mask fields. Suggested by Krzysztof Kozlowski.
- Change .mask type to u8. Suggested by Krzysztof Kozlowski.
- Make .drv_data field const. Suggested by Krzysztof Kozlowski.
- Don't cast to drop const on .drv_data asign. Suggested by Krzysztof Kozlowski.
- Use platform_get_device_id() macro. Suggested by Krzysztof Kozlowski.
- Rename rtc_reg to max77686_rtc_reg_offset. Suggested by Krzysztof Kozlowski.
- Comment what's mapped by max77686_map. Suggested by Krzysztof Kozlowski.
- Use max77686_map array indexes in init. Suggested by Krzysztof Kozlowski.
- Remove REG_RTC_UPDATE1 since is not used by neither max77686 nor max77802.
- Add a MAX77802 prefix to ALARM_ENABLE_VALUE. Suggested by Krzysztof Kozlowski.
- Rename .rtcae to .alarm_enable_reg and .rtcrm to .separate_i2c_addr.
  Suggested by Krzysztof Kozlowski.
- Don't use func and LINE in error messages. Suggested by Krzysztof Kozlowski.
- Remove REG_RTC_AE2 since is not used by neither max77686 nor max77802.
- Check if REG_RTC_AE1 has a valid address before accessing it.
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #8.
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #9.
- Add Krzysztof Kozlowski's Reviewed-by tag to patch #10.

Javier Martinez Canillas (10):
  rtc: max77686: Fix max77686_rtc_read_alarm() return value
  rtc: max77686: Use ARRAY_SIZE() instead of current array length
  rtc: max77686: Use usleep_range() instead of msleep()
  rtc: max77686: Use a driver data struct instead hard-coded values
  rtc: max77686: Add an indirection level to access RTC registers
  rtc: max77686: Add max77802 support
  rtc: max77686: Use dev_warn() instead of pr_warn()
  rtc: Remove Maxim 77802 driver
  ARM: exynos_defconfig: Remove MAX77802 RTC Kconfig symbol
  ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig symbol

 arch/arm/configs/exynos_defconfig   |   1 -
 arch/arm/configs/multi_v7_defconfig |   1 -
 drivers/rtc/Kconfig                 |  10 -
 drivers/rtc/Makefile                |   1 -
 drivers/rtc/rtc-max77686.c          | 332 +++++++++++++++++++-----
 drivers/rtc/rtc-max77802.c          | 502 ------------------------------------
 6 files changed, 266 insertions(+), 581 deletions(-)
 delete mode 100644 drivers/rtc/rtc-max77802.c

-- 
2.5.0
