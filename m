From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Feb 2016 20:54:19 -0300
Subject: [PATCH 3/3] hwrng: mxc-fsl - add support for Freescale RNGC
In-Reply-To: <20160229213850.GS2613@pengutronix.de>
References: <1456761156-27664-1-git-send-email-s.trumtrar@pengutronix.de>
 <1456761156-27664-3-git-send-email-s.trumtrar@pengutronix.de>
 <CAOMZO5BN-1U6vX0HAHWX30t+23NnqEpOw6AttSgvqaZnq=cN6Q@mail.gmail.com>
 <20160229213850.GS2613@pengutronix.de>
Message-ID: <CAOMZO5BLYumOrBuoB5-RgzLAJ=o4zp9ocv4jcZRy=p6Pky1SyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 6:38 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Feb 29, 2016 at 06:16:50PM -0300, Fabio Estevam wrote:
>> On Mon, Feb 29, 2016 at 12:52 PM, Steffen Trumtrar
>> <s.trumtrar@pengutronix.de> wrote:
>>
>> > +       ret = clk_prepare_enable(rngc->clk);
>> > +       if (ret)
>> > +               return ret;
>> > +
>> > +       rngc->irq = platform_get_irq(pdev, 0);
>> > +       if (!rngc->irq) {
>> > +               dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
>> > +               clk_disable_unprepare(rngc->clk);
>> > +
>> > +               return ret;
>>
>> You are returning the wrong error code here:
>>
>> Better do like this:
>>
>>        rngc->irq = platform_get_irq(pdev, 0);
>>        if (rngc->irq < 0) {
>
> rngc->irq is unsigned, so this is never true.
>
>>                dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
>>                clk_disable_unprepare(rngc->clk);
>>                return rngc->irq;
>>        }
>
> So here comes my better approach:

As irq is only used inside probe it can be removed from struct mxc_rngc.

Or maybe like this:

         ret = platform_get_irq(pdev, 0);
         if (ret < 0) {
                 dev_err(&pdev->dev, "FSL RNGC couldn't get irq\n");
                 clk_disable_unprepare(rngc->clk);
                 return ret;
         }
