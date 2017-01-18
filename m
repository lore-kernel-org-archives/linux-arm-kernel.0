From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 18 Jan 2017 10:20:21 +0100
Subject: [PATCH v7 3/8] PWM: add pwm-stm32 DT bindings
In-Reply-To: <1483608344-9012-4-git-send-email-benjamin.gaignard@st.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-4-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20170118092021.GE18989@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 10:25:39AM +0100, Benjamin Gaignard wrote:
> Define bindings for pwm-stm32
> 
> version 6:
> - change st,breakinput parameter format to make it usuable on stm32f7 too.
> 
> version 2:
> - use parameters instead of compatible of handle the hardware configuration
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> new file mode 100644
> index 0000000..866f222
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> @@ -0,0 +1,33 @@
> +STMicroelectronics STM32 Timers PWM bindings
> +
> +Must be a sub-node of an STM32 Timers device tree node.
> +See ../mfd/stm32-timers.txt for details about the parent node.
> +
> +Required parameters:
> +- compatible:		Must be "st,stm32-pwm".
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		List of phandles pointing to pin configuration nodes for PWM module.
> +			For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
> +
> +Optional parameters:
> +- st,breakinput:	Arrays of three u32 <index level filter> to describe break input configurations.
> +			"index" indicates on which break input the configuration should be applied.

It might be useful to specify what the valid values are for the break
input index.

Also, u32 is kind of a Linuxism, perhaps "Arrays of three cells"? Also,
does this mean there can be multiple entries? Such as 6 cells for two
configurations? What's the maximum number of such configurations?

If it's possible to specify multiple configurations, maybe a slightly
clearer wording would be: "One or more <index level filter> triplets to
describe..."

> +			"level" gives the active level (0=low or 1=high) for this configuration.

So how does this work exactly? "level" specifies the output level if the
filter value is matched?

> +			"filter" gives the filtering value to be applied.

Is this a single value at which "level" will be applied? Or is it an
upper/lower bound that can be used to restrict the output to "level" if
the signal goes beyond/below a certain threshold?

Maybe an example would clarify this. Or perhaps a reference to a manual
where a more in-depth description of this functionality can be found.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/45afc3e2/attachment.sig>
