From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Feb 2011 19:51:32 +0100
Subject: [PATCH v2 13/13] tty: pruss SUART driver
In-Reply-To: <alpine.LFD.2.00.1102181917520.2701@localhost6.localdomain6>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<20110218143500.23b3044b@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.00.1102181917520.2701@localhost6.localdomain6>
Message-ID: <201102181951.32631.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 February 2011 19:23:49 Thomas Gleixner wrote:
> On Fri, 18 Feb 2011, Alan Cox wrote:
> 
> > On Fri, 18 Feb 2011 19:17:38 +0530
> > "Subhasish Ghosh" <subhasish@mistralsolutions.com> wrote:
> > 
> > > Hello,
> > > 
> > > Regarding the semaphore to mutex migration.
> > > We are using down_trylock in interrupt context,
> > > mutex_trylock cannot be used in interrupt context, so we cannot use mutex in 
> > > our driver.
> > 
> > Then you probably need to rework your locking. Best bet might be to fix
> > all the other stuff and report the driver, and people can think about the
> > locking problem.
> 
> That semaphore is utterly useless to begin with. There are more
> serious locking problems than this one. Non serialized calls to
> suart_intr_clrmask/suart_intr_setmask are the most obvious ones.
> 
> Aside of that the code is complete unreadable.

I think it mostly suffers from the same problem as the CAN driver
I commented on earlier: One of the files (pruss_suart_api.c) was
clearly not written with Linux as the target, and the other files
try to work around this by wrapping a Linux driver around it.

The suart_api HAL stuff clearly needs to go away, so that the rest
can be rewritten into a proper device driver.

	Arnd
