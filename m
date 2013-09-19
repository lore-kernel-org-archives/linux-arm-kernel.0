From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Sep 2013 11:40:28 +0100
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <20130919105437.75e0f0a3@armhf>
References: <20130919105437.75e0f0a3@armhf>
Message-ID: <20130919104028.GI21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 10:54:37AM +0200, Jean-Francois Moine wrote:
> This patch adds a simple sound codec which is described by the DT.
> This codec may be used when no specific codec action is needed.

Hrm.  I'm generally not enthusiastic about this sort of thing because it
requires every user of the device to understand the capabilities of the
device instead of being able to just say they have a device of type X -
it seems better to type the data in once in a driver and then reference
it.  That said...

> +Child 'capture' and 'playback' required properties:
> +- stream-name: name of the stream

What does this mean in the binding?

> +Formats:
> +	"s8"
> +	"u8"

I'd cut this down to just the PCM formats for now - many of the formats
you list there aren't terribly well defined even within ALSA, I don't
think some of them have ever been used at all.  A binding document
should really document what things mean as well.

> +Rates:
> +	5512
> +	8000

This shouldn't be a list of defined rates, it should allow any number,
and it should support ranges since while some devices do enumerate
specific rates simpler devices often just support a continuous range of
rates.

> --- a/sound/soc/generic/Kconfig
> +++ b/sound/soc/generic/Kconfig

CODEC drivers should go in codecs.

> +#define DRV_NAME "simple-codec"

Just write the string in the one place where it is used.

> +static char *format_tb[] = {
> +	"s8", "u8", "s16_le", "s16_be",
> +	"u16_le", "u16_be", "s24_le", "s24_be",
> +	"u24_le", "u24_be", "s32_le", "s32_be",
> +	"u32_le", "u32_be", "float_le", "float_be",
> +
> +	"float64_le", "float64_be", "iec958_subframe_le", "iec958_subframe_be",
> +	"mu_law", "a_law", "ima_adpcm", "mpeg",
> +	"gsm", "", "", "",
> +	"", "", "", "special",

This seems a bit obscure and fragile - an explicit lookup table would be
better I think.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130919/01798a1f/attachment.sig>
