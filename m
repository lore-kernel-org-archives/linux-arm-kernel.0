From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 15 Jan 2014 11:18:25 +0100
Subject: [PATCH v2 06/12] at91: smc: Adds helper functions to validate
 and clip the smc timings.
In-Reply-To: <CACh+v5Pi-ZF5orDWheX9C3MpUcU56oDio_O8s6sR3Snb9QmTZQ@mail.gmail.com>
References: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>	<1389270709-32662-7-git-send-email-jjhiblot@traphandler.com>	<52D65880.10301@atmel.com>
 <CACh+v5Pi-ZF5orDWheX9C3MpUcU56oDio_O8s6sR3Snb9QmTZQ@mail.gmail.com>
Message-ID: <52D66071.4000900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2014 10:54, Jean-Jacques Hiblot :
> 2014/1/15 Nicolas Ferre <nicolas.ferre@atmel.com>:
>> On 09/01/2014 13:31, Jean-Jacques Hiblot :
>>> This patchs implememnts 2 functions to help with the configuration of a
>>> chip-select's timing:
>>> * sam9_smc_check_cs_configuration : checks that the values would fit in the
>>>   registers.
>>> * sam9_smc_clip_cs_configuration : clip the values to their maximum.
>>>
>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>> ---
>>>  arch/arm/mach-at91/include/mach/at91sam9_smc.h |  2 +
>>>  arch/arm/mach-at91/sam9_smc.c                  | 77 ++++++++++++++++++++++++++
>>>  2 files changed, 79 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-at91/include/mach/at91sam9_smc.h b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
>>> index c3e29311..615ac56 100644
>>> --- a/arch/arm/mach-at91/include/mach/at91sam9_smc.h
>>> +++ b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
>>> @@ -47,6 +47,8 @@ extern void sam9_smc_read_mode(int id, int cs, struct sam9_smc_config *config);
>>>  extern void sam9_smc_write_mode(int id, int cs, struct sam9_smc_config *config);
>>>  extern void sam9_smc_cs_read(void __iomem *, struct sam9_smc_config *config);
>>>  extern void sam9_smc_cs_configure(void __iomem *, struct sam9_smc_config *cfg);
>>> +extern int sam9_smc_check_cs_configuration(struct sam9_smc_config *config);
>>> +extern void sam9_smc_clip_cs_configuration(struct sam9_smc_config *config);
>>>  #endif
>>>
>>>  #define AT91_SMC_SETUP               0x00                            /* Setup Register for CS n */
>>> diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
>>> index d7a6156..fe3c492 100644
>>> --- a/arch/arm/mach-at91/sam9_smc.c
>>> +++ b/arch/arm/mach-at91/sam9_smc.c
>>> @@ -23,6 +23,83 @@
>>>
>>>  static void __iomem *smc_base_addr[2];
>>>
>>> +static int count_trailing_zeroes(u32 x)
>>
>> Don't we have something generic for this?
>>
>> Check include/asm-generic/bitops/count_zeros.h
> 
> I wonder how I could have missed this one :o)
> 
>>
>>> +{
>>> +     int ret = 0;
>>> +     if (!(x & 0xFFFF)) {
>>> +             ret += 16;
>>> +             x = x >> 16;
>>> +     }
>>> +     if (!(x & 0xFF)) {
>>> +             ret += 8;
>>> +             x = x >> 8;
>>> +     }
>>> +     if (!(x & 0xF)) {
>>> +             ret += 4;
>>> +             x = x >> 4;
>>> +     }
>>> +     if (!(x & 0x3)) {
>>> +             ret += 2;
>>> +             x = x >> 2;
>>> +     }
>>> +     if (!(x & 0x1)) {
>>> +             ret += 1;
>>> +             x = x >> 1;
>>> +     }
>>> +     if (!(x & 0x1))
>>> +             ret += 1;
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +
>>> +#define __CHECK_CFG(config, x, y)  do {\
>>> +     if (x##_(config->y) > x) {\
>>> +             pr_debug("error: %s (0x%x) is out of range\n", #y,\
>>> +                     config->y >> count_trailing_zeroes(x));\
>>> +             return -EINVAL;\
>>> +             } \
>>> +     } while (0)
>>
>> I do not like the use of macro for this. You can convert them to
>> functions and it would increase readability. I am pretty confident that
>> gcc will optimize it so that is won't impact performance.
> 
> It's not a matter of performance. I wanted to use the stringification
> for the debug message.

