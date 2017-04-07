From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 7 Apr 2017 17:10:09 +0200
Subject: [PATCH 2/4] pinctrl: stm32: replace device_initcall() with
 arch_initcall()
In-Reply-To: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
References: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1491577811-26989-3-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pinctrl has to be registered earlier. Mainly to register bank irqdomain
earlier as other devices could use interrupts from those irqdomain.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f429.c b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
index 990b867..4bbade2 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32f429.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
@@ -1584,4 +1584,8 @@
 	},
 };
 
-builtin_platform_driver(stm32f429_pinctrl_driver);
+static int __init stm32f429_pinctrl_init(void)
+{
+	return platform_driver_register(&stm32f429_pinctrl_driver);
+}
+arch_initcall(stm32f429_pinctrl_init);
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f746.c b/drivers/pinctrl/stm32/pinctrl-stm32f746.c
index c0b4462..a2fae73 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32f746.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32f746.c
@@ -1678,4 +1678,9 @@
 		.of_match_table = stm32f746_pctrl_match,
 	},
 };
-builtin_platform_driver(stm32f746_pinctrl_driver);
+
+static int __init stm32f746_pinctrl_init(void)
+{
+	return platform_driver_register(&stm32f746_pinctrl_driver);
+}
+arch_initcall(stm32f746_pinctrl_init);
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32h743.c b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
index f7f9eac..e34b2b9 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32h743.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
@@ -1977,4 +1977,8 @@
 	},
 };
 
-builtin_platform_driver(stm32h743_pinctrl_driver);
+static int __init stm32h743_pinctrl_init(void)
+{
+	return platform_driver_register(&stm32h743_pinctrl_driver);
+}
+arch_initcall(stm32h743_pinctrl_init);
-- 
1.9.1
