From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 09 Oct 2015 10:01:39 -0700
Subject: [GIT PULL] Broadcom soc changes for v4.4
In-Reply-To: <10665189.Vh1KLFXpVv@wuerfel>
References: <1443824458-20799-1-git-send-email-f.fainelli@gmail.com>
 <1443824458-20799-4-git-send-email-f.fainelli@gmail.com>
 <10665189.Vh1KLFXpVv@wuerfel>
Message-ID: <5617F2F3.1000501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/15 08:46, Arnd Bergmann wrote:
> On Friday 02 October 2015 15:20:58 Florian Fainelli wrote:
>> This pull request contains the following Broadcom SoC platform and driver changes:
>>
>> - Brian Norris create a drivers/soc/brcmstb/ stub and then adds support for S2/S3/S5
>>   suspend/resume modes for the Broadcom BCM7xxx Set Top Box SoCs
> 
> I'm not overly happy with this part of the code (sorry Brian):
> 
> - it looks like it should be a cpuidle driver. Not completely sure about this,
>   but I'd like to see at least an Ack from the cpuidle maintainers to confirm
>   that they want it to be done in drivers/soc

Could you clarify how you think this should be fitting in the cpuidle
framework? This is system-wide S2/S3/S5 states we are talking about
here, and that comes with specific constraints, like moving code from
DRAM execution to SRAM execution for instance, not sure where cpuidle
can help with that. And if it does, how we coordinate with that framework.

> 
> - any code here that is not going into a cpuidle driver for this part looks
>   like it's better suited to go to arch/arm/mach-bcm, as the code doesn't
>   feel like a driver. This is of course a gray area, and can be debated.

There are some large portions of this code that are shared between SoCs,
past, current and future chips, with the exception of the small assembly
part which needs to be architecture specific for obvious reasons.

For instance, the power state machine code is fairly SoC-independant,
and to some extent, the DDR controller code is as well, that is what
motivated putting that code here, so it can be re-used in the future
when we submit support for new chips as well.

> 
> - it's clearly not endian-safe. There really is no reason to use __raw
>   mmio accessors here, or to define the interface to the firmware in terms
>   of native endianess when the registers and firmware is known to be
>   little-endian.

Ok, that one is one me, I should have made sure it was.

> 
> Sorry for not noticing the driver earlier when it was discussed on the list,
> but I think the above is reason enough to do another revision.
> Can you submit a new pull request without the suspend/resume handling?

I can do that, but then I am really expecting someone to take a deep
look at the implementation and make some educated recommendations about
how this should be pieced together to achieve the expected ACPI-like
suspend states.

Thanks
-- 
Florian
