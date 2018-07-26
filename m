From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jul 2018 21:50:05 +0200
Subject: [PATCH 5/5] arm: dts: aspeed: Add power9 CFAM dtsi and use it on
 OpenPower P9 machines
In-Reply-To: <20180724042406.15374-6-benh@kernel.crashing.org>
References: <20180724042406.15374-1-benh@kernel.crashing.org>
 <20180724042406.15374-6-benh@kernel.crashing.org>
Message-ID: <CAOesGMjAGb7T-89C3eYPf7zsPYSp=7CVx756PNngs73ue27Jhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I came across this patch as part of Joel's pull request, so this is
somewhat high latency review that I guess nobody else cared to do:


On Tue, Jul 24, 2018 at 6:24 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This provides proper chip IDs but also adds the various sub-devices
> necessary for the future OCC driver among other. All the added nodes
> comply with the existing upstream FSI bindings.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts  |   1 +
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |   2 +
>  .../boot/dts/aspeed-bmc-opp-witherspoon.dts   |   2 +
>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |   2 +
>  arch/arm/boot/dts/ibm-power9-cfam.dtsi        | 104 ++++++++++++++++++
>  arch/arm/boot/dts/ibm-power9-dual.dtsi        |  58 ++++++++++
>  6 files changed, 169 insertions(+)
>  create mode 100644 arch/arm/boot/dts/ibm-power9-cfam.dtsi
>  create mode 100644 arch/arm/boot/dts/ibm-power9-dual.dtsi
>

> diff --git a/arch/arm/boot/dts/ibm-power9-cfam.dtsi b/arch/arm/boot/dts/ibm-power9-cfam.dtsi
> new file mode 100644
> index 000000000000..5bda517f93cc
> --- /dev/null
> +++ b/arch/arm/boot/dts/ibm-power9-cfam.dtsi
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2018 IBM Corp
> +
> +#define __MAKE_LABEL(p,i)      p##i
> +#define _MAKE_LABEL(p,i)       __MAKE_LABEL(p,i)
> +#define HUB_LABEL              _MAKE_LABEL(fsi_hub,CFAM_CHIP_ID)
> +#define I2C_LABEL(n)           _MAKE_LABEL(_MAKE_LABEL(cfam,CFAM_CHIP_ID),_i2c##n)

This is a red flag with respect to obscurity. It's a magic dtsi file
that has to be included at the right spot in the dts file or things
will break horribly -- we really try to avoid those kind of
constructs.

Also, you use it by passing in a predefined CHIP_ID, so you have
#define / #include / #undef. And on top of that you have open-coded
actual stable naming references to nodes that can't be found because
they're created by macros.

I know you want this to instantiate a bunch of boilerplate, so if you
want to do that, maybe you'd be better off having this file just
define a couple of macros, and then instantiate the actual subtrees
with that macro (the macro can then take the chipid). That way you can
still expose the same label-making macros in the locations where you
setup the stable naming. Much less cognitive load on someone trying to
read it and figure out just what's being instantiated where, and what
nodes the i2c<#> aliases are referring to.

Also:

> +/ {
> +       aliases {
> +               i2c100 = &cfam0_i2c0;
> +               i2c101 = &cfam0_i2c1;
> +               i2c102 = &cfam0_i2c2;
> +               i2c103 = &cfam0_i2c3;
> +               i2c104 = &cfam0_i2c4;
> +               i2c105 = &cfam0_i2c5;
> +               i2c106 = &cfam0_i2c6;
> +               i2c107 = &cfam0_i2c7;
> +               i2c108 = &cfam0_i2c8;
> +               i2c109 = &cfam0_i2c9;
> +               i2c110 = &cfam0_i2c10;
> +               i2c111 = &cfam0_i2c11;
> +               i2c112 = &cfam0_i2c12;
> +               i2c113 = &cfam0_i2c13;
> +               i2c114 = &cfam0_i2c14;
> +               i2c200 = &cfam1_i2c0;
> +               i2c201 = &cfam1_i2c1;
> +               i2c202 = &cfam1_i2c2;
> +               i2c203 = &cfam1_i2c3;
> +               i2c204 = &cfam1_i2c4;
> +               i2c205 = &cfam1_i2c5;
> +               i2c206 = &cfam1_i2c6;
> +               i2c207 = &cfam1_i2c7;
> +               i2c208 = &cfam1_i2c8;
> +               i2c209 = &cfam1_i2c9;
> +               i2c210 = &cfam1_i2c10;
> +               i2c211 = &cfam1_i2c11;
> +               i2c212 = &cfam1_i2c12;
> +               i2c213 = &cfam1_i2c13;
> +               i2c214 = &cfam1_i2c14;

This is... unconventional. Fixed mapping but up at a high bus range
such that it won't conflict with other SoC busses?

Just make your tools figure out what bus to use with sysfs or DT
entries instead, much less of a hack. We've done these things to IRQs
and GPIOs in the past, and it's a pain to clean up later.


-Olof
