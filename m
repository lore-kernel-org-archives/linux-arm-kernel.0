From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 11 Aug 2017 08:42:35 -0700
Subject: [PATCH v4 3/4] of: unittest: Add phandle remapping test
In-Reply-To: <20170811154236.12891-1-stephen.boyd@linaro.org>
References: <20170811154236.12891-1-stephen.boyd@linaro.org>
Message-ID: <20170811154236.12891-4-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Test the functionality of of_parse_phandle_with_args_map().

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/of/unittest-data/testcases.dts      |  11 +++
 drivers/of/unittest-data/tests-phandle.dtsi |  25 ++++++
 drivers/of/unittest.c                       | 120 ++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)

diff --git a/drivers/of/unittest-data/testcases.dts b/drivers/of/unittest-data/testcases.dts
index 12f7c3d649c8..173b96f39cd0 100644
--- a/drivers/of/unittest-data/testcases.dts
+++ b/drivers/of/unittest-data/testcases.dts
@@ -26,12 +26,23 @@
 / { __local_fixups__ {
 	testcase-data {
 		phandle-tests {
+			provider4 {
+				phandle-map = <0x00000008 0x00000018
+					       0x00000024 0x0000003c
+					       0x00000050 0x00000064>;
+			};
 			consumer-a {
 				phandle-list = <0x00000000 0x00000008
 						0x00000018 0x00000028
 						0x00000034 0x00000038>;
 				phandle-list-bad-args = <0x00000000 0x0000000c>;
 			};
+			consumer-b {
+				phandle-list = <0x00000000 0x00000008
+						0x00000018 0x00000024
+						0x00000030 0x00000034>;
+				phandle-list-bad-args = <0x00000000 0x0000000c>;
+			};
 		};
 		interrupts {
 			intmap0 {
diff --git a/drivers/of/unittest-data/tests-phandle.dtsi b/drivers/of/unittest-data/tests-phandle.dtsi
index 5b1527e8a7fb..59e297f497d1 100644
--- a/drivers/of/unittest-data/tests-phandle.dtsi
+++ b/drivers/of/unittest-data/tests-phandle.dtsi
@@ -25,6 +25,18 @@
 				#phandle-cells = <3>;
 			};
 
+			provider4: provider4 {
+				#phandle-cells = <2>;
+				phandle-map = <0 1 &provider1 3>,
+					      <4 0 &provider0>,
+					      <16 5 &provider3 3 5 0>,
+					      <200 8 &provider2 23 6>,
+					      <19 0 &provider2 15 0>,
+					      <2 3 &provider3 2 5 3>;
+				phandle-map-mask = <0xff 0xf>;
+				phandle-map-pass-thru = <0x0 0xf0>;
+			};
+
 			consumer-a {
 				phandle-list =	<&provider1 1>,
 						<&provider2 2 0>,
@@ -43,6 +55,19 @@
 				unterminated-string = [40 41 42 43];
 				unterminated-string-list = "first", "second", [40 41 42 43];
 			};
+
+			consumer-b {
+				phandle-list =	<&provider1 1>,
+						<&provider4 2 3>,
+						<0>,
+						<&provider4 4 0x100>,
+						<&provider4 0 0x61>,
+						<&provider0>,
+						<&provider4 19 0x20>;
+				phandle-list-bad-phandle = <12345678 0 0>;
+				phandle-list-bad-args = <&provider2 1 0>,
+							<&provider4 0>;
+			};
 		};
 	};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 0107fc680335..c6091d1e55de 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -443,6 +443,125 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 }
 
+static void __init of_unittest_parse_phandle_with_args_map(void)
+{
+	struct device_node *np, *p0, *p1, *p2, *p3;
+	struct of_phandle_args args;
+	int i, rc;
+
+	np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-b");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	p0 = of_find_node_by_path("/testcase-data/phandle-tests/provider0");
+	if (!p0) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	p1 = of_find_node_by_path("/testcase-data/phandle-tests/provider1");
+	if (!p1) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	p2 = of_find_node_by_path("/testcase-data/phandle-tests/provider2");
+	if (!p2) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	p3 = of_find_node_by_path("/testcase-data/phandle-tests/provider3");
+	if (!p3) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	rc = of_count_phandle_with_args(np, "phandle-list", "#phandle-cells");
+	unittest(rc == 7, "of_count_phandle_with_args() returned %i, expected 7\n", rc);
+
+	for (i = 0; i < 8; i++) {
+		bool passed = true;
+
+		rc = of_parse_phandle_with_args_map(np, "phandle-list",
+						    "phandle", i, &args);
+
+		/* Test the values from tests-phandle.dtsi */
+		switch (i) {
+		case 0:
+			passed &= !rc;
+			passed &= (args.np == p1);
+			passed &= (args.args_count == 1);
+			passed &= (args.args[0] == 1);
+			break;
+		case 1:
+			passed &= !rc;
+			passed &= (args.np == p3);
+			passed &= (args.args_count == 3);
+			passed &= (args.args[0] == 2);
+			passed &= (args.args[1] == 5);
+			passed &= (args.args[2] == 3);
+			break;
+		case 2:
+			passed &= (rc == -ENOENT);
+			break;
+		case 3:
+			passed &= !rc;
+			passed &= (args.np == p0);
+			passed &= (args.args_count == 0);
+			break;
+		case 4:
+			passed &= !rc;
+			passed &= (args.np == p1);
+			passed &= (args.args_count == 1);
+			passed &= (args.args[0] == 3);
+			break;
+		case 5:
+			passed &= !rc;
+			passed &= (args.np == p0);
+			passed &= (args.args_count == 0);
+			break;
+		case 6:
+			passed &= !rc;
+			passed &= (args.np == p2);
+			passed &= (args.args_count == 2);
+			passed &= (args.args[0] == 15);
+			passed &= (args.args[1] == 0x20);
+			break;
+		case 7:
+			passed &= (rc == -ENOENT);
+			break;
+		default:
+			passed = false;
+		}
+
+		unittest(passed, "index %i - data error on node %s rc=%i\n",
+			 i, args.np->full_name, rc);
+	}
+
+	/* Check for missing list property */
+	rc = of_parse_phandle_with_args_map(np, "phandle-list-missing",
+					    "phandle", 0, &args);
+	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
+
+	/* Check for missing cells,map,mask property */
+	rc = of_parse_phandle_with_args_map(np, "phandle-list",
+					    "phandle-missing", 0, &args);
+	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+
+	/* Check for bad phandle in list */
+	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-phandle",
+					    "phandle", 0, &args);
+	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+
+	/* Check for incorrectly formed argument list */
+	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-args",
+					    "phandle", 1, &args);
+	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+}
+
 static void __init of_unittest_property_string(void)
 {
 	const char *strings[4];
@@ -2326,6 +2445,7 @@ static int __init of_unittest(void)
 	of_unittest_find_node_by_name();
 	of_unittest_dynamic();
 	of_unittest_parse_phandle_with_args();
+	of_unittest_parse_phandle_with_args_map();
 	of_unittest_printf();
 	of_unittest_property_string();
 	of_unittest_property_copy();
-- 
2.7.4
