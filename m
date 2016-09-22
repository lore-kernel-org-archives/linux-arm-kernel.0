From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 22 Sep 2016 20:13:01 +0200
Subject: [PATCH] arm: dts: fix rk3066a based boards vdd_log voltage
 initialization
In-Reply-To: <20160922164752.GP7994@sirena.org.uk>
References: <CAD=FV=UOXcUZyXRj++GkKksyFedGt59vQz8958nhhF9UM7rOuw@mail.gmail.com>
 <20160919191327.741a2b89@bbrezillon>
 <CAD=FV=Ufmvg1P8suOPQ53kpOD1pei4N2dOpKUCxZk001XKj_OA@mail.gmail.com>
 <20160919194844.0db7b307@bbrezillon>
 <CAD=FV=UyW5cXGGmq5xUzZ1aV5NzbBYGOz1gO9V1itrFU-PigAw@mail.gmail.com>
 <20160919200627.3ca1aae4@bbrezillon>
 <CAD=FV=U_BQez2eCqm7mX9kj0dcEsnBKiFWcLAhXXJD+yTZhACw@mail.gmail.com>
 <20160919224352.3b84b6c0@bbrezillon>
 <CAD=FV=W=ZiaLu1=zcnDyUqvK6f=E-0AWH9URHE3cgAKWWa+aJA@mail.gmail.com>
 <20160922171217.09a6d13f@bbrezillon>
 <20160922164752.GP7994@sirena.org.uk>
Message-ID: <20160922201301.0157a292@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Sep 2016 17:47:52 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Sep 22, 2016 at 05:12:17PM +0200, Boris Brezillon wrote:
> > +Mark  
> 
> > I realize Mark has been out of the discussion, and what started as a DT
> > problem actually turned into a PWM regulator discussion.
> > Maybe we should start a new thread.  
> 
> Probably, you're lucky I even looked at this - the number of irrelevant
> patches I get CCed on is such that I'll often delete things that look
> irrelevant unread.  I'm unsure what the relevance is, it looks like it's
> mainly a discussion about pinctrl?

Not exactly, even if this involves pin muxing.

> 
> > As I said, the problem you're describing (pins muxed to the PWM device
> > when it should actually stay in gpio+input mode) is not new, and the old
> > pwm-regulator and pwm-rockchip implementation (before my atomic PWM
> > changes) were behaving the same way.  
> 
> Why would this make any kind of sense?
> 
> > What is new though, is the pwm_regulator_init_state() function [1], and
> > it seems it's now preventing the probe of a pwm-regulator device if the
> > initial PWM state is not described in the voltage-table.  
> 
> > The question is, what should we do?  
> 
> > 1/ Force users to put an entry matching this state (which means
> >    breaking DT compat)
> > 2/ Put a valid value in drvdata->state even if it's not reflecting the
> >    real state
> > 3/ Patch regulator core to support an "unknown-selector" return code.  
> 
> Could someone say what the actual problem was please?

Well, to sum-up, the discussion started because Andy notice that some
boards were no longer booting, and found out that commit 87248991a1de
("regulator: pwm: Properly initialize the ->state field") was causing
the regression, because ->get_voltage_sel() was returning -EINVAL,
which in turn was caused by a missing entry in the voltage table.

Doug also noted that Andy was expecting the pin connected to the PWM
regulator to stay in a GPIO+input state until the PWM is really
enabled, in order to avoid glitches. But this not the case currently,
since the PWM chip claims all the pins at probe time.

So, there are 2 different problems here:
1/ the board no longer boots because of commit 87248991a1de and a
   missing entry in the voltage table
2/ claiming the PWM pins at probe time can cause glitches

I'm currently trying to solve #1, but most of the discussion in this
thread was about addressing #2.

> That was a very
> long e-mail so I might be missing something but the obvious thing seems
> to be to force a state since we'll be doing that when we enable anyway.

Hm, okay, but which state should we choose? The first entry in the
voltage-table?

> Or just not have the voltage table and use it as a continuous regulator.

Yes, but that means patching the DT, which means breaking the DT compat.
