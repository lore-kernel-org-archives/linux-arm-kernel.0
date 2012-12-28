From: robherring2@gmail.com (Rob Herring)
Date: Fri, 28 Dec 2012 10:59:05 -0600
Subject: [PATCH] cpuidle: kirkwood: Move out of mach directory, add DT.
In-Reply-To: <20121228163815.GD5172@lunn.ch>
References: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
 <50DDAA42.2020101@gmail.com> <20121228143517.GA5172@lunn.ch>
 <50DDB2E3.103@gmail.com> <20121228154927.GC5172@lunn.ch>
 <50DDC54A.3020509@gmail.com> <20121228163815.GD5172@lunn.ch>
Message-ID: <50DDCFD9.6080307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/2012 10:38 AM, Andrew Lunn wrote:
>>> The block of registers is for controlling the SDRAM. Its not really a
>>> MFD. The cpuidle code is putting the SDRAM controller into self
>>> refresh mode and then doing a WFI.
>>
>> It is multi-function in the sense that multiple subsystems needing to
>> access shared registers. If you have ECC, then you would need to give
>> EDAC subsystem access to ECC related registers.
> 
> There is no ECC. Data sheet specifically says its not supported.

That was only an example.

> Currently, there are no other users of the SDRAM controller than
> cpuidle. Linux is not touching the configuration, so i assume early
> boot code in u-boot is setting up the controller.
> 
>>>>> I could just hard code the address, since its the same for all
>>>>> kirkwood SoCs. Also, the register is not being used by any other
>>>>> code on kirkwood, so its not shared.
>>>>
>>>> Then describe it based on the reference manual, but you need to do so
>>>> assuming you are using all the other registers. I assume there are other
>>>> registers at say 0x1414 or 0x141c. You have to be careful if you create
>>>> separate nodes for each register or sub-group of registers. It needs to
>>>> work no matter what the OS expectation is.
>>>
>>> I don't understand what you are try to explain here. It makes little
>>> sense for the cpuidle driver to take all the SDRAM control registers.
>>
>> Exactly. The same is true of the dts. It makes little sense to describe
>> only 1 register of a h/w block. Perhaps the memory controller subsystem
>> (drivers/memory) can be expanded to include self-refresh functions.
>> Entering self-refresh can be tricky, so it might not really be possible
>> to define a common api here.
> 
> For kirkwood it is easy. Poke 0x7 into the register and then WFI.
> 
> However, since there are no other users of the SDRAM controller, it
> seems overkill to implement a drivers/memory driver, or a MFD driver,
> for just one register.
> 
> So maybe i just end up hard coding the register address in the driver?

You could just define the memory controller node and use it directly by
cpuidle for now. If or when you need to support multiple users, then the
kernel can be updated to have some intermediate MFD or memory controller
driver. You just don't want to be changing the DTS when that happens.
Hardcoding it is what we have now, so it's not any worse and would be
acceptable.

Rob

> 
> 	Thanks
> 
> 		Andrew
> 
