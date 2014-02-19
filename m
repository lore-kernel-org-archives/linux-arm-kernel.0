From: info@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Feb 2014 18:49:13 +0100
Subject: [PATCH v4 07/13] ARM: dts: mvebu: Add a new set of registers
 to the PMSU node
In-Reply-To: <20140219170033.4ca8343b@skate>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>	<1392312816-17657-8-git-send-email-gregory.clement@free-electrons.com>
 <20140219170033.4ca8343b@skate>
Message-ID: <5304EE99.7000102@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/2014 17:00, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Thu, 13 Feb 2014 18:33:30 +0100, Gregory CLEMENT wrote:
> 
>>  - reg: Should contain PMSU registers location and length. First pair
>> -  for the per-CPU SW Reset Control registers, second pair for the
>> -  Power Management Service Unit.
>> +  for the per-CPU SW Reset Control registers, second pair for the CPU
>> +  Power Management Service Unit registers, third pair for the Fabric Power
>> +  Management Service Unit registers.
>>  
>>  Example:
>>  
>> -armada-370-xp-pmsu at d0022000 {
>> +armada-370-xp-pmsu at 22000 {
>>  	compatible = "marvell,armada-370-xp-pmsu";
>> -	reg = <0xd0022100 0x430>,
>> -	      <0xd0020800 0x20>;
>> +	reg = <0x22100 0x430>,
>> +	      <0x20800 0x20>,
>> +	      <0x22000 0x24>;
> 
> I am not too happy with this because:
> 
>  *) We have to remove the second register pair from the PMSU. I haven't
>     yet posted the patches on LAKML for SMP on 375 and 38x, but the 375
>     doesn't have a PMSU. It however has the same CPU reset control
>     registers as 370 and XP. Therefore, these 0x20800 registers have to
>     be handled by a separate driver (that uses the reset framework),
>     and not handled by the PMSU driver. This way, Armada 370/XP can use
>     PMSU+CPU reset, while 375 will only use CPU reset.
> 
>  *) I think making the PMSU register start at 0x22100 was a mistake.
>     The PMSU registers actually start at 0x22000 and they seem to go all
>     the way to 0x23000. So we should have only one register pair. This
>     of course raises some backward compatibility questions for the DT.

I agree to use something like:

armada-370-xp-pmsu at 22000 {
	compatible = "marvell,armada-xp-pmsu"; /* new compatible string */
	reg = <0x22000 0x1000>;
	};


and I think the best option would be to introduce a new compatible string
for this. In the same time we continue to support the old compatible string
but we print a big warning during the kernel boot that this compatible string
is deprecated, and we will finally remove it a few release.

Thanks,

Gregory


> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 602 196 044
