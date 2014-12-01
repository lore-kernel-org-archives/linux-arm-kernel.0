From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Mon, 01 Dec 2014 17:11:08 +0530
Subject: [PATCH] PM/ Domains: Export of_genpd_get_from_provider function.
In-Reply-To: <CAPDyKFpX5nXR18pKdLrtDrPK60p1y2CEqq+--3z3jczRRmKrqA@mail.gmail.com>
References: <CAPDyKFpX5nXR18pKdLrtDrPK60p1y2CEqq+--3z3jczRRmKrqA@mail.gmail.com>
Message-ID: <1417434068-7344-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function looks up a PM domain form the provider. This will be
useful to add parent/child domain relationship from the SoC specific
code. The caller of the function must make sure that PM domain provider
is already registered.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
This patch may solve the same purpose which is done by earlier posts
1) https://lkml.org/lkml/2014/11/24/319 - In this there were comments
for not using the PM domain name.

2) Ulf Hansson posted a patch 
http://www.spinics.net/lists/linux-samsung-soc/msg39745.html which also solves
similar purpose but I feel this is slightly complex and involves changing
the genpd structure.


 drivers/base/power/domain.c |    3 ++-
 include/linux/pm_domain.h   |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d822753..5d7a2c1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2129,7 +2129,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
  * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
  * on failure.
  */
-static struct generic_pm_domain *of_genpd_get_from_provider(
+struct generic_pm_domain *of_genpd_get_from_provider(
 					struct of_phandle_args *genpdspec)
 {
 	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
@@ -2149,6 +2149,7 @@ static struct generic_pm_domain *of_genpd_get_from_provider(
 
 	return genpd;
 }
+EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 
 /**
  * genpd_dev_pm_detach - Detach a device from its PM domain.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9690827..4954e24 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -282,6 +282,8 @@ typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
 int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 			void *data);
 void of_genpd_del_provider(struct device_node *np);
+struct generic_pm_domain *of_genpd_get_from_provider(
+			struct of_phandle_args *genpdspec);
 
 struct generic_pm_domain *__of_genpd_xlate_simple(
 					struct of_phandle_args *genpdspec,
@@ -299,6 +301,12 @@ static inline int __of_genpd_add_provider(struct device_node *np,
 }
 static inline void of_genpd_del_provider(struct device_node *np) {}
 
+static inline struct generic_pm_domain *of_genpd_get_from_provider(
+			struct of_phandle_args *genpdspec)
+{
+	return NULL;
+}
+
 #define __of_genpd_xlate_simple		NULL
 #define __of_genpd_xlate_onecell	NULL
 
-- 
1.7.9.5
