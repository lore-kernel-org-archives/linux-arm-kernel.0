From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 6 May 2018 06:08:57 +0000
Subject: [PATCH V6 4/7] ARM: dts: imx6sx-sabreauto: add fec support
In-Reply-To: <CAOMZO5B8xrnjyoPoj0J_+WM6TBbE1Gbq8HChdTCQ=UpKYyRBmQ@mail.gmail.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
 <1525508963-7986-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5B8xrnjyoPoj0J_+WM6TBbE1Gbq8HChdTCQ=UpKYyRBmQ@mail.gmail.com>
Message-ID: <AM3PR04MB1315664F28DCADA2448C1FFAF5840@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Saturday, May 5, 2018 8:11 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Haibo Chen <haibo.chen@freescale.com>; Andy Duan
> <fugang.duan@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>; Robin Gong
> <yibin.gong@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V6 4/7] ARM: dts: imx6sx-sabreauto: add fec support
> 
> On Sat, May 5, 2018 at 5:29 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Add FEC support on i.MX6SX Sabre Auto board.
> >
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> 
> Again, it is not clear who is the author here. Is it Fugang or yourself?
 
Same story explained in patch V6 7/7.

> 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V5:
> >         use "gpios" instead of "enable-gpio".
> >  arch/arm/boot/dts/imx6sx-sabreauto.dts | 80
> > ++++++++++++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > index 4d41b4d..7dda741 100644
> > --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> > @@ -18,6 +18,17 @@
> >                 reg = <0x80000000 0x80000000>;
> >         };
> >
> > +       reg_fec: fec_io_supply {
> > +               compatible = "regulator-gpio";
> > +               regulator-name = "1.8V_1.5V_FEC";
> > +               regulator-min-microvolt = <1500000>;
> > +               regulator-max-microvolt = <1800000>;
> > +               states = <1500000 0x0 1800000 0x1>;
> > +               gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;
> > +               vin-supply = <&sw2_reg>;
> > +               enable-active-high;
> > +       };
> 
> I still find this confusing.
> 
> There is no consumer for reg_fec in, so it seems you are relying on the fact that
> the kernel regulator core will disable reg_fec to put the regulator in the state
> you require.

Adding consumer for reg_fec in NOT available in this patch, as FEC driver itself
does NOT support setting IO voltage based on setting of dtb, so if want to add
consumer, need to patch FEC driver as well.

As I explained before, this reg is for adjusting IO voltage between 1.5V and 1.8V,
and FEC driver can work on both of them, current FEC driver can work well no matter
if it is 1.5V or 1.8V, to avoid confusion, I think I can remove this reg_fec in this patch series,
let FEC driver work with default setting of this GPIO regulator, we can add reg_fec support
after FEC driver supports adjusting IO voltage. Thanks.

Anson.
