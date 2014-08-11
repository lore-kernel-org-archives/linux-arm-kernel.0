From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 11 Aug 2014 17:42:33 +0200
Subject: Building kernel for more than one SoC
In-Reply-To: <20140804201712.GK30282@n2100.arm.linux.org.uk>
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140804201712.GK30282@n2100.arm.linux.org.uk>
Message-ID: <53E8E469.9050807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2014 22:17, Russell King - ARM Linux :
> On Thu, Jul 31, 2014 at 01:59:36PM +0000, Grant Edwards wrote:
>> I'm told that it should be possible to build a kernel that will run on
>> two different SoC chips.  They're closely related (same ARM9 core,
>> many identical internal peripherals -- AT91SAM9G20 and 'G25), and
>> would likely have identical external hardware.
>>
>> In order to handle the internal periphals that differ, it was
>> recommended that I use loadable modules to keep the kernel size small.
>> However, my root filesystem is in RAM, so I don't see how loadable
>> modules helps unless I remove all of the .ko files from the root
>> filesystem after the kernel has booted.
> 
> I think whoever made that recommendation probably isn't aware of the
> direction that mainline kernels are heading.
> 
> Where we're going with mainline kernels is to have a set of drivers
> which work irrespective of the hardware you have.
> 
> We've actually had this policy for about the last decade - we've
> supported building the same family of SoCs into one single kernel
> (identified by their mach-* directory) and expecting that their
> drivers will cope with the differences between the SoCs at runtime.
> (Note that the CPU itself has never really come into it; we've had
> good abstractions for the CPU support since the late 90's, with the
> exception of a borderline between the ARMv5 and ARMv6 architectures.)
> 
> Whether the Atmel code does that or not, I don't know, but it _should_
> do it.

Absolutely, we do follow this policy for quite some time. So anything
that prevents what Russell describes above should be considered as a bug ;-)

> Over the last few years, we've been moving mainline towards even
> tighter integration, where it's possible to build completely
> dissimilar SoCs together, so ultimately we end up with: legacy kernels,
> one multi-platform ARMv5 and earlier kernel, and one multi-platform
> ARMv6 and later kernel.

We are almost at the point where we can have a multi-platform ARMv6/7
for sama5 SoCs and ARMv5 for our ARM9s.

>> It seems it would be simpler to just link in all required drivers for
>> both chips and discard the ones that aren't needed after kernel
>> initialization.
> 
> Even better is to abstract the differences and have the same driver
> code deal with the different variants internally - the selection of
> which variant being controlled via the device tree "compatible"
> property, or another appropriate method.

Sure. Everything in at91 is converted to device tree those days.

Best regards,
-- 
Nicolas Ferre
