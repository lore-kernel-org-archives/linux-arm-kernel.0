From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Apr 2013 09:57:29 -0600
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <20130416104545.GA19837@e102568-lin.cambridge.arm.com>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
 <516C544A.4090107@wwwdotorg.org>
 <20130416104545.GA19837@e102568-lin.cambridge.arm.com>
Message-ID: <516D74E9.9030404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2013 04:45 AM, Lorenzo Pieralisi wrote:
> Thanks Stephen for the review.
> 
> On Mon, Apr 15, 2013 at 08:26:02PM +0100, Stephen Warren wrote:
>> On 04/15/2013 10:13 AM, Lorenzo Pieralisi wrote:
>>> In order to extend the current cpu nodes bindings to newer CPUs
>>> inclusive of AArch64 and to update support for older ARM CPUs this
>>> patch updates device tree documentation for the cpu nodes bindings.
>>>
>>
>>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>>
>>>  http://devicetree.org
>>>  
>>> -For the ARM architecture every CPU node must contain the following properties:
>>> -
>> ...
>>> +with updates for 32-bit and 64-bit ARM systems provided in this document.
>>> +
>>> +In the bindings below:
>>
>> That's a slightly odd change, since it removes the statement that a cpus
>> node must exist, and "in the bindings below" is not idiomatic for DT
>> binding definitions.
> 
> I beg to differ.
> 
> "Bindings for CPU nodes follow the ePAPR standard...."
> 
> ePAPR v1.1
> 
> 3.6 CPUS node properties
> 
> "A cpus node is required for all device trees".

Hmm, OK, I guess that's true. Still, I think this binding was pretty
much complete without having to read that document before wasn't it, yet
now it isn't? I suppose that's OK.

>> Perhaps replace that last list with:
>>
>> The ARM architecture requires the following properties in the cpus and
>> cpu nodes contain the properties described below.
>>
>>> +- square brackets define bitfields, eg reg[7:0] value of the bitfield in
>>> +  the reg property contained in bits 7 down to 0
>>
>> Isn't that standard enough it's not even worth mentioning? If it is,
>> it's certainly not something that should be mentioned in the part of the
>> document that describes which properties are requried.
> 
> It is mentioned before cpus node and cpu node descriptions start.

It's in the list "In the bindings below", which kinda lumps together
some syntax definitions for the text, and the actual semantic
definitions of the node contents.

>>> +	- #address-cells
>>> +		Usage: required
>>
>> "Usage" sounds more like what it's used for. "Presence" seems better to me.
> 
> I have not reinvented the wheel, just had a look at powerPC bindings and
> tried to comply. If "Usage" is not proper we also have to patch a number
> of in-kernel DT bindings and update the ePAPR.

The existing language seems unfortunate. I suppose it makes sense to
follow it since this document is defining a "sub class" of it, but
still, I'd still be tempted just to use the right word.

>>> +	- enable-method
>>> +		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
>>> +		       systems
>>> +		Value type: <string>
>>> +		Definition: On ARM 64-bit systems must be "spin-table" [1].
>>
>> Can that be an integer instead? with dtc+cpp support, that shouldn't
>> hurt the eyes too much any more.
> 
> Mmm, I need to read more on dtc+cpp, I do not think that leaving it
> as a string would hurt though, am I wrong ? Can we assume that all dts
> are preprocessed before being compiled and passed to the kernel ?

It wouldn't hurt too much, but representing enums as strings when
there's a capability to simply represent it as a integer just feels
pretty gross to me.

>>> +[1] ARM Linux kernel documentation
>>> +    Documentation/devicetree/bindings/arm64/booting.txt
>>
>> Is referencing Linux-specific documentation from a supposedly
>> OS-agnostic DT binding definition a good idea?
> 
> Well, an OS-agnostic DT binding definition in the Linux kernel Documentation
> directory.

I think that's mainly a historical "accident". There is perpetual talk
of moving the bindings directory, and even the .dts files I believe, to
a separate repository to make this distinction clear.