I see. It is interesting but anyway, we might keep it simple and just
flag the error with the incriminated value...

Bye,


>>> +int sam9_smc_check_cs_configuration(struct sam9_smc_config *config)
>>> +{
>>> +     __CHECK_CFG(config, AT91_SMC_NWESETUP, nwe_setup);
>>> +     __CHECK_CFG(config, AT91_SMC_NCS_WRSETUP, ncs_write_setup);
>>> +     __CHECK_CFG(config, AT91_SMC_NRDSETUP, nrd_setup);
>>> +     __CHECK_CFG(config, AT91_SMC_NCS_RDSETUP, ncs_read_setup);
>>> +     __CHECK_CFG(config, AT91_SMC_NWEPULSE, nwe_pulse);
>>> +     __CHECK_CFG(config, AT91_SMC_NCS_WRPULSE, ncs_write_pulse);
>>> +     __CHECK_CFG(config, AT91_SMC_NRDPULSE, nrd_pulse);
>>> +     __CHECK_CFG(config, AT91_SMC_NCS_RDPULSE, ncs_read_pulse);
>>> +     __CHECK_CFG(config, AT91_SMC_NWECYCLE, write_cycle);
>>> +     __CHECK_CFG(config, AT91_SMC_NRDCYCLE, read_cycle);
>>> +     __CHECK_CFG(config, AT91_SMC_TDF, tdf_cycles);
>>> +     return 0;
>>> +}
>>> +
>>> +#define __CLIP_CFG(config, x, y)  do {\
>>> +     if (x##_(config->y) > x) {\
>>> +             config->y = x >> count_trailing_zeroes(x);\
>>> +             pr_debug("clipping %s to %d\n", #y, config->y);\
>>> +             } \
>>> +     } while (0)
>>
>> Ditto.
>>
>>> +
>>> +void sam9_smc_clip_cs_configuration(struct sam9_smc_config *config)
>>> +{
>>> +     __CLIP_CFG(config, AT91_SMC_NWESETUP, nwe_setup);
>>> +     __CLIP_CFG(config, AT91_SMC_NCS_WRSETUP, ncs_write_setup);
>>> +     __CLIP_CFG(config, AT91_SMC_NRDSETUP, nrd_setup);
>>> +     __CLIP_CFG(config, AT91_SMC_NCS_RDSETUP, ncs_read_setup);
>>> +     __CLIP_CFG(config, AT91_SMC_NWEPULSE, nwe_pulse);
>>> +     __CLIP_CFG(config, AT91_SMC_NCS_WRPULSE, ncs_write_pulse);
>>> +     __CLIP_CFG(config, AT91_SMC_NRDPULSE, nrd_pulse);
>>> +     __CLIP_CFG(config, AT91_SMC_NCS_RDPULSE, ncs_read_pulse);
>>> +     __CLIP_CFG(config, AT91_SMC_NWECYCLE, write_cycle);
>>> +     __CLIP_CFG(config, AT91_SMC_NRDCYCLE, read_cycle);
>>> +     __CLIP_CFG(config, AT91_SMC_TDF, tdf_cycles);
>>> +
>>> +}
>>> +
>>>  static void sam9_smc_cs_write_mode(void __iomem *base,
>>>                                       struct sam9_smc_config *config)
>>>  {
>>>
>>
>>
>> --
>> Nicolas Ferre
> 
> 


-- 
Nicolas Ferre
