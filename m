From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 22 Feb 2011 11:11:03 +0000
Subject: [PATCH v2 13/13] tty: pruss SUART driver
In-Reply-To: <A6D1CF0E941748448610BE8874FC586F@subhasishg>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-14-git-send-email-subhasish@mistralsolutions.com>
	<20110211162814.6ff274f1@lxorguk.ukuu.org.uk>
	<A6D1CF0E941748448610BE8874FC586F@subhasishg>
Message-ID: <20110222111103.5d0dd0a7@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> we used separate files and hence we decided to keep the code in a separate
> directory so that the related files can be identified easily.

Fair enough but I would have thought you could drop the two files in the
serial directory if they have obviously related names- trivial item/
> 
> >
> >
> >
> >> +#ifdef __SUART_DEBUG
> >> +#define __suart_debug(fmt, args...) \
> >> + printk(KERN_DEBUG "suart_debug: " fmt, ## args)
> >> +#else
> >> +#define __suart_debug(fmt, args...)
> >> +#endif
> >> +
> >> +#define  __suart_err(fmt, args...) printk(KERN_ERR "suart_err: " fmt, ##
> >> args)
> >
> > Use dev_dbg/dev_err/pr_debug/pr_err
> 
> SG - did you mean replace the printks above with dev_dgb/err or the 
> suart_dbg/err.

Ideally all the messages shopuld use dev_dbg/dev_err etc. That allows you
to configure debug levels and the like nicely as well as producing
clearer printk info. In some cases with tty code you may not know the
device so have to use pr_err/pr_debug etc.

Ok

> > Which is never checked. Far better to use WARN_ON and the like for such
> > cases - or if like this one they don't appear to be possible to simply
> > delete them
> 
> SG -- OK, does this look ok ?
> =================================
> if (h_uart == NULL) {
> +WARN_ON(1);
> - return PRU_SUART_ERR_HANDLE_INVALID;
> +return -EINVAL;
> }

Yep - the user will now get a backtrace, and in addition kerneloops.org
can capture it if that is set up in the distro in use.

Alan
