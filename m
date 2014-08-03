From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Aug 2014 20:23:26 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <1406891173.5747.63.camel@hornet>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
 <53DB6B4F.9080605@arm.com> <1406890899.2794.40.camel@linaro1.home>
 <1406891173.5747.63.camel@hornet>
Message-ID: <20140803032326.GC14214@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 12:06:13PM +0100, Pawel Moll wrote:
> On Fri, 2014-08-01 at 12:01 +0100, Jon Medhurst (Tixy) wrote:
> > > -->8
> > > diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> > > index 490f3dced749..f4c36e70166a 100644
> > > --- a/arch/arm/common/bL_switcher.c
> > > +++ b/arch/arm/common/bL_switcher.c
> > > @@ -794,7 +794,7 @@ static int bL_switcher_hotplug_callback(struct 
> > > notifier_block *nfb,
> > >          return NOTIFY_DONE;
> > >   }
> > > 
> > > -static bool no_bL_switcher;
> > > +static bool no_bL_switcher = true;
> > 
> > This changes the default for everyone, which I guess is fair enough if
> > there is a good reason, but I'm not sure there is.
> 
> I would vote for this change and argue that b.L switcher is "strange
> enough" (ie. I know I've got 5 processors, so why do I see only 2?)
> _not_ to have it enabled by default. I'd hope that a user looking for
> this functionality will know how to turn it on.

I strongly disagree. Today nearly all products that ship have a switcher
enabled, since the scheduler work has not been done yet upstream. Having
a platform that behaves undeterministically because the scheduler can't tell
the core types apart and makes bad decisions is better than someone not finding
the right number of CPUs under /proc/cpuinfo.

And the same goes in the other direction: Any user looking to test out the
scheduler work will know how to turn it on.

The only other argument I'm willing to have here is if you want to somehow
control this per platform and add a hook on vexpress that turns off the
switcher by default. The rest of them should have it on.


-Olof
