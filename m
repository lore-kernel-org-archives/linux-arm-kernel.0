From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 9 Oct 2014 17:16:08 +0200
Subject: [PATCHv5 2/3] pwm: make the PWM_POLARITY flag in DTB optional
In-Reply-To: <1412690134-13712-3-git-send-email-LW@KARO-electronics.de>
References: <1412690134-13712-1-git-send-email-LW@KARO-electronics.de>
 <1412690134-13712-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <20141009151605.GA8818@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 03:55:33PM +0200, Lothar Wa?mann wrote:
> Change the pwm chip driver registration, so that a chip driver that
> supports polarity inversion can still be used with DTBs that don't
> provide the 'PWM_POLARITY' flag.
> 
> This is done to provide polarity inversion support for the pwm-imx
> driver without having to modify all existing DTS files.

I don't like how this throws out the window the only sanity checking we
have in place for the #pwm-cells property.

As I understand it, the problem that you're trying to solve is one of
backwards-compatibility where existing device trees have #pwm-cells =
<2>, but the driver is extended to support flags as well.

In that case, can we not simply make of_pwm_xlate_with_flags() support
that case transparently? That is, if the driver sets .of_pwm_n_cells to
3, we can still support #pwm-cells = <2> and use the default (no) flags
instead.

Something like the below should do that (compile-tested only).

Thierry
-------------- next part --------------
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 966497d10c6e..89a5e309b0a3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -136,9 +136,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
+	/* check that the driver supports a third cell for flags */
 	if (pc->of_pwm_n_cells < 3)
 		return ERR_PTR(-EINVAL);
 
+	/* flags in the third cell are optional */
+	if (args->args_count < 2)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >= pc->npwm)
 		return ERR_PTR(-EINVAL);
 
@@ -148,10 +153,12 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 
 	pwm_set_period(pwm, args->args[1]);
 
-	if (args->args[2] & PWM_POLARITY_INVERTED)
-		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
-	else
-		pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+	if (args->args_count > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
+		else
+			pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+	}
 
 	return pwm;
 }
@@ -162,9 +169,14 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
+	/* sanity check driver support */
 	if (pc->of_pwm_n_cells < 2)
 		return ERR_PTR(-EINVAL);
 
+	/* all cells are required */
+	if (args->args_count != pc->of_pwm_n_cells)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >= pc->npwm)
 		return ERR_PTR(-EINVAL);
 
@@ -536,13 +548,6 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 		goto put;
 	}
 
-	if (args.args_count != pc->of_pwm_n_cells) {
-		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
-			 args.np->full_name);
-		pwm = ERR_PTR(-EINVAL);
-		goto put;
-	}
-
 	pwm = pc->of_xlate(pc, &args);
 	if (IS_ERR(pwm))
 		goto put;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141009/da3e1b34/attachment.sig>
