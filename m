From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 11 Sep 2015 13:43:52 +0100
Subject: [PATCH v4] pinctrl: mediatek: Implement wake handler and suspend
 resume
In-Reply-To: <CAM2ehZaDwQtckXcDQQh+XkYKXvVzy-6Tp+kdvRku0w2xVibPtQ@mail.gmail.com>
References: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
 <55DB4609.5040904@arm.com>
 <CAGS+omBnoitju07KQ1Y7JHTbce6+DO4WqWHTaKz5D+T157zEJA@mail.gmail.com>
 <1441535972.22230.5.camel@mhfsdcap03> <55EEAA24.6080706@arm.com>
 <55EF11E6.7030307@arm.com>
 <CAM2ehZaDwQtckXcDQQh+XkYKXvVzy-6Tp+kdvRku0w2xVibPtQ@mail.gmail.com>
Message-ID: <55F2CC88.3030304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/09/15 12:22, Chung-Yih Wang (???) wrote:
> Hi Sudeep and Maoguang,
>
>     Please correct me if I am wrong. I think the wake_mask Maoguang
> implemented is the wake-up configuration and it is how he disabled
> other unwanted interrupt sources(e.g. audio jacket insertion) during
> suspend.
>

OK, you are right, I think I now understand the issue. I misread the
code initially thinking the suspend/resume are implemented as
syscore_ops but they are standard device pm ops.

>    With Sudeep's patch which we had similar one before, the system got
> waken up by audio jack insertion which we don't want. Maoguang tried
> to implement wake_mask as the wake-up configuration to keep track of
> effective wakeup sources(i.e. those who makes enable_irq_wake) and
> write the wake-up configuration in mtk_eint_suspend(). What is your
> suggestion to address this issue? Thanks!
>

One option is to convert them to *_noirq callbacks assuming all the
users of this pinctrl irqchip have sanely implemented their
suspend/resume and don't trigger interrupts between dpm_suspend and
suspend_device_irqs. What do you think ?

Regards,
Sudeep

---->8

@@ -1130,8 +1130,8 @@ static int mtk_eint_resume(struct device *device)
  }

  const struct dev_pm_ops mtk_eint_pm_ops = {
-       .suspend = mtk_eint_suspend,
-       .resume = mtk_eint_resume,
+       .suspend_noirq = mtk_eint_suspend,
+       .resume_noirq = mtk_eint_resume,
  };
