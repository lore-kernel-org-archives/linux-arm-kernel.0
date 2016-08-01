From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 1 Aug 2016 17:11:01 +0800
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
In-Reply-To: <fb559224-561c-3476-1146-96f7aea427f0@arm.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
 <fb559224-561c-3476-1146-96f7aea427f0@arm.com>
Message-ID: <CAGb2v65cD4_4S8vW4qCd0zsqXAZuy=-cpdWOE778pRsNr4-cDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 1, 2016 at 9:43 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
> Hi Maxime,
>
> On 26/07/16 21:30, Maxime Ripard wrote:
>> Hi,
>>
>> Here is the previous A64 patches made by Andre [1], reworked to use
>> the new sunxi-ng clock framework.
>>
>> This uses the current H3 clock code, as both are really similar. The
>> first patches are just meant to rework slightly the H3 code, before
>> introducing the A64-related patches.
>>
>> Some WiP stuff have been removed, such as the MMC part, but this serie
>> already has a decent amount of devices supported: uart, i2c, rsb, etc.
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

I'm guessing this was nacked by device tree maintainers and/or clk
maintainers. A recent thread adding display timings in DT to the
simple-panel binding is a similar example.

> - It makes it quite hard for any other DT user (*BSD, U-Boot) to use the
> clocks, since they would have to copy quite verbatim the Linux
> implementation choice. This is admittedly also true for the old clock
> framework, but still unfortunate.
>
> So as mentioned several times before, I am looking into a more firmware
> driven clock system using the SCPI[1] framework.
> The idea is:
> - The basic clocks (OSC24M, OSC32K, AHB1, APB1, APB2, PERIPH0) are
> expressed as fixed clocks. If I am not mistaken, Allwinner recommends
> certain frequencies for them anyway, so we just use that and set them up
> before booting Linux, for instance in ATF.

True. These are set by the bootloader because it uses them.

If you're concerned about the clock rate changing, you can always have
the clocks set to read only, i.e. clock rates cannot be changed.

> - The gates clocks are expressed as before, but by defining a generic DT
> compatible fallback name. I have no idea why every SoC enters its name
> into the simple_gates.c source file, while just mentioning the
> compatible string in the DT bindings and using the SoC specific name
> together with a generic fallback like "allwinner,sunxi-simple-gates"
> would suffice. This means that we don't need to touch simple-gates.c
> anymore most of the time.

My understanding is that because they _are_ different, they are defined
by different compatible strings. The fact that we can have a simple
clk driver supporting all of them, using the clk-indices property to
get the bit offsets, is beside the point.

clk-indices is used for clk name lookup through DT, when the phandle
index is not the same as the one used for clk-output-names. We are
slightly abusing it to get the bit offsets. It is entirely possible
to do a clk binding without them. You would then have that information
in the driver.

> - Any clock that can (and has to) be programmed with a variable
> frequency is expressed as an SCPI clock. This interface allows basically
> querying and setting a frequency - not very powerful, but sufficient for
> the clocks I checked. Firmware then takes the burden of programming the
> respective clock register - which is not rocket science if we lock the
> base clocks to a certain frequency.

Can it also propagate clock rate changes and reparenting such that
we do not need to describe clock relationships in the kernel? If not
then we still need some kind of description somewhere. And the clk
maintainers don't seem too fond of 1 clk per node designs, which
would allow you to describe it in the DT.

We will run into this when we do audio and video. The module clocks
may or may not have dividers or multiple parents. But in some cases
you have to change the PLL clock rate, which in turn changes the clock
rate of all the clocks under it. An example would be playing 44.1 KHz
audio through the internal codec, which requires a different PLL clock
rate than playing 48 KHz audio. But if at the same time you're also
using I2S at 44.1 KHz or some multiple, you would want to know the
clock rate is about to change, and maybe block the change.

Can SCPI notify the kernel about these changes? If not you'd have
some logic in the kernel. Splitting the logic here IMHO is not a
good design.

>
> The advantage of this approach would be:
> - The impact to Linux code is minimized. Normally there would be no need
> to touch the kernel at all when we introduce a new SoC.
> - Any other DT user can quite easily make use of the clock system
> without adding tons of complicated Allwinner specific clock code. The
> simple-gates driver is almost trivial to implement, and chances are SCPI
> is already around anyway.
> - If there are any peculiarities with a certain clock (implementation),
> we can solve this in firmware. Fixes to code would immediately benefit
> all users - existing kernels (from distributions), newer kernels and
> other OSes.

Upgrading firmware is still upgrading something... I'm not sure how
it's better.

> - Having SCPI gives us simple regulators and sensors (temperature,
> power) for free (in terms of no Linux code required). It also allows for
> DVFS support, though this may require more work on the firmware side.

Are you arguing to move PMIC support into SCPI firmware?

> - This approach matches many of the more serious ARM64 machines out
> there, which refrain from exposing all of their clock framework to Linux.

A quick grep through linux-next shows only the Juno platform using
"arm,scpi-clocks". Some other consumer oriented vendors, such as
mediatek, nvidia, qualcomm, renesas and rockchip have monolithic
clock nodes.

