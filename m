From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 05 Dec 2014 11:30:10 +0000
Subject: [PATCH v3 0/3] SoCFPGA: L3 NIC driver
In-Reply-To: <20141204183730.GB11889@leverpostej>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
 <14512010.yFXFS4V07x@wuerfel> <20141130205331.GR20688@pengutronix.de>
 <2134330.94UNhqfuFY@wuerfel> <20141204183730.GB11889@leverpostej>
Message-ID: <54819742.3000009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 04/12/14 18:37, Mark Rutland wrote:
> On Thu, Dec 04, 2014 at 04:30:58PM +0000, Arnd Bergmann wrote:
>> On Sunday 30 November 2014 21:53:31 Robert Schwebel wrote:
>>> On Sun, Nov 30, 2014 at 12:51:58PM +0100, Arnd Bergmann wrote:
>>>>> This series adds support for the SoCFPGA L3 NIC. As the memory range has
>>>>> a lot of holes, where you can not read from, syscon can not be used for
>>>>> this IP core. Instead add a new driver, that knows about all the allowed
>>>>> ranges and guards the access via regmap.
>>>>
>>>> What is an L3 NIC?
>>>
>>> Fron the SoCFPGA manual:
>>>
>>> "
>>> The hard processor system (HPS) level 3 (L3) interconnect and level 4
>>> (L4) peripheral buses are implemented with the ARM CoreLinkTM Network
>>> Interconnect (NIC-301). The NIC-301 provides a foundation for a
>>> high-performance HPS interconnect based on the ARM Advanced
>>> Microcontroller Bus Architecture (AMBA) Advanced eXtensible Interface
>>> (AXI), Advanced High-Performance Bus (AHBTM), and Advanced Peripheral
>>> Bus (APBTM) protocols. The L3 interconnect implements a multilayer,
>>> nonblocking architecture that supports multiple simultaneous
>>> transactions between masters and slaves, including the Cortex-A9
>>> microprocessor unit (MPU) subsystem. The interconnect provides five
>>> independent L4 buses to access control and status registers (CSRs) of
>>> peripherals, managers, and memory controllers Related Information
>>> http://infocenter.arm.com/ Additional information is available in the
>>> AMBA Network Interconnect (NIC-301) Technical Reference Manual, revision
>>> r2p3, which you can download from the ARM info center website.
>>
>> Please put something like this in the introductory mail and later
>> into the pull request then. If the l3-nic is an ARM nic-301, shouldn't
>> the compatible string be "arm,nic-301"?

A common binding like that might work for earlier NIC301 revisions which 
were a fairly straightforward N-masters-to-M-slaves IP block. NIC301r2 
(and NIC400 after it) is a rather different beast which is massively 
configurable and allows manually wiring together various master and 
slave ports with switches, register blocks, etc. willy-nilly like some 
kind of RTL Lego set. Given that, bindings for individual 
implementations make a lot more sense than first appears.

>
> We should also treat the device as a bus, with it's child devices as
> nodes underneath it (rather than a block on the side referred to by
> phandle).

At the risk of reigniting the big hairy topology discussion, a "single" 
NIC of this flavour can have multiple unconnected paths through it (as 
sounds like may be the case here), with the master ports having entirely 
unrelated address maps, so from Linux's point of view it could look like 
several different buses which just happen to share a power domain. Add 
to that the fun possibility of things like having GPV registers only 
visible on one "bus" but controlling remapping of another "bus", and I 
think implementation-specific bindings are probably the only way for us 
to stay remotely sane.

[Disclaimer: this comes from working on the end-user configuration tool, 
so I know more about that than the hardware itself]

Robin.
