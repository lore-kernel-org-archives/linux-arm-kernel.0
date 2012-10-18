From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Oct 2012 16:20:59 -0600
Subject: [PATCH 03/10] tty: pxa: configure pin
In-Reply-To: <1350551224-12857-3-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-3-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <508080CB.5010904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 03:06 AM, Haojian Zhuang wrote:
> Configure pins by pinctrl driver.

In general, it seems better to use pinctrl "hogs" if the driver is only
going to statically set up one pinctrl state and never change it. The
alternative is make every single driver execute these pinctrl calls,
which could be tedious.

However, that does raise one question: If all the pinctrl setup is done
by hogs, then how do we ensure that the pinctrl driver is probed first,
and hence sets up the pins before any driver relies on them being set
up? If a driver explicitly enables a pinctrl state (as in this patch),
then deferred probe ensures that, but without any explicit pinctrl
action, it'll only work by luck.

LinusW, what are your thoughts on that?
