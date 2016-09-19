From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 19 Sep 2016 20:06:27 +0200
Subject: [PATCH] arm: dts: fix rk3066a based boards vdd_log voltage
 initialization
In-Reply-To: <CAD=FV=UyW5cXGGmq5xUzZ1aV5NzbBYGOz1gO9V1itrFU-PigAw@mail.gmail.com>
References: <1474274639-27768-1-git-send-email-andy.yan@rock-chips.com>
 <1474274696-28090-1-git-send-email-andy.yan@rock-chips.com>
 <CAD=FV=VawAOWBF_PoXqSj3oiVgfF8SnCBp56p8F==XsaVLmMcg@mail.gmail.com>
 <2318029.f7g774Bk76@phil>
 <CAD=FV=UOXcUZyXRj++GkKksyFedGt59vQz8958nhhF9UM7rOuw@mail.gmail.com>
 <20160919191327.741a2b89@bbrezillon>
 <CAD=FV=Ufmvg1P8suOPQ53kpOD1pei4N2dOpKUCxZk001XKj_OA@mail.gmail.com>
 <20160919194844.0db7b307@bbrezillon>
 <CAD=FV=UyW5cXGGmq5xUzZ1aV5NzbBYGOz1gO9V1itrFU-PigAw@mail.gmail.com>
Message-ID: <20160919200627.3ca1aae4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Sep 2016 10:52:51 -0700
Doug Anderson <dianders@chromium.org> wrote:

> Hi,
> 
> On Mon, Sep 19, 2016 at 10:48 AM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > The PWM chip has always claimed the pins and muxed them to the PWM IP.
> > So, this means it's broken from the beginning, and my patch is only
> > uncovering the problem (unless the pins stay configured as input until
> > the PWM is enabled, which I'm not sure is the case).  
> 
> Such a solution is achievable with the pinctrl APIs pretty easily.
> You might not be able to use the automatic "init" state but you can do
> something similar and switch to an "active" state once the PWM is
> actually turned on the first time.

But is it really the case here (I don't see any code requesting a
specific pinmux depending on the PWM state)?

Anyway, we really need to handle this case, we should define the
typical voltage when the PWM is disabled. Same as what you suggested
with voltage-when-input, but with a different naming (since the concept
of pinmux is PWM hardware/driver specific).

	voltage-when-pwm-disabled = <...>;
