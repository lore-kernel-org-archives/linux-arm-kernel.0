From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Aug 2017 17:46:58 +0800
Subject: [linux-sunxi] [PATCH 3/4] drivers: soc: sunxi: add support for
 remapping func value to reg value
In-Reply-To: <20170809085627.32687-4-icenowy@aosc.io>
References: <20170809085627.32687-1-icenowy@aosc.io>
 <20170809085627.32687-4-icenowy@aosc.io>
Message-ID: <CAGb2v64ryu76PcKZtaeC0g7C=02hy9os80X3wTyRkyNEFZ0QZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 4:56 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> On some Allwinner SoCs, sometimes the value needed to write into the
> register to claim SRAM is not equal to the value specified in the
> device tree.
>
> We now defines 0 as "CPU" and 1 as "Device", however, for VE SRAM, the
> register needs to be written 0x7FFFFFFF to claim it to VE, and for
> Allwinner A64's SRAM C the needed register value to claim it to DE2 is
> 0, and the value that enables CPU's access to the SRAM is 1.

The device tree binding defines 0 as "mapped to CPU" and 1 as "mapped
to X device". This matches the value written to the configuration
register for the SRAM blocks currently supported. However, the not yet
supported VE SRAM block is claimed for the device by writing 0x7fffffff,
which is vastly different from the other blocks. On the A64, SRAM C is
claimed by the device by writing a 0, which is the opposite of the current
design.

>
> Add a value remapping in sunxi_sram_func structure, and let the
> sunxi_sram_of_parse function set the remapped register value.

Add:

This allows us to keep the convention currently used in the device tree
binding.

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Some amendments to the commit message above. Code looks good.
