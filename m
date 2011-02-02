From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 02 Feb 2011 17:04:08 +0100
Subject: [patch 3/5] efikamx: add mc13892 support / implement power off
In-Reply-To: <20110202153856.GX9041@pengutronix.de> (Sascha Hauer's message of
	"Wed, 2 Feb 2011 16:38:56 +0100")
References: <20110202112104.380352125@rtp-net.org>
	<20110202112124.144175679@rtp-net.org>
	<20110202153856.GX9041@pengutronix.de>
Message-ID: <87k4hizamf.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> Hi Arnaud,
>
> On Wed, Feb 02, 2011 at 12:21:07PM +0100, Arnaud Patard wrote:
>> This patch declares regulators for the efikamx. Use it also to power off the
>> efikamx.
>> Unfortunately, on the efikamx to2 boards, this doesn't work but they allow to
>> power off by setting GPIO 4 13 to high level instead of powering off through
>> the mc13892.
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> 
>
> [...]
>
>> Index: linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c
>> ===================================================================
>> --- linux-2.6-submit.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2011-02-02 09:57:51.000000000 +0100
>> +++ linux-2.6-submit/arch/arm/mach-mx5/board-mx51_efikamx.c	2011-02-02 09:59:43.000000000 +0100
>> @@ -25,6 +25,9 @@
>>  #include <linux/fsl_devices.h>
>>  #include <linux/spi/flash.h>
>>  #include <linux/spi/spi.h>
>> +#include <linux/mfd/mc13892.h>
>> +#include <linux/regulator/machine.h>
>> +#include <linux/regulator/consumer.h>
>>  
>>  #include <mach/common.h>
>>  #include <mach/hardware.h>
>> @@ -56,6 +59,10 @@
>>  #define EFIKAMX_RESET1_1	IMX_GPIO_NR(3, 2)
>>  #define EFIKAMX_RESET		IMX_GPIO_NR(1, 4)
>>  
>> +#define EFIKAMX_POWEROFF	IMX_GPIO_NR(4, 13)
>> +
>> +#define EFIKAMX_PMIC		IMX_GPIO_NR(1, 6)
>> +
>>  /* the pci ids pin have pull up. they're driven low according to board id */
>>  #define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>>  #define MX51_PAD_PCBID1	IOMUX_PAD(0x51C, 0x134, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>> @@ -79,6 +86,9 @@
>>  	/* reset */
>>  	MX51_PAD_DI1_PIN13__GPIO3_2,
>>  	MX51_PAD_GPIO1_4__GPIO1_4,
>> +
>> +	/* power off */
>> +	MX51_PAD_CSI2_VSYNC__GPIO4_13,
>>  };
>>  
>>  /*   PCBID2  PCBID1 PCBID0  STATE
>> @@ -187,6 +197,44 @@
>>  		gpio_direction_output(EFIKAMX_RESET, 0);
>>  }
>>  
>> +static struct regulator *pwgt1, *pwgt2, *coincell;
>> +
>> +static void mx51_efikamx_power_off(void)
>> +{
>> +	if (!IS_ERR(coincell))
>> +		regulator_disable(coincell);
>> +
>> +	if (!IS_ERR(pwgt1) && !IS_ERR(pwgt2)) {
>> +		regulator_disable(pwgt2);
>> +		regulator_disable(pwgt1);
>> +	}
>> +	gpio_direction_output(EFIKAMX_POWEROFF, 1);
>> +}
>> +
>> +static int __init mx51_efikamx_power_init(void)
>> +{
>> +	pwgt1 = regulator_get(NULL, "pwgt1");
>> +	pwgt2 = regulator_get(NULL, "pwgt2");
>> +	if (!IS_ERR(pwgt1) && !IS_ERR(pwgt2)) {
>> +		regulator_enable(pwgt1);
>> +		regulator_enable(pwgt2);
>> +	}
>> +	gpio_request(EFIKAMX_POWEROFF, "poweroff");
>> +	pm_power_off = mx51_efikamx_power_off;
>> +
>> +	/* enable coincell charger. maybe need a small power driver ? */
>> +	coincell = regulator_get(NULL, "coincell");
>> +	if (!IS_ERR(coincell)) {
>> +		regulator_set_voltage(coincell, 3000000, 3000000);
>> +		regulator_enable(coincell);
>> +	}
>> +
>> +	regulator_has_full_constraints();
>> +
>> +	return 0;
>> +}
>> +late_initcall(mx51_efikamx_power_init);
>
> Please always protect these board specific initcalls with a
> machine_is_*. Just because efikamx support is compiled into the kernel
> doesn't mean it's the only machine this kernel will run on.

ok. fixed here and in sb code. I'm using the same kernel on sb & mx but
the diff are small in this part so I didn't notice. I'm going to test if
things are still ok with the proper checks.

Arnaud
