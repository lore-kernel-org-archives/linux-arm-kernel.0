From: wmb@firmworks.com (Mitch Bradley)
Date: Tue, 05 Jun 2012 19:22:39 -1000
Subject: [PATCH v2 8/9] ARM: dts: refresh dts file for arch mmp
In-Reply-To: <CAN1soZykbTFGk=qAmzDe2qyQVVYBJpxcPYh6OzWyPxiBacJ-mg@mail.gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
 <1336134626-12262-9-git-send-email-haojian.zhuang@gmail.com>
 <87d35ezkm1.fsf@laptop.org> <201206060128.28167.arnd@arndb.de>
 <4FCEB694.8080904@firmworks.com>
 <CAN1soZykbTFGk=qAmzDe2qyQVVYBJpxcPYh6OzWyPxiBacJ-mg@mail.gmail.com>
Message-ID: <4FCEE91F.1030308@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/5/2012 4:35 PM, Haojian Zhuang wrote:
> On Wed, Jun 6, 2012 at 9:47 AM, Mitch Bradley<wmb@firmworks.com>  wrote:
>> On 6/5/2012 3:28 PM, Arnd Bergmann wrote:
>>>
>>> On Tuesday 05 June 2012, Chris Ball wrote:
>>>>
>>>> Hi Haojian,
>>>>
>>>> On Fri, May 04 2012, Haojian Zhuang wrote:
>>>>>
>>>>> Append mmp2 and pxa910 dts files. Update PXA168 dts files for irq,
>>>>> timer, gpio components.
>>>>
>>>>
>>>> The patch I'm replying to introduced a device tree for MMP2/Brownstone
>>>> in 3.5-rc1.  We're looking at adopting the MMP2 device tree for the OLPC
>>>> XO-1.75 board, and Mitch Bradley has some corrections to the device tree
>>>> format that we'd like to make, appended below.
>>>>
>>>> You can see all of the files Mitch mentions at:
>>>> http://dev.laptop.org/~wmb/mmp2-devicetree/
>>>>
>>>> Here's my proposal for what to do next:
>>>>   * First, you choose one of the two forms that Mitch links to.
>>>>     (Either "mmp2.dtsi" or "mmp2-flat.dtsi"; we have a weak preference
>>>>     for mmp2-flat.dtsi.)
>>>
>>>
>>> My preference would be towards mmp2.dtsi. I've recommended doing it
>>> that way to other people, too.
>>
>> In most cases, I have found that exposing the full hierarchy is preferable.
>>   For this specific SoC, which I have been working with for quite awhile now,
>> I haven't found any instance where exposing the AXI/APB levels buys you
>> anything.  The hierarchy just adds clutter.
>>
>> That said, I don't feel strongly about it.
>>
> mmp2-brownstone.dts is too complex since both apb&  axi are imported.
> Could we only use flat structure in mmp2-brownstone.dts?

See http://dev.laptop.org/~wmb/mmp2-devicetree/mmp2-brownstone-flat.dts 
<http://dev.laptop.org/%7Ewmb/mmp2-devicetree/mmp2-brownstone-flat.dts>
>
>
>>
>>>
>>>
>>>> d) Moved the "intcmux" nodes down a level so they are children of the
>>>> top-level interrupt-controller node.  The problem with having them as
>>>> peers of the top-level interrupt-controller is that their "reg"
>>>> properties conflict.  For example:
>>>> intcmux4 at d4282150 { ... reg =<0x150 0x4>,<0x168 0x4>    ... }
>>>>
>>>> This is incorrect in several ways:
>>>>
>>>>     1) "@d4282150" is inconsistent with "reg =<0x150" .  The "unit
>>>>        address" after @ is supposed to be the same as the first component
>>>>        of the reg property.  d4282150 is not identical to 150.
>>>
>>>
>>> I thought the rule was that the @... part should be a translated address
>>> in the presence of "ranges" translation so we get a unique value in case
>>> we have multiple devices of the same name on the same address but on
>>> different buses.
>>>
>>> If we change this here, I suppose it also needs to be changed in a number
>>> of other places, and we have to rethink the method for unique device
>>> names.
>>
>>
>> My thinking was that "ranges" is inappropriate in this case (within the
>> top-level interrupt controller node), and I got rid of it.  That being the
>> case, this is not "in the presence of ranges".
>>
>>
>>>
>>>
>>>> The solution is to put the intcmux nodes underneath the
>>>> interrupt-controller node.  The interrupt-controller node now has
>>>> #address-cells and #size-cells properties so it can have children, but
>>>> it does not have a ranges property, so the address space is not passed
>>>> through.  The child (intcmux) reg addresses can then be interpreted
>>>> independently, without conflict.
>>>
>>>
>>> Right. The implication for this however is that the driver cannot
>>> treat the reg property as a physical address it can do ioremap on,
>>> but needs to interface with the driver that provides the address
>>> space.
>>
>>
>> Indeed.  For this driver, the intcmux subnodes are handled by the same
>> driver as the top-level interrupt controller, and those subordinate
>> registers are accessed via that driver's one mapping of the register block.
>>
> Mitch,
>
> Did you test cascade intcmux in DTS? I tried it before and got failure. But I
> didn't dig it yet, so I use parallel intc node instead.

Chris and I are testing it now.  It's not working yet, but we have only 
been looking at it for less than one hour.  Perhaps we will make 
progress tomorrow.
>
>
>
