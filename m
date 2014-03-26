From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Wed, 26 Mar 2014 20:57:57 +0100
Subject: [PATCH] clk: register fixed-clock only if #clock-cells property
 is present
In-Reply-To: <CAOMZO5DJPKvha7A-foktsB2dEw9xGXL_++uBXj_3ScAPTXNOkw@mail.gmail.com>
References: <1395858127-18730-1-git-send-email-s.nawrocki@samsung.com>
 <CAOMZO5DJPKvha7A-foktsB2dEw9xGXL_++uBXj_3ScAPTXNOkw@mail.gmail.com>
Message-ID: <53333145.4080903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 03/26/2014 07:33 PM, Fabio Estevam wrote:
> On Wed, Mar 26, 2014 at 3:22 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
[...]
> Still not able to boot with this patch applied:

Perhaps a change as below helps ?

 From 85ee85e4a92b42442354f3f2454be50c173e1c59 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Wed, 26 Mar 2014 20:54:13 +0100
Subject: [PATCH] clk: reverse default clk provider initialization order 
in of_clk_init()

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
  drivers/clk/clk.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fb3c40b..d30809c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2608,7 +2608,7 @@ void __init of_clk_init(const struct of_device_id 
*matches)

  		parent->clk_init_cb = match->data;
  		parent->np = np;
-		list_add(&parent->node, &clk_provider_list);
+		list_add_tail(&parent->node, &clk_provider_list);
  	}

  	while (!list_empty(&clk_provider_list)) {
-- 
1.7.9.5


This should keep the clock providers initialization order as before,
rather than reversing it.
Anyway, I think the clock dependencies need to be specified in
the device tree explicitly to avoid surprises like this when,
e.g. clock nodes get reordered in dts or by dtc.

--
Regards,
Sylwester
