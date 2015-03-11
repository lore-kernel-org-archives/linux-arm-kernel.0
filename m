From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 11 Mar 2015 10:57:56 -0500
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <CAJAp7OiVwvPjRbrBxw7Dndvk4Apwz_bx=CzSqeqd3JzYhmB7Kw@mail.gmail.com>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <CAOesGMjJXyjNH-Lm66mZXq0X=52DyRtdmpvQ4sFEr0cMAp3b-w@mail.gmail.com>
 <3A588B25-66ED-4BB5-8C8F-D050D8A2F9F3@codeaurora.org>
 <10886228.vUHyKm1ubP@wuerfel>
 <7DA73171-01A5-4158-9A69-015B62D2D7E8@codeaurora.org>
 <CAJAp7OiVwvPjRbrBxw7Dndvk4Apwz_bx=CzSqeqd3JzYhmB7Kw@mail.gmail.com>
Message-ID: <D86EB9D2-8F0B-4B43-9E07-2811ED88C648@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 11, 2015, at 10:33 AM, Bjorn Andersson <bjorn@kryo.se> wrote:

> On Tue, Mar 10, 2015 at 12:57 PM, Kumar Gala <galak@codeaurora.org> wrote:
>> 
>> On Mar 10, 2015, at 2:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> 
>>> On Tuesday 10 March 2015 13:10:08 Kumar Gala wrote:
>>>>>>>>>>>>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>>>>>>>>>>>>>> on Qualcomm MSM platforms to determine which device tree should be
>>>>>>>>>>>>>> utilized and passed to the kernel.
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>> Cc: <devicetree@vger.kernel.org>
>>>>>>>>>>>>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>>>>>>>>>>>> 
>>>>>>>>>>>>> Is this the special magic that allows qcom bootloaders to take a kernel
>>>>>>>>>>>>> plus multiple DTBs and figure out which DTB to pass?
>>>>>>>>>>>>> 
>>>>>>>>>>>>> Kevin
>>>>>>>>>>>> 
>>>>>>>>>>>> yes
>>>>>>>>>>> 
>>>>>>>>>>> That's a bummer.
>>>>>>>>>>> 
>>>>>>>>>>> Luckily, the solution for upstream is still quite simple: Provide only
>>>>>>>>>>> one devicetree, and it'll be used, right?
>>>>>>>>>> 
>>>>>>>>>> We can provide only one, we still need the IDs in the DT.
>>>>>>>>> 
>>>>>>>>> How are the DTS provided? Concatenated with the kernel, or in a
>>>>>>>>> wrapped data format? Or in a separate partition from the kernel?
>>>>>>>> 
>>>>>>>> Its a wrapped data format that is than concatenated with the kernel if I remember correctly.
>>>>>>> 
>>>>>>> Then you should be able to create a tool that can write this concatenated
>>>>>>> format and insert these properties from a table that matches the boot
>>>>>>> loader, right?
>>>>>>> 
>>>>>>>    Arnd
>>>>>> 
>>>>>> Are you suggesting the tool insert the properties in the DT?  I?m not sure I understand what the point of doing that would be.
>>>>> 
>>>>> To insert platform-local properties that mean nothing outside of the
>>>>> firmware packaging of the device trees, which is the case here?
>>>>> 
>>>>> I think the idea of having the installer script inserting them is
>>>>> quite reasonable in this case.
>>>>> 
>>>>> 
>>>>> -Olof
>>>> 
>>>> These values are static, so not sure what the point of having the installer script do that?
>>>> 
>>> 
>>> It combines two hacks to work around a nonstandard boot loader.
>>> Once the bootloader is fixed, you can stop using that script.
>>> 
>>>      Arnd
>> 
>> I feel as if I?m missing something here.  If we just have the properties in the .dts files I don?t need to change anything ever, no script, no worries about working with old or new boot loaders, etc.
>> 
> 
> But are these values actually used by the boot loader?
> 
> As far as I could see in 8974 the dtbTool provided by Qualcomm
> extracts the values from the list of dtbs and use them to create the
> table-of-content in the QCDT blob. The boot loader then looks in this
> TOC to pick the right dtb to use.

Are you asking do we utilize the values out of the DT directly?  If so, no.  You are correct that the tool pulls them out.  This is all about where we keep the information that associates a given DTB with its MSM-ID/BOARD-ID values.  While we can move that info into a tool, it just means updating the tool constantly to map an compatible string to those values.  The other means is keeping the values with the DTB as properties as this binding suggests.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
