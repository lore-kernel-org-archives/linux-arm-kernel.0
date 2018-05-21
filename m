From: jacopo@jmondi.org (jacopo mondi)
Date: Mon, 21 May 2018 14:33:40 +0200
Subject: [PATCH v3 2/3] arm64: dts: renesas: draak: Describe CVBS input
In-Reply-To: <6943843.2osudLfTFd@avalon>
References: <1526654878-11143-1-git-send-email-jacopo+renesas@jmondi.org>
 <1569661.saMqNra8vc@avalon> <20180521095705.GC4432@w540>
 <6943843.2osudLfTFd@avalon>
Message-ID: <20180521123340.GA15035@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Mon, May 21, 2018 at 01:54:55PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
>
> On Monday, 21 May 2018 12:57:05 EEST jacopo mondi wrote:
> > On Fri, May 18, 2018 at 06:12:15PM +0300, Laurent Pinchart wrote:
> > > On Friday, 18 May 2018 17:47:57 EEST Jacopo Mondi wrote:
> > >> Describe CVBS video input through analog video decoder ADV7180
> > >> connected to video input interface VIN4.
> > >>
> > >> The video input signal path is shared with HDMI video input, and
> > >> selected by on-board switches SW-53 and SW-54 with CVBS input selected
> > >> by the default switches configuration.
> > >>
> > >> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > >> Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> > >>
> > >> ---
> > >> v2 -> v3:
> > >> - Add comment to describe the shared input video path
> > >> - Add my SoB and Niklas' R-b tags
> > >> ---
> > >>
> > >>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 42 +++++++++++++++++++
> > >>  1 file changed, 42 insertions(+)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > >> b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts index 9d73de8..95745fc
> > >> 100644
> > >> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > >> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > >> @@ -142,6 +142,11 @@
> > >>  		groups = "usb0";
> > >>  		function = "usb0";
> > >>  	};
> > >> +
> > >> +	vin4_pins_cvbs: vin4 {
> > >> +		groups = "vin4_data8", "vin4_sync", "vin4_clk";
> > >> +		function = "vin4";
> > >> +	};
> > >>  };
> > >>
> > >>  &i2c0 {
> > >> @@ -154,6 +159,23 @@
> > >>  		reg = <0x50>;
> > >>  		pagesize = <8>;
> > >>  	};
> > >> +
> > >> +	analog-video at 20 {
> > >> +		compatible = "adi,adv7180";
> > >> +		reg = <0x20>;
> > >> +
> > >> +		port {
> > >
> > > The adv7180 DT bindings document the output port as 3 or 6 (respectively
> > > for the CP and ST versions of the chip). You should thus number the port.
> > > Apart from that the patch looks good.
> >
> > I admit I have barely copied this from Gen-2 boards DTS, but reading
> > the driver code and binding description again, I think this is
> > correct, as the output port numbering and mandatory input port (which
> > is missing here) only apply to adv7180cp/st chip versions.
> >
> > Here we describe plain adv7180, no need to number output ports afaict.
>
> Indeed, my bad.
>
> Shouldn't you however use "adi,adv7180cp" as that's the chip we are using ?
> The "adi,adv7180" has no port documented in its DT bindings, so it shouldn't
> have any port node at all.

I'm a bit confused here.

The only Gen-2 board using the "adi,adv7180cp" compatible string is
Gose, which is also the only one I can get schematics for. That board
indeed feature an ADV7180WBCP32Z, as the Draak does. I cannot get
schematics for any other Gen-2 board, to compare the ADV7180 variant
installed there. If anyone can confirm that all other Gen-2 board uses
a different version (or that all other Gen-2 board DTS file use a
wrong compatible string value), I'll re-send this with a different
compatible value and proper port nodes numbering.

Thanks
  j
>
> > >> +			/*
> > >> +			 * The VIN4 video input path is shared between
> > >> +			 * CVBS and HDMI inputs through SW[49-54] switches.
> > >> +			 *
> > >> +			 * CVBS is the default selection, link it to VIN4 here.
> > >> +			 */
> > >> +			adv7180_out: endpoint {
> > >> +				remote-endpoint = <&vin4_in>;
> > >> +			};
> > >> +		};
> > >> +	};
> > >>  };
> > >>
> > >>  &i2c1 {
> > >> @@ -246,3 +268,23 @@
> > >>  	timeout-sec = <60>;
> > >>  	status = "okay";
> > >>  };
> > >> +
> > >> +&vin4 {
> > >> +	pinctrl-0 = <&vin4_pins_cvbs>;
> > >> +	pinctrl-names = "default";
> > >> +
> > >> +	status = "okay";
> > >> +
> > >> +	ports {
> > >> +		#address-cells = <1>;
> > >> +		#size-cells = <0>;
> > >> +
> > >> +		port at 0 {
> > >> +			reg = <0>;
> > >> +
> > >> +			vin4_in: endpoint {
> > >> +				remote-endpoint = <&adv7180_out>;
> > >> +			};
> > >> +		};
> > >> +	};
> > >> +};
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/96b4ef37/attachment.sig>
