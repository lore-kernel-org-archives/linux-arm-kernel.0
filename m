From: swboyd@chromium.org (Stephen Boyd)
Date: Wed, 21 Mar 2018 09:58:46 -0700
Subject: [PATCH v3 1/3] dt-bindings: gpio: Add a gpio-reserved-ranges property
In-Reply-To: <20180321165848.89751-1-swboyd@chromium.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
Message-ID: <20180321165848.89751-2-swboyd@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

Some qcom platforms make some GPIOs or pins unavailable for use
by non-secure operating systems, and thus reading or writing the
registers for those pins will cause access control issues.
Introduce a DT property to describe the set of GPIOs that are
available for use so that higher level OSes are able to know what
pins to avoid reading/writing.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/devicetree/bindings/gpio/gpio.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index b5de08e3b1a2..a7c31de29362 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -151,9 +151,9 @@ in a lot of designs, some using all 32 bits, some using 18 and some using
 first 18 GPIOs, at local offset 0 .. 17, are in use.
 
 If these GPIOs do not happen to be the first N GPIOs at offset 0...N-1, an
-additional bitmask is needed to specify which GPIOs are actually in use,
-and which are dummies. The bindings for this case has not yet been
-specified, but should be specified if/when such hardware appears.
+additional set of tuples is needed to specify which GPIOs are unusable, with
+the gpio-reserved-ranges binding. This property indicates the start and size
+of the GPIOs that can't be used.
 
 Optionally, a GPIO controller may have a "gpio-line-names" property. This is
 an array of strings defining the names of the GPIO lines going out of the
@@ -178,6 +178,7 @@ gpio-controller at 00000000 {
 	gpio-controller;
 	#gpio-cells = <2>;
 	ngpios = <18>;
+	gpio-reserved-ranges = <0 4>, <12 2>;
 	gpio-line-names = "MMC-CD", "MMC-WP", "VDD eth", "RST eth", "LED R",
 		"LED G", "LED B", "Col A", "Col B", "Col C", "Col D",
 		"Row A", "Row B", "Row C", "Row D", "NMI button",
-- 
Sent by a computer through tubes
