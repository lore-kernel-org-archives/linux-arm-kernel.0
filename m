From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Feb 2016 18:16:50 -0300
Subject: [PATCH 3/3] hwrng: mxc-fsl - add support for Freescale RNGC
In-Reply-To: <1456761156-27664-3-git-send-email-s.trumtrar@pengutronix.de>
References: <1456761156-27664-1-git-send-email-s.trumtrar@pengutronix.de>
 <1456761156-27664-3-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CAOMZO5BN-1U6vX0HAHWX30t+23NnqEpOw6AttSgvqaZnq=cN6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 12:52 PM, Steffen Trumtrar
<s.trumtrar@pengutronix.de> wrote:

> +       ret = clk_prepare_enable(rngc->clk);
> +       if (ret)
> +               return ret;
> +
> +       rngc->irq = platform_get_irq(pdev, 0);
> +       if (!rngc->irq) {
> +               dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
> +               clk_disable_unprepare(rngc->clk);
> +
> +               return ret;

You are returning the wrong error code here:

Better do like this:

       rngc->irq = platform_get_irq(pdev, 0);
       if (rngc->irq < 0) {
               dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
               clk_disable_unprepare(rngc->clk);
               return rngc->irq;
       }
