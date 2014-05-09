From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 May 2014 17:47:19 +0100
Subject: [PATCHv4 2/2] regmap: add DT endianness binding support.
In-Reply-To: <1399601073-19278-3-git-send-email-Li.Xiubo@freescale.com>
References: <1399601073-19278-1-git-send-email-Li.Xiubo@freescale.com>
 <1399601073-19278-3-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20140509164719.GE16418@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 03:04:33AM +0100, Xiubo Li wrote:
> For many drivers which will support rich endianness of CPU<-->Dev
> need define DT properties by itself without the binding support.
> 
> The endianness using regmap:
> Index    CPU       Device     Endianess flag for DT bool property
> ------------------------------------------------------------
> 1        LE        LE         -
> 2        LE        BE         'big-endian-{val,reg}'
> 3        BE        BE         -
> 4        BE        LE         'little-endian-{val,reg}'

Get rid of the CPU column. It has precisely _nothing_ to do with the
device.

If you happen to have a device that can be integrated with varying
endianness, the endianness should be described regardless of whether
this happens to be the same as the CPU endianness. The kernel can then
choose to do the right thing regardless.

Assuming LE or BE by default is sane if most implementations are one
rather than the other. Probing and figuring it out dynamically is also
fine. Assuming that it's the same as the kernel is broken in general,
and should be avoided -- those cases _require_ a *-endian property to
work if the CPU can function in either endianness.

> Please see the following documetation for detail:
>     Documentation/devicetree/bindings/endianness/endianness.txt

I don't think this is sufficient. That document describes the preferred
idiom, not the meaning w.r.t. a specific binding.

[...]

> +	case REGMAP_ENDIAN_REG:
> +		if (of_property_read_bool(np, "big-endian-reg"))
> +			*endian = REGMAP_ENDIAN_BIG;
> +		else if (of_property_read_bool(np, "little-endian-reg"))
> +			*endian = REGMAP_ENDIAN_LITTLE;

While this follows the guidelines you've added, context is still
required to understand precisely what this means. We need a binding
document describing what *-endian-reg means for this binding (i.e. what
does -reg cover? All registers? some? buffers?).

Imagine I added a little-endian-foo property. You'd be able to reason
that something is little endian, but you'd have no idea of precisely
what without reading documentation or code. As not everyone wants to
read several thousand lines of Linux kernel code to write a dts we
require documentation.

> +	case REGMAP_ENDIAN_VAL:
> +		if (of_property_read_bool(np, "big-endian-val"))
> +			*endian = REGMAP_ENDIAN_BIG;
> +		else if (of_property_read_bool(np, "little-endian-val"))
> +			*endian = REGMAP_ENDIAN_LITTLE;

Likewise.

Cheers,
Mark.
