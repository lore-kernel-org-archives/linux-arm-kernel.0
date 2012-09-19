From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Wed, 19 Sep 2012 09:54:47 -0700
Subject: [PATCH 07/11] tty/serial: Add kgdb_nmi driver
In-Reply-To: <5059B200.9040706@windriver.com>
References: <20120913150133.GA16238@lizard>
 <1347548615-18227-7-git-send-email-anton.vorontsov@linaro.org>
 <5059B200.9040706@windriver.com>
Message-ID: <20120919165447.GA6316@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 06:52:32AM -0500, Jason Wessel wrote:
[...]
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -145,6 +145,8 @@ __setup("kgdboc=", kgdboc_option_setup);
> >  
> >  static void cleanup_kgdboc(void)
> >  {
> > +	if (kgdb_unregister_nmi_console())
> > +		return;
> >  	kgdboc_unregister_kbd();
> >  	if (configured == 1)
> >  		kgdb_unregister_io_module(&kgdboc_io_ops);
> > @@ -198,6 +200,10 @@ do_register:
> >  	if (err)
> >  		goto noconfig;
> >  
> > +	err = kgdb_register_nmi_console();
> > +	if (err)
> > +		goto noconfig;
> > +
> 
> Just one question on this one, what do you expect to happen, or how
> does this work when you use a different serial port for example on a
> board that has a real serial port and an FIQ port?   It was not
> obvious that there was a path to check if the port you are
> registering is an FIQ enabled port and then call the
> kgdb_register_nmi_console at that point.

Yes, it works perfectly fine. If the port is not FIQ-enabled (which,
technically, can be enabled later -- it's just not implemented), then
ttyNMI just won't able to receive data.

The reason why I register nmi console in KGDB code (as opposite to arch
code), is the dependcy: the port should be initialized before it can be
used as ttyNMI. We could place the ttyNMI registration code into
late_initcall in arch/, and check for dbg_io_ops, but that is ugly by
itself, plus dbg_io_ops can change.

But with your kgdb_arch->enable_nmi suggestion (which I'll surely
implement), we can skip the registration at least for the cases when
the arch doesn't have this feature.

Thanks!

Anton.
