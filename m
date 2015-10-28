From: rjui@broadcom.com (Ray Jui)
Date: Wed, 28 Oct 2015 09:08:02 -0700
Subject: [PATCH v3 2/2] arm64: dts: Add BRCM IPROC NAND DT node for NS2
In-Reply-To: <39063E8F96E11742B35A201CC5D095B7AFFB81@SJEXCHMB10.corp.ad.broadcom.com>
References: <1445577373-21252-1-git-send-email-anup.patel@broadcom.com>
 <1445577373-21252-3-git-send-email-anup.patel@broadcom.com>
 <20151028001920.GY13239@google.com> <563015FC.9040006@broadcom.com>
 <20151028003935.GZ13239@google.com> <56301B00.1020301@broadcom.com>
 <39063E8F96E11742B35A201CC5D095B7AFFB81@SJEXCHMB10.corp.ad.broadcom.com>
Message-ID: <5630F2E2.8060508@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/28/2015 2:06 AM, Anup Patel wrote:
>
>
>> -----Original Message-----
>> From: Ray Jui [mailto:rjui at broadcom.com]
>> Sent: 28 October 2015 06:17
>> To: Brian Norris
>> Cc: Anup Patel; David Woodhouse; Linux MTD; Rob Herring; Pawel Moll; Mark
>> Rutland; Catalin Marinas; Will Deacon; Sudeep Holla; Ian Campbell; Kumar Gala;
>> Scott Branden; Florian Fainelli; Pramod Kumar; Vikram Prakash; Sandeep
>> Tripathy; Linux ARM Kernel; Device Tree; Linux Kernel; bcm-kernel-feedback-list
>> Subject: Re: [PATCH v3 2/2] arm64: dts: Add BRCM IPROC NAND DT node for
>> NS2
>>
>>
>>
>> On 10/27/2015 5:39 PM, Brian Norris wrote:
>>> On Tue, Oct 27, 2015 at 05:25:32PM -0700, Ray Jui wrote:
>>>> On 10/27/2015 5:19 PM, Brian Norris wrote:
>>>>> On Fri, Oct 23, 2015 at 10:46:13AM +0530, Anup Patel wrote:
>>>>>> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi
>>>>>> b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>>>>>> index f603277..9610822 100644
>>>>>> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>>>>>> @@ -212,5 +212,19 @@
>>>>>>    			compatible = "brcm,iproc-rng200";
>>>>>>    			reg = <0x66220000 0x28>;
>>>>>>    		};
>>>>>> +
>>>>>> +		nand: nand at 66460000 {
>>>>>> +			compatible = "brcm,nand-iproc", "brcm,brcmnand-
>> v6.1";
>>>>>
>>>>> Technically, the binding says you should also have "brcm,brcmnand"
>>>>> as a last resort. Otherwise (for the NAND parts):
>>>>>
>>>>
>>>> I believe Anup was seeing issues when both "brcm,nand-iproc" and
>>>> "brcm,brcmnand" are present.
>>>>
>>>> Note "brcm,nand-iproc" invokes 'iproc_nand_probe', which calls
>>>> 'brcmnand_probe' in the end.
>>>>
>>>> "brcm,brcmnand" invokes 'brcmstb_nand_probe', which also calls
>>>> 'brcmstb_probe', but without all the prep configuration required for
>>>> "brcm,nand-iproc".
>>>
>>> Ah, I forgot about that problem. That seems like an OF infrastructure
>>> issue that could be fixed. We could lump these drivers back together,
>>> and make sure that "brcm,nand-iproc" gets the priority in the
>>> of_device_id list.
>>>
>>> Or we could just relax the DT binding.
>>>
>>> But wait, wouldn't cygnus already have that problem? You're using the
>>> binding I suggested in arch/arm/boot/dts/bcm-cygnus.dtsi.
>>
>> Interestingly, we do not see this problem with Cygnus or NSP, but only on NS2
>> (arm64 based). There may be a difference between how OF devices are
>> instantiated between arm and arm64?
>
> Alternately, it could be also about order in-which platform drivers are matched
> for newly created OF device.
>
>>
>>>
>>> Oh, and I see we hacked this one in drivers/mtd/nand/brcmnand/Makefile:
>>>
>>>     # link order matters; don't link the more generic brcmstb_nand.o before the
>>>     # more specific iproc_nand.o, for instance
>>
>> Yes, I see that too (after sending out my previous email, :)). Maybe
>> Anup can help to elaborate on the problem. I'm now getting a bit
>> confused on how the problem can surface on NS2.
>
> I think for a newly created OF devices the Linux device driver framework will
> match the platform drivers in the order in which they are registered by module
> init functions. Now the order of module init function calls will be based how
> the .initcall section is formed by linker and order in which objects are linked.
>

Yes, what you said is my understanding as well, but then here is the 
mystery. This is the link order in brcmnand/Makefile:

1 # link order matters; don't link the more generic brcmstb_nand.o 
before the
2 # more specific iproc_nand.o, for instance
3 obj-$(CONFIG_MTD_NAND_BRCMNAND) += iproc_nand.o
4 obj-$(CONFIG_MTD_NAND_BRCMNAND) += bcm63138_nand.o
5 obj-$(CONFIG_MTD_NAND_BRCMNAND) += brcmstb_nand.o
6 obj-$(CONFIG_MTD_NAND_BRCMNAND) += brcmnand.o

Based on the order above, probe from iproc_nand should always be called 
first if a matching compatible string is found. If so, then why having 
both compatible strings "brcm,brcmnand" and "brcm,nand-iproc" causes 
issues for NS2 (I remember it broke smoketest in the past when you 
submitted the change)? I'm not saying we should have "brcm,brcmnand" for 
iProc devices, but I don't get why it would cause any issue.

Does the order of the compatible string matter when they are assigned to 
the same 'compatible' property like this?

compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1",    "brcm,brcmnand";


> IMHO, if multiple platform drivers match given OF device then platform driver
> with longest matching compatible string should only be probed. I don't know
> how big change this would be for OF framework.
>
>>
>> But in general, I think it's a good idea to relax the requirement in the
>> DT binding document to not require "brcm,brcmnand", in the case when
>> "brcm,nand-iproc" and "brcm,nand-bcm63138" are present.
>
> Even I think, it will be good to relax the DT bindings requirement for
> BRCM NAND driver.
>
> Regards,
> Anup
>
