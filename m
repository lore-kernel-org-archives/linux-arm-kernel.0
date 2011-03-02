From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 02 Mar 2011 20:58:28 +0100
Subject: [patch v2 1/2] mc13892: reboot on wdi event
In-Reply-To: <20110302194716.GH22310@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
	=?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Wed, 2 Mar 2011 20:47:16 +0100")
References: <20110302184512.512010086@rtp-net.org>
	<20110302185000.369378760@rtp-net.org>
	<20110302194716.GH22310@pengutronix.de>
Message-ID: <871v2pxpjv.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

Hi,
> Hello Arnaud,
>
> On Wed, Mar 02, 2011 at 07:45:13PM +0100, Arnaud Patard wrote:
>> By default, on wdi (watchdog input) event the mc13892 is powering off.
>> This patch allows to change this behaviour throught platform_data.
>> 
>> v2:
>> - move to mc13xxx-core
>> - make it configurable
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> 
>> Index: linux-2.6-submit/drivers/mfd/mc13xxx-core.c
>> ===================================================================
>> --- linux-2.6-submit.orig/drivers/mfd/mc13xxx-core.c	2011-03-01 22:26:40.000000000 +0100
>> +++ linux-2.6-submit/drivers/mfd/mc13xxx-core.c	2011-03-02 12:24:30.000000000 +0100
>> @@ -136,6 +136,9 @@
>>  #define MC13XXX_REVISION_FAB		(0x03 << 11)
>>  #define MC13XXX_REVISION_ICIDCODE	(0x3f << 13)
>>  
>> +#define MC13892_POWERCTL2		15
>> +#define MC13892_POWERCTL2_WDIRESET	(1<<12)
>> +
>>  #define MC13783_ADC1		44
>>  #define MC13783_ADC1_ADEN		(1 << 0)
>>  #define MC13783_ADC1_RAND		(1 << 1)
>> @@ -715,6 +718,7 @@
>>  	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
>>  	enum mc13xxx_id id;
>>  	int ret;
>> +	unsigned int val;
>>  
>>  	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
>>  	if (!mc13xxx)
>> @@ -734,6 +738,15 @@
>>  	if (ret || id == MC13XXX_ID_INVALID)
>>  		goto err_revision;
>>  
>> +	if ((id == MC13XXX_ID_MC13892) && pdata->wdi_reboot) {
>> +		/* allows to reboot on wdi event */
>> +		ret = mc13xxx_reg_read(mc13xxx, MC13892_POWERCTL2, &val);
>> +		if (!ret) {
>> +			val |= MC13892_POWERCTL2_WDIRESET;
>> +			mc13xxx_reg_write(mc13xxx, MC13892_POWERCTL2, val);
>> +		}
>> +	}
>> +
>>  	/* mask all irqs */
>>  	ret = mc13xxx_reg_write(mc13xxx, MC13XXX_IRQMASK0, 0x00ffffff);
>>  	if (ret)
>> Index: linux-2.6-submit/include/linux/mfd/mc13xxx.h
>> ===================================================================
>> --- linux-2.6-submit.orig/include/linux/mfd/mc13xxx.h	2011-03-01 22:30:59.000000000 +0100
>> +++ linux-2.6-submit/include/linux/mfd/mc13xxx.h	2011-03-01 22:31:27.000000000 +0100
>> @@ -149,6 +149,8 @@
> git diff provide some info about the context after the @@ hunk header.
> I consider this really useful.  GNU diff is able to do this, too (option
> -p).
>

hmm... I forgot to configure quilt to do that. sorry.

>>  	int num_regulators;
>>  	struct mc13xxx_regulator_init_data *regulators;
>>  	struct mc13xxx_leds_platform_data *leds;
>> +
>> +	unsigned int wdi_reboot;
> there is already a member .flags.  What about defining another bit for
> that?
>

I thought that using the .flags member for that was kind of misusing it
as for now, it's only used to enable or disable some mc13xxx sub device.

Arnaud
