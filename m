From: zhouqiao@marvell.com (Qiao Zhou)
Date: Thu, 05 Jul 2012 21:52:14 +0800
Subject: [PATCH 1/4] mfd: support 88pm80x in 80x driver
In-Reply-To: <201207051206.10376.arnd@arndb.de>
References: <1341486425-697-1-git-send-email-zhouqiao@marvell.com>
 <1341486425-697-2-git-send-email-zhouqiao@marvell.com>
 <201207051206.10376.arnd@arndb.de>
Message-ID: <4FF59C0E.2080401@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2012 08:06 PM, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Qiao Zhou wrote:
>> +
>> +static const struct i2c_device_id pm80x_id_table[] = {
>> +	{"88PM800", CHIP_PM800},
>> +	{"88PM805", CHIP_PM805},
>> +};
>> +MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
>
> The point of moving the table to the individual drivers was that the
> right one can get loaded automatically. This requires of course that
> you put only one in there. It really needs to be
>
> static const struct i2c_device_id pm800_id_table[] = {
> 	{"88PM800", CHIP_PM800},
> };
> MODULE_DEVICE_TABLE(i2c, pm800_id_table);
>
> and
>
> static const struct i2c_device_id pm805_id_table[] = {
> 	{"88PM805", CHIP_PM805},
> };
> MODULE_DEVICE_TABLE(i2c, pm805_id_table);
would update. thanks!
>
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 75f6ed6..22dba98 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -3,7 +3,12 @@
>>   #
>>
>>   88pm860x-objs			:= 88pm860x-core.o 88pm860x-i2c.o
>> +88pm80x-objs			:= 88pm80x-i2c.o
>> +88pm800-objs			:= 88pm800-core.o
>> +88pm805-objs			:= 88pm805-core.o
>>   obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
>> +obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
>> +obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
>
> This can be written much shorter if you leave out the "88pm80?-objs:=" lines
> and just build each module from one file as in
>
> obj-$(CONFIG_MFD_88PM800)	+= 88pm800-core.o 88pm80x-i2c.o
>
> It might make sense to drop the "core" and "i2c" postfixes on the names,
> your choice.
would update. thanks!
>
>> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
>> new file mode 100644
>> index 0000000..687f296
>> --- /dev/null
>> +++ b/include/linux/mfd/88pm80x.h
>
> I don't really like repeating myself, but this still contains a lot
> of crap that needs to be moved out of this file, into the places
> where it's used:
>
>> +enum {
>> +	/* Procida */
>> +	PM800_CHIP_A0  = 0x60,
>> +	PM800_CHIP_A1  = 0x61,
>> +	PM800_CHIP_B0  = 0x62,
>> +	PM800_CHIP_C0  = 0x63,
>> +	PM800_CHIP_END = PM800_CHIP_C0,
>> +
>> +	/* Make sure to update this to the last stepping */
>> +	PM8XXX_CHIP_END = PM800_CHIP_END
>> +};
>
> 88pm800-core.c
would move to 88pm800.c
>
>> +enum {
>> +	PM800_ID_INVALID,
>> +	PM800_ID_VIBRATOR,
>> +	PM800_ID_SOUND,
>> +	PM800_ID_MAX,
>> +};
>
> unused?
unused. would remove.
>
>> +enum {
>> +	PM800_ID_BUCK1 = 0,
>> +	PM800_ID_BUCK2,
>> +	PM800_ID_BUCK3,
>> +	PM800_ID_BUCK4,
>> +	PM800_ID_BUCK5,
>> +
>> +	PM800_ID_LDO1,
>> +	PM800_ID_LDO2,
>> +	PM800_ID_LDO3,
>> +	PM800_ID_LDO4,
>> +	PM800_ID_LDO5,
>> +	PM800_ID_LDO6,
>> +	PM800_ID_LDO7,
>> +	PM800_ID_LDO8,
>> +	PM800_ID_LDO9,
>> +	PM800_ID_LDO10,
>> +	PM800_ID_LDO11,
>> +	PM800_ID_LDO12,
>> +	PM800_ID_LDO13,
>> +	PM800_ID_LDO14,
>> +	PM800_ID_LDO15,
>> +	PM800_ID_LDO16,
>> +	PM800_ID_LDO17,
>> +	PM800_ID_LDO18,
>> +	PM800_ID_LDO19,
>> +
>> +	PM800_ID_RG_MAX,
>> +};
>> +#define PM800_MAX_REGULATOR	PM800_ID_RG_MAX	/* 5 Bucks, 19 LDOs */
>> +#define PM800_NUM_BUCK (5)	/*5 Bucks */
>> +#define PM800_NUM_LDO (19)	/*19 Bucks */
>
> unused? should probably go into the regulator driver
it's regulator resource and be used in 88pm800_core.c & regulator.c. 
keep it here currently.
>
>> +/* 88PM805 Registers */
>> +#define PM805_CHIP_ID			(0x00)
>
> 88pm805-core.c
would move it to 805-core.c
>
>> +/* Audio */
>> +
>> +/* 88PM800 registers */
>> +enum {
>> +	PM80X_INVALID_PAGE = 0,
>> +	PM80X_BASE_PAGE,
>> +	PM80X_POWER_PAGE,
>> +	PM80X_GPADC_PAGE,
>> +	PM80X_TEST_PAGE,
>> +};
>
> unused?
unused and would remove
>
>> +/* page 0 basic: slave adder 0x60 */
>> +
>> +/* Interrupt Registers */
>> +#define PM800_CHIP_ID			(0x00)
>> +
>> +#define PM800_STATUS_1			(0x01)
>> +#define PM800_ONKEY_STS1		(1 << 0)
>> +#define PM800_EXTON_STS1		(1 << 1)
>> +#define PM800_CHG_STS1			(1 << 2)
>> +#define PM800_BAT_STS1			(1 << 3)
>> +#define PM800_VBUS_STS1			(1 << 4)
>> +#define PM800_LDO_PGOOD_STS1	(1 << 5)
>> +#define PM800_BUCK_PGOOD_STS1	(1 << 6)
>> +
>> +#define PM800_STATUS_2			(0x02)
>> +#define PM800_RTC_ALARM_STS2	(1 << 0)
>
> These can probably stay here.
>
>> +#define PM800_INT_STATUS1		(0x05)
>> +#define PM800_ONKEY_INT_STS1		(1 << 0)
>> +#define PM800_EXTON_INT_STS1		(1 << 1)
>> +#define PM800_CHG_INT_STS1			(1 << 2)
>> +#define PM800_BAT_INT_STS1			(1 << 3)
>> +#define PM800_RTC_INT_STS1			(1 << 4)
>> +#define PM800_CLASSD_OC_INT_STS1	(1 << 5)
>> ...
>> +/* number of INT_ENA & INT_STATUS regs */
>> +#define PM800_INT_REG_NUM			(4)
>
> all the interrupt handling can go into 88pm800-core.c
would move to pm800-core.c
>
>> +/* RTC Registers */
>> +#define PM800_RTC_CONTROL		(0xD0)
>> +#define PM800_RTC_COUNTER1		(0xD1)
>> +#define PM800_RTC_COUNTER2		(0xD2)
>> +#define PM800_RTC_COUNTER3		(0xD3)
>> +#define PM800_RTC_COUNTER4		(0xD4)
>> +#define PM800_RTC_EXPIRE1_1		(0xD5)
>> +#define PM800_RTC_EXPIRE1_2		(0xD6)
>> +#define PM800_RTC_EXPIRE1_3		(0xD7)
>> +#define PM800_RTC_EXPIRE1_4		(0xD8)
>> +#define PM800_RTC_TRIM1			(0xD9)
>> +#define PM800_RTC_TRIM2			(0xDA)
>> +#define PM800_RTC_TRIM3			(0xDB)
>> +#define PM800_RTC_TRIM4			(0xDC)
>> +#define PM800_RTC_EXPIRE2_1		(0xDD)
>> +#define PM800_RTC_EXPIRE2_2		(0xDE)
>> +#define PM800_RTC_EXPIRE2_3		(0xDF)
>> +#define PM800_RTC_EXPIRE2_4		(0xE0)
>> +#define PM800_RTC_MISC1			(0xE1)
>> +#define PM800_RTC_MISC2			(0xE2)
>> +#define PM800_RTC_MISC3			(0xE3)
>> +#define PM800_RTC_MISC4			(0xE4)
>> +
>> +/* bit definitions of RTC Register 1 (0xD0) */
>> +#define PM800_ALARM1_EN			(1 << 0)
>> +#define PM800_ALARM_WAKEUP		(1 << 4)
>> +#define PM800_ALARM			(1 << 5)
>> +#define PM800_RTC1_USE_XO		(1 << 7)
>> +
>> +#define PM800_POWER_DOWN_LOG1	(0xE5)
>> +#define PM800_POWER_DOWN_LOG2	(0xE6)
>> +
>> +#define PM800_RTC_MISC5			(0xE7)
>
> rtc-88pm80x.c
RTC_CONTROL & MISC reg still be needed by platform, so keep it here. 
move others to rtc-88pm80x.c
>
>> +/* Regulator Control Registers: BUCK1,BUCK5,LDO1 have DVC */
>> +
>> +/* LDO1 with DVC[0..3] */
>> +#define PM800_LDO1_VOUT		(0x08) /* VOUT1 */
>> +#define PM800_LDO1_VOUT_2	(0x09)
>> +#define PM800_LDO1_VOUT_3	(0x0A)
>> +#define PM800_LDO2_VOUT		(0x0B)
>> +#define PM800_LDO3_VOUT		(0x0C)
>> +#define PM800_LDO4_VOUT		(0x0D)
>> +#define PM800_LDO5_VOUT		(0x0E)
>> +#define PM800_LDO6_VOUT		(0x0F)
>> +#define PM800_LDO7_VOUT		(0x10)
>> +#define PM800_LDO8_VOUT		(0x11)
>
> unused
it's used in regulator, and would move to regulator.c.
>
>> +#define get_pmic_version(chip) (*(unsigned char *) chip)
>
> unused
would remove.
>
>> +/* Interrupt Number in 88PM800 */
>> +enum {
>> +	PM800_IRQ_ONKEY,	/*EN1b0 *//*0 */
>> +	PM800_IRQ_EXTON,	/*EN1b1 */
>> +	PM800_IRQ_CHG,		/*EN1b2 */
>> +	PM800_IRQ_BAT,		/*EN1b3 */
>> +	PM800_IRQ_RTC,		/*EN1b4 */
>> +	PM800_IRQ_CLASSD,	/*EN1b5 *//*5 */
>> +	PM800_IRQ_VBAT,		/*EN2b0 */
>> +	PM800_IRQ_VSYS,		/*EN2b1 */
>> +	PM800_IRQ_VCHG,		/*EN2b2 */
>> +	PM800_IRQ_TINT,		/*EN2b3 */
>> +	PM800_IRQ_GPADC0,	/*EN3b0 *//*10 */
>> +	PM800_IRQ_GPADC1,	/*EN3b1 */
>> +	PM800_IRQ_GPADC2,	/*EN3b2 */
>> +	PM800_IRQ_GPADC3,	/*EN3b3 */
>> +	PM800_IRQ_GPADC4,	/*EN3b4 */
>> +	PM800_IRQ_GPIO0,	/*EN4b0 *//*15 */
>> +	PM800_IRQ_GPIO1,	/*EN4b1 */
>> +	PM800_IRQ_GPIO2,	/*EN4b2 */
>> +	PM800_IRQ_GPIO3,	/*EN4b3 */
>> +	PM800_IRQ_GPIO4,	/*EN4b4 *//*19 */
>> +	PM800_MAX_IRQ,
>> +};
>
> 88pm800-core.c
would move it to 800-core.c
>
>> +/* Interrupt Number in 88PM805 */
>> +enum {
>> +	PM805_IRQ_LDO_OFF,	/*0 */
>> +	PM805_IRQ_SRC_DPLL_LOCK,	/*1 */
>> +	PM805_IRQ_CLIP_FAULT,
>> +	PM805_IRQ_MIC_CONFLICT,
>> +	PM805_IRQ_HP2_SHRT,
>> +	PM805_IRQ_HP1_SHRT,	/*5 */
>> +	PM805_IRQ_FINE_PLL_FAULT,
>> +	PM805_IRQ_RAW_PLL_FAULT,
>> +	PM805_IRQ_VOLP_BTN_DET,
>> +	PM805_IRQ_VOLM_BTN_DET,
>> +	PM805_IRQ_SHRT_BTN_DET,	/*10 */
>> +	PM805_IRQ_MIC_DET,	/*11 */
>> +
>> +	PM805_MAX_IRQ,
>> +};
>
> 88pm805-core.c
would move it to 805-core.c
>
> 	Arnd
>
Arnd, thanks for review and sorry for the inconvenience.

-- 

Best Regards
Qiao
