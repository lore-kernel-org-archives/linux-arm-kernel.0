From: al.stone@linaro.org (Al Stone)
Date: Wed, 29 Apr 2015 09:39:25 -0600
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup device
 coherency
In-Reply-To: <D1665A4F.19E17%suravee.suthikulpanit@amd.com>
References: <D1665A4F.19E17%suravee.suthikulpanit@amd.com>
Message-ID: <5540FB2D.4080905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2015 08:57 AM, Suthikulpanit, Suravee wrote:
> 
> 
> On 4/29/15, 09:47, "Arnd Bergmann" <arnd@arndb.de> wrote:
> 
>> On Wednesday 29 April 2015 09:45:43 Suravee Suthikulpanit wrote:
>>> On 04/29/2015 09:03 AM, Arnd Bergmann wrote:
>>>> On Wednesday 29 April 2015 08:44:09 Suravee Suthikulpanit wrote:
>>>>> +                       device->flags.cca_seen = 1;
>>>>> +               } else if (IS_ENABLED(CONFIG_ACPI_MUST_HAVE_CCA)) {
>>>>> +                       /*
>>>>> +                        * Architecture has specified that if the
>>> device
>>>>> +                        * can do DMA, it must have ACPI _CCA object.
>>>>> +                        * Here, there could be two cases:
>>>>> +                        *   1. Not DMA-able device.
>>>>> +                        *   2. DMA-able device, but missing _CCA
>>> object.
>>>>> +                        *
>>>>> +                        * In both cases, we will default to dma
>>> non-coherent.
>>>>> +                        */
>>>>> +                       cca = 0;
>>>>> +               } else {
>>>>> +                       /*
>>>>> +                        * If architecture does not specify that
>>> device must
>>>>> +                        * specify ACPI _CCA (e.g. x86), we default
>>> to use
>>>>> +                        * dma coherent.
>>>>> +                        */
>>>>> +                       cca = 1;
>>>>> +               }
>>>>>
>>>>
>>>> What does it mean here if a device does DMA but is not coherent? Do
>>> you
>>>> have an example of a server that needs this?
>>>>
>>>> Can we please make the default for ARM64 cca=1 as well?
>>>>
>>>>       Arnd
>>>>
>>>
>>> Actually, I am trying to implement the logic for when missing _CCA to
>>> be 
>>> consistent with the behavior when the devicetree entry does not specify
>>> "dma-coherent" property. IIUC, in such case, Linux will default to
>>> using 
>>> non-coherent DMA.
>>
>> Why?
>>
>> 	Arnd
> 
> Otherwise, it would seem inconsistent with what states in the ACPI spec:
>  
>   CCA objects are only relevant for devices that can access CPU-visible
> memory,
>   such as devices that are DMA capable. On ARM based systems, the _CCA
> object 
>   must be supplied all such devices. On Intel platforms, if the _CCA
> object is 
>   not supplied, the OSPM will assume the devices are hardware cache
> coherent.
> 
> From the statement above, I interpreted as if it is not present, it would
> be non-coherent.
> 
> Suravee

A little background to Suravee's statement...

When the spec was being changed for _CCA, it was determined by the ASWG
that there was no reasonable default -- either choice would break something.
Multiple OSs, SoC vendors, and platform vendors were asked.  So, the spec
says for ARMv8, _CCA must be specified when needed and is not assumed to have
any value.  Obviously, any OS can choose to behave differently, but that's
what was specified and why it was specified that way.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
