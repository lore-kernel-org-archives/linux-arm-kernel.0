From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 28 Sep 2016 00:20:18 +0930
Subject: [PATCH 6/8] pinctrl: aspeed-g4: Capture SuperIO pinmux dependency
In-Reply-To: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
Message-ID: <b5f67ba76018314d08e240f95951751896687d37.1474986045.git-series.andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two LPC-related signals in the AST2400 depend on state in the SuperIO IP
block. Use the recently added infrastructure to capture this
relationship.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 4 ++--
 drivers/pinctrl/aspeed/pinctrl-aspeed.h    | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index a21b071ff290..ceb13d4955cb 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -82,8 +82,8 @@ FUNC_GROUP_DECL(MDIO2, A3, D5);
 
 #define H19 13
 #define H19_DESC        SIG_DESC_SET(SCU80, 13)
-SIG_EXPR_LIST_DECL_SINGLE(LPCPD, LPCPD, H19_DESC);
-SIG_EXPR_LIST_DECL_SINGLE(LPCSMI, LPCSMI, H19_DESC);
+SIG_EXPR_LIST_DECL_SINGLE(LPCPD, LPCPD, H19_DESC, SIG_DESC_BIT(SIORD30, 1, 0));
+SIG_EXPR_LIST_DECL_SINGLE(LPCSMI, LPCSMI, H19_DESC, SIG_DESC_SET(SIORD30, 1));
 MS_PIN_DECL(H19, GPIOB5, LPCPD, LPCSMI);
 
 FUNC_GROUP_DECL(LPCPD, H19);
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.h b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
index 4384407d77fb..3a76d2c95584 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.h
@@ -266,6 +266,8 @@
 #define SCUA8           0xA8 /* Multi-function Pin Control #9 */
 #define HW_STRAP2       0xD0 /* Strapping */
 
+#define SIORD30		SIG_DESC_TO_REG(ASPEED_IP_SIO, 0x30)
+
  /**
   * A signal descriptor, which describes the register, bits and the
   * enable/disable values that should be compared or written.
-- 
git-series 0.8.10
