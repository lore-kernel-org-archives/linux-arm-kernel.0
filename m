From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Jul 2013 11:45:12 -0600
Subject: [PATCH v6 2/8] ASoC: atmel: machine driver for at91sam9x5-wm8731
 boards
In-Reply-To: <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
Message-ID: <51F7FBA8.6080400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 04:32 AM, Richard Genoud wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Description of the Asoc machine driver for an at91sam9x5 based board
> with a wm8731 audio DAC. Wm8731 is clocked by a crystal and used as a
> master on the SSC/I2S interface. Its connections are a headphone jack
> and an Line input jack.
> 
> [Richard: this is based on an old patch from Nicolas that I forward
> ported and reworked to use only device tree]

> diff --git a/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt b/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt

> +* Atmel at91sam9x5ek wm8731 audio complex
> +
> +Required properties:
> +  - compatible: "atmel,sam9x5-wm8731-audio"
> +  - atmel,model: The user-visible name of this sound complex.
> +  - atmel,ssc-controller: The phandle of the SSC controller
> +  - atmel,audio-codec: The phandle of the WM8731 audio codec
> +  - atmel,audio-routing: A list of the connections between audio components.
> +    Each entry is a pair of strings, the first being the connection's sink,
> +    the second being the connection's source.
> +
> +Available audio endpoints for the audio-routing table:
> +
> +Board connectors:
> + * Headphone Jack
> + * Line In Jack
> +
> +wm8731 pins:
> +cf Documentation/devicetree/bindings/sound/wm8731.txt

In the Tegra bindings, I deliberately put the list of CODEC pins into
the audio complex binding rather than the CODEC binding. That's because
I'm not sure that in the long-term we want to use strings to identify
the CODEC pins, rather than using integers. By putting the list orf
CODEC pins in the audio complex binding rather than the CODEC binding, I
didn't lumber the CODEC binding with a list of strings that it had to
support forever.

One reason that strings are problematic is because they can't be mixed
with integers/phandles in the same property, so if we ever end up with
more generic audio bindings where the routing table is expressed more like:

audio-routes = <&component_a $a_pin &component_b $b_pin>;

... in order to allow completely arbitrary and fully name-spaced routing
specification[1], then $a_pin and $b_pin need to be integers not strings.

[1] and perhaps we can get rid of properties like
audio-codec/ssc-controller, and automatically deduce which components
are needed simply by finding all phandles in the audio-routes property.

Perhaps the solution here is to allow mixing phandles/integers/strings
in one property, but that's potentially quite a large change to the DTB
format; we'd need to introduce type fields into the property data, and
other data format changes.
