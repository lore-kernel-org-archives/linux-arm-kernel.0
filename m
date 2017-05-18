From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 18 May 2017 15:30:25 +0100
Subject: [PATCH] arm64: dts: juno: Enable some SMMUs
In-Reply-To: <1495113239.3174.11.camel@linaro.org>
References: <eeb81dbbd7ddfbbccb961c0f20c5cb90f120e89f.1495110010.git.robin.murphy@arm.com>
 <1495113239.3174.11.camel@linaro.org>
Message-ID: <ef53211e-1d91-c653-0393-f5e98ce94693@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/17 14:13, Jon Medhurst (Tixy) wrote:
> On Thu, 2017-05-18 at 13:23 +0100, Robin Murphy wrote:
>> The IOMMU-backed DMA API support has now been in place for a while and
>> proven stable, so there's no real need to keep most of Juno's SMMUs
>> disabled. The USB, HDLCDs, and CoreSight ETR all just need to map RAM
>> buffers for DMA - enabling their SMMUs obviates CPU bounce buffering for
>> USB's streaming DMA to the upper memory bank, and lets the other two
>> allocate their relatively large coherent buffers without pressuring CMA.
>>
>> Some more software work is still needed for the DMA-330 and PCIe before
>> those can accommodate SMMU translation correctly in all cases, so we
>> leave those alone for now.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
> 
> For those that don't already know, status = "disabled" for smmu is
> broken in Linux 4.12-rc1, and this fixes it...
> https://lkml.org/lkml/2017/5/17/344

Well, it's not *technically* broken - we do stop waiting for disabled
IOMMUs that never appear, you just need to get to an initramfs or other
workable userspace to load another driver such that the deferred probe
queue gets kicked again after that point :P

But yeah, the whole business reminded me that it was about time to do
this anyway. I should dig up that pl330 patch I started, too...

Robin.

>>  arch/arm64/boot/dts/arm/juno-base.dtsi | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> index bfe7d683a42e..02aea43238fc 100644
>> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
>> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> @@ -53,7 +53,6 @@
>>  		#global-interrupts = <1>;
>>  		dma-coherent;
>>  		power-domains = <&scpi_devpd 0>;
>> -		status = "disabled";
>>  	};
>>  
>>  	gic: interrupt-controller at 2c010000 {
>> @@ -546,7 +545,6 @@
>>  			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
>>  		#iommu-cells = <1>;
>>  		#global-interrupts = <1>;
>> -		status = "disabled";
>>  	};
>>  
>>  	smmu_hdlcd0: iommu at 7fb20000 {
>> @@ -556,7 +554,6 @@
>>  			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>>  		#iommu-cells = <1>;
>>  		#global-interrupts = <1>;
>> -		status = "disabled";
>>  	};
>>  
>>  	smmu_usb: iommu at 7fb30000 {
>> @@ -567,7 +564,6 @@
>>  		#iommu-cells = <1>;
>>  		#global-interrupts = <1>;
>>  		dma-coherent;
>> -		status = "disabled";
>>  	};
>>  
>>  	dma at 7ff00000 {
