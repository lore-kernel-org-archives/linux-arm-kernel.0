From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 1 Aug 2016 11:44:20 +0100
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
In-Reply-To: <20160801103024.cc74c093466d7fdfd91a2587@free.fr>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
 <fb559224-561c-3476-1146-96f7aea427f0@arm.com>
 <20160801103024.cc74c093466d7fdfd91a2587@free.fr>
Message-ID: <8b4d1f09-b1ce-5708-f815-29dbd438c2db@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Francois,

On 01/08/16 09:30, Jean-Francois Moine wrote:
> On Mon, 1 Aug 2016 02:43:06 +0100
> Andr? Przywara <andre.przywara@arm.com> wrote:
> 
>> As this became quite a long read, here a TL;DR:
>> - We consider using an SCPI based clock system for the A64, alongside
>> allwinner,simple-gates and fixed clocks. We try to avoid any Allwinner
>> specific clocks (apart from the simple-gates).
>> - ARM Trusted Firmware provides the SCPI implementation - for now, later
>> we may move this into a possible arisc firmware.
>> - We upstream some basic DT first, possibly omitting any controversial
>> clock parts at all.
>>
>> Let me know what you think!
> 
> Hi Andr?,
> 
> This looks interesting.
> As I understand, the clock enable/rate setting functions would be in
> the arisc. The arisc firmware would be loaded only once in the Soc and
> would contain the code for handling this specific SoC.
> From my calculations, this would save about 1Mb of clock descriptions
> in the kernel for a universal Allwinner kernel.

This is the rough idea, yes. In the moment the clock code sits in the
ARM Trusted Firmware part, but in fact this is an implementation detail.
Theoretically we could also move that clock code to U-Boot on 32-bit
SoCs to sit next to the PSCI implementation, which uses the same smc
call mechanism as I do in this first implementation.
But unfortunately we cannot remove the existing code from the kernel,
since that would break all existing users (unless they upgrade their
firmware). So I am not sure if supporting older SoCs with this mechanism
is worthwhile.

But: yes, I want to avoid adding tedious clock descriptions for each and
every new SoC to the kernel. What really worries me is that sunxi-ng
makes this situation probably worse, as we now have to add SoC specific
"code" (in fact: clock descriptions) for every SoC, even if that chip
doesn't introduce any new clock type.

> But I don't see why you are keeping the simple-gates. The bus gate may
> be ungated/gated when the clock is enabled/disabled, and that's what
> Allwinner's software does.

We could do. But SCPI does not have an explicit enable/disable
interface, it only describes that setting the frequency to 0 disables
the clock. For enabling it one would have to set some frequency (!= 0),
which the firmware could then translate into a "set that bit in the gate
register" for any gate-only clock, which sounds rather hackish to me.
Also it would require to alter the SCPI clock driver to implement the
enable/disable ops, since I think we never call set_rate for those clocks.

So having the quite straight forward "simple-gates" driver around seems
more sane. In the end this driver just translates "clock number x" into
"bit number x" in that register, which is very generic. That's why I
urged to introduce a fallback compatible name to express this very feature.

Cheers,
Andre.
