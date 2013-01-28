From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 28 Jan 2013 09:56:15 +0000
Subject: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
In-Reply-To: <CAF6AEGtrHBxvnp052K6z3aj3dAxJf1hy7H72EoAWr6PhTtwr8Q@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-2-git-send-email-robdclark@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA939BB@DBDE01.ent.ti.com>
 <CAF6AEGsqkUr0R3eYa4P371tUPq_NLSJLhH=N_MkyJF31s068+g@mail.gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA93A7D@DBDE01.ent.ti.com>
 <CAF6AEGtrHBxvnp052K6z3aj3dAxJf1hy7H72EoAWr6PhTtwr8Q@mail.gmail.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA944D2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Jan 25, 2013 at 20:22:55, Rob Clark wrote:
> On Fri, Jan 25, 2013 at 8:15 AM, Mohammed, Afzal <afzal@ti.com> wrote:

> > It's not about being simple, but not doing the wrong way, here you are
> > relying on a platform specific clock in a driver, think about the case
> > where same IP is used on another platform. Either way it is not a good
> > thing to handle platform specific details (about disp_clk) in driver.

> Right, but I was trying to understand what was the benefit that the
> added complexity is.  I didn't realize on davinci that you are limited

Here I am referring to usage of disp_clk,

Driver is not supposed to do platform hacks - here you are trying to
configure something (PLL) in your driver which is not part of LCDC IP.
And LCDC IP is not aware of PLL which is a platform specific matter
(existent only in AM335x), it is only aware of functional clock.

You can set the rate on "fck" (functional clock) in AM335x using my patch,
"ARM: AM33XX: clock: SET_RATE_PARENT in lcd path", and there
would not be any need for driver to be aware of platform specific PLL.

> >> >> +     priv->clk = clk_get(dev->dev, "fck");

> >> >> +     priv->disp_clk = clk_get(dev->dev, "dpll_disp_ck");

> at the moment all this discussion is a bit moot.  I'd propose leaving
> the driver as it is for now, because that at least makes it useful on
> am33xx.  And when CCF and davinci have the needed support in place,

Let's forget about leveraging CCF in driver, but sane solution w.r.t PLL
configuration would be to do as mentioned above.

Regards
Afzal
