From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 10:15:12 -0600
Subject: [PATCH v2] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <5211FE21.4030707@arm.com>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <1376673599-3967-1-git-send-email-punit.agrawal@arm.com>
 <520E701D.6040006@wwwdotorg.org> <5211FE21.4030707@arm.com>
Message-ID: <52124490.9070205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 05:14 AM, Punit Agrawal wrote:
> Hi Stephen,
> 
> Thanks for the helpful comments.
> 
> On 16/08/13 19:31, Stephen Warren wrote:
>> On 08/16/2013 11:19 AM, Punit Agrawal wrote:
>>> The CCI PMU can profile bus transactions at the master and slave
>>> interfaces of the CCI. The PMU can be used to observe an aggregated view
>>> of the bus traffic between the various components connected to the CCI.
>>>
>>> Extend the existing CCI driver to support the PMU by registering a perf
>>> backend for it.
>>
>> I think this binding addresses my comments, thanks. Just one comment
>> below:
>>
>>> diff --git a/Documentation/devicetree/bindings/arm/cci.txt
>>> b/Documentation/devicetree/bindings/arm/cci.txt
>>
>>> +        - reg:
>>> +            Usage: required
>>> +            Value type: <prop-encoded-array>
>>
>>> +        - interrupts:
>>> +            Usage: required
>>> +            Value type: <prop-encoded-array>
>>
>> That makes it sound like the layout/content of those two properties is
>> the same. That's not true; one is an array of (base, size) cells, and
>> the other is of (phandle, args*) cells. The difference between the data
>> being phandles-vs-integers seems important.
>>
>> Perhaps says:
>>
>> Value type: Integer cells. Array of register entries, each expressed as
>> a pair of cells, containing base and size.
>>
>> Value type: Integer cells. Array of interrupt specifier entries, as
>> defined in ../interrupt-controller/interupts.txt.
>>
> 
> This is indeed better. I've updated the documentation for "interrupts"
> but am not sure about changing the "reg" property. The description used
> here is similar to other "reg" property description in the same file
> used for other CCI sub-nodes. Do you think this is sufficiently
> important clarification to change the other instances as well?

Well, you may as well make all the descriptions consistent since you've
explicitly attempted to describe the format of each property rather than
just using the rather inexact text that's usually used.

Hopefully when we have a DT schema and bindings can inherit from
each-other, only one single binding schema will actually have to specify
the format of reg, and others will simply define how many entries to the
property requires.
