From: vigneshr@ti.com (Vignesh R)
Date: Thu, 10 Aug 2017 10:54:01 +0530
Subject: [PATCH 1/7] mtd: spi-nor: cadence-quadspi: add a delay in write
 sequence
In-Reply-To: <20170810000545.hphnihd5ghugfbof@rob-hp-laptop>
References: <20170801045434.8733-1-vigneshr@ti.com>
 <20170801045434.8733-2-vigneshr@ti.com>
 <20170810000545.hphnihd5ghugfbof@rob-hp-laptop>
Message-ID: <86dc7599-bf45-504e-2bbd-ef72054d0a6f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 10 August 2017 05:35 AM, Rob Herring wrote:
> On Tue, Aug 01, 2017 at 10:24:28AM +0530, Vignesh R wrote:
>> As per 66AK2G02 TRM[1] SPRUHY8F section 11.15.5.3 Indirect Access
>> Controller programming sequence, a delay equal to couple QSPI master
>> clock(~5ns) is required after setting CQSPI_REG_INDIRECTWR_START bit and
>> writing data to the flash. Add a new compatible to handle the couple of
>> cycles of delay required in the indirect write sequence, since this
>> delay is specific to TI 66AK2G SoC.
>>
>> [1]http://www.ti.com/lit/ug/spruhy8f/spruhy8f.pdf
>>
[...]
>> +	/*
>> +	 * As per 66AK2G02 TRM SPRUHY8F section 11.15.5.3 Indirect Access
>> +	 * Controller programming sequence, couple of cycles of
>> +	 * QSPI_REF_CLK delay is required for the above bit to
>> +	 * be internally synchronized by the QSPI module. Provide 5
>> +	 * cycles of delay.
>> +	 */
>> +	ndelay(cqspi->wr_delay);
>>  
>>  	while (remaining > 0) {
>>  		write_bytes = remaining > page_size ? page_size : remaining;
>> @@ -1213,6 +1222,9 @@ static int cqspi_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>> +	if (of_device_is_compatible(dev->of_node, "ti,k2g-qspi"))
>> +		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
>> +						   cqspi->master_ref_clk_hz);
> 
> Use the data pointer in the of_device_id table and put the delay value 
> there.
> 

I thought about this, but for a given SoC, delay value might vary
depending on what frequency QSPI master_ref_clk is set to. So hard
coding will not help. How about having a flag (CQSPI_NEEDS_WR_DELAY) in
data pointer and then using that to determine whether or not to
calculate and set delay here?

>>  
>>  	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
>>  			       pdev->name, cqspi);
>> @@ -1285,6 +1297,7 @@ static const struct dev_pm_ops cqspi__dev_pm_ops = {
>>  
>>  static const struct of_device_id cqspi_dt_ids[] = {
>>  	{.compatible = "cdns,qspi-nor",},
>> +	{.compatible = "ti,k2g-qspi",},
>>  	{ /* end of table */ }
>>  };
>>  
>> -- 
>> 2.13.3
>>

-- 
Regards
Vignesh
