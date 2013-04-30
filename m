From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 30 Apr 2013 10:39:43 +0300
Subject: [PATCH V2] video: implement a simple framebuffer driver
In-Reply-To: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <517F753F.5090909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 05:39 AM, Stephen Warren wrote:
> A simple frame-buffer describes a raw memory region that may be rendered
> to, with the assumption that the display hardware has already been set
> up to scan out from that buffer.
> 
> This is useful in cases where a bootloader exists and has set up the
> display hardware, but a Linux driver doesn't yet exist for the display
> hardware.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> v2: s/dumb/simple/ throughout. Provide more details on pixel format.
> 
> I ended up going with a separate FB driver:
> * DRM/KMS look much more complex, and don't provide any benefit that I can
>   tell for this simple driver.
> * Creating a separate driver rather than adjusting offb.c to work allows a
>   new clean binding to be defined, and doesn't require removing or ifdefing
>   PPC-isms in offb.c.
> ---
>  .../bindings/video/simple-framebuffer.txt          |   25 +++
>  drivers/video/Kconfig                              |   17 ++
>  drivers/video/Makefile                             |    1 +
>  drivers/video/simplefb.c                           |  234 ++++++++++++++++++++
>  4 files changed, 277 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/simple-framebuffer.txt
>  create mode 100644 drivers/video/simplefb.c
> 
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> new file mode 100644
> index 0000000..3ea4605
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> @@ -0,0 +1,25 @@
> +Simple Framebuffer
> +
> +A simple frame-buffer describes a raw memory region that may be rendered to,
> +with the assumption that the display hardware has already been set up to scan
> +out from that buffer.
> +
> +Required properties:
> +- compatible: "simple-framebuffer"
> +- reg: Should contain the location and size of the framebuffer memory.
> +- width: The width of the framebuffer in pixels.
> +- height: The height of the framebuffer in pixels.
> +- stride: The number of bytes in each line of the framebuffer.
> +- format: The format of the framebuffer surface. Valid values are:
> +  - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
> +
> +Example:
> +
> +	framebuffer {
> +		compatible = "simple-framebuffer";
> +		reg = <0x1d385000 (1600 * 1200 * 2)>;
> +		width = <1600>;
> +		height = <1200>;
> +		stride = <(1600 * 2)>;
> +		format = "r5g6b5";
> +	};

I'm not an expert on DT, but I think the point of DT is to describe the
hardware. This doesn't describe the hardware at all.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130430/f0ef8507/attachment-0001.sig>
