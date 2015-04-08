From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 7 Apr 2015 22:25:50 -0700
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <1428432239-4114-5-git-send-email-lee.jones@linaro.org>
References: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
 <1428432239-4114-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20150408052550.GB31970@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Can you please add some commit text here? Why did we make this
change?

>  .../devicetree/bindings/clock/clock-bindings.txt   | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> index 06fc6d5..daf3323 100644
> --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -44,6 +44,44 @@ For example:
>    clocks by index. The names should reflect the clock output signal
>    names for the device.
>  
> +clock-always-on:    Some hardware contains bunches of clocks which must never be
> +		    turned off.  If drivers a) fail to obtain a reference to any
> +		    of these or b) give up a previously obtained reference
> +		    during suspend, the common clk framework will attempt to
> +		    disable them and a platform can fail irrecoverably as a
> +		    result.  Usually the only way to recover from these failures
> +		    is to reboot.

Should we even be talking about "the common clk framework" in
this document? Ideally this document/binding isn't Linux
specific. Plus, the framework doesn't disable clocks during
suspend, it disables clocks during late init as long as the clock
isn't enabled by software.

Maybe we can drop this first paragraph and replace the second
with this single sentence:

	Clocks which should never be disabled.

> +
> +		    To avoid either of these two scenarios from catastrophically
> +		    disabling an otherwise perfectly healthy running system,
> +		    clocks can be identified as always-on using this property
> +		    from inside a clocksource's node.

s/clocksource/clock provider/

> +
> +		    This property is not to be abused.  It is only to be used to
> +		    protect platforms from being crippled by gated clocks, not
> +		    as a convenience function to avoid using the framework
> +		    correctly inside device drivers.
> +
> +		    Expected values are hardware clock indices.  If the
> +		    clock-indices property (see below) is used, then supplied
> +		    values must correspond to one of the listed identifiers.
> +		    Using the clock-indices example below, hardware clock <2>
> +		    is missing, therefore it is considered invalid to then
> +		    list clock <2> as an always-on clock.
> +
> +For example:
> +
> +    oscillator {
> +        #clock-cells = <1>;
> +        clock-output-names = "ckil", "ckih";
> +        clock-always-on = <0>, <1>;
> +    };
> +
> +- this node defines a device with two clock outputs, just as in the
> +  example above.  The only difference being that 'ckil' and 'ckih'
> +  are now identified as an always-on clocks, so the framework will

s/an//

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
