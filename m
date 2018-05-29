From: lukma@denx.de (Lukasz Majewski)
Date: Tue, 29 May 2018 15:58:12 +0200
Subject: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
In-Reply-To: <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
References: <20180509153428.1440-1-lukma@denx.de>
 <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
 <20180519140202.3449e3c1@jawa>
 <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
Message-ID: <20180529155736.275e27b1@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Hi Lukasz,
> 
> On Sat, May 19, 2018 at 9:02 AM, Lukasz Majewski <lukma@denx.de>
> wrote:
> 
> > After removing imx53-kp-ddc and imx53-kp-common iomux subnodes I do
> > see following errors in the dmesg (v4.17-rc5):
> >
> > imx53-pinctrl 53fa8000.iomuxc: function 'iomuxc' not supported
> > imx53-pinctrl 53fa8000.iomuxc: invalid function iomuxc in map
> > table  
> 
> Could you please investigate this error?

Sorry for "small" delay on this.

Ok, so I've investigated the issue:

1. The code, which you pasted:
http://code.bulix.org/ik01yu-339697

works correctly as imx53-qsb-common.dtsi directly includes "imx53.dtsi"
in which iomuxc label is defined.

In my case though,

2. I do include imx53-tqma53.dtsi [1], in which the iomuxc" label
is extended:

&iomuxc {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_hog>;

	imx53-tqma53 {
		pinctrl_hog: hoggrp {

.......

};

The imx53-tqma53.dtsi then includes imx53.dtsi.

Moreover, my file -> imx53-kp.dtsi as it includes [1], it extends
further the &iomuxc label:

&iomuxc {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_kp_common>;
	
	imx53-kp-common {
		pinctrl_buzzer: buzzergrp {
.......
};

So, when I remove imx53-kp-common I will have mismatch with [1] iomuxc
structure.

The code works as expected when I do remove imx53-tqma53 in [1].

However, I would prefer to not touch this imx53-tqma53.dtsi file.
It is also included in: imx53-mba53.dts, which extends iomux in
following way:

&iomuxc {
        lvds1 {
                pinctrl_lvds1_1: lvds1-grp1 {


Here I would need to remove lvds1, disp1 and tve to make it working.
However, it will not break during build, but at run time.

Considering the above, I would prefer to leave the code in [1] as is
and use imx53-kp-common as well (as in v2 of this patch).

Fabio, what do you think?

[I'm using linux 4.17-rc7 (with included dtc 1.4.6)]

> 
> I have just tried the following change on a imx53-qsb:
> http://code.bulix.org/ik01yu-339697
> 
> and it works as expected:
> # dmesg  | grep iomux
> [    0.100046] imx53-pinctrl 53fa8000.iomuxc: initialized IMX pinctrl
> driver




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180529/4d73a962/attachment.sig>
