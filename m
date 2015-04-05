From: stefan@agner.ch (Stefan Agner)
Date: Mon, 06 Apr 2015 00:19:43 +0200
Subject: [PATCH v4 07/11] ARM: allow MULTIPLATFORM with !MMU
In-Reply-To: <20150405161014.GG13898@n2100.arm.linux.org.uk>
References: <1428090292-21693-1-git-send-email-stefan@agner.ch>
 <1428090292-21693-8-git-send-email-stefan@agner.ch>
 <20150403200931.GD13898@n2100.arm.linux.org.uk>
 <1f84d767d3bb8a8c470a26064cba454e@agner.ch>
 <20150405161014.GG13898@n2100.arm.linux.org.uk>
Message-ID: <24394c50bcd8000c21aca0360fd20b6f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-05 18:10, Russell King - ARM Linux wrote:
> On Sat, Apr 04, 2015 at 01:56:20AM +0200, Stefan Agner wrote:
>> On 2015-04-03 22:09, Russell King - ARM Linux wrote:
>> > On Fri, Apr 03, 2015 at 09:44:48PM +0200, Stefan Agner wrote:
>> >> In order to support SoC with heterogenous CPU architectures (such
>> >> as Freescale Vybrid/i.MXSX) it is preferable to use the same
>> >> architecture (ARCH_MXC in this case) for the MMU enabled and !MMU
>> >> CPU. Hence allow to select MULTIPLATFORM even without MMU.
>> >>
>> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> >> ---
>> >>  arch/arm/Kconfig | 21 ++++++++++-----------
>> >>  1 file changed, 10 insertions(+), 11 deletions(-)
>> >>
>> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> >> index 9f1f09a..636cb3f 100644
>> >> --- a/arch/arm/Kconfig
>> >> +++ b/arch/arm/Kconfig
>> >> @@ -230,7 +230,7 @@ config VECTORS_BASE
>> >>  	  in size.
>> >>
>> >>  config ARM_PATCH_PHYS_VIRT
>> >> -	bool "Patch physical to virtual translations at runtime" if EMBEDDED
>> >> +	bool "Patch physical to virtual translations at runtime" if EMBEDDED || (ARCH_MULTIPLATFORM && MMU)
>> >>  	default y
>> >
>> > This makes no sense.  Multiplatform MMU _requires_ this feature, so why
>> > offer it to the user when multiplatform is enabled _and_ MMU is enabled?
>>
>> I see, this is plain wrong. Will replace that with a select ... if MMU
>> in multiplatform.
> 
> I think what I'd like to see is, in the top level choice:
> 
> config ARM_SINGLE_ARMV7M
> 	bool "ARM architecture v7M compliant (Cortex-M0/M3/M4) SoC"
> 	depends on !MMU
> 	select ARM_NVIC
> 	... etc ...

I guess that would be ARCH_SINGLE_ARMV7M?

> 
> which then allows a /multiplatform/ v7M kernel to be built, allowing the
> selection of EFM32, SOC_VF610, and any other v7M compliant SoC.

In my view, that wouldn't end up being much different than what that
patchset is doing:
With the introduction of ARCH_MULTI_V7M, we add something like a top
level v7M compliant selection. Due to the !MMU dependencies of all other
CPU families the family selection is minimal (when selecting !MMU):

    *** CPU Core family selection *** 
[*] ARMv7-M based platforms (Cortex-M)

And since ARCH_MULTI_V7M is not part of ARCH_MULTI_V6_V7 or anything,
the whole SoC selection contains only sensible SoC's without further
changes (also within the i.MX family, currently only "Vybrid Family
VF610 support" is selectable):

[ ] MMU-based Paged Memory Management Support                       
    ARM system type (Allow multiple platforms to be selected)  ---> 
    Multiple platform selection  --->                               
[*] Energy Micro efm32                                              
[*] Freescale i.MX family  --->    
    *** Processor Type ***
...

> So, it's very similar to multiplatform in the sense that several SoCs
> can be built together, but we preserve the need not to build
> incompatible stuff together.

As far as I can tell, this is already the case with that patchset.

The differences boil down to on which level we split the v7M CPU
selection apart: On ARCH_* level or ARCH_MULTI_* level. Given that we
allow a multiplatform _v7M kernel, the latter sounds more natural to
me...

Are there arguments to split v7M CPU selection apart on ARCH_* level
which I don't see?

--
Stefan
