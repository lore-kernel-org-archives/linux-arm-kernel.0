From: michael.williamson@criticallink.com (Michael Williamson)
Date: Mon, 27 Dec 2010 06:42:38 -0500
Subject: [PATCH] davinci: Support various speedgrades for MityDSP-L138
	and	MityARM-1808 SoMs
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247FAF658@dbde02.ent.ti.com>
References: <1293039999-20239-1-git-send-email-michael.williamson@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247FAF658@dbde02.ent.ti.com>
Message-ID: <4D187BAE.6090509@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/27/2010 12:54 AM, Nori, Sekhar wrote:
> Hi Michael,
> 
> On Wed, Dec 22, 2010 at 23:16:39, Michael Williamson wrote:
>> For the MityDSP-L138/MityARM-1808 SoMs, the speed grade can be determined
>> from the part number string read from the factory configuration block on
>> the on-board I2C PROM.  Configure the maximum CPU speed based on this
>> information.
>>
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>> ---
>>  arch/arm/mach-davinci/board-mityomapl138.c |   76 +++++++++++++++++++++++++---
>>  1 files changed, 68 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
>> index 0bb5f0c..9d30c01 100644
>> --- a/arch/arm/mach-davinci/board-mityomapl138.c
>> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
>> @@ -44,38 +44,102 @@ struct factory_config {
>>
>>  static struct factory_config factory_config;
>>
>> +struct part_no_info {
>> +     const char      *part_no;  /* part number string of interest */
>> +     int             max_freq; /* khz */
>> +};
>> +
>> +static struct part_no_info part_no_info[] = {
> 
> Can you call this mityomapl138_partno_info[]? That way
> it is clear that this symbol is relevant to the Mity board
> when someone looks up the symbol table.
> 

Yes.  I will correct.

>> +     {
>> +             .part_no        = "L138-C",
>> +             .max_freq       = 300000,
>> +     },
>> +     {
>> +             .part_no        = "L138-D",
>> +             .max_freq       = 375000,
>> +     },
>> +     {
>> +             .part_no        = "L138-F",
>> +             .max_freq       = 456000,
>> +     },
>> +     {
>> +             .part_no        = "1808-C",
>> +             .max_freq       = 300000,
>> +     },
>> +     {
>> +             .part_no        = "1808-D",
>> +             .max_freq       = 375000,
>> +     },
>> +     {
>> +             .part_no        = "1808-F",
>> +             .max_freq       = 456000,
>> +     },
>> +     {
>> +             .part_no        = "1810-D",
>> +             .max_freq       = 375000,
>> +     },
>> +};
>> +
>>  static void read_factory_config(struct memory_accessor *a, void *context)
>>  {
>>       int ret;
>> +#ifdef CONFIG_CPU_FREQ
>> +     int i;
>> +#endif
>>       struct davinci_soc_info *soc_info = &davinci_soc_info;
>>
>>       ret = a->read(a, (char *)&factory_config, 0, sizeof(factory_config));
>>       if (ret != sizeof(struct factory_config)) {
>>               pr_warning("MityOMAPL138: Read Factory Config Failed: %d\n",
>>                               ret);
>> -             return;
>> +             goto bad_config;
>>       }
>>
>>       if (factory_config.magic != FACTORY_CONFIG_MAGIC) {
>>               pr_warning("MityOMAPL138: Factory Config Magic Wrong (%X)\n",
>>                               factory_config.magic);
>> -             return;
>> +             goto bad_config;
>>       }
>>
>>       if (factory_config.version != FACTORY_CONFIG_VERSION) {
>>               pr_warning("MityOMAPL138: Factory Config Version Wrong (%X)\n",
>>                               factory_config.version);
>> -             return;
>> +             goto bad_config;
>>       }
>>
>>       pr_info("MityOMAPL138: Found MAC = %pM\n", factory_config.mac);
>> -     pr_info("MityOMAPL138: Part Number = %s\n", factory_config.partnum);
>>       if (is_valid_ether_addr(factory_config.mac))
>>               memcpy(soc_info->emac_pdata->mac_addr,
>>                       factory_config.mac, ETH_ALEN);
>>       else
>>               pr_warning("MityOMAPL138: Invalid MAC found "
>>                               "in factory config block\n");
>> +
>> +     pr_info("MityOMAPL138: Part Number = %s\n", factory_config.partnum);
>> +
>> +#ifdef CONFIG_CPU_FREQ
>> +     for (i = 0; i < ARRAY_SIZE(part_no_info); i++) {
>> +             /*
>> +              * the part number has additional characters beyond what is
>> +              * stored in the table.  This information is not needed for
>> +              * determining the speed grade, and would require several
>> +              * more table entries.  Only check the first N characters
>> +              * for a match.
>> +              */
>> +             if (!strncmp(factory_config.partnum, part_no_info[i].part_no,
>> +                     strlen(part_no_info[i].part_no))) {
>> +                     da850_max_speed = part_no_info[i].max_freq;
>> +                     break;
>> +             }
>> +     }
>> +#endif
>> +
>> +bad_config:
>> +#ifdef CONFIG_CPU_FREQ
>> +     ret = da850_register_cpufreq("pll0_sysclk3");
>> +     if (ret)
>> +             pr_warning("cpufreq registration failed: %d\n", ret);
>> +#endif
> 
> It is generally discouraged to have #ifdefs inside function
> blocks as it creates difficult to read and maintain code.
> 
> Instead, can you please create a function of the sort
> mityompal138_init_cpufreq(char *partnum) to consolidate
> the code you have put under #ifdefs here? partnum can
> be NULL in case of bad config data. This function will
> be defined to return success in case CONFIG_CPU_FREQ is
> not defined.
> 

Yes.  I understand.  I'll give it another spin.  Thanks.

> Thanks,
> Sekhar
> 
>>  }
>>
>>  static struct at24_platform_data mityomapl138_fd_chip = {
>> @@ -383,10 +447,6 @@ static void __init mityomapl138_init(void)
>>       if (ret)
>>               pr_warning("rtc setup failed: %d\n", ret);
>>
>> -     ret = da850_register_cpufreq("pll0_sysclk3");
>> -     if (ret)
>> -             pr_warning("cpufreq registration failed: %d\n", ret);
>> -
>>       ret = da8xx_register_cpuidle();
>>       if (ret)
>>               pr_warning("cpuidle registration failed: %d\n", ret);
>> --
>> 1.7.0.4
>>
>> _______________________________________________
>> Davinci-linux-open-source mailing list
>> Davinci-linux-open-source at linux.davincidsp.com
>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>>
> 
