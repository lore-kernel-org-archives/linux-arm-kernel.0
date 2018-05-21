From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 May 2018 10:52:18 +0100
Subject: [PATCH v3 4/5] ARM: perf: Allow the use of the PMUv3 driver on
 32bit ARM
In-Reply-To: <f40d8620-eb57-37be-a2f0-b7bf7a74c087@arm.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
 <20180518143913.26306-5-marc.zyngier@arm.com>
 <f40d8620-eb57-37be-a2f0-b7bf7a74c087@arm.com>
Message-ID: <1a87b643-67ec-dce8-1f44-d831c8302afc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/18 10:34, Vladimir Murzin wrote:
> On 18/05/18 15:39, Marc Zyngier wrote:
>> +static inline int read_pmuver(void)
>> +{
>> +	/* PMUVers is not a signed field */
>> +	u32 dfr0 = read_cpuid_ext(CPUID_EXT_DFR0);
>> +	return (dfr0 >> 24) & 0xf;
>> +}
> 
> Should we rule out versions prior v3 here or in __armv8pmu_probe_pmu()?

I'm in two minds about it: The ARM ARM is quite clear about the fact
that this is not legal ("In any ARMv8 implementation the values 0001 and
0010 are not permitted."), and DT clearly lied to us in that case.

If we want to consistently handle that case, it should probably be done
in __armv8pmu_probe_pmu, bailing out if the version is our of scope for
the driver.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
