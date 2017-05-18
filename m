From: s-anna@ti.com (Suman Anna)
Date: Thu, 18 May 2017 10:59:07 -0500
Subject: [PATCH 1/3] ARM: davinci: da8xx: Create DSP device only when
 assigned memory
In-Reply-To: <098d38ab-4be3-ec01-044d-1fd2e0ac6130@ti.com>
References: <20170516221347.37990-1-s-anna@ti.com>
 <20170516221347.37990-2-s-anna@ti.com>
 <098d38ab-4be3-ec01-044d-1fd2e0ac6130@ti.com>
Message-ID: <6c37a43e-78d4-3fa4-21ca-3c94ad83cbe4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On 05/18/2017 01:10 AM, Sekhar Nori wrote:
> On Wednesday 17 May 2017 03:43 AM, Suman Anna wrote:
>> The DSP device on Davinci platforms does not have an MMU and requires
>> specific DDR memory to boot. This memory is reserved using the rproc_mem
>> kernel boot parameter and is assigned to the device on non-DT boots.
>> The remoteproc core uses the DMA API and so will fall back to assigning
>> random memory if this memory is not assigned to the device, but the DSP
>> remote processor boot will not be successful in such cases. So, check
>> that memory has been reserved and assigned to the device specifically
>> before even creating the DSP device.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  arch/arm/mach-davinci/devices-da8xx.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
>> index 7cf529ffbe5a..1ccf52e49886 100644
>> --- a/arch/arm/mach-davinci/devices-da8xx.c
>> +++ b/arch/arm/mach-davinci/devices-da8xx.c
>> @@ -814,6 +814,8 @@ static struct platform_device da8xx_dsp = {
>>  	.resource	= da8xx_rproc_resources,
>>  };
>>  
>> +static bool rproc_mem_inited __initdata;
>> +
>>  #if IS_ENABLED(CONFIG_DA8XX_REMOTEPROC)
>>  
>>  static phys_addr_t rproc_base __initdata;
>> @@ -852,6 +854,8 @@ void __init da8xx_rproc_reserve_cma(void)
>>  	ret = dma_declare_contiguous(&da8xx_dsp.dev, rproc_size, rproc_base, 0);
>>  	if (ret)
>>  		pr_err("%s: dma_declare_contiguous failed %d\n", __func__, ret);
>> +	else
>> +		rproc_mem_inited = true;
>>  }
>>  
>>  #else
>> @@ -866,6 +870,12 @@ int __init da8xx_register_rproc(void)
>>  {
>>  	int ret;
>>  
>> +	if (!rproc_mem_inited) {
>> +		pr_warn("%s: memory not reserved for DSP, not registering DSP device\n",
>> +			__func__);
> 
> We now have a warning and an error if dma_declare_contiguous() fails. I
> like this message better. So can you replace the existing error message
> with this text instead ?

Hmm, this trace is not just covering the dma_declare_contiguous failure.
There can be two different errors in da8xx_rproc_reserve_cma, and this
trace only shows up when the device is being registered. So not sure how
your suggestion improves anything by dropping/replacing one of them.

regards
Suman
