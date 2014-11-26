From: dianders@chromium.org (Doug Anderson)
Date: Wed, 26 Nov 2014 14:46:00 -0800
Subject: [PATCH v2] mmc: dw_mmc: add quirk for broken data transfer over
 scheme
In-Reply-To: <1416903008-4160-1-git-send-email-addy.ke@rock-chips.com>
References: <1415970338-2637-1-git-send-email-addy.ke@rock-chips.com>
 <1416903008-4160-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=UmG1okxJ5JV-1cuRRQJi7EEPXc7Q90sWjfMWBqb7VSMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 25, 2014 at 12:10 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
> This patch add a new quirk to add a s/w timer to notify the driver
> to terminate current transfer and report a data timeout to the core,
> if DTO interrupt does NOT come within the given time.
>
> dw_mmc call mmc_request_done func to finish transfer depends on
> DTO interrupt. If DTO interrupt does not come in sending data state,
> the current transfer will be blocked.
>
> But this case really exists, when driver reads tuning data from
> card on RK3288-pink2 board. I measured waveforms by oscilloscope
> and found that card clock was always on and data lines were always
> holded high level in sending data state.
>
> We got the reply from synopsys:
> There are two counters but both use the same value of [31:8] bits.
> Data timeout counter doesn't wait for stop clock and you should get
> DRTO even when the clock is not stopped.
> Host Starvation timeout counter is triggered with stop clock condition.
>
> This means that host should get DRTO and DTO interrupt.
>
> But we really don't get any data-related interrupt in RK3X SoCs.
> And driver can't get data transfer state, it can do nothing but wait for.

Have you asked someone on your IC team to confirm this is an SoC
errata on your SoC?  ...or is there something else we could be doing
wrong (overclocking?  jitter in the clock?  bad dividers?) that could
be causing this problem?


>  #ifdef CONFIG_OF
>  static struct dw_mci_of_quirks {
>         char *quirk;
> @@ -2513,6 +2549,9 @@ static struct dw_mci_of_quirks {
>         }, {
>                 .quirk  = "disable-wp",
>                 .id     = DW_MCI_QUIRK_NO_WRITE_PROTECT,
> +       }, {
> +               .quirk  = "broken-dto",
> +               .id     = DW_MCI_QUIRK_BROKEN_DTO,

You're adding a device tree property without any binding.  If you need
to add this please send a patch before this one modifying the device
tree bindings.

...but that brings up the question: do you _really_ need to add a
property?  You already know that all rk3288 SoCs need this and you
already know that you're an rk3288 SoC.  Just add this quirk in the
rk3288 code always and be done with it.  ...and if this is also needed
on other Rockchip parts, add it there too.

-Doug
