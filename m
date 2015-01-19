From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Jan 2015 14:20:02 +0100
Subject: [PATCH] ARM: dts: sun4i: Add simplefb node with
 de_fe0-de_be0-lcd0-hdmi pipeline
In-Reply-To: <1421672477-12978-2-git-send-email-hdegoede@redhat.com>
References: <1421672477-12978-1-git-send-email-hdegoede@redhat.com>
 <1421672477-12978-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150119132002.GD4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Mon, Jan 19, 2015 at 02:01:17PM +0100, Hans de Goede wrote:
> Testing has shown that on sun4i the display backend engine does not have
> deep enough fifo-s causing flickering / tearing in full-hd mode due to
> fifo underruns. This can be avoided by letting the display frontend engine
> do the dma from memory, and then letting it feed the data directly into
> the backend unmodified, as the frontend does have deep enough fifo-s.
> 
> Note since u-boot-v2015.01 has been released using the de_be0-lcd0-hdmi
> pipeline on sun4i, we need to keep that one around too (unfortunately).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index f5e35b5..ccd60e3 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -44,6 +44,14 @@
>  				 <&ahb_gates 44>;
>  			status = "disabled";
>  		};
> +
> +		framebuffer at 1 {
> +			compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
> +			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
> +			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
> +				 <&ahb_gates 44>, <&ahb_gates 46>;
> +			status = "disabled";
> +		};

Thanks for this.

I do have a question though, maybe I'm missing something, but what
would prevent us from using the existing node already? The output
pipeline seems to be the same, at least for which output we
use. Wether we use or not the display frontend looks like an
implementation detail.

That or just having several strings in allwinner,pipeline.

If this simplefb binding is just going to be a collection of all the
various combinations we have, plus the legacy options, I'm a bit
worried that this is just going to be a hell to maintain, without any
way to remove it at compile time (if such feature is ever merged in
DTC).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/bca6e4d2/attachment.sig>
