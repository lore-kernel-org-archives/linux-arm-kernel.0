From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 12:05:43 +0200
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140714100542.GB9870@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
> at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> controller device.
> 
> The HLCDC block provides a single RGB output port, and only supports LCD
> panels connection to LCD panels for now.
> 
> The atmel,panel property link the HLCDC RGB output with the LCD panel
> connected on this port (note that the HLCDC RGB connector implementation
> makes use of the DRM panel framework).
> 
> Connection to other external devices (DRM bridges) might be added later by
> mean of a new atmel,xxx (atmel,bridge) property.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt

This is the wrong directory. Device tree bindings describe hardware, but
DRM is a Linux-specific framework. And yes, there are already files in
that directory, I know, but that doesn't make it any better.

I suggest either devicetree/bindings/gpu or devicetree/bindings/video.

> diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
[...]
> +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
> +See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt for more details.

I think it's better to refer to these using relative filenames. When the
device tree bindings are moved out of the kernel tree, they may no
longer use the same hierarchy.

> +Required properties:
> + - compatible: value should be one of the following:
> +   "atmel,hlcdc-dc"

There's only one value, so perhaps: should be "atmel,hlcdc-dc".

> + - atmel,panel: Should contain a phandle with 2 parameters.
> +   The first cell is a phandle to a DRM panel device
> +   The second cell encodes the RGB mode, which can take the following values:
> +   * 0: RGB444
> +   * 1: RGB565
> +   * 2: RGB666
> +   * 3: RGB888

These are properties of the panel and should be obtained from the panel
directly rather than an additional cell in this specifier.

> +   The third cell encodes specific flags describing LCD signals configuration
> +   (see Atmel's datasheet for a full description of these fields):
> +   * bit 0: HSPOL: Horizontal Synchronization Pulse Polarity
> +   * bit 1: VSPOL: Vertical Synchronization Pulse Polarity
> +   * bit 2: VSPDLYS: Vertical Synchronization Pulse Start
> +   * bit 3: VSPDLYE: Vertical Synchronization Pulse End
> +   * bit 4: DISPPOL: Display Signal Polarity
> +   * bit 7: DISPDLY: LCD Controller Display Power Signal Synchronization
> +   * bit 12: VSPSU: LCD Controller Vertical synchronization Pulse Setup Configuration
> +   * bit 13: VSPHO: LCD Controller Vertical synchronization Pulse Hold Configuration
> +   * bit 16-20: GUARDTIME: LCD DISPLAY Guard Time

Similarly for most of these: HSPOL and VSPOL seem to correspond to the
DRM_MODE_FLAG_{{P,N},{H,V}}SYNC flags in struct drm_display_mode. And
VSPDLYS as well as VSPDLYE sound like they may be vsync_start and
vsync_end of the same structure.

As for the others, maybe if you could explain what exactly they are we
may be able to find a better fit.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/b4cf2773/attachment.sig>
