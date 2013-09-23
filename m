From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 15:19:56 -0600
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <20130919105437.75e0f0a3@armhf>
References: <20130919105437.75e0f0a3@armhf>
Message-ID: <5240B07C.6080404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2013 02:54 AM, Jean-Francois Moine wrote:
> This patch adds a simple sound codec which is described by the DT.
> This codec may be used when no specific codec action is needed.

> diff --git a/Documentation/devicetree/bindings/sound/simple-codec.txt b/Documentation/devicetree/bindings/sound/simple-codec.txt

> +Device-Tree bindings for the simple codec
> +
> +Required properties:
> +- compatible: should be "linux,simple-codec".

We shouldn't have any Linux-specific bindings. It might be reasonable to
define a binding for a "simple CODEC", but there's no reason it should
be Linux-specific.

> +- dai-name: name of the codec

That should be internal to the driver; it's Linux-specific.

> +Optional properties:
> +- capture: information about capture
> +- playback: information about playback
> +At least one of the 'capture' or 'playback' nodes must be present.

Judging by the example, those are nodes not properties.

> +Child 'capture' and 'playback' required properties:
> +- stream-name: name of the stream

Stream name is also probably too Linux-specific.

> +- formats: list of the supported formats (see below)
> +- rates: list of the supported rates (see below)
> +- #channels: minimum and maximum numbers of channels
> +
> +Formats:
> +	"s8"
> +	"u8"

I think the binding should specify on-the-wire formats, not in-memory
formats. For example, if this binding is used to represent an I2S CODEC,
it's more important to know whether it supports left-justified,
right-justified, DSP mode, etc., and the max number of bits (or perhaps
a list of supported numbers of bits) per channel in each case.
