From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 7 Mar 2011 10:50:41 +0100
Subject: [patch v3 1/3] arm: introduce cross trigger interface helpers
In-Reply-To: <AANLkTi=v4DgdQdtTi6Qn24upQvRObffWh=vRTAVHWXgX@mail.gmail.com>
References: <1299149633-699-1-git-send-email-tom.leiming@gmail.com>
	<1299149633-699-2-git-send-email-tom.leiming@gmail.com>
	<AANLkTi=v4DgdQdtTi6Qn24upQvRObffWh=vRTAVHWXgX@mail.gmail.com>
Message-ID: <AANLkTi==L0Mzb46+qG_ysbwg1XRifwm6R5pKWUQgL40d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry forgot the ack:

Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean

On Mon, Mar 7, 2011 at 10:48 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> On Thu, Mar 3, 2011 at 11:53 AM, ?<tom.leiming@gmail.com> wrote:
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> OMAP4 uses cross trigger interface(CTI) to route
>> performance monitor irq to GIC, so introduce cti
>> helpers to make access for cti easily.
>>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>> ---
>> ?arch/arm/include/asm/cti.h | ?177 ++++++++++++++++++++++++++++++++++++++++++++
>> ?1 files changed, 177 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/include/asm/cti.h
>>
>> diff --git a/arch/arm/include/asm/cti.h b/arch/arm/include/asm/cti.h
>> new file mode 100644
>> index 0000000..48f173a
>> --- /dev/null
>> +++ b/arch/arm/include/asm/cti.h
>> @@ -0,0 +1,177 @@
>> +/*
>> + * ?arch/arm/include/asm/cti.h
>> + */
>> +#ifndef __ASMARM_CTI_H
>> +#define __ASMARM_CTI_H
>> +
>> +#include ? ? ? <asm/io.h>
>> +
>> +/*The registers' definition is from section 3.2 of
>> + * ? ? Embedded Cross Trigger Revision: r0p0
>> + **/
>> +#define ? ? ? ? ? ? ? ?CTICONTROL ? ? ? ? ? ? ?0x000
>> +#define ? ? ? ? ? ? ? ?CTISTATUS ? ? ? ? ? ? ? 0x004
>> +#define ? ? ? ? ? ? ? ?CTILOCK ? ? ? ? ? ? ? ? 0x008
>> +#define ? ? ? ? ? ? ? ?CTIPROTECTION ? ? ? ? ? 0x00C
>> +#define ? ? ? ? ? ? ? ?CTIINTACK ? ? ? ? ? ? ? 0x010
>> +#define ? ? ? ? ? ? ? ?CTIAPPSET ? ? ? ? ? ? ? 0x014
>> +#define ? ? ? ? ? ? ? ?CTIAPPCLEAR ? ? ? ? ? ? 0x018
>> +#define ? ? ? ? ? ? ? ?CTIAPPPULSE ? ? ? ? ? ? 0x01c
>> +#define ? ? ? ? ? ? ? ?CTIINEN ? ? ? ? ? ? ? ? 0x020
>> +#define ? ? ? ? ? ? ? ?CTIOUTEN ? ? ? ? ? ? ? ?0x0A0
>> +#define ? ? ? ? ? ? ? ?CTITRIGINSTATUS ? ? ? ? 0x130
>> +#define ? ? ? ? ? ? ? ?CTITRIGOUTSTATUS ? ? ? ?0x134
>> +#define ? ? ? ? ? ? ? ?CTICHINSTATUS ? ? ? ? ? 0x138
>> +#define ? ? ? ? ? ? ? ?CTICHOUTSTATUS ? ? ? ? ?0x13c
>> +#define ? ? ? ? ? ? ? ?CTIPERIPHID0 ? ? ? ? ? ?0xFE0
>> +#define ? ? ? ? ? ? ? ?CTIPERIPHID1 ? ? ? ? ? ?0xFE4
>> +#define ? ? ? ? ? ? ? ?CTIPERIPHID2 ? ? ? ? ? ?0xFE8
>> +#define ? ? ? ? ? ? ? ?CTIPERIPHID3 ? ? ? ? ? ?0xFEC
>> +#define ? ? ? ? ? ? ? ?CTIPCELLID0 ? ? ? ? ? ? 0xFF0
>> +#define ? ? ? ? ? ? ? ?CTIPCELLID1 ? ? ? ? ? ? 0xFF4
>> +#define ? ? ? ? ? ? ? ?CTIPCELLID2 ? ? ? ? ? ? 0xFF8
>> +#define ? ? ? ? ? ? ? ?CTIPCELLID3 ? ? ? ? ? ? 0xFFC
>> +
>> +/*The two below are from section 3.6.4 of
>> + * ? ? CoreSight v1.0 Architecture Specification
>> + **/
>> +#define ? ? ? ? ? ? ? ?LOCKACCESS ? ? ? ? ? ? ?0xFB0
>> +#define ? ? ? ? ? ? ? ?LOCKSTATUS ? ? ? ? ? ? ?0xFB4
>> +
>> +/**
>> + * struct cti - cross trigger interface struct
>> + * @base: mapped virtual address for the cti base
>> + * @irq: irq number for the cti
>> + * @trig_out_for_irq: triger out number which will cause
>> + * ? ? the @irq happen
>> + *
>> + * cti struct used to operate cti registers.
>> + */
>> +struct cti {
>> + ? ? ? void *base;
>> + ? ? ? int irq;
>> + ? ? ? int trig_out_for_irq;
>> +};
>> +
>> +/**
>> + * cti_init - initialize the cti instance
>> + * @cti: cti instance
>> + * @base: mapped virtual address for the cti base
>> + * @irq: irq number for the cti
>> + * @trig_out: triger out number which will cause
>> + * ? ? the @irq happen
>> + *
>> + * called by machine code to pass the board dependent
>> + * @base, @irq and @trig_out to cti.
>> + */
>> +static inline void cti_init(struct cti *cti,
>> + ? ? ? void *base, int irq, int trig_out)
>> +{
>> + ? ? ? cti->base = base;
>> + ? ? ? cti->irq ?= irq;
>> + ? ? ? cti->trig_out_for_irq = trig_out;
>> +}
>> +
>> +/**
>> + * cti_map_trigger - use the @chan to map @trig_in to @trig_out
>> + * @cti: cti instance
>> + * @trig_in: trigger in number
>> + * @trig_out: trigger out number
>> + * @channel: channel number
>> + *
>> + * This function maps one trigger in of @trig_in to one trigger
>> + * out of @trig_out using the channel @chan.
>> + */
>> +static inline void cti_map_trigger(struct cti *cti,
>> + ? ? ? int trig_in, int trig_out, int chan)
>> +{
>> + ? ? ? void *base = cti->base;
>> + ? ? ? unsigned long val;
>> +
>> + ? ? ? val = __raw_readl(base + CTIINEN + trig_in * 4);
> Rather use 'void __iomem *' type for the __raw_readl and __raw_writel functions.
> Idem for the other occurences here below.
>
>> + ? ? ? val |= 1 << chan;
>> + ? ? ? __raw_writel(val, base + CTIINEN + trig_in * 4);
>> +
>> + ? ? ? val = __raw_readl(base + CTIOUTEN + trig_out * 4);
>> + ? ? ? val |= 1 << chan;
>> + ? ? ? __raw_writel(val, base + CTIOUTEN + trig_out * 4);
>> +}
>> +
>> +/**
>> + * cti_enable - enable the cti module
>> + * @cti: cti instance
>> + *
>> + * enable the cti module
>> + */
>> +static inline void cti_enable(struct cti *cti)
>> +{
>> + ? ? ? __raw_writel(0x1, cti->base);
>> +}
>> +
>> +/**
>> + * cti_disable - disable the cti module
>> + * @cti: cti instance
>> + *
>> + * enable the cti module
>> + */
>> +static inline void cti_disable(struct cti *cti)
>> +{
>> + ? ? ? __raw_writel(0, cti->base);
>> +}
>> +
>> +/**
>> + * cti_irq_ack - clear the cti irq
>> + * @cti: cti instance
>> + *
>> + * clear the cti irq
>> + */
>> +static inline void cti_irq_ack(struct cti *cti)
>> +{
>> + ? ? ? void *base = cti->base;
>> + ? ? ? unsigned long val;
>> +
>> + ? ? ? val = __raw_readl(base + CTIINTACK);
>> + ? ? ? val |= 1 << cti->trig_out_for_irq;
>> + ? ? ? __raw_writel(val, base + CTIINTACK);
>> +}
>> +
>> +/**
>> + * cti_unlock - unlock cti module
>> + * @cti: cti instance
>> + *
>> + * unlock the cti module, or else any writes to the cti
>> + * module is not allowed.
>> + */
>> +static inline void cti_unlock(struct cti *cti)
>> +{
>> + ? ? ? void *base = cti->base;
>> + ? ? ? unsigned long val;
>> +
>> + ? ? ? val = __raw_readl(base + LOCKSTATUS);
>> +
>> + ? ? ? if (val & 1) {
>> + ? ? ? ? ? ? ? val = 0xC5ACCE55;
> Could this be defined as a macro?
>
>> + ? ? ? ? ? ? ? __raw_writel(val, base + LOCKACCESS);
>> + ? ? ? }
>> +}
>> +
>> +/**
>> + * cti_lock - lock cti module
>> + * @cti: cti instance
>> + *
>> + * lock the cti module, so any writes to the cti
>> + * module will be not allowed.
>> + */
>> +static inline void cti_lock(struct cti *cti)
>> +{
>> + ? ? ? void *base = cti->base;
>> + ? ? ? unsigned long val;
>> +
>> + ? ? ? val = __raw_readl(base + LOCKSTATUS);
>> +
>> + ? ? ? if (!(val & 1)) {
>> + ? ? ? ? ? ? ? val = ~0xC5ACCE55;
> Idem
>
>> + ? ? ? ? ? ? ? __raw_writel(val, base + LOCKACCESS);
>> + ? ? ? }
>> +}
>> +#endif
>> --
>> 1.7.3
>
> Minor comments: checkpatch throws away some warnings:
>
> WARNING: please, no space before tabs
> #74: FILE: arch/arm/include/asm/cti.h:10:
> + * ^IEmbedded Cross Trigger Revision: r0p0$
>
> WARNING: please, no space before tabs
> #100: FILE: arch/arm/include/asm/cti.h:36:
> + * ^ICoreSight v1.0 Architecture Specification$
>
> WARNING: please, no space before tabs
> #110: FILE: arch/arm/include/asm/cti.h:46:
> + * ^Ithe @irq happen$
>
> WARNING: please, no space before tabs
> #126: FILE: arch/arm/include/asm/cti.h:62:
> + * ^Ithe @irq happen$
>
> total: 0 errors, 4 warnings, 177 lines checked
>
>
> Regards,
> Jean
>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
