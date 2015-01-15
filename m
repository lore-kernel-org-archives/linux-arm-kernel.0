From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Jan 2015 16:23:10 -0800
Subject: [PATCH v3 4/4] pinctrl: qcom: Add support for reset for apq8064
In-Reply-To: <CAOZdJXXZ3RH1zOGcz1L58d9DV_LSZtUxYVKe6ssM71nyhnbMyg@mail.gmail.com>
References: <1409322659-17693-1-git-send-email-pramod.gurav@smartplayin.com>	<1409322659-17693-5-git-send-email-pramod.gurav@smartplayin.com>	<CAOZdJXXRgrYUEcX4f5zRuKgX-Dtbpvf-SV4-8rjuohv3=0NJhQ@mail.gmail.com>	<54B6FF75.70500@codeaurora.org>
 <CAOZdJXXZ3RH1zOGcz1L58d9DV_LSZtUxYVKe6ssM71nyhnbMyg@mail.gmail.com>
Message-ID: <54B7086E.7060807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 03:54 PM, Timur Tabi wrote:
> On Wed, Jan 14, 2015 at 5:44 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> I think so. Can you send a patch? Plus it would be nice to move i = 0 in
>> the for loop at the same time.
> Sadly, Qualcomm policy makes that very cumbersome for me.  I won't be
> able to send a patch any time soon.
>

Hm... we'll have to figure out that part. Anyway here's the patch.

---8<----
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] pinctrl: qcom: Don't iterate past end of function array

Timur reports that this code crashes if nfunctions is 0. Fix the
loop iteration to only consider valid elements of the functions
array.

Reported-by: Timur Tabi <timur@codeaurora.org>
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Ivan T. Ivanov <iivanov@mm-sol.com>
Cc: Andy Gross <agross@codeaurora.org>
Fixes: 327455817a92 "pinctrl: qcom: Add support for reset for apq8064"
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index e730935fa457..ed7017df065d 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -865,10 +865,10 @@ static int msm_ps_hold_restart(struct notifier_block *nb, unsigned long action,
 
 static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
 {
-	int i = 0;
+	int i;
 	const struct msm_function *func = pctrl->soc->functions;
 
-	for (; i <= pctrl->soc->nfunctions; i++)
+	for (i = 0; i < pctrl->soc->nfunctions; i++)
 		if (!strcmp(func[i].name, "ps_hold")) {
 			pctrl->restart_nb.notifier_call = msm_ps_hold_restart;
 			pctrl->restart_nb.priority = 128;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
