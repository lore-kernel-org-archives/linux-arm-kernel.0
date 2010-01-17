From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 17 Jan 2010 13:26:18 +0000
Subject: [suspend/resume] Re: userspace notification from module
In-Reply-To: <20100117130739.GA2035@ucw.cz>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001162305.56972.rjw@sisk.pl> <20100116221929.GB8425@elf.ucw.cz>
	<201001162326.09092.rjw@sisk.pl> <20100117130739.GA2035@ucw.cz>
Message-ID: <20100117132618.GA742@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 17, 2010 at 02:07:39PM +0100, Pavel Machek wrote:
> AFAICT following message would be nice.
> 
> 1) battery is critical, userspace please do something
> 
> On zaurus and similar, you could add
> 
> 2) oh and btw we had power failure so we suspended (or maybe -- so
> hardware suspended itself -- rmk's examples and old apm systems); we
> are now back and running
> 
> notification... but... ideally those power failures should never
> happen anyway, so... having this notification is in no way neccessary.

There's another consideration here: the more complex the emergency
procedure, the higher the chance of _something_ causing it to fail,
and if it does fail, the result is data loss.

In a properly running system, this isn't something that's going to
get a lot of testing, so there's a higher chance that there will be
bugs, so the simpler the solution, the better.

It's a bit like the kernel shutdown paths - because they don't get a
lot of use, they don't get tested enough, and having discussed it with
Arjan van de Ven, it's a known weakness.  So we know that they're not
that well tested - and the result is eg, 33-rc3 on shutdown results
in an oops for me on x86.

You really don't want to oops or deadlock on "battery critically low".
