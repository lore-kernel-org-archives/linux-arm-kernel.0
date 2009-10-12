From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 12 Oct 2009 09:14:24 +0200
Subject: zaurus suspend saga: 2.6.32-rc3
In-Reply-To: <87skdpvs3y.fsf@free.fr>
References: <20091011090423.GB1414@ucw.cz>
 <87skdpvs3y.fsf@free.fr>
Message-ID: <20091012071424.GE1765@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2009-10-11 17:59:45, Robert Jarzmik wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> > Hi!
> >
> > I'm using patch similar to this for debugging:
> >
> > ...and good news is that it blinks after pressing of power button.
> >
> > ...core > pm_test also works.
> >
> > I also verified that end of pxa_pm_enter() is reached (with similar
> > blinking patch). End of corgi_pxa_pm_enter() seems to be reached, too.
> >
> > Any ideas what to try next?
> 
> For the Mitac MIO A701 board, with a similar problem, I had :
>  - removed almost all drivers (except screen and USB for control)
>  - realized that the culprit was amongst drivers (which resumed in a loop in
>  that time, should be the same now)

Seems like it is not that simple here;

suspend_enter():

	if (!error) {
		if (!suspend_test(TEST_CORE))
			error = suspend_ops->enter(state);
		sysdev_resume();
	}

[it reaches this point]
	arch_suspend_enable_irqs();
[but not this one]
	BUG_ON(irqs_disabled());

 Enable_cpus:
	enable_nonboot_cpus();

Do I have screaming irq or something?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
