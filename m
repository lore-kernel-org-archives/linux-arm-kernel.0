From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Nov 2010 09:18:32 +0000
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <AANLkTin5Tfcuy0WcHJ22rWC8niwZCj8SZAMKLz0p9jwc@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
	<1290526740-27624-2-git-send-email-ohad@wizery.com>
	<20101126045912.GC6598@lixom.net>
	<AANLkTin5Tfcuy0WcHJ22rWC8niwZCj8SZAMKLz0p9jwc@mail.gmail.com>
Message-ID: <20101126091832.GE9310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 26, 2010 at 10:53:10AM +0200, Ohad Ben-Cohen wrote:
> >> +int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
> >> +{
> >> + ? ? int ret;
> >> +
> >> + ? ? if (unlikely(!hwlock)) {
> >> + ? ? ? ? ? ? pr_err("invalid hwlock\n");
> >
> > These kind of errors can get very spammy for buggy drivers.
> 
> Yeah, but that's the purpose - I want to catch such egregious drivers
> who try to crash the kernel.

That can be better - because you get a backtrace, and it causes people
to report the problem rather than just ignore it.  It may also prevent
the driver author releasing his code (as it won't work on their
initial testing.)

> > It's likely
> > more useful to either do a WARN_ON(), and/or move them under a debug
> > config option.
> 
> Why would you prefer to compile out reporting of such extremely buggy
> behavior ?

If it's "extremely buggy behaviour" then the drivers deserve to crash.
Such stuff should cause them not to get out the door.  A simple printk
with an error return can just be ignored.
