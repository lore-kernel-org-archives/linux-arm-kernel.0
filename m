From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 16 Oct 2017 08:42:41 -0500
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <CACRpkdYis3kNG45zmkTcP8vCutfRJkh5UjnzwFVeyLmFYFEC-A@mail.gmail.com>
References: <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
 <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
 <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
 <CACRpkdYfAcKrgbgybccurUKTyR0E+tHDyzp7sbXxXxKuyMOGhQ@mail.gmail.com>
 <619f48d2-59c7-c090-4ace-9e8db9f92064@codeaurora.org>
 <CACRpkdZFunwQ=tiQqsapap7Ozz42hr=df5vqbC0S5xy5Wn+ZWw@mail.gmail.com>
 <255ad0dc-2d16-ae7f-0b45-500e23cff1a4@codeaurora.org>
 <20171003220311.GU457@codeaurora.org>
 <CACRpkdYXsY5eixYkEeuZTHJn7q6_6BdTxZ-2yneUyEKUjKF3Gw@mail.gmail.com>
 <20171012073922.GB18706@codeaurora.org>
 <CACRpkdYis3kNG45zmkTcP8vCutfRJkh5UjnzwFVeyLmFYFEC-A@mail.gmail.com>
Message-ID: <22ef3c75-bdf6-6aeb-a1dd-2d03eb46fd58@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2017 05:43 PM, Linus Walleij wrote:
> So I guess the driver needs to know what pin registers it can't
> access so the user does not get a gun to shoot in the foot with.
> 
> If we augment gpiolib to just handle -EACCES or something
> (-EIO?) from the driver .get_direction() callback for these lines,
> things should be smooth?

You mean like this:

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c 
b/drivers/pinctrl/qcom/pinctrl-msm.c
index ff491da64dab..ca4ae3d76eb4 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -443,6 +443,14 @@ static int msm_gpio_get_direction(struct gpio_chip 
*chip, unsigned int offset)

  	g = &pctrl->soc->groups[offset];

+	/*
+	 * During initialization, gpiolib may query all GPIOs for their
+	 * initial direction, regardless if they exist, so block access
+	 * to those that are unavailable.
+	 */
+	if (!g->npins)
+		return -ENODEV;
+
  	val = readl(pctrl->regs + g->ctl_reg);

  	/* 0 = output, 1 = input */


This is what I have in my patch already.  I can return any error message 
you like, but -ENODEV already works.

The problem is that it's insufficient.  I also want the non-available 
GPIOs to be as absent as possible.  I don't want them to show up in 
/sys/kernel/debug/gpio, and I don't want to be able to create them via 
/sys/class/gpio/export.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
