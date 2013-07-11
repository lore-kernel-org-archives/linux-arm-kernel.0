From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Jul 2013 23:24:41 -0700
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <51DE4E3F.6030503@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org> <20130710142633.GV5523@atomide.com>
 <51DE4E3F.6030503@ti.com>
Message-ID: <20130711062440.GY5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130710 23:25]:
> On Wednesday 10 July 2013 07:56 PM, Tony Lindgren wrote:
> > 
> > Felipe is right, looks like all we need is to check if context is
> > initialized or not. So no need for mach-omap2/serial.c or hwmod tinkering.
> > 
> > After that having DEBUG_LL and cmdline with earlyprintk console=ttyO..
> > works for me.
> 
> On what platform? Like I said there are flags set statically in hmwod
> data for OMAP4 and OMAP5, which make it work without any hwmod tinkering
> in mach-omap2/serial.c. But it won't work for am33xx.

For me omap4 sdp hangs during ttyO2 probe if earlyprintk is enabled for
that port and console is enabled for that port. That's because we attempt
to restore uninitialized context.

It's possible that we have more than one bug here though.
 
> > @@ -1523,6 +1524,8 @@ static int serial_omap_probe(struct platform_device *pdev)
> >  
> >  	pm_runtime_mark_last_busy(up->dev);
> >  	pm_runtime_put_autosuspend(up->dev);
> > +	up->initialized = true;
> 
> This won't help as the context save for serial happens as part of set_termios() and not
> when the device is probed.

The issue is that in serial probe we currently restore NULL context to
the port which kills earlyprintk output until set_termios() is called.

But as discussed, there are better ways for fixing this issue.

Regards,

Tony
