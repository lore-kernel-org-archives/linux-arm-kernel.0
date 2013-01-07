From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 7 Jan 2013 13:25:10 +0100
Subject: [PATCH] i2c: samsung: resume race fix
In-Reply-To: <CAHfPSqCQ9e3VR3En+hQGWVOt0RRGsmHzHTFvBF+h2-rEX5oXhQ@mail.gmail.com>
References: <1352284106-24988-1-git-send-email-ch.naveen@samsung.com>
 <20121107114437.0a563c7e@endymion.delvare>
 <CAHfPSqCQ9e3VR3En+hQGWVOt0RRGsmHzHTFvBF+h2-rEX5oXhQ@mail.gmail.com>
Message-ID: <20130107132510.7a6ce9ae@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Jan 2013 17:35:25 +0530, Naveen Krishna Ch wrote:
> On 7 November 2012 16:14, Jean Delvare <khali@linux-fr.org> wrote:
> > On Wed, 07 Nov 2012 15:58:26 +0530, Naveen Krishna Chatradhi wrote:
> >> Don't unmark the device as suspended until after it's been re-setup.
> >>
> >> The main race would be w.r.t. an i2c driver that gets resumed at the same
> >> time (asyncronously), that is allowed to do a transfer since suspended
> >> is set to 0 before reinit, but really should have seen the -EIO return
> >> instead.
> >>
> >> Signed-off-by: Olof Johansson <olofj@chromium.org>
> >> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> >> ---
> >>  drivers/i2c/busses/i2c-s3c2410.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> >> index 3e0335f..dbaf920 100644
> >> --- a/drivers/i2c/busses/i2c-s3c2410.c
> >> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> >> @@ -1134,10 +1134,10 @@ static int s3c24xx_i2c_resume(struct device *dev)
> >>       struct platform_device *pdev = to_platform_device(dev);
> >>       struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
> >>
> >> -     i2c->suspended = 0;
> >>       clk_prepare_enable(i2c->clk);
> >>       s3c24xx_i2c_init(i2c);
> >>       clk_disable_unprepare(i2c->clk);
> >> +     i2c->suspended = 0;
> >>
> >>       return 0;
> >>  }
> >
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> I don't see this patch landed any where in linux-i2c tree, Though it was acked.
> Was it missed or should i be doing something for this to be merged ??

Nothing needed from your side AFAIK, Wolfram should pick patches when I
ack them, maybe this one was simply overlooked.

-- 
Jean Delvare
