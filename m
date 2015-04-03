From: stefan@agner.ch (Stefan Agner)
Date: Sat, 04 Apr 2015 01:56:20 +0200
Subject: [PATCH v4 07/11] ARM: allow MULTIPLATFORM with !MMU
In-Reply-To: <20150403200931.GD13898@n2100.arm.linux.org.uk>
References: <1428090292-21693-1-git-send-email-stefan@agner.ch>
 <1428090292-21693-8-git-send-email-stefan@agner.ch>
 <20150403200931.GD13898@n2100.arm.linux.org.uk>
Message-ID: <1f84d767d3bb8a8c470a26064cba454e@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-03 22:09, Russell King - ARM Linux wrote:
> On Fri, Apr 03, 2015 at 09:44:48PM +0200, Stefan Agner wrote:
>> In order to support SoC with heterogenous CPU architectures (such
>> as Freescale Vybrid/i.MXSX) it is preferable to use the same
>> architecture (ARCH_MXC in this case) for the MMU enabled and !MMU
>> CPU. Hence allow to select MULTIPLATFORM even without MMU.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/Kconfig | 21 ++++++++++-----------
>>  1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 9f1f09a..636cb3f 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -230,7 +230,7 @@ config VECTORS_BASE
>>  	  in size.
>>
>>  config ARM_PATCH_PHYS_VIRT
>> -	bool "Patch physical to virtual translations at runtime" if EMBEDDED
>> +	bool "Patch physical to virtual translations at runtime" if EMBEDDED || (ARCH_MULTIPLATFORM && MMU)
>>  	default y
> 
> This makes no sense.  Multiplatform MMU _requires_ this feature, so why
> offer it to the user when multiplatform is enabled _and_ MMU is enabled?

I see, this is plain wrong. Will replace that with a select ... if MMU
in multiplatform.

> Patch 7817/1 in the patch system tried doing something like you're trying
> to do here - I wonder whether you've reviewed the mailing list for
> previous discussions.

I did some research at RFC/v1 time and mainly looked into Arnd's git
trees. Most patches just open up !MMU for multiplatform. What I'm trying
to do here is to enable !MMU with multiplatform while keeping the impact
as little as possible, e.g. by making all other platforms in
multiplatform dependent on MMU.

See also
https://www.marc.info/?l=linux-kernel&m=141997848124399&w=2

> Given that it's Easter, I'm not going to re-state what I said last time
> this came up, but instead leave you to do some research.  For example,
> reading message id <20130819232411.GX23006@n2100.arm.linux.org.uk>...

Also looked at some other messages about this topic, but I guess quotes
from the message above will do to discuss this further:
> Now, here's the question: can multiplatform ever work properly on nommu?
> 
> We get multiplatform working on MMU by using the MMU to provide a more
> consistent view of the system.  On noMMU, we don't have that.  So if
> your kernel is built to run assuming that it will be located in ram at
> location X on platform Y, that isn't going to work if platform Z doesn't
> have RAM there.

The platforms I primarily have in mind (heterogeneous multi-processing
SoC's with MMU/!MMU processors) would actually allow such a
multiplatform kernel: i.MX6 SoloX as well as Vybrid have the main memory
in the same location, hence one could build a multiplatform !MMU kernel
for this two devices. Of course, this is possible more by chance. I also
did not tried it yet. I don't have a i.MX6 SoloX device.

> My feeling is that the motivation behind this patch is to avoid an
> amount of yuckyness associated with trying to enable Versatile Express
> support outside of the multiplatform container - it's not really about
> being able to build a single zImage which works on all noMMU platforms.
> So, I don't think this is the right solution to this problem.

I must admit that this was the main motivation for me too. My first
approach was to create a set of completely independent config symbols:
http://marc.info/?l=linux-arm-kernel&m=141756604900611&w=2

However, I'm sure this could be done better and with less config
symbols.

So, if you think it would be worth enabling multiplatform for these
devices (Vybrid/i.MX6 SoloX), I would prepare a patchset which does it
while not converting EFM32 to multiplatform (as patch 08/11 currently
does).

If you think it's also not worth for those devices, I will try to enable
ARCH_MXC/SOC_VF610 with !MMU and !MULTIPLATFORM...

--
Stefan
