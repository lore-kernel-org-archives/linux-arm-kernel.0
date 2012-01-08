From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 8 Jan 2012 12:55:05 -0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <20120108145254.GE20216@S2101-09.ap.freescale.net>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
 <20120108145254.GE20216@S2101-09.ap.freescale.net>
Message-ID: <20120108205504.GF29065@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 10:52:56PM +0800, Shawn Guo wrote:
> On Fri, Jan 06, 2012 at 11:25:41AM +0800, Richard Zhao wrote:

> > +					VDDA-supply = <&reg_2P5V>;
> > +					VDDIO-supply = <&reg_3P3V>;

> I would prefer to have them named vdda-supply and vddio-supply.  But
> I just learnt that they do not work, because sgtl5000 driver
> (sound/soc/codecs/sgtl5000.c) has the supply_names in upper case, while
> unlike of_node_cmp() is strcasecmp(), of_prop_cmp() is just strcmp().

> But the convention on property name is really all using lower case,
> and mixing cases there looks odd, so I'm thinking about the changes
> below on of_get_regulator().

>         snprintf(prop_name, 32, "%s-supply", supply);
> +       while (prop_name[i] && i < 32) {
> +               prop_name[i] = tolower(prop_name[i]);
> +               i++;
> +       }

There's two big problems here.  One is that we clearly shouldn't be
open coding this here but adding a function for it.  The other is that
this is going to break any existing device tree which has upper cased
supplies.  If we were going to do something here I'd go with case
insensitve matching though I'm not sure it's a real problem.
