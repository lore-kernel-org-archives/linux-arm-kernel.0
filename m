From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Tue, 10 Jul 2012 08:34:03 +0800
Subject: [PATCH 3/3] Watchdog: Omap: get the bootstatus for OMAP2Plus
In-Reply-To: <87ipdwx4zn.fsf@ti.com>
References: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
 <1341808779-25532-4-git-send-email-zumeng.chen@windriver.com>
 <87ipdwx4zn.fsf@ti.com>
Message-ID: <4FFB787B.8010808@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?10? 00:40, Kevin Hilman ??:
> Zumeng Chen<zumeng.chen@windriver.com>  writes:
>
>> The offset of WKUP_MOD is not right for the PRM_RSTST of OMAP3. So here
>> put the right one to match to the actual physical addr 0x48307258, which
>> defined in PRCM Registers section.
>>
>> And there is a MPU_WD_RST bit in PRM_RSTST(0x48307258) holding the signal
>> from omap-wdt reboot, so that we can return WDIOF_CARDRESET if the board
>> wakes up from omap-wdt reboot for WDIOC_GETBOOTSTATUS ioctl.
>>
>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>> ---
>>   arch/arm/mach-omap2/prcm.c |    5 ++++-
>>   1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
>> index 480f40a..4dcc706 100644
>> --- a/arch/arm/mach-omap2/prcm.c
>> +++ b/arch/arm/mach-omap2/prcm.c
>> @@ -49,8 +49,11 @@ void __iomem *prcm_mpu_base;
>>   u32 omap_prcm_get_reset_sources(void)
>>   {
>>   	/* XXX This presumably needs modification for 34XX */
> While you're fixing this for OMAP3, you can remove this comment as well.
No problem, I'll update it in V2. Thanks for your kind reminder :-)

Regards,
Zumeng
>
>> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>> +	if (cpu_is_omap24xx())
>>   		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST)&  0x7f;
>> +	if (cpu_is_omap34xx())
>> +		return omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP2_RM_RSTST)&
>> +		       0x7f;
>>   	if (cpu_is_omap44xx())
>>   		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST)&  0x7f;
> Kevin
