From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 27 Mar 2013 13:10:23 +0200
Subject: [PATCH 6/6] video: fb: vt8500: Convert framebuffer drivers to
 standardized binding
In-Reply-To: <1364374021-10844-7-git-send-email-linux@prisktech.co.nz>
References: <1364374021-10844-1-git-send-email-linux@prisktech.co.nz>
 <1364374021-10844-7-git-send-email-linux@prisktech.co.nz>
Message-ID: <5152D39F.1090104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2013-03-27 10:47, Tony Prisk wrote:
> Now that a display timing binding is available, convert our almost identical
> binding to use the standard binding.
> 
> This patch converts the vt8500 and wm8505 framebuffer drivers and
> associated dts/dtsi files to use the standard binding as defined in
> bindings/video/display-timing.txt.
> 
> There are two side-effects of making this conversion:
> 
> 1) The fb node should now be in the board file, rather than the soc file as
> the display-timing node is a child of the fb node.
> 
> 2) We still require a bits per pixel property to initialize the framebuffer
> for the different lcd panels. Rather than including this as part of the
> display timing, it is moved into the framebuffer node.
> 
> I have also taken the opportunity to alphabetise the includes of each
> driver to avoid double-ups.

I don't think this is correct. I don't have that much experience with
DT, but I think you should have, for example:

wm8850.dtsi:

	fb: fb at d8051700 {
		compatible = "wm,wm8505-fb";
		reg = <0xd8051700 0x200>;
	};

wm8850-w70v2.dts:

&fb {
	bits-per-pixel = <16>;

	display-timings {
		native-mode = <&timing0>;
		timing0: 800x480 {
			clock-frequency = <0>;
			...
		};
	};
};

So, the core fb part should be in the SoC's file, as it's part of the
SoC. And the stuff that tells what kind of display is attached is in the
board dts file.

Also, just a word of warning, I think the videomode series I've sent for
review will cause some breakage with this series if the videomode series
is accepted. Nothing difficult to fix, though, but we'll need some extra
management to avoid compilation failures.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/50215154/attachment.sig>
