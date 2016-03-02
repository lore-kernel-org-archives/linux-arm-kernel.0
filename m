From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 2 Mar 2016 23:58:53 +0100
Subject: [PATCH 4/6] pwm: pwm-lpc18xx-sct: test clock rate to avoid
 division by 0
In-Reply-To: <CAGhQ9VzQLfhT4erDam_69-Zf4vp3gzKx+jbanXM8Ky+fmG=6EQ@mail.gmail.com>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
 <1456958018-7849-5-git-send-email-wsa@the-dreams.de>
 <CAGhQ9VzQLfhT4erDam_69-Zf4vp3gzKx+jbanXM8Ky+fmG=6EQ@mail.gmail.com>
Message-ID: <20160302225853.GA2303@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 11:44:02PM +0100, Joachim Eastwood wrote:
> Hi Wolfram,
> 
> On 2 March 2016 at 23:33, Wolfram Sang <wsa@the-dreams.de> wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > The clk API may return 0 on clk_get_rate, so we should check the result before
> > using it as a divisor.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >
> > Should go individually via subsystem tree.
> >
> >  drivers/pwm/pwm-lpc18xx-sct.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> > index 9163085101bc94..6487962c355c03 100644
> > --- a/drivers/pwm/pwm-lpc18xx-sct.c
> > +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> > @@ -360,6 +360,8 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
> >         }
> >
> >         lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
> > +       if (!lpc18xx_pwm->clk_rate)
> > +               return -EINVAL;
> 
> This needs to be:
> if (!lpc18xx_pwm->clk_rate) {
>     ret = -EINVAL;
>     goto disable_pwmclk;
> }

Yes, that slipped through. Thanks!

> I would also prefer an explicit check against 0 here. ie.:

Well, I like the reading "if not rate then error"

Will send V2 now...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160302/e24b2786/attachment.sig>
