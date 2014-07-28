From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Mon, 28 Jul 2014 10:40:31 -0400
Subject: [RFC 0/8] Audio clocks for sun[457]i, SoC revision detection
In-Reply-To: <20140728124208.GH3952@lukather>
References: <1406519386-4902-1-git-send-email-emilio@elopez.com.ar>
 <20140728124208.GH3952@lukather>
Message-ID: <CAKON4OyXB66ERMwadeLN5pvhcGbCSqCP+=7JLzpHsNLpeELBaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 8:42 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Emilio,
>
> On Mon, Jul 28, 2014 at 12:49:38AM -0300, Emilio L?pez wrote:
>> Hi everyone,
>>
>> This series adds support for PLL2 on A10 rev B and higher, A10S, A13
>> and A20. It also includes support for the codec clock as well as
>> module 1 clocks, used in the audio blocks. There's also two patches
>> fixing sparse warnings on the driver.
>
> And where is the SoC revision detection you were talking about ? :)
>
>> I'm sending this as RFC as this does not support the A10 rev A PLL2
>> clock. It seems from the Allwinner code that rev A has a different
>> register layout, and is programmed with different values. Unfortunately
>> there's no mention of this on the User Manual, so I'm left to guess
>> for the most part.
>
> Do you have any reference pointing this out?
>
>> The clock code is not the only part in where rev A is special cased;
>> there's some register writes just for it on the analog audio driver
>> as well, so we probably need a way to support this in a generic way.
>>
>> So, how should we proceed with this? Here are some ideas:
>>   * Make different device trees with different compatibles. Pros:
>>     not much extra code. Cons: we don't know the SoC revision on
>>     devices and/or they may change during the product lifecycle.
>
> Which makes it a pretty poor solution :)
>
>>   * Use different compatibles and change them on U-Boot. Pros: it
>>     keeps Linux simple. Cons: dependency on a newer bootloader.
>
> Which is a no-go.
>
>>   * Use different compatibles and change them on early boot.
>>     Pros: compatibility with existing bootloaders. Cons: Need
>>     code in Linux to fixup the DT
>
> Plus, we don't need to care about having different DT, and let the
> user indentify which revision it has. I'm very much in favor of this
> solution. And it works for all the boards.
>
>>   * Have a function "int sunxi_soc_revision(void)" that drivers
>>     can use to check which SoC revision they're running on.
>>     Pros: no DT fixup. Cons: ugly and less portable if the driver
>>     ever needs to run on a non-sunxi platform.
>
> Yep.
>
>> I'd like to hear everyone's thoughts on this. From what I've seen
>> around on LAKML, it seems the last option is the one in widest use, but
>> I'd appreciate a confirmation.
>
> Mostly for historical reason I'd say. All the newer platforms seem to
> handle this by fixing up the DT at the early stages.

I thought we were going to do it like this..
http://lxr.free-electrons.com/source/arch/arm/mach-mvebu/board-v7.c#L71

The machine driver for the A10 would check the CPU revision and then
alter the compatible strings as needed to create new ones that encode
the chip revision level.

In this case it would look for  "allwinner,sun4i-a10-codec" and then
add a compatible string like "allwinner,sun4i-a10a-codec" to the front
of the list so that it will be bound first.

>
>> If this is the way forward, where should the code live in? The SoC
>> detection is done by reading a register on the timer block on sun4i,
>> and SID on sun5i.
>
> In mach-sunxi I'd say. I've started working on it a few weeks back, in
> order to use soc-device too, but it's pretty much wip for now.
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com



-- 
Jon Smirl
jonsmirl at gmail.com