>
> Also this opens the door to much easier support for new SoCs - up to a
> point where any new chip would actually run out of the box on existing
> distributions (thinking of LTS releases here). The pinctrl driver is a
> nasty guy around here - but let's not make it worse and try to fix that
> guy later ;-)

Not really. You still have to write the firmware for the new SoCs,
unless you expect Allwinner to adopt our design. And getting the new
firmware to work with the existing bootloader (if upstream support
isn't done yet) may be tricky, as you already went through for the
A64.

>
> So I managed to finish a first prototype this weekend.
> SCPI requires a mailbox and a shared memory region to work. The latter
> is trivial, but we are lacking a proper mailbox driver for sunxi.
> Besides that the Allwinner mailbox only works between the arisc and the
> ARM cores, not between ARM cores or within one core in different
> exception levels. So signalling a mailbox in EL1 and taking the IRQ in
> EL3 does not work.
> As a quick solution I implemented a synchronous "smc" mailbox, which
> uses the ARM smc instruction to transfer control into firmware. Firmware
> then reads the payload from the shared memory region, handles the
> request and returns to EL1. We then advertise this mailbox in the SCPI
> DT node, and the rest of the SCPI framework can happily work with that.
> I described the clocks as mentioned above and put the MMC clocks under
> SCPI control.
> I put a draft DT here [2] to illustrate my ideas.
>
> I know this is quite controversial, so what about these following steps:
>
> - I polish my existing patches and send a prototype this week. We can
> then discuss the merits and drawbacks of this approach based on the code.
> - It it turns out that sunxi-ng is the way to go, I will test and
> comment on this series.
> - If we are not sure yet, we can try to go with an almost clock-less DT
> for now (drop I2C and make UART0 use osc24M directly, for a start). This
> would leave the door open for either approach. Or we use the
> simple-gates only for now.

A clock-less system is quite useless. The only things that work are the
peripherals tied to apb2, namely uarts and i2c busses. And maybe simplefb
if you get the display pipeline working in the bootloader. This is where
A83T has been for some time. :(

Regards
ChenYu

>
> I am happy to discuss this here on the list.
>
> Cheers,
> Andre
>
> [1]
> http://infocenter.arm.com/help/topic/com.arm.doc.dui0922g/scp_message_interface_v1_2_DUI0922G_en.pdf
> [2] https://gist.github.com/apritzel/faa3dc5cbe7591be8c55a439f725578e
>
>>
>> Let me know what you think,
>> Maxime
>>
>> 1: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/410338.html
>>
>> Andre Przywara (5):
>>   arm64: sunxi: Kconfig: add essential pinctrl driver
>>   arm64: Kconfig: sunxi: add PINCTRL
>>   Documentation: devicetree: add vendor prefix for Pine64
>>   arm64: dts: add Allwinner A64 SoC .dtsi
>>   arm64: dts: add Pine64 support
>>
>> Maxime Ripard (8):
>>   clk: sunxi-ng: mux: Rename mux macro to be consistent
>>   clk: sunxi-ng: mux: Add mux table support
>>   clk: sunxi-ng: sun8i: Rename DDR and video plls
>>   clk: sunxi-ng: sun8i: Fix register offset
>>   clk: sunxi-ng: sun8i: Rename H3 only clocks
>>   clk: sunxi-ng: sun8i: Move fixed factors around
>>   clk: sunxi-ng: sun8i: Prefix clock defines by SoC Name
>>   clk: sunxi-ng: Add A64 clocks
>>
>>  Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
>>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>  MAINTAINERS                                        |   1 +
>>  arch/arm/boot/dts/sun8i-h3.dtsi                    |  62 +-
>>  arch/arm64/Kconfig.platforms                       |   2 +
>>  arch/arm64/boot/dts/Makefile                       |   1 +
>>  arch/arm64/boot/dts/allwinner/Makefile             |   5 +
>>  .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  50 ++
>>  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  70 ++
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 273 +++++++
>>  drivers/clk/sunxi-ng/Kconfig                       |  13 +-
>>  drivers/clk/sunxi-ng/Makefile                      |   2 +-
>>  drivers/clk/sunxi-ng/ccu-sun50i-a64.h              |  68 ++
>>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c                | 896 ++++++++++++++++-----
>>  drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |  44 +-
>>  drivers/clk/sunxi-ng/ccu_div.h                     |   2 +-
>>  drivers/clk/sunxi-ng/ccu_mp.h                      |   2 +-
>>  drivers/clk/sunxi-ng/ccu_mux.c                     |  14 +
>>  drivers/clk/sunxi-ng/ccu_mux.h                     |  29 +-
>>  include/dt-bindings/clock/sun50i-a64-ccu.h         | 132 +++
>>  include/dt-bindings/clock/sun8i-h3-ccu.h           | 188 ++---
>>  include/dt-bindings/reset/sun50i-a64-ccu.h         |  97 +++
>>  23 files changed, 1588 insertions(+), 366 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a64.h
>>  create mode 100644 include/dt-bindings/clock/sun50i-a64-ccu.h
>>  create mode 100644 include/dt-bindings/reset/sun50i-a64-ccu.h
>>
