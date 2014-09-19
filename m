From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 19 Sep 2014 10:36:54 -0700 (PDT)
Subject: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
In-Reply-To: <20140919161927.GA28613@kahuna>
References: <1411067086-16613-1-git-send-email-nm@ti.com>
 <1411067086-16613-4-git-send-email-nm@ti.com>
 <alpine.DEB.2.10.1409181749170.4206@nanos> <20140919030333.GA6088@kahuna>
 <alpine.DEB.2.10.1409190710320.5612@nanos> <20140919161927.GA28613@kahuna>
Message-ID: <alpine.DEB.2.10.1409191027330.5612@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Sep 2014, Nishanth Menon wrote:
> On 08:37-20140919, Thomas Gleixner wrote:
> > The other omap drivers using this have the same issue ... And of
> > course they are subtly different.
> > 
> > The uart one handles the actual device interrupt, which is violating
> > the general rule of possible interrupt reentrancy in the pm-runtime
> > case if the two interrupts are affine to two different cores. Yes,
> > it's protected by a lock and works by chance ....
> > 
> > The mmc one issues a disable_irq_nosync() in the wakeup irq handler
> > itself.
> > 
> > WHY does one driver need that and the other does not? You are not even
> > able to come up with a common scheme for OMAP. I don't want to see the
> > mess others are going to create when this stuff becomes more used.
> > 
> > Thanks,
> > 
> > 	tglx
> 
> I think I understand your concern - I request Tony to comment about
> this. I mean, I can try and hook things like uart in other drivers
> (like https://patchwork.kernel.org/patch/4759171/ ), but w.r.t overall
> generic usage guideline wise, I would prefer Tony to comment.

No, the uart and that i2c thing are just wrong. Assume the following

device irq affine to cpu0
wakeup irq affine to cpu1

CPU 0				CPU 1

runtime suspend

 enable_wake(wakeup irq);

wakeup interrupt is raised	device interrupt is raised

  dev_handler(device)		dev_handler(device)

It might work due to locking, but it is nevertheless wrong. Interrupt
handlers for devices are guaranteed not to be reentrant. And this
brilliant stuff simply violates that guarantee. So, no. It's wrong
even if it happens to work by chance.

Thanks,

	tglx
