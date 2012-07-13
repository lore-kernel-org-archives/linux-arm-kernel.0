From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Jul 2012 10:48:54 +0200
Subject: [PATCH 0/7] Add support for Freescale's mc34708 to mc13xxx driver
In-Reply-To: <11987916.rOoNGcb1ly@dev1>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <11987916.rOoNGcb1ly@dev1>
Message-ID: <20120713084854.GD592@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[I added git at vger.k.o to Cc: please strip the recipents accordingly if
you reply.]

On Fri, Jul 13, 2012 at 09:02:56AM +1000, Marc Reilly wrote:
> Hi Uwe,
> 
> > This series was tested on a Phytec pcm038 (mc13783 on spi) using
> > traditional boot (i.e. not dt) and on a i.MX53 based machine (mc34708 on
> > i2c) using dt boot.
> > 
> > Philippe's patches are already in next, they are just included here for
> > those who want to test the patches. The 'mfd/mc13xxx: drop modifying
> > driver's id_table in probe' was already sent out yesterday and is
> > included here because the last patch depends on it.
> > 
> 
> For all patches (that don't already have it):
> Acked-by: Marc Reilly <marc@cpdesign.com.au>
Thanks.

> If for some reason you do a V2:
> - In patch 6 moves line "#define MC13XXX_NUMREGS 0x3f" around, is this 
> necessary?
It doesn't move it around, that's only how it looks. I removed enum
mc13xxx_id (above MC13XXX_NUMREGS) and added struct mc13xxx_variant
(below MC13XXX_NUMREGS). Git choosed to use the closing brace of enum
mc13xxx_id and struct mc13xxx_variant respectively as context (together
with the following empty line).
(For the new readers, here is how git represented the relevant part:

 #include <linux/regmap.h>
 #include <linux/mfd/mc13xxx.h>

-enum mc13xxx_id {
-	MC13XXX_ID_MC13783,
-	MC13XXX_ID_MC13892,
-	MC13XXX_ID_INVALID,
+#define MC13XXX_NUMREGS 0x3f
+
+struct mc13xxx;
+
+struct mc13xxx_variant {
+	const char *name;
+	void (*print_revision)(struct mc13xxx *mc13xxx, u32 revision);
 };

-#define MC13XXX_NUMREGS 0x3f
+extern struct mc13xxx_variant
+		mc13xxx_variant_mc13783,
+		mc13xxx_variant_mc13892;

 struct mc13xxx {
 	struct regmap *regmap;
...
)

The following would be an equivalent and (for humans) easier to review
patch:

 #include <linux/regmap.h>
 #include <linux/mfd/mc13xxx.h>

-enum mc13xxx_id {
-	MC13XXX_ID_MC13783,
-	MC13XXX_ID_MC13892,
-	MC13XXX_ID_INVALID,
-};
-
 #define MC13XXX_NUMREGS 0x3f

+struct mc13xxx;
+
+struct mc13xxx_variant {
+	const char *name;
+	void (*print_revision)(struct mc13xxx *mc13xxx, u32 revision);
+};
+
+extern struct mc13xxx_variant
+		mc13xxx_variant_mc13783,
+		mc13xxx_variant_mc13892;
+
 struct mc13xxx {
 	struct regmap *regmap;
...

But as this touches 17 lines compared to only 15 using the way git
choosed to represent patch 6, git used the smaller representation. (I'm
not sure this is the correct reason, but at least it sounds sensible.)
Usually this metric is sane, but here it's not. I don't know if you can
do anything about it? E.g. take the number of +, - and context blocks
into account. Then it would be 5 for the patch above vs. 7 for the
way git did it.
Or weight a context line containing

	#define MC13XXX_NUMREGS 0x3f

more than two lines one of which is empty and the other only contains a
}?

> - Patch 4 should come last, ie after "add support for mc34708"
Yeah, but it doesn't break bisectibility, and as the rtc patches go in via a
different tree (in fact akpm already took them) it doesn't matter much.

Best regards and thanks for your feedback
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
