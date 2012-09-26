From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Sep 2012 14:38:15 +0200
Subject: [PATCH 2/2] ARM: ABMA: Disable/Enable interface clock from
 suspend/resume
In-Reply-To: <1348658647-25975-3-git-send-email-vipulkumar.samar@st.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
 <1348658647-25975-3-git-send-email-vipulkumar.samar@st.com>
Message-ID: <CACRpkdY_reBeOpyzxdjh9hsc1n_Ff7p5KFBA0Ysys_zDv3WtrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2012 at 1:24 PM, Vipul Kumar Samar
<vipulkumar.samar@st.com> wrote:

> AMBA devices interface clock is disabled in RTPM suspend/resume hooks
> but not in conventional hooks.
>
> This patch adds support to disable/enable clock for conventional
> suspend/resume calls.
(...)
> +       struct amba_device *pcdev = to_amba_device(dev);
>         int ret = 0;
>
>         if (!drv)
> @@ -132,16 +133,27 @@ static int amba_pm_suspend(struct device *dev)
>                 ret = amba_legacy_suspend(dev, PMSG_SUSPEND);
>         }
>
> +       if (!ret)
> +               clk_disable(pcdev->pclk);
> +
>         return ret;
>  }

You're not accounting for the case where pcdev->pclk
is an error pointer (as happens if pclk lookup fails at
probe).

I think you can simplify some of the code using
the external accessors from <linux/amba/bus.h>:

amba_pclk_enable();
amba_pclk_disable();

But:

Again this is a case where you have a race between runtime
suspend/resume and ordinary suspend/resume.

These ordinary suspend/resume operations should probably
wait for runtime suspend to happen *first* if and only if
runtime PM is enabled, and then the block will be gated
off. So we really need to figure out how we can make sure
that this happens.

If just ordinary PM is enabled, the above makes sense but in
that case I think we should have that #ifdef:ed as an alternative
or something.

So something like:

suspend():
#ifdef CONFIG_PM_RUNTIME
   /* Wait for runtime PM to hammer down the pclk */
#elif CONFIG_PM
   amba_pclk_disable();
#endif

resume():
#if defined(CONFIG_PM) && !defined(CONFIG_PM_RUNTIME)
  amba_pclk_enable();
#endif
  /* Let runtime PM lazily enable the clock when needed */

To complicate things further the bus operations can be
overridden by e.g. voltage domains. In this case we (ux500)
have choosen to call out to the AMBA level to make sure
semantics are preserved.

Yours,
Linus Walleij
