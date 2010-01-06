From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 6 Jan 2010 12:15:51 +0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <op.u530zufm7p4s8u@localhost>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<op.u530zufm7p4s8u@localhost>
Message-ID: <20100106121551.GU4179@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2010 at 01:00:56PM +0100, Micha? Nazarewicz wrote:
>> +#else /* CONFIG_CPU_HAS_PMU */
>> +
>> +static inline const struct pmu_irqs *
>> +reserve_pmu(void)
>> +{
>> +	ERR_PTR(-ENODEV);
>
> -	ERR_PTR(-ENODEV);
> +	return ERR_PTR(-ENODEV);
>
>> +}
>> +
>> +static inline int
>> +release_pmu(const struct pmu_irqs *irqs)
>> +{
>
> +	return -ENODEV;
>
>> +}
>> +
>> +static inline int
>> +init_pmu(void)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +#endif /* CONFIG_CPU_HAS_PMU */
>> +
>> +#endif /* __ARM_PMU_H__ */
Thanks, well spotted!
>> +static const struct pmu_irqs pmu_irqs = {
>> +	.irqs	    = irqs,
>> +	.num_irqs   = ARRAY_SIZE(irqs),
>> +};
>> +
>> +static DECLARE_MUTEX(pmu_mutex);
>
> Isn't mutex an overkill? A bit field would be enough:
>
> -static DECLARE_MUTEX(pmu_mutex);
> +static volatile long pmu_mutex;
Yes, it probably is. I don't think performance is important here but that's a
simpler solution so I'll make that change.

Thanks,

Jamie
