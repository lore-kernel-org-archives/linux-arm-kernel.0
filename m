From: tom.leiming@gmail.com (Ming Lei)
Date: Mon, 7 Mar 2011 18:20:11 +0800
Subject: [patch v3 1/3] arm: introduce cross trigger interface helpers
In-Reply-To: <AANLkTi=v4DgdQdtTi6Qn24upQvRObffWh=vRTAVHWXgX@mail.gmail.com>
References: <1299149633-699-1-git-send-email-tom.leiming@gmail.com>
	<1299149633-699-2-git-send-email-tom.leiming@gmail.com>
	<AANLkTi=v4DgdQdtTi6Qn24upQvRObffWh=vRTAVHWXgX@mail.gmail.com>
Message-ID: <AANLkTi=xLq9fhHn1n_QzwsqhDuP4QUyGG+fj+usWPeYn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

2011/3/7 Jean Pihet <jean.pihet@newoldbits.com>:

>> +static inline void cti_map_trigger(struct cti *cti,
>> + ? ? ? int trig_in, int trig_out, int chan)
>> +{
>> + ? ? ? void *base = cti->base;
>> + ? ? ? unsigned long val;
>> +
>> + ? ? ? val = __raw_readl(base + CTIINEN + trig_in * 4);
> Rather use 'void __iomem *' type for the __raw_readl and __raw_writel functions.
> Idem for the other occurences here below.

Will do it.

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

This is even hard-coded in ECT spec, so not needed to
define as macro.

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

See above.


thanks,
-- 
Lei Ming
