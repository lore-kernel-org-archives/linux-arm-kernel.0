From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 30 Jul 2015 18:08:52 +0100
Subject: [PATCH v2 02/11] [media] stv0367: Add support for 16Mhz reference
 clock
In-Reply-To: <1438276141-16902-1-git-send-email-peter.griffin@linaro.org>
References: <1438276141-16902-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1438276141-16902-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The B2100A dvb NIM card from ST has 2x stv0367 demodulators
and 2x TDA18212 silicon tuners, with a 16Mhz crystal. To
get this working properly with the upstream driver we need
to add support for the 16Mhz reference clock.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/media/dvb-frontends/stv0367.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/dvb-frontends/stv0367.c b/drivers/media/dvb-frontends/stv0367.c
index 9a49db1..44cb73f 100644
--- a/drivers/media/dvb-frontends/stv0367.c
+++ b/drivers/media/dvb-frontends/stv0367.c
@@ -1554,6 +1554,11 @@ static int stv0367ter_init(struct dvb_frontend *fe)
 
 	switch (state->config->xtal) {
 		/*set internal freq to 53.125MHz */
+	case 16000000:
+		stv0367_writereg(state, R367TER_PLLMDIV, 0x2);
+		stv0367_writereg(state, R367TER_PLLNDIV, 0x1b);
+		stv0367_writereg(state, R367TER_PLLSETUP, 0x18);
+		break;
 	case 25000000:
 		stv0367_writereg(state, R367TER_PLLMDIV, 0xa);
 		stv0367_writereg(state, R367TER_PLLNDIV, 0x55);
-- 
1.9.1
