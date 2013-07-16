From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 16 Jul 2013 16:09:54 -0400
Subject: [PATCH RFC v2 04/14] ARM: debug: provide 8250 debug uart register
 shift configuration option
In-Reply-To: <20130716192403.GA13150@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
 <E1Uz8FU-00047a-AB@rmk-PC.arm.linux.org.uk> <51E59338.6020102@ti.com>
 <20130716191658.GG24642@n2100.arm.linux.org.uk>
 <20130716192403.GA13150@n2100.arm.linux.org.uk>
Message-ID: <51E5A892.7060309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 July 2013 03:24 PM, Russell King - ARM Linux wrote:
> On Tue, Jul 16, 2013 at 08:16:58PM +0100, Russell King - ARM Linux wrote:
>> On Tue, Jul 16, 2013 at 02:38:48PM -0400, Santosh Shilimkar wrote:
>>> Just a question. Exposing selection choice for UART port
>>> and probably flow control is just fine, but do we need to
>>> really need config entries for SHIFT, PA, VA etc ?
>>
>> Let's look at the original problem.  We have lots of files in
>> arch/arm/include/debug who's sole purpose is to define a pair of base
>> addresses.  Maybe around 500 lines of code doing just that - though
>> much of it is copyright notices (can someone explain to me the point
>> of claiming copyright on four lines of code defining a base address of
>> a UART which is, apart from the addresses themselves, identical with
>> every other damned file?)
>>
>> What this series does is remove many of those files by consolidating
>> much of them into a much denser way to represent all this variability.
>> However, this doesn't really address the root problem, which is that
>> we have all this information in the kernel, which needs to be added
>> to every single time we have a new platform come along no matter what
>> it is.
>>
>> We need to stop that from happening - we need a way for people to tell
>> the kernel where their UART is without having to load the kernel up
>> with lots of platform specific information [*].
>>
>> Also, even without this, the debug menu has become something of a
>> sprawling mess, with various people re-implementing what's already
>> there presumably because they don't look/don't bother to research what
>> support is already there - and is another source of constant additions.
>>
>> So, the idea that every platform gets to somehow put its UART addresses
>> into the kernel image isn't scalable.  Either we end up with lots of
>> defaults in a Kconfig wihch are also prone to merge conflicts, or we
>> end up with lots of files in arch/arm/include/debug defining the base
>> addresses.
>>
>> We need to stop all of these problems from happening before they
>> become a big headache for us - imagine Linus' reaction when our debug
>> menu grows to be the largest Kconfig file in the kernel tree!  Do you
>> want to be there when that happens?  We're the 22nd biggest Kconfig
>> file already at 25K - there's only one debug Kconfig larger and that's
>> the main lib/Kconfig.debug one which has recently been through a cleanup.
>>
>> Therefore, the idea is to provide _generic_ options which people can
>> set according to their platforms needs.  Remember, this is *supposed*
>> to be a developer tool, not a user tool, so asking for addresses and
>> other parameters is perfectly acceptable - just make sure that they're
>> documented in a reasonable place.
> 
> And as if to prove the point, while writing that email, a patch dropped
> into my mailbox:
> 
> "ARM: BCM53XX: initial support for the BCM5301/BCM470X"
> 
> which adds yet another 8250 debug UART where the only difference between
> it and the others are its two base addresses, and in order to do that
> it needs to add 25 or so more lines - 19 lines in a header file and six
> in arch/arm/Kconfig.debug.
> 
> With the solution I'm proposing above, that could be:
> 
> - zero lines if you just set the options via Kconfig
> - one, two or maybe at most three lines if you include it with some
>   documentation file already in the kernel
> 
Fair enough. Sorry I missed the point about providing the LL debug
information with config entries than adding the code. It indeed
doable as long as the information is documented as you said.

Thanks for explaining the goal of the series again.

Regards,
Santosh 
