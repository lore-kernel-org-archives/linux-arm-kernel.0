From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon,  5 Jan 2015 11:04:13 +0100
Subject: [RESEND PATCH 1/2] pinctrl: st: avoid multiple mutex lock
In-Reply-To: <1420452254-30625-1-git-send-email-patrice.chotard@st.com>
References: <1420452254-30625-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1420452254-30625-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Francesco VIRLINZI <francesco.virlinzi@st.com>

Using the sysfs inteface to inspect the pins configuration
the system can walk around a path which acquires the same
mutex twice.

On STiH407 platform, for example :
cat /sys/kernel/debug/pinctrl/920f080.pin-controller-front0/pinconf-pins
hangs the kernel and never returns.

With this patch the mutex is temporary freed.

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 7c9d513..87570e6 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1012,8 +1012,10 @@ static void st_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 				   struct seq_file *s, unsigned pin_id)
 {
 	unsigned long config;
-	st_pinconf_get(pctldev, pin_id, &config);
 
+	mutex_unlock(&pctldev->mutex);
+	st_pinconf_get(pctldev, pin_id, &config);
+	mutex_lock(&pctldev->mutex);
 	seq_printf(s, "[OE:%ld,PU:%ld,OD:%ld]\n"
 		"\t\t[retime:%ld,invclk:%ld,clknotdat:%ld,"
 		"de:%ld,rt-clk:%ld,rt-delay:%ld]",
-- 
1.9.1
