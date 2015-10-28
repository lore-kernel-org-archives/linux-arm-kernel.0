From: rjui@broadcom.com (Ray Jui)
Date: Tue, 27 Oct 2015 17:46:56 -0700
Subject: [PATCH v3 2/2] arm64: dts: Add BRCM IPROC NAND DT node for NS2
In-Reply-To: <20151028003935.GZ13239@google.com>
References: <1445577373-21252-1-git-send-email-anup.patel@broadcom.com>
 <1445577373-21252-3-git-send-email-anup.patel@broadcom.com>
 <20151028001920.GY13239@google.com> <563015FC.9040006@broadcom.com>
 <20151028003935.GZ13239@google.com>
Message-ID: <56301B00.1020301@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/27/2015 5:39 PM, Brian Norris wrote:
> On Tue, Oct 27, 2015 at 05:25:32PM -0700, Ray Jui wrote:
>> On 10/27/2015 5:19 PM, Brian Norris wrote:
>>> On Fri, Oct 23, 2015 at 10:46:13AM +0530, Anup Patel wrote:
>>>> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>>>> index f603277..9610822 100644
>>>> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
>>>> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>>>> @@ -212,5 +212,19 @@
>>>>   			compatible = "brcm,iproc-rng200";
>>>>   			reg = <0x66220000 0x28>;
>>>>   		};
>>>> +
>>>> +		nand: nand at 66460000 {
>>>> +			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
>>>
>>> Technically, the binding says you should also have "brcm,brcmnand" as a
>>> last resort. Otherwise (for the NAND parts):
>>>
>>
>> I believe Anup was seeing issues when both "brcm,nand-iproc" and
>> "brcm,brcmnand" are present.
>>
>> Note "brcm,nand-iproc" invokes 'iproc_nand_probe', which calls
>> 'brcmnand_probe' in the end.
>>
>> "brcm,brcmnand" invokes 'brcmstb_nand_probe', which also calls
>> 'brcmstb_probe', but without all the prep configuration required for
>> "brcm,nand-iproc".
>
> Ah, I forgot about that problem. That seems like an OF infrastructure
> issue that could be fixed. We could lump these drivers back together,
> and make sure that "brcm,nand-iproc" gets the priority in the
> of_device_id list.
>
> Or we could just relax the DT binding.
>
> But wait, wouldn't cygnus already have that problem? You're using the
> binding I suggested in arch/arm/boot/dts/bcm-cygnus.dtsi.

Interestingly, we do not see this problem with Cygnus or NSP, but only 
on NS2 (arm64 based). There may be a difference between how OF devices 
are instantiated between arm and arm64?

>
> Oh, and I see we hacked this one in drivers/mtd/nand/brcmnand/Makefile:
>
>    # link order matters; don't link the more generic brcmstb_nand.o before the
>    # more specific iproc_nand.o, for instance

Yes, I see that too (after sending out my previous email, :)). Maybe 
Anup can help to elaborate on the problem. I'm now getting a bit 
confused on how the problem can surface on NS2.

But in general, I think it's a good idea to relax the requirement in the 
DT binding document to not require "brcm,brcmnand", in the case when 
"brcm,nand-iproc" and "brcm,nand-bcm63138" are present.

>
> Brian
>

Thanks,

Ray
