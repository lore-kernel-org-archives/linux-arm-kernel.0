From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 21 Nov 2014 13:45:32 +0900
Subject: [PATCH/RFC] ARM: shmobile: dts: Add common file for MSIOF1
In-Reply-To: <1416544027-5680-1-git-send-email-horms+renesas@verge.net.au>
References: <1416544027-5680-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CANqRtoRxd64yoXQaPbR-euRtT6MX9AnasF32sK6B_EKoE30fJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Nov 21, 2014 at 1:27 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> The R-Car Gen 2 SoCs have MSIOF1 interfaces however they
> are not exposed on any boards currently supported in mainline.

Ok, but that's the same as many other devices on R-Car Gen2 SoCs no?
Basically the SoC contains a hardware block but it is not used on the
actual board. I wonder what made MSIOF1 a target for sudden code
consolidation?

> The purpose of r8a77xx-msiof1.dtsi is to be included
> in a dts file if MSIOF1 is exposed by some means.

Judging by the file name this seems to be a board specific property
made generic somehow.

> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [horms: Reworked into a separate dtsi file]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[snip]

> +&pfc {
> +       msiof1_pins: spi2 {
> +               renesas,groups = "msiof1_clk_c", "msiof1_sync_c", "msiof1_rx_c",
> +                                "msiof1_tx_c";
> +               renesas,function = "msiof1";
> +       };
> +};
> +
> +&msiof1 {
> +       pinctrl-0 = <&msiof1_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};

The DTS above only works on boards that are using the "C" set of pins
for the MSIOF1. Other configurations will not work. It also assumes
that all SoC code is using the same strings for the PFC which may or
may not be true.

Does some common policy for the Linux kernel exist about how to break
out board specific device support in DTS? If so we should follow it.

If not, from my conservative view point this patch looks like over
doing code sharing with increased overhead and no apparent upside
except more complex dependencies.

Thanks,

/ magnus
