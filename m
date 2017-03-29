From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 29 Mar 2017 21:38:53 +0200
Subject: [PATCH v2 1/2] base: soc: Let soc_device_match() return no match when
 called too early
In-Reply-To: <1490816334-14568-1-git-send-email-geert+renesas@glider.be>
References: <1490816334-14568-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1490816334-14568-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If soc_device_match() is called before the SoC bus has been registered,
bus_for_each_dev() returns -EINVAL, which is considered a match, as it
is non-zero.

While calling soc_device_match() too early can be considered an
integration mistake, returning a match is counter-intuitive:
soc_device_match() is typically used to handle quirks, i.e. to deviate
from the default path.  Hence add a check to abort checking and return
no match instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Drop RFC state,
  - Add Acked-by,
  - Add missing "too early" to second paragraph of description.
---
 drivers/base/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index dc26e5949a320223..50033081834a9ccd 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -230,6 +230,8 @@ const struct soc_device_attribute *soc_device_match(
 			break;
 		ret = bus_for_each_dev(&soc_bus_type, NULL, (void *)matches,
 				       soc_device_match_one);
+		if (ret < 0)
+			return NULL;
 		if (!ret)
 			matches++;
 		else
-- 
2.7.4
