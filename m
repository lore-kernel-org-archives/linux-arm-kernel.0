From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 21 Apr 2010 15:14:34 +0530
Subject: [PATCH] PL061 GPIO: Bug fix - setting gpio for HIGH_LEVEL interrupt
	is not working.
Message-ID: <1271843074-4158-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current implementation of PL061, setting type of irq to HIGH_LEVEL is not
working. This patch fixes this bug.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/gpio/pl061.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
index 4f172ab..d30c8a6 100644
--- a/drivers/gpio/pl061.c
+++ b/drivers/gpio/pl061.c
@@ -188,7 +188,7 @@ static int pl061_irq_type(unsigned irq, unsigned trigger)
 		gpioibe &= ~(1 << offset);
 		if (trigger & IRQ_TYPE_EDGE_RISING)
 			gpioiev |= 1 << offset;
-		else
+		else if (trigger & IRQ_TYPE_EDGE_FALLING)
 			gpioiev &= ~(1 << offset);
 	}
 	writeb(gpioibe, chip->base + GPIOIBE);
-- 
1.6.0.2
