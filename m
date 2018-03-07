From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 7 Mar 2018 09:49:57 +0100
Subject: [PATCH v3 3/3] tty: st-asc: Update tty alias
In-Reply-To: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1520412597-30545-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
must include only lowercase and '-'.

After having updated all STi boards serial aliases from "ttyASN"
to "serialN", st-asc driver need to be updated accordingly as tty
aliases id is retrieved using of_alias_get_id().

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
v3: _ update st-asc driver with "serial" alias prefix and keep "ttyAS" in second choice
v2: _ update st-asc driver with "serial" alias prefix

 drivers/tty/serial/st-asc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c763253514e9..5f9f01fac6dd 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -782,7 +782,9 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
 	if (!np)
 		return NULL;
 
-	id = of_alias_get_id(np, ASC_SERIAL_NAME);
+	id = of_alias_get_id(np, "serial");
+	if (id < 0)
+		id = of_alias_get_id(np, ASC_SERIAL_NAME);
 
 	if (id < 0)
 		id = 0;
-- 
1.9.1
