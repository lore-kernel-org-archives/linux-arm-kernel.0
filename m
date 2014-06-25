From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Jun 2014 15:52:21 -0600
Subject: [PATCH v1 5/9] of: Add NVIDIA Tegra XHCI controller binding
In-Reply-To: <1403072180-4944-6-git-send-email-abrestic@chromium.org>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
 <1403072180-4944-6-git-send-email-abrestic@chromium.org>
Message-ID: <53AB4495.1020000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2014 12:16 AM, Andrew Bresticker wrote:
> Add device-tree binding documentation for the XHCI controller present
> on Tegra124 and later SoCs.

> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt

> +Required properties:
> +--------------------

> + - clock-names: Must include the following entries:
> +    - xusb_host
> +    - xusb_falcon_src
> +    - xusb_ss
> +    - xusb_ss_src
> +    - xusb_hs_src
> +    - xusb_fs_src
> +    - pll_u_480m
> +    - clk_m
> +    - pll_e

> + - reset-names: Must include the following entries:
> +   - xusb_host
> +   - xusb_ss

Usually the CAR has a reset control for each clock. So, I would expect
as many entries in reset-names as in clock-names. Even if the SW doesn't
currently touch all the reset lines, we should make sure the binding
requires them to be present so that any DT will contain the entries if
they're ever needed in the future.

In the CAR documentation, I see "XUSB_DEV" as a clock/reset bit. Is that
missing from the list above?

> + - nvidia,xusb-mbox: Handle to the Tegra XUSB mailbox node.

As mentioned earlier, I think that's an internal implementation detail.
Shouldn't the two nodes be squashed together?

> +Optional properties:

> + - s1p05v-supply: 1.05V supply regulator.
> + - s1p8v-supply: 1.8V supply regulator.
> + - s3p3v-supply: 3.3V supply regulator.

What are those supplies for? I would have expected any input to the SoC
to have a name that described its purpose, and the pins and DT
properties would be named to match.
