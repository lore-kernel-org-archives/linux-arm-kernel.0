From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jul 2015 09:10:13 +0200
Subject: [PATCH v7 5/5] clk: dt: Introduce binding for critical clock
 support
In-Reply-To: <1437570255-21049-6-git-send-email-lee.jones@linaro.org>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
 <1437570255-21049-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20150727071013.GO2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Jul 22, 2015 at 02:04:15PM +0100, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/clock/clock-bindings.txt   | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> index 06fc6d5..4137034 100644
> --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -44,6 +44,45 @@ For example:
>    clocks by index. The names should reflect the clock output signal
>    names for the device.
>  
> +critical-clock:	Some hardware contains bunches of clocks which, in normal
> +		circumstances, must never be turned off.  If drivers a) fail to
> +		obtain a reference to any of these or b) give up a previously
> +		obtained reference during suspend, it is possible that some
> +		Operating Systems might attempt to disable them to save power.
> +		If this happens a platform can fail irrecoverably as a result.
> +		Usually the only way to recover from these failures is to
> +		reboot.
> +
> +		To avoid either of these two scenarios from catastrophically
> +		disabling an otherwise perfectly healthy running system,
> +		clocks can be identified as 'critical' using this property from
> +		inside a clocksource's node.
> +
> +		This property is not to be abused.  It is only to be used to
> +		protect platforms from being crippled by gated clocks, NOT as a
> +		convenience function to avoid using the framework correctly
> +		inside device drivers.
> +
> +		Expected values are hardware clock indices.  If the
> +		clock-indices property (see below) is used, then supplied
> +		values must correspond to one of the listed identifiers.
> +		Using the clock-indices example below, hardware clock <2>
> +		is missing, therefore it is considered invalid to then
> +		list clock <2> as a critical clock.

I think we should also consider having it simply as a boolean. Using
indices for clocks that don't have any (for example because it only
provides a single clock) seem to not really make much sense.

Also, since you can have a bunch of them, using critical-clocks seem
more appropriate.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150727/752ad1cd/attachment.sig>
