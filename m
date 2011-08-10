From: rob.herring@calxeda.com (Rob Herring)
Date: Wed, 10 Aug 2011 09:31:54 -0500
Subject: Subject: L2x0 OF properties do not include interrupt #
In-Reply-To: <201108101609.56995.arnd@arndb.de>
References: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
	<201108101609.56995.arnd@arndb.de>
Message-ID: <4E42965A.9010500@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 08/10/2011 09:09 AM, Arnd Bergmann wrote:
> On Wednesday 10 August 2011, Mark Rutland wrote:
> 
>> I realise I'm a bit late to the party here, but I'd like to propose adding an
>> optional interrupt parameter to the binding. I'm not aware of any
>> implementations which use separate interrupts, but given the binding
>> seems to be generic across L2CC implementations (and is not limited simply to
>> the L2x0), having a list rather than a single interrupt may be appropriate for
>> someone.
> 
> Sounds good, thanks for pointing this out.
> 
> How many possible interrupt sources are there? If there is only a small number
> of those (e.g. at most 4), we might just list all of them and register
> them from the driver even if they are all the same.
> 

Here's all the interrupts on the PL310:

DECERRINTR Decode error received on master ports from L3
SLVERRINTR Slave error received on master ports from L3
ERRRDINTR Error on L2 data RAM read
ERRRTINTR Error on L2 tag RAM read
ERRWDINTR Error on L2 data RAM write
ERRWTINTR Error on L2 tag RAM write
PARRDINTR Parity error on L2 data RAM read
PARRTINTR Parity error on L2 tag RAM read
ECNTRINTR Event Counter Overflow/Increment
L2CCINTR L2CC Combined Interrupt Output

It's likely that you would want to split these to different drivers.
EDAC for parity/bus errors and hw-events for event counters, for example.

Rob

>> This would boil down to (for the moment) a Documentation change along the lines of:
>>
>>> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
>>> index f50e021..d4b387b 100644
>>> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
>>> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
>>> @@ -28,6 +28,7 @@ Optional properties:
>>>  - arm,filter-ranges : <start length> Starting address and length of window to
>>>    filter. Addresses in the filter window are directed to the M1 port. Other
>>>    addresses will go to the M0 port.
>>> +- interrupt : A combined interrupt.
>>>  
>>>  Example:
>>>  
>>> @@ -39,4 +40,5 @@ L2: cache-controller {
>>>          arm,filter-latency = <0x80000000 0x8000000>;
>>>          cache-unified;
>>>          cache-level = <2>;
>>> +        interrupt = <45>;
>>>  };
>>
>> Any thoughts?
> 
> Do we also need to document an interrupt-parent property, or is that implied?
> 
> 	Arnd
