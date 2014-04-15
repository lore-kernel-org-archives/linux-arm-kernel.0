From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 15 Apr 2014 12:36:07 -0700
Subject: [PATCH 2/4] mmc: tegra: fix reporting of base clock frequency
In-Reply-To: <534D797D.7030201@wwwdotorg.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397526163-20126-3-git-send-email-abrestic@chromium.org>
 <534D797D.7030201@wwwdotorg.org>
Message-ID: <CAL1qeaFoQd1sZkTHSJnnVcYgLDLSP_Hr6VHd3s8aKfnAz-iyNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 11:25 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/14/2014 07:42 PM, Andrew Bresticker wrote:
>> Tegra SDHCI controllers, by default, report a base clock frequency
>> of 208Mhz in SDHCI_CAPABILTIES which may or may not be equal to the
>> actual base clock frequency.
>
> Some explanation of why this "may or may not be equal to the actual base
> clock frequency" would be nice.
>
> Presumably, it's because the clock frequency is supplied by the clock
> controller module, and configuring that happens externally to the SD
> controller, so the SD HW has no knowledge of the actual frequency, and
> hence simply reports a hard-coded maximum possible clock frequency?

Correct.  I'll fix up the commit message.

>
>> While this can be overridden by setting
>> BASE_CLK_FREQ in VENDOR_CLOCK_CTRL on Tegra30 and later SoCs, just
>> set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN and supply a get_max_clock()
>> callback to get the actual rate of the base clock.
>
> It's not clear to me from the function name that
> sdhci_pltfm_clk_get_max_clock() simply calls clk_get() on the actual
> clock. It might be nice to mention that in the commit description.
