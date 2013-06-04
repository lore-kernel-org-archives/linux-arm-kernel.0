From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 09:25:02 +0200
Subject: [PATCH 00/11] drivers: Add Pinctrl PM support
In-Reply-To: <20130531170437.GA17591@core.coreip.homeip.net>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <20130531170437.GA17591@core.coreip.homeip.net>
Message-ID: <CACRpkdYnhjpFp1CM=P_hddBe4qVigtE0c+CN9NKvk3nFgJS-ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 7:04 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> As with the original introduction of pinctrl states my question is: "Can
> all of this be handled in the driver/bus core instead of adding a lot
> of boilerplate code to the individual drivers".

It can. Per the suggestion in 2/11:

- Adding pins_sleep and pins_idle to struct dev_pin_info
  in include/linux/pinctrl/devinfo.h

- Modify drivers/base/pinctrl.c to optionally look up
  sleep and idle states, you can make that code
  #ifdef CONFIG_PM I think.

- Add something like static inline functions to
  include/linux/pinctrl/consumer.h
  with names like pinctrl_select_pm_idle(struct device *)
  pinctrl_select_pm_sleep(struct device *) to switch states
  using the device core containers, and includes
  checking IS_ERR() on the handles etc.

I think this will save a *lot* of identical code in all the
drivers, that will just have to call
pinctrl_select_pm_sleep(), pinctrl_select_pm_default()
pinctrl_select_pm_idle() instead of all the complex code.

This is what I planned to do but never got around to.

Yours,
Linus Walleij
