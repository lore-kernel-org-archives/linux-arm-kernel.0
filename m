From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 8 May 2013 13:11:18 +0100
Subject: [PATCH 1/3] xen/arm: initialize pm functions later
In-Reply-To: <alpine.DEB.2.02.1305081303310.18865@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305081303310.18865@kaball.uk.xensource.com>
Message-ID: <1368015080-5182-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are running in dom0, we have to wait for the arch specific code to
complete the initialization in order for us to successfully reset the
power_off and pm_restart functions.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index d30042e..83d13b0 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -272,12 +272,18 @@ static int __init xen_guest_init(void)
 	if (!xen_initial_domain())
 		xenbus_probe(NULL);
 
+	return 0;
+}
+core_initcall(xen_guest_init);
+
+static int __init xen_pm_init(void)
+{
 	pm_power_off = xen_power_off;
 	arm_pm_restart = xen_restart;
 
 	return 0;
 }
-core_initcall(xen_guest_init);
+subsys_initcall(xen_pm_init);
 
 static irqreturn_t xen_arm_callback(int irq, void *arg)
 {
-- 
1.7.2.5
