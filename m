From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Tue, 31 May 2011 19:02:34 +0530
Subject: [PATCH 2/2] ARM: OMAP4: MMC: no regulator off during probe for
	eMMC
In-Reply-To: <20110531132614.GR11352@atomide.com>
References: <1306765534-20103-1-git-send-email-balajitk@ti.com>
	<1306765534-20103-3-git-send-email-balajitk@ti.com>
	<20110531132614.GR11352@atomide.com>
Message-ID: <BANLkTikhQ9esHA+WefbbfD=RUDWVsG9MbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 6:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Balaji T K <balajitk@ti.com> [110530 07:23]:
>> eMMC does not handle power off when not in sleep state,
>> Skip regulator disable during probe when eMMC is
>> not in known state - state left by bootloader.
>>
>> Resolves eMMC failure on OMAP4
>> mmc0: error -110 whilst initialising MMC card
>>
>> --- a/arch/arm/mach-omap2/hsmmc.h
>> +++ b/arch/arm/mach-omap2/hsmmc.h
>> @@ -18,6 +18,7 @@ struct omap2_hsmmc_info {
>> ? ? ? bool ? ?nonremovable; ? /* Nonremovable e.g. eMMC */
>> ? ? ? bool ? ?power_saving; ? /* Try to sleep or power off when possible */
>> ? ? ? bool ? ?no_off; ? ? ? ? /* power_saving and power is not to go off */
>> + ? ? bool ? ?no_off_init; ? ?/* no power off when not in MMC sleep state */
>> ? ? ? bool ? ?vcc_aux_disable_is_sleep; /* Regulator off remapped to sleep */
>> ? ? ? int ? ? gpio_cd; ? ? ? ?/* or -EINVAL */
>> ? ? ? int ? ? gpio_wp; ? ? ? ?/* or -EINVAL */
>
> Can't you use no_off for this too?

no_off is used for devices which do not want to disable regulator at any time.

newly introduced no_off_init is to skip disable regulator only during probe
After eMMC is put in sleep state (while suspend), regulator for eMMC
(VAUX1) can be disabled.

-- 
Thanks and Regards,
Balaji T K

>
> Tony
>
