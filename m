From: dianders@chromium.org (Doug Anderson)
Date: Wed, 4 Jan 2012 15:47:52 -0800
Subject: [PATCH 0/4] ARM: tegra: Automatic UART selection for earlyprintk
In-Reply-To: <CAD=FV=X8p5RXKc0CW4KYzmoCw7tkOrahD2tnqKfXqqRR6MEAJQ@mail.gmail.com>
References: <1325629520-23018-1-git-send-email-swarren@nvidia.com>
 <CAD=FV=X8p5RXKc0CW4KYzmoCw7tkOrahD2tnqKfXqqRR6MEAJQ@mail.gmail.com>
Message-ID: <CAD=FV=WE51BbXdkQ9zjVCR_vjuHR5qn0YR+RteL-Q30bZ59BCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(repost, since gmail seems to have mangled my message)

For the series,

Tested-by: Doug Anderson <dianders@chromium.org>

Thank you for picking this up.

A few overall comments on the patch set:
1. This patch has the side effect of requiring the use of zImage to
? ?get the proper behavior. ?If we ever try to move decompression
? ?of the kernel to the bootloader (as has been talked about, since
? ?u-boot supports it) we'll lose earlyprintk behavior. ?...of course,
? ?this does match how some other ARM boards do things. ?I'm OK with
? ?this.
2. I'm slightly concerned about cramming stuff into IRAM, since
? ?I don't have a good concept of what IRAM adresses are used when.
? ?When I grep for IRAM users in our kernel, I see
? ?TEGRA_AVP_RESUME_ADDR is using the base of IRAM. ?We're not going
? ?to be hosing suspend/resume or anything else with this CL, are we?
? ?In the very least, I'd perfer to see a #define for the '0x100' and
? ?the '0x55415254' so that we can correlate the constants in
? ?uncompress.h and debug-macro.S

Tested:
Tested the series on a Tegra2-based board (Kaen) with
CONFIG_TEGRA_DEBUG_UART_NONE defined on the current ToT chromium-os
tree with the following pre-changes:
1. Reverted hack from our tree: 63b76a4638f3934e69c8724881060f121845184c
2. Added "arm/tegra: Support Tegra30 in decompressor UART setup" as
? ?described in the patch header.
3. Adjusted patch 4 to apply cleanly to our older "common.c"
4. Added missing #include <linux/kernel.h> to uncompress.h, as
? ?indicated by swarren on tegra IRC.

Also tried stopping in the bootloader and clearing the 'D' with:
? mw.b 0x7000605c 0
...and validated that I missed the earlyprintks (as expected) but
still booted.

---

On Wed, Jan 4, 2012 at 3:45 PM, Doug Anderson <dianders@chromium.org> wrote:
> For the series,
> Tested-by: Doug Anderson <dianders@chromium.org>
> Thank you for picking this up.
> A few overall comments on the patch set:1. This patch has the side
> effect of requiring the use of zImage to?? ?get the proper behavior.
> If we ever try to move decompression? ?of the kernel to the bootloader
> (as has been talked about, since? ?u-boot supports it) we'll lose
> earlyprintk behavior. ?...of course,?? ?this does match how some other
> ARM boards do things. ?I'm OK with? ?this.2. I'm slightly concerned
> about cramming stuff into IRAM, since? ?I don't have a good concept of
> what IRAM adresses are used when.? ?When I grep for IRAM users in our
> kernel, I see?? ?TEGRA_AVP_RESUME_ADDR is using the base of IRAM.
> We're not going? ?to be hosing suspend/resume or anything else with
> this CL, are we?? ?In the very least, I'd perfer to see a #define for
> the '0x100' and?? ?the '0x55415254' so that we can correlate the
> constants in?? ?uncompress.h and debug-macro.S
> Tested:Tested the series on a Tegra2-based board (Kaen)
> withCONFIG_TEGRA_DEBUG_UART_NONE defined on the current ToT
> chromium-os?tree with the following pre-changes:1. Reverted hack from
> our tree: 63b76a4638f3934e69c8724881060f121845184c2. Added "arm/tegra:
> Support Tegra30 in decompressor UART setup" as? ?described in the
> patch header.3. Adjusted patch 4 to apply cleanly to our older
> "common.c"4. Added missing #include <linux/kernel.h> to uncompress.h,
> as?? ?indicated by swarren on tegra IRC.
> Also tried stopping in the bootloader and clearing the 'D' with:? mw.b
> 0x7000605c 0...and validated that I missed the earlyprintks (as
> expected) butstill booted.
> ---
> On Tue, Jan 3, 2012 at 2:25 PM, Stephen Warren <swarren@nvidia.com> wrote:
>> This series allows a Tegra zImage to automatically select the UART to use
>> for the zImage decompressor and early printk, based on information from
>> the bootloader. The code scans each UART, looking for one that is clocked,
>> is out of reset, and that the bootloader has written 'D' (for 'D'ebug) to
>> the scratch register.
>>
>> At present, the ChromiumOS branch of U-Boot sets up UARTs in this way. If
>> this patch is accepted into the kernel, I'll upstream the U-Boot change to
>> mainline U-Boot.
>>
>> This is important, since different boards use different UARTs, and it's
>> nice not to have to configure the kernel differently when switching
>> boards.
>>
>> This patch series depends on patch "[PATCH V2] arm/tegra: Support Tegra30
>> in decompressor UART setup" for context.
>>
>> Doug Anderson (2):
>> ?ARM: tegra: Introduce define DEBUG_UART_SHIFT
>> ?ARM: tegra: uncompress.h: Store UART address in a variable
>>
>> Stephen Warren (2):
>> ?ARM: tegra: uncompress.h: Choose a UART at runtime
>> ?ARM: tegra: Pass uncompress.h UART selection to DEBUG_LL
>>
>> ?arch/arm/mach-tegra/common.c ? ? ? ? ? ? ? ? ? | ? 17 ++++
>> ?arch/arm/mach-tegra/include/mach/debug-macro.S | ? 87 +++++++++++++++++---
>> ?arch/arm/mach-tegra/include/mach/uncompress.h ?| ?108 +++++++++++++++++++++---
>> ?3 files changed, 190 insertions(+), 22 deletions(-)
>>
