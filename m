From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Apr 2015 21:17:46 +0200
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <1428432239-4114-5-git-send-email-lee.jones@linaro.org>
References: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
 <1428432239-4114-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20150407191746.GA26727@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Apr 07, 2015 at 07:43:59PM +0100, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
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
> +
> +		    To avoid either of these two scenarios from catastrophically
> +		    disabling an otherwise perfectly healthy running system,
> +		    clocks can be identified as always-on using this property
> +		    from inside a clocksource's node.

Isn't "clocksource" here way too similar to, I don't know, the
clocksource framework? Wouln't clock provider be better?

> +
> +		    This property is not to be abused.  It is only to be used to
> +		    protect platforms from being crippled by gated clocks, not
> +		    as a convenience function to avoid using the framework
> +		    correctly inside device drivers.

Disregarding what's stated here, I'm pretty sure that this will
actually happen. Where do you place the cursor?

Should we create a new driver for our RAM controller, or do we want to
use clock-always-on?

Do we really want to enforce this if we ever gain a driver that would
actually be able to manage its clock (like do we want the CPU clock to
never *ever* be gated just because we don't have a cpuidle/hotplug
driver yet?)

Have you seen the numerous NAK on such approach Mike did?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150407/dc94b180/attachment.sig>
