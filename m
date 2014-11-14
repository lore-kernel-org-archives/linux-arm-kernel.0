From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 12:03:46 +0100
Subject: [PATCH v2 13/14] ARM: STi: DT: STiH410: Add usb2 picophy dt nodes
In-Reply-To: <20141114095621.GA1648@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1415876417-28728-1-git-send-email-peter.griffin@linaro.org>
 <2401196.5cvW5dPSz2@wuerfel>
 <20141114095621.GA1648@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <1546892.RCPeXgVQNJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 09:56:21 Peter Griffin wrote:
> 
> I'll appologize in advance as I'm not sure I've understood you correctly, definately your answer
> has given me a bunch more questions to clarify my understanding...
> 
> In the case of this particular node, then both reg properties refer to the syscfg_core address space
> as both <0xf8 0x04> and <0xf4 0x04> are offsets into syscfg_core registers. So moving it under
> the syscfg_core like you originaly suggested I believe would meet the definition of 'reg' ("describes the
> address of the device's resources within the address space defined by its parent bus").

You will also have to add an appropriate 'ranges' property then.

> Or maybe you meant, if I want to keep the picophy node where it is (under soc), I need to stop using the reg
> property?

That would also be possible, just put the register numbers into your 'st,syscfg'
property after the phandle, and leave the reg property empty then.

> The other problem I was describing is a device with some memory mapped registers and some
> sysconfig registers you can find examples already upstream in stih416.dtsi file with the
> ethernet0 and miphy365x_phy nodes.
> 
> Here the first 1/2 reg properties are expressed as a 32 bit physical address and size (meets the spec definition),
> and the last is expressed as a sysconfig offset and size (which AFAIK doesn't match the spec definition).
> This change in address space is however documented in the bindings documentation.
> 
> How should devices which have multiple address spaces ideally be handled?

There should at most be one 'reg' address space, so put it under the node whose
bus these refer to. Put all offsets that are relative to a syscon link into
the phandle that refers to the syscon device, or hardcode the offsets in the
driver.

> From looking around in the source I see a few different ways people have done this: -
> 
> 1) Some drivers encode the data statically into the source and make a decision based on compatible string.
> 2) Some drivers add a couple of extra dt properties to encode the offset (spifsm in stih416)
> 3) Some drivers mix address spaces in the reg properties (examples given above) 
> 3) Probably some other ways I've not found yet
>
> Is there a blessed way of doing this? It would be nice at least for all the drivers in STI to be doing
> it the same as currently there seems to be a mix of implementations.

You can do 1 or 2, not 3.

	Arnd
