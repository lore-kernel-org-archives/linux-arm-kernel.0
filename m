From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 15 Jun 2017 11:13:15 +0100
Subject: [PATCH 05/12] coresight tmc: Add helpers for accessing 64bit
 registers
In-Reply-To: <20170614174904.GA22030@xps15>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-6-git-send-email-suzuki.poulose@arm.com>
 <20170614174904.GA22030@xps15>
Message-ID: <f9f02bdd-ebfd-16b1-0f3d-03989f47ddf7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/17 18:49, Mathieu Poirier wrote:
> On Mon, Jun 12, 2017 at 03:36:44PM +0100, Suzuki K Poulose wrote:
>> Coresight TMC splits 64bit registers into a pair of 32bit registers
>> (e.g DBA, RRP, RWP). Provide helpers to read/write to these registers.
>
> I'm good with this patch but please specify these changes are to support the
> SoC-600 suite.  That way when we look back at this set in a couple of years we
> don't loose hair thinking we've been carrying bugs all this time.

To be honest, these are not necessarily just for the support of SoC-600.
It is applies to the current driver with SoC-400, as you could see below,
where we have always assumed that the RRP/RWP/DBA HI bits are always
0. Technically, the TMC supports upto 40bits and hence we have been doing
it wrong.

>> -	read_ptr = readl_relaxed(drvdata->base + TMC_RRP);
>> -	write_ptr = readl_relaxed(drvdata->base + TMC_RWP);
>> +	read_ptr = tmc_read_rrp(drvdata);
>> +	write_ptr = tmc_read_rwp(drvdata);



>> -		writel_relaxed(read_ptr, drvdata->base + TMC_RRP);
>> +		tmc_write_rrp(drvdata, read_ptr);
>>  		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);

>>  	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
>> +	tmc_write_dba(drvdata, drvdata->paddr);
>>
>> -	writel_relaxed(drvdata->paddr, drvdata->base + TMC_DBALO);
>> -	writel_relaxed(0x0, drvdata->base + TMC_DBAHI);

>>
>> -	rwp = readl_relaxed(drvdata->base + TMC_RWP);
>> +	rwp = tmc_read_rwp(drvdata);
>>  	val = readl_relaxed(drvdata->base + TMC_STS);
>>


Suzuki
