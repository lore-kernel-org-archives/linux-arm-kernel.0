From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 22 May 2016 12:26:06 +0200
Subject: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
In-Reply-To: <1463648641-6931-2-git-send-email-vigneshr@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
Message-ID: <20160522102606.GB23704@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
> There are rotary-encoders where GPIO lines reflect the actual position
> of the rotary encoder dial. For example, if dial points to 9, then four
> GPIO lines connected to the rotary encoder will read HLLH(1001b = 9).
> Add support for such rotary-encoder.
> The driver relies on rotary-encoder,absolute-encoder DT property to
> detect such encoders.
> Since, GPIO IRQs are not necessary to work with
> such encoders, optional polling mode support is added using

I don't understand this. It's necessary in the same way as with the
already supported devices. I.e. you want to trigger an irq when the
encoder is moved and then check for it's position in the handler.

> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index 6c9f0c8a846c..9c928dbd1500 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -12,6 +12,10 @@ Optional properties:
>  - rotary-encoder,relative-axis: register a relative axis rather than an
>    absolute one. Relative axis will only generate +1/-1 events on the input
>    device, hence no steps need to be passed.
> +- rotary-encoder,absolute-encoder: support encoders where GPIO lines
> +  reflect the actual position of the rotary encoder dial. For example,
> +  if dial points to 9, then four GPIO lines read HLLH(1001b = 9).
> +  In this case, rotary-encoder,steps-per-period needed not be defined.

IMHO this is wrong, I'd formalize this device as:

	{
		compatible = "rotary-encoder";
		gpios = <&gpio 19 1>, <&gpio 20 0>, <...>, <...>;
		rotary-encoder,encoding = "binary";
		rotary-encoder,steps = <16>;
		rotary-encoder,steps-per-period = <16>;
		rotary-encoder,rollover;
	}

and support this with a v4 of

	http://thread.gmane.org/gmane.linux.kernel.input/48892

.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
