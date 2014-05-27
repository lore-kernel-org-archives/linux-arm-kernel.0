From: elder@linaro.org (Alex Elder)
Date: Tue, 27 May 2014 08:43:22 -0500
Subject: [PATCH v4 1/5] devicetree: bindings: document Broadcom CPU enable
 method
In-Reply-To: <20140527114958.GC18476@e102568-lin.cambridge.arm.com>
References: <1400607830-10989-1-git-send-email-elder@linaro.org>
 <1400607830-10989-2-git-send-email-elder@linaro.org>
 <20140527114958.GC18476@e102568-lin.cambridge.arm.com>
Message-ID: <5384967A.80402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2014 06:49 AM, Lorenzo Pieralisi wrote:
> On Tue, May 20, 2014 at 06:43:46PM +0100, Alex Elder wrote:
>> Broadcom mobile SoCs use a ROM-implemented holding pen for
>> controlled boot of secondary cores.  A special register is
>> used to communicate to the ROM that a secondary core should
>> start executing kernel code.  This enable method is currently
>> used for members of the bcm281xx and bcm21664 SoC families.
>>
>> The use of an enable method also allows the SMP operation vector to
>> be assigned as a result of device tree content for these SoCs.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> This is getting out of control, it is absolutely ghastly. I wonder how
> I can manage to keep cpus.txt updated if anyone with a boot method
> du jour adds into cpus.txt, and honestly in this specific case it is even
> hard to understand why.

I concur that it gets out of control to document bindings
in "cpus.txt" like this.

I posted a separate, independent documentation patch, to
address this issue specifically:
    devicetree: bindings: separate CPU enable method descriptions
There I don't even include my new addition but I also
do a little work to sort out some stuff--for example only
defining "cpu-release-addr" (or "qcom,saw") in the one place
where it's relevant.

> Can't it be done with bindings for the relative register address space
> (regmap ?) and platform code just calls the registers driver to set-up the
> jump address ? It is platform specific code anyway there is no way you
> can make this generic.

This is feedback specific to how I implement this enable method.
I am going to address this in a follow-on message, to distinguish
it from the broader question of where best to document these
enable methods.  (I'll be sending that message later today.)

> I really do not see the point in cluttering cpus.txt with this stuff, it
> is a platform specific hack, and do not belong in generic bindings in my
> opinion.

Again, I completely agree with this.

In order to assign the SMP operations vector for my machine
via device tree, I need to define an "enable-method" property
in either the "cpus" node or one of the "cpu" nodes.  I would
prefer to use a generic method, but the method used here is
semantically different from the others in existence, and I
need to document how it works.  The place currently used
to do that is "cpus.txt".

Please look at the patch I mentioned above.  I'd be glad to
do it another way; but it is an attempt to address what I
saw as a problem that I think you are talking about.

Thanks.

					-Alex


> Thanks,
> Lorenzo
> 
>> ---
>>  Documentation/devicetree/bindings/arm/cpus.txt | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>> index 333f4ae..c6a2411 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>> @@ -185,6 +185,7 @@ nodes to be present and contain the properties described below.
>>  			    "qcom,gcc-msm8660"
>>  			    "qcom,kpss-acc-v1"
>>  			    "qcom,kpss-acc-v2"
>> +			    "brcm,bcm11351-cpu-method"
>>  
>>  	- cpu-release-addr
>>  		Usage: required for systems that have an "enable-method"
>> @@ -209,6 +210,17 @@ nodes to be present and contain the properties described below.
>>  		Value type: <phandle>
>>  		Definition: Specifies the ACC[2] node associated with this CPU.
>>  
>> +	- secondary-boot-reg
>> +		Usage:
>> +			Required for systems that have an "enable-method"
>> +			property value of "brcm,bcm11351-cpu-method".
>> +		Value type: <u32>
>> +		Definition:
>> +			Specifies the physical address of the register used to
>> +			request the ROM holding pen code release a secondary
>> +			CPU.  The value written to the register is formed by
>> +			encoding the target CPU id into the low bits of the
>> +			physical start address it should jump to.
>>  
>>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>>  
>> -- 
>> 1.9.1
>>
>>
> 
