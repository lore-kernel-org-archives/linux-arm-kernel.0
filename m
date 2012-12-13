From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 13 Dec 2012 13:18:43 -0600
Subject: [RFC 1/5] ARM: CORESIGHT: Add generic lock/unlock helpers
In-Reply-To: <20121213145803.GL26540@mudshark.cambridge.arm.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-2-git-send-email-jon-hunter@ti.com>
 <20121213145803.GL26540@mudshark.cambridge.arm.com>
Message-ID: <50CA2A13.9090005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/13/2012 08:58 AM, Will Deacon wrote:
> Hi Jon,
> 
> On Wed, Dec 12, 2012 at 09:43:04PM +0000, Jon Hunter wrote:
>> The Cross Trigger Interface (CTI) helpers in cti.h include definitions
>> for the Coresight Lock Access Register (LAR) and Lock Status Register
>> (LSR). These registers are already defined in coresight.h and so rather
>> than having multiple definitions, just use the definitions from
>> coresight.h.
>>
>> Add the following coresight macros ...
>> - coresight_unlock() --> Unlocks coresight module
>> - coresight_lock()   --> Locks coresight module
>>
>> Use the above macros for ETB, ETM and CTI. The do-while(0) statement
>> has been removed from the macro as it is not a multi-line macro.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
>>  arch/arm/include/asm/cti.h                |   16 +++-------------
>>  arch/arm/include/asm/hardware/coresight.h |   16 ++++++++--------
>>  2 files changed, 11 insertions(+), 21 deletions(-)
> 
> [...]
> 
>> diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/include/asm/hardware/coresight.h
>> index 7ecd793..dcd0e66 100644
>> --- a/arch/arm/include/asm/hardware/coresight.h
>> +++ b/arch/arm/include/asm/hardware/coresight.h
>> @@ -141,17 +141,17 @@
>>  #define ETBFF_TRIGEVT		BIT(9)
>>  #define ETBFF_TRIGFL		BIT(10)
>>  
>> -#define etb_writel(t, v, x) \
>> -	(__raw_writel((v), (t)->etb_regs + (x)))
>> +#define etb_writel(t, v, x) (__raw_writel((v), (t)->etb_regs + (x)))
>>  #define etb_readl(t, x) (__raw_readl((t)->etb_regs + (x)))
>>  
>> -#define etm_lock(t) do { etm_writel((t), 0, CSMR_LOCKACCESS); } while (0)
>> -#define etm_unlock(t) \
>> -	do { etm_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
>> +#define etb_lock(t) coresight_lock((t)->etb_regs)
>> +#define etb_unlock(t) coresight_unlock((t)->etb_regs)
>> +#define etm_lock(t) coresight_lock((t)->etm_regs)
>> +#define etm_unlock(t) coresight_unlock((t)->etm_regs)
>>  
>> -#define etb_lock(t) do { etb_writel((t), 0, CSMR_LOCKACCESS); } while (0)
>> -#define etb_unlock(t) \
>> -	do { etb_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
>> +#define coresight_lock(base) (__raw_writel(0, base + CSMR_LOCKACCESS))
>> +#define coresight_unlock(base) \
>> +	(__raw_writel(UNLOCK_MAGIC, base + CSMR_LOCKACCESS))
>>  
>>  #endif /* __ASM_HARDWARE_CORESIGHT_H */
> 
> How about we take this opportunity to divorce the more general coresight
> bits from the etb specific parts, like you've done for the cti. We could
> move the ETB stuff out into asm/etb.h (although it might be nice to keep all
> the coresight device headers in one place... answers on a postcard) and just
> have the architected coresight functionality in this header.

Yes I have been wondering about that too. Long term it would be good to
find a home in the drivers directory for all these coresight devices
too. For now, we could extract the etb/etm parts from coresight.h into
etb.h and etm.h, respectively.

Cheers
Jon
