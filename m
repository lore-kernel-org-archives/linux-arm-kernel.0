From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Oct 2016 15:29:46 -0200
Subject: [PATCH] ARM: imx: gpc: Initialize all power domains
In-Reply-To: <20161019141556.GA18806@tiger>
References: <1476208413-11286-1-git-send-email-fabio.estevam@nxp.com>
 <20161019141556.GA18806@tiger>
Message-ID: <CAOMZO5CORjf_86-XBy+STd4sEhcus8y1G4B-n58h3KNyuVyEew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Oct 19, 2016 at 12:15 PM, Shawn Guo <shawnguo@kernel.org> wrote:

> It's not clear to me why this is only with multi_v7_defconfig, not
> imx_v6_v7_defconfig.  Also, is it a regression or long-standing issue?

Investigated this a bit further and the problem seems to be in the
power domain driver.

The change below fixes the problem on mx6:

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e023066..461d03c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1572,8 +1572,6 @@ int of_genpd_add_provider_onecell(struct device_node *np,
        for (i = 0; i < data->num_domains; i++) {
                if (!data->domains[i])
                        continue;
-               if (!pm_genpd_present(data->domains[i]))
-                       goto error;

                data->domains[i]->provider = &np->fwnode;
                data->domains[i]->has_provider = true;

, will submit this to the power domain folks.
