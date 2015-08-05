From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Aug 2015 09:55:41 +0900
Subject: [PATCH v2 0/6] ARM: shmobile: Move gpio ranges from C code to DT
In-Reply-To: <1438696519-13727-1-git-send-email-geert+renesas@glider.be>
References: <1438696519-13727-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150805005540.GB20726@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Tue, Aug 04, 2015 at 03:55:13PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series moves the setup of the GPIO-PFC pin mapping for
> Renesas PFC/GPIO combos from C code to DT, and does some cleanups.
> The move to DT is needed to make the GPIO hogging mechanism work, cfr.
> the discussion following "[PATCH] [RFC] gpio: Retry deferred GPIO
> hogging on pin range change" (https://lkml.org/lkml/2015/6/16/455).
> 
> The series consists of 3 parts:
>   a. Patches 1-3 add the missing "gpio-ranges" properties to the dtsi
>      files for all affected SoCs,
>   b. Patch 4 disables the C code to set up the mapping on DT platforms
>      (it's still needed on SH or ARM-legacy),
>   c. Patches 5-6 do a few more cleanups in the sh-pfc gpio code.
> 
> Changes compared to v1 ("[PATCH 0/7] ARM: shmobile: Move gpio ranges
> from C code to DT",
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/353124.html):
>   - Add check for CONFIG_OF and pfc->dev->of_node,
>   - #ifdef out the code instead of introducing helper and dummy
>     functions,
>   - Drop "pinctrl: sh-pfc: Move sh_pfc_add_gpiochip() up", as it's no
>     longer needed due to the #ifdefs,
>   - Add Acked-by.
> 
> Dependencies:
>   - This series applies against renesas-devel-20150803-v4.2-rc5,
>   - Part a must go in first, to avoid regressions,
>   - While I didn't notice any bad behavior by having part a only, part b
>     should go in immediately after part a. Hence I think it's best if
>     Simon can take this one, too.
>   - Part c is independent (it doesn't touch the same code), so it can go
>     in before or after the other parts, or in parallel.
> 
> Given this fixes the LCD on r8a7740/armadillo, which is a regression
> introduced by the removal of armadillo-legacy support, I think at least
> patch 2 should be queued for v4.3.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (6):
>   ARM: shmobile: r8a73a4 dtsi: Add missing "gpio-ranges" to gpio node
>   ARM: shmobile: r8a7740 dtsi: Add missing "gpio-ranges" to gpio node
>   ARM: shmobile: sh73a0 dtsi: Add missing "gpio-ranges" to gpio node
>   pinctrl: sh-pfc: Stop calling gpiochip_add_pin_range() on DT platforms
>   pinctrl: sh-pfc: Remove empty gpio_function_free()
>   pinctrl: sh-pfc: Confine legacy function GPIOs to SH

Where possible I prefer not to apply non-DTS/DTSI patches on top of
DTS/DTSI patches, I believe this is in keeping with how the ARM SoC
maintainers like things handled.  With this in mind I have done the following:

1. Queued up the DTSI patches (patches 1 - 3) for v4.3 in my dt branch.
   I intend for this to turn up in next soon.
2. Queued up for pinctrl patches (patches 4 - 6) for v4.4 in a pinctrl patch.
   I intend for these to be present in the renesas devel branch but
   not in next until after the release of v4.3-rc1. I would also be
   happy to drop them and let Linus Walleij take these patches for v4.4,
   assuming patches 1 - 3 are accepted for v4.3.
