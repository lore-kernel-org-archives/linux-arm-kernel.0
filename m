From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sun, 28 Jan 2018 16:51:30 -0800
Subject: [PATCH] pinctrl: msm: allow the gpio base to be configurable
In-Reply-To: <042b6cea-38f7-a660-0059-5f24fc7db9eb@codeaurora.org>
References: <1516915209-28295-1-git-send-email-timur@codeaurora.org>
 <20180128232310.GA12728@builder>
 <042b6cea-38f7-a660-0059-5f24fc7db9eb@codeaurora.org>
Message-ID: <20180129005129.GB12728@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 28 Jan 15:29 PST 2018, Timur Tabi wrote:

> On 1/28/18 5:23 PM, Bjorn Andersson wrote:
> > What platform has multiple TLMMs?
> > 
> > [..]
> 
> An upcoming one.
> 

Cool :)

> > > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > > index b7b6849625ec..4dc76e15bd14 100644
> > > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > > @@ -901,7 +901,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
> > >   		return -EINVAL;
> > >   	chip = &pctrl->chip;
> > > -	chip->base = 0;
> 
> > My bad, this should have been -1.
> 
> Perhaps, but it's been 0 for a very long time, so I don't want to break any
> existing platforms by suddenly relocating all GPIOs across all Qualcomm
> platforms.
> 

Yeah, I see that I got this wrong when I wrote the driver 4 years ago...

There should be no in-kernel users depending on these numbers being hard
coded, so anyone depending on these numbers starting at 0 would be user
space - doing so incorrectly.

> What do you think about my other idea?
> 

With static numbering of gpios you end up having cross-instance and
cross-driver tweaks to make things fit the number space. In particular
when you combine different gpio chips in different ways for different
devices this becomes a mess.

That's why the idea of static gpio numbering was abandoned a long long
time ago. So while it does solve an immediate problem for you it is
proven not to be the right solution in the long run...

Regards,
Bjorn
