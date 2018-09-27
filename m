From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 27 Sep 2018 14:49:04 +0300
Subject: [RESEND PATCHv2 1/2] ARM: dts: ti: add support for building Texas
 Instruments specific overlays
In-Reply-To: <CAMuHMdUeTjR6cDuYj_5mwHK8dexn4fXxX1yMHDhdOxHhh3d5-w@mail.gmail.com>
References: <1535722107-13767-1-git-send-email-t-kristo@ti.com>
 <1536049651-10206-1-git-send-email-t-kristo@ti.com>
 <1536049651-10206-2-git-send-email-t-kristo@ti.com>
 <ac8227f4-4be3-df90-e2b9-6994b8b62592@gmail.com>
 <CAMuHMdUeTjR6cDuYj_5mwHK8dexn4fXxX1yMHDhdOxHhh3d5-w@mail.gmail.com>
Message-ID: <3ceff403-4e9b-1c18-3023-552856b8de4f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

I think this topic has went stale, but I believe I figured out a way to 
work with overlays at the moment.

Basically involves couple of steps:

1) Save the overlay source files under existing file folders, and use 
the same .dts file type for them as for typical DT source files.
2) Use "make DTC_FLAGS=-@ dtbs" to compile everything, or some variant 
of this (if want to compile single file for example.) Basically need to 
add that DTC_FLAGS build flag only.

So, the question is, is this acceptable approach? Can we start posting 
overlay files for upstream to pick up, with the /plugin/ directive 
within the files, and use .dts as their file type?

All the patches I posted so far just attempted to make the system more 
maintainable (read: more readable for human beings, with the .dt*o file 
types, separated folders for the DTC_FLAGS and everything), but it seems 
it should be possible to live without any of that.

-Tero

On 07/09/18 00:36, Geert Uytterhoeven wrote:
> Hi Frank,
> 
> On Wed, Sep 5, 2018 at 10:54 PM Frank Rowand <frowand.list@gmail.com> wrote:
>> On 09/04/18 01:27, Tero Kristo wrote:
>>> Add support for TI specific DT subdir, along with support for building
>>> DT overlays. Right now, no DT files are specified in this directory,
>>> those are to be added later.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/ti/Makefile
>>> @@ -0,0 +1,9 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +#
>>> +# Make file to build device tree binaries for boards based on
>>> +# Texas Instruments Inc processors
>>> +#
>>> +# Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
>>> +#
>>> +
>>> +DTC_FLAGS += -@
>>>
>>
>> I will nack any attempt to unconditionally compile a devicetree file with the
>> -@ flag (which adds symbols to the resulting .dtb).  The resulting overhead
>> is not acceptable.
>>
>> Adding the symbols must be under the control of the person either creating
>> or using the .dtb.  The way to provide that control is the challenging part.
>>
>> One way would be to configure the compile option via kbuild configuration.
>> There is opposition to this approach because it makes the .dtb dependent
>> on the Linux kernel configuration.  So suggestions of an alternative
>> mechanism would be welcome.
> 
> IMHO that would be quite a "soft" dependency: it's just about adding symbols
> or not. No real dependency on Linux or kernel features.
> 
>> Another _possible_ solution would be to add a dtc_strip tool to the dtc
>> project.  dtc_strip would remove the symbol information from a .dtb,
>> in a manner that is analogous to strip removing debug information from
>> a program file.
> 
> Removing unwanted symbols is indeed easier than adding them to an
> existing DTB.
> 
>> One aspect of unconditionally building a .dtb with symbols, then
>> optionally removing the symbols with dtc_strip is that it seems
>> like a backwards process.  For example, we don't build the kernel
>> with debug symbols then strip the symbols out when we don't want
>> them.  I'll have to mull this over if the dtc_strip method sounds
>> like a good approach to other people.
> 
> That's not a fair comparison: DTB symbols are not debug information,
> but an ABI. It's more akin to exporting kernel symbols to (possible
> out-of-tree) kernel modules, which is controlled by CONFIG_MODULES.
> 
> So a Kconfig symbol to enable it, and a dtc_strip for removing them,
> makes most sense to me.
> 
> BTW, we do run strip on vmlinux ;-)
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
