From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Oct 2013 12:15:13 +0100
Subject: [PATCH 01/11] usb: chipidea: Add power management support
In-Reply-To: <20131015021814.GA3254@shlinux1.ap.freescale.net>
References: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
 <1381570513-24927-2-git-send-email-peter.chen@freescale.com>
 <20131014110108.GL25034@n2100.arm.linux.org.uk>
 <20131015021814.GA3254@shlinux1.ap.freescale.net>
Message-ID: <20131015111512.GA25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 10:18:15AM +0800, Peter Chen wrote:
> So, the lessons for this topic are:
> 
> - If one atomic variable's operation only includes one instruction like
> atomic_read and atomic_set, it is not meaningful for using atomic
> operation, we can just use bool instead of it.

The lesson here is that these are 100% equivalent as far as safety from
races is concerned:

	a = atomic_read(&v);		a = v->counter;

	atomic_set(&v, b);		v->counter = b;

and in general, whenever atomic_read() gets used it's almost certainly
a sign of a bug.

Consider this (similar has been submitted):

	a = atomic_read(&v);
	if (a != 0)
		a += 1;

	atomic_set(&v, a);

and people have thought that somehow this is magically safe from races
because they're using atomic_t, and somehow that saves the universe.
The above is in fact no safer than:

	a = *v;
	if (a != 0)
		a += 1;
	*v = a;

The only thing that using atomic_* does is add a false sense of security
and a level of obfuscation to catch the unwary reviewer.

The reason is quite simple: a single access read in itself is atomic.
Either it has read the value, or it hasn't.  A single access store is
itself atomic.  Either the data has been written, or it hasn't.  The
issue is _always_ what you do around it.
