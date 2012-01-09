From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jan 2012 08:56:05 +0800
Subject: [PATCH 4/6] arm/dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <20120108205504.GF29065@opensource.wolfsonmicro.com>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-5-git-send-email-richard.zhao@linaro.org>
 <20120108145254.GE20216@S2101-09.ap.freescale.net>
 <20120108205504.GF29065@opensource.wolfsonmicro.com>
Message-ID: <20120109005603.GA1835@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 12:55:05PM -0800, Mark Brown wrote:
> On Sun, Jan 08, 2012 at 10:52:56PM +0800, Shawn Guo wrote:
> > On Fri, Jan 06, 2012 at 11:25:41AM +0800, Richard Zhao wrote:
> 
> > > +					VDDA-supply = <&reg_2P5V>;
> > > +					VDDIO-supply = <&reg_3P3V>;
> 
> > I would prefer to have them named vdda-supply and vddio-supply.  But
> > I just learnt that they do not work, because sgtl5000 driver
> > (sound/soc/codecs/sgtl5000.c) has the supply_names in upper case, while
> > unlike of_node_cmp() is strcasecmp(), of_prop_cmp() is just strcmp().
> 
> > But the convention on property name is really all using lower case,
> > and mixing cases there looks odd, so I'm thinking about the changes
> > below on of_get_regulator().
> 
> >         snprintf(prop_name, 32, "%s-supply", supply);
> > +       while (prop_name[i] && i < 32) {
> > +               prop_name[i] = tolower(prop_name[i]);
> > +               i++;
> > +       }
> 
> There's two big problems here.  One is that we clearly shouldn't be
> open coding this here but adding a function for it.  The other is that
> this is going to break any existing device tree which has upper cased
> supplies.  If we were going to do something here I'd go with case
> insensitve matching though I'm not sure it's a real problem.

Ok, let's test device tree maintainers.

Grant, Rob,

Could the problem we are seeing here be a good reason to make the
following change?

diff --git a/include/linux/of.h b/include/linux/of.h
index a75a831..c26c20f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -147,7 +147,7 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 /* Default string compare functions, Allow arch asm/prom.h to override */
 #if !defined(of_compat_cmp)
 #define of_compat_cmp(s1, s2, l)       strcasecmp((s1), (s2))
-#define of_prop_cmp(s1, s2)            strcmp((s1), (s2))
+#define of_prop_cmp(s1, s2)            strcasecmp((s1), (s2))
 #define of_node_cmp(s1, s2)            strcasecmp((s1), (s2))
 #endif

-- 
Regards,
Shawn
