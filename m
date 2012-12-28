From: robherring2@gmail.com (Rob Herring)
Date: Fri, 28 Dec 2012 10:14:02 -0600
Subject: [PATCH] cpuidle: kirkwood: Move out of mach directory, add DT.
In-Reply-To: <20121228154927.GC5172@lunn.ch>
References: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
 <50DDAA42.2020101@gmail.com> <20121228143517.GA5172@lunn.ch>
 <50DDB2E3.103@gmail.com> <20121228154927.GC5172@lunn.ch>
Message-ID: <50DDC54A.3020509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/2012 09:49 AM, Andrew Lunn wrote:
> On Fri, Dec 28, 2012 at 08:55:31AM -0600, Rob Herring wrote:
>> On 12/28/2012 08:35 AM, Andrew Lunn wrote:
>>> On Fri, Dec 28, 2012 at 08:18:42AM -0600, Rob Herring wrote:
>>>> On 12/28/2012 06:47 AM, Andrew Lunn wrote:
>>>>> Move the Kirkwood cpuidle driver out of arch/arm/mach-kirkwood and
>>>>> into drivers/cpuidle. Convert the driver into a platform driver and
>>>>> add a device tree binding. Add a DT node to instantiate the driver for
>>>>> boards converted to DT, and a platform data for old style boards.
>>>>
>>>> Is this an old comment? I don't see any platform data.
>>>
>>> There is no platform data, since all the driver needs is an address of
>>> the DDR control register. The code to create a platform device entry
>>> is in common.c hunk.
>>
>> So you should say "a platform device for old style boards".
> 
> Hi Rob
> 
> O.K. I will change it.
>  
>>>>> +		cpuidle at 1418 {
>>>>> +			compatible = "marvell,kirkwood-cpuidle";
>>>>> +			reg = <0x1418 0x4>;
>>>>> +		};
>>>>> +
>>>>
>>>> This is describing what linux wants, not the hardware. This is a common
>>>> problem with cpuidle drivers in that they use shared registers. I don't
>>>> have a good solution, but this doesn't belong in DTS.
>>>
>>> Do you have a bad solution?
>>
>> Ha! :) I should say I don't have a clear, obvious solution.
>>
>> Don't do a platform driver and just check the machine compatible
>> property which is what I did for highbank.
> 
> Yes, i've seen your cpuidle-calxeda.c. I can follow that model, but i
> still somehow need the address of the SDRAM controller "Operation
> Register".
> 
>> Have the machine code create
>> the platform device. Not *all* platform devices have to be created based
>> on the DTB. Create an MFD driver for the whole block of registers.
> 
> The block of registers is for controlling the SDRAM. Its not really a
> MFD. The cpuidle code is putting the SDRAM controller into self
> refresh mode and then doing a WFI.

It is multi-function in the sense that multiple subsystems needing to
access shared registers. If you have ECC, then you would need to give
EDAC subsystem access to ECC related registers.

>>
>>> I could just hard code the address, since its the same for all
>>> kirkwood SoCs. Also, the register is not being used by any other
>>> code on kirkwood, so its not shared.
>>
>> Then describe it based on the reference manual, but you need to do so
>> assuming you are using all the other registers. I assume there are other
>> registers at say 0x1414 or 0x141c. You have to be careful if you create
>> separate nodes for each register or sub-group of registers. It needs to
>> work no matter what the OS expectation is.
> 
> I don't understand what you are try to explain here. It makes little
> sense for the cpuidle driver to take all the SDRAM control registers.

Exactly. The same is true of the dts. It makes little sense to describe
only 1 register of a h/w block. Perhaps the memory controller subsystem
(drivers/memory) can be expanded to include self-refresh functions.
Entering self-refresh can be tricky, so it might not really be possible
to define a common api here.

Rob

> Thanks
> 
> 	Andrew
> 
