From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 20 Nov 2012 16:48:18 +0200
Subject: [PATCHv9 1/3] Runtime Interpreted Power Sequences
In-Reply-To: <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
Message-ID: <50AB9832.90709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2012-11-17 12:55, Alexandre Courbot wrote:

A few questions after looking at the documentation:

> +Example
> +-------
> +Here are example sequences declared within a backlight device that use all the
> +supported resources types:
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		...
> +
> +		/* resources used by the power sequences */
> +		pwms = <&pwm 2 5000000>;
> +		pwm-names = "backlight";
> +		power-supply = <&backlight_reg>;
> +
> +		power-sequences {
> +			power-on {
> +				step0 {
> +					type = "regulator";
> +					id = "power";
> +					enable;
> +				};
> +				step1 {
> +					type = "delay";
> +					delay = <10000>;
> +				};
> +				step2 {
> +					type = "pwm";
> +					id = "backlight";
> +					enable;
> +				};
> +				step3 {
> +					type = "gpio";
> +					gpio = <&gpio 28 0>;
> +					value = <1>;
> +				};
> +			};

I guess there's a reason, but the above looks a bit inconsistent. For
gpio you define the gpio resource inside the step. For power and pwm the
resource is defined before the steps. Why wouldn't "pwm = <&pwm 2
5000000>;" work in step2?

> +When a power sequence is run, its steps is executed one after the other until
> +one step fails or the end of the sequence is reached.

The document doesn't give any hint of what the driver should do if
running the power sequence fails. Run the "opposite" power sequence?
Will that work for all resources? I'm mainly thinking of a case where
each enable of the resource should be matched by a disable, i.e. you
can't call disable if no enable was called.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/95e3ac2a/attachment.sig>
