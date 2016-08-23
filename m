From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Aug 2016 21:31:29 +0200
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
In-Reply-To: <fb559224-561c-3476-1146-96f7aea427f0@arm.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
 <fb559224-561c-3476-1146-96f7aea427f0@arm.com>
Message-ID: <20160823193129.GO2598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Aug 01, 2016 at 02:43:06AM +0100, Andr? Przywara wrote:
> Hi Maxime,
> 
> On 26/07/16 21:30, Maxime Ripard wrote:
> > Hi,
> > 
> > Here is the previous A64 patches made by Andre [1], reworked to use
> > the new sunxi-ng clock framework.
> > 
> > This uses the current H3 clock code, as both are really similar. The
> > first patches are just meant to rework slightly the H3 code, before
> > introducing the A64-related patches.
> > 
> > Some WiP stuff have been removed, such as the MMC part, but this serie
> > already has a decent amount of devices supported: uart, i2c, rsb, etc.
> 
> Thanks very much for looking into this and compiling this series!
> 
> In general this looks good to me - apart from the sunxi-ng clock usage.
> I think I have some small fixes to the DT (have to compare against my
> latest local branch), I will comment on this later.
> 
> As I think I never officially expressed my concerns about the new sunxi
> clock system, so I use that opportunity here ;-)
> 
> As this became quite a long read, here a TL;DR:
> - We consider using an SCPI based clock system for the A64, alongside
> allwinner,simple-gates and fixed clocks. We try to avoid any Allwinner
> specific clocks (apart from the simple-gates).
> - ARM Trusted Firmware provides the SCPI implementation - for now, later
> we may move this into a possible arisc firmware.
> - We upstream some basic DT first, possibly omitting any controversial
> clock parts at all.
> 
> Let me know what you think!
> 
> 
> Now the long part ....
> 
> Basically I see those issues with the new clocks:
> - sunxi-ng requires a complicated SoC specific source file in the
> kernel. Although that makes the DT pretty easy (and avoids breaking it
> the future), it ultimately requires an explicit code drop for every new
> SoC, even if they share 95% of the clocks (as H3 and A64 do, for instance).
> - This code file does not actually contain any code, instead it's just
> data and looks like it should really be presented in DT - which brings
> us back to something like the old sunxi clock scheme, which is
> apparently not considered good enough. I still wonder if we could create
> a generic sunxi-ng user, which explains the needed clocks in the DT
> instead of in code. I admit that looks like quite some work.
> - It makes it quite hard for any other DT user (*BSD, U-Boot) to use the
> clocks, since they would have to copy quite verbatim the Linux
> implementation choice. This is admittedly also true for the old clock
> framework, but still unfortunate.

3 - You never get a complete clock support for any SoC, requirining
    for pretty much every driver to create from scratch a new clock
    driver.

4 - You require for all these clocks drivers some Ack from both the DT
    and clocks maintainers, who both said they were fed up with this.

5 - If you realise some day down the road that the parenting
    relationship is not right, or that some clock is not doing what
    you thought it was, you can't really fix it properly because of
    the DT stability you wanted us to enforce.

> So as mentioned several times before, I am looking into a more firmware
> driven clock system using the SCPI[1] framework.
> The idea is:
> - The basic clocks (OSC24M, OSC32K, AHB1, APB1, APB2, PERIPH0) are
> expressed as fixed clocks. If I am not mistaken, Allwinner recommends
> certain frequencies for them anyway, so we just use that and set them up
> before booting Linux, for instance in ATF.
> - The gates clocks are expressed as before, but by defining a generic DT
> compatible fallback name. I have no idea why every SoC enters its name
> into the simple_gates.c source file, while just mentioning the
> compatible string in the DT bindings and using the SoC specific name
> together with a generic fallback like "allwinner,sunxi-simple-gates"
> would suffice. This means that we don't need to touch simple-gates.c
> anymore most of the time.
> - Any clock that can (and has to) be programmed with a variable
> frequency is expressed as an SCPI clock. This interface allows basically
> querying and setting a frequency - not very powerful, but sufficient for
> the clocks I checked. Firmware then takes the burden of programming the
> respective clock register - which is not rocket science if we lock the
> base clocks to a certain frequency.
> 
> The advantage of this approach would be:
> - The impact to Linux code is minimized. Normally there would be no need
> to touch the kernel at all when we introduce a new SoC.

But you duplicate the clock framework entirely, both the core code and
the data you were complaining about, with all the issues that arise
from code duplication. You still have to create that big file you were
complaining about, with exactly the same constraints.

> - Any other DT user can quite easily make use of the clock system
> without adding tons of complicated Allwinner specific clock code. The
> simple-gates driver is almost trivial to implement, and chances are SCPI
> is already around anyway.
> - If there are any peculiarities with a certain clock (implementation),
> we can solve this in firmware. Fixes to code would immediately benefit
> all users - existing kernels (from distributions), newer kernels and
> other OSes.

But no-one would actually be able to use it, because no one upgrades
its firmware, including all the major distributions (Debian, Ubuntu,
Fedora, OpenWRT, Arch, Gento, you name it). So there's effectively no
way to fix a bug that was there.

> - Having SCPI gives us simple regulators and sensors (temperature,
> power) for free (in terms of no Linux code required). It also allows for
> DVFS support, though this may require more work on the firmware side.

And ignoring all the other features that the PMIC support, and the
board uses out there (GPIO, ADCs, Power supplies, battery charger, USB
VBUS monitoring)

> - This approach matches many of the more serious ARM64 machines out
> there, which refrain from exposing all of their clock framework to Linux.

$ git grep -l scpi arch/arm64/boot/dts/**.dtsi
arch/arm64/boot/dts/arm/juno-base.dtsi

Are you saying that only Juno is a serious ARM64 machine?

> Also this opens the door to much easier support for new SoCs - up to a
> point where any new chip would actually run out of the box on existing
> distributions (thinking of LTS releases here). The pinctrl driver is a
> nasty guy around here - but let's not make it worse and try to fix that
> guy later ;-)

That's not true and you know it.

What you actually suggest is to implement a minimal set of clocks in
ATF (the opposite being, the entire set of clocks, which would of
course be untested, so it basically falls down in the exact same
category).

What this means is that, since we will obviously not support all the
clocks client from day one, any user will be *required* for a new
kernel release to operate as it's expected to upgrade the ATF.

Without any help from the distribution (s)he's running, because no one
has that kind of scenario in mind. And let's be honest, I don't see
Ubuntu changing the dependencies for the kernel for the Allwinner SoCs
alone (let alone the fact that it's pretty much impossible in a
generic way to know where and how the ATF is installed).

Apart from being a major pain for any user, upgrading the bootloader
is also a showstopper for most industries.

So, no, we won't do that. The A64 support is something we actually
want to use in real-life products, and our users to be happy with the
support they have.

NAK.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/c9aaf206/attachment.sig>
