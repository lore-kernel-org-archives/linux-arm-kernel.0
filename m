From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 18 Apr 2016 10:47:03 -0700
Subject: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
In-Reply-To: <5420659.scnjID7ZLn@wuerfel>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
 <79DC79A7-D4CE-4983-B1C5-CBD2E9CBBFB9@gmail.com> <5420659.scnjID7ZLn@wuerfel>
Message-ID: <ae624772-9306-50ee-3dc1-df8156eaa16d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/17/2016 7:02 AM, Arnd Bergmann wrote:
> On Sunday 10 April 2016 18:43:52 Florian Fainelli wrote:
>>> +#ifdef CONFIG_ARM
>>> +static int iproc_pcie_abort_handler(unsigned long addr, unsigned int
>>> fsr,
>>> +                                  struct pt_regs *regs)
>>> +{
>>> +      if (fsr == 0x1406)
>>> +              return 0;
>>> +
>>> +      return 1;
>>
>> As you later noted this prevents this driver from being a module now. Since the expectation is that either a fixed bootloader or a platform should enot produce these data aborts, or allow them to be ignored, why not just put this code back where it belongs in the machine specific file which kills many birds with the same stone:
>>
>> - code is ways built-in, and hook_fault_code is installed prior to PCIe loading (function is marked with __init)
>> - platforms which do not need that, just do not install it for that specific code
>> - it is clear which platforms need it and which do not, yet the driver remains agnostic
>>
>> NB: there could be other platforms some day needing that which also propagate the error differently, forcing you to add more and more of these codes in the PCIe driver.
>>
>
> I think ideally the driver should be able to access some of its internal
> registers to figure out what really happened, but the handler above doesn't
> do that, it just silently ignores *any* errors based on the fsr.
>
> Could one of you check the datasheets for the iproc PCI hardware to
> see if there are any error handling registers we may want to use to
> further drill down on what went wrong and whether it is safe to ignore
> the CPU fault?

I'm still trying... I've never worked on NorthStar but I believe the 
PAXB PCIe block in NorthStar is essentially the same (or at least very 
similar) to NSP and Cygnus. I couldn't find any registers from the 
Cygnus datasheet that allows us to either disable this abort or provide 
a mechanism for better error handling (at least there's nothing obvious 
from the datasheet of Cygnus).

I'm trying to contact the ASIC designer of this block and see if I can 
get further information from him.

Thanks,

Ray

>
> 	Arnd
>
