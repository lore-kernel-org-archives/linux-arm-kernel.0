From: dianders@chromium.org (Doug Anderson)
Date: Mon, 22 Jun 2015 13:04:02 -0700
Subject: [PATCH v2 1/2] ARM: rockchip: add support holding 24Mhz osc
 during suspend
In-Reply-To: <1434880847-29505-2-git-send-email-zyw@rock-chips.com>
References: <1434880847-29505-1-git-send-email-zyw@rock-chips.com>
 <1434880847-29505-2-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=Ux+gKJQtr1Qq+ubTNBKNGKTuCGx-3hTAj0j6fAEEJq2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Sun, Jun 21, 2015 at 3:00 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> If we want to wake up system via usb, the 24Mhz osc could not be
> disabled during suspend, read the usb phy SIDDQ bit to decide whether
> to switch to 32khz clock-in.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
>
>  arch/arm/mach-rockchip/pm.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)

As talked about privately, this patch is ugly.  ...but I don't see a
solution that is less ugly.  This method has the advantages that it is
"automatic"--the system figures out whether it needs the 24MHz clock
automatically based on whether the PHYs were left on.  No other
communication / device tree stuff is needed.


> +       /* if any usb phy is still on(GRF_SIDDQ==0), that means we need the
> +        * function of usb wakeup, so do not switch to 32khz, since the usb phy
> +        * clk does not connect to 32khz osc*/

This is not _quite_ the block commenting style used in this file.  It
would be a bit nicer if it matched.

Other than that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

On the chromeos-3.14 kernel (with the WIP dwc2 patches):
Tested-by: Douglas Anderson <dianders@chromium.org>
