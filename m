From: Frank.Hofmann@tomtom.com (Frank Hofmann)
Date: Sun, 22 May 2011 09:01:14 +0200
Subject: [linux-pm] [RFC PATCH] ARM hibernation / suspend-to-disk support
	code
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
	<201105210027.17159.rjw@sisk.pl>
Message-ID: <2C577202CB5719438D4E9608C565CB2C01B69D7B@NL-EXC-07.intra.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> [ ... ]
> > > r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ handler,
> > > if FIQ is in use.  Can we expect any driver using FIQ to save/restore
> > > this state itself, rather than doing it globally?  This may be
> > > reasonable.
> > 
> > We don't need to save/restore those, because at the time the snapshot is 
> > taken interrupts are off and we cannot be in any trap handler either. On 
> > resume, the kernel that has been loaded has initialized them properly 
> > already.
> 
> I'm not sure if this is a safe assumption in general.  We may decide to
> switch to loading hibernate images from boot loaders, for example, and
> it may not hold any more.  Generally, please don't assume _anything_ has
> been properly initialized during resume, before the image is loaded.
> This has already beaten us a couple of times.
> 
> Thanks,
> Rafael

Hi Rafael,

regarding "cannot rely on any state", if that is so then it seems quite unnecessary to save/restore _any_ ARM non-#SYSTEM_MODE state - it'd better be reinitialized by calling cpu_init() after the "core restore" callback. The archives were quite a bit helpful in this context:

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg12671.html

that's the same situation isn't it ?

Regarding FIQ: I agree with Russell and others who previously stated that a driver using FIQ is responsible for implementing suspend/resume hooks itself. But what could be done is to disable/enable it for the snapshot, just in case.

I've also found out that the vmlinux.lds changes don't seem to be necessary - they've been the last remnant of the "old" ARM hibernation patch, but just leaving those out looks to make no difference (the nosave data still ends up in the same place, with the same elf section attributes).

With all this in mind, the core part of the patch becomes somewhat simpler. See attached.


I'll test this on Monday.
FrankH.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110522/71096fef/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hibernation-core-22May2011.patch
Type: text/x-patch
Size: 5391 bytes
Desc: hibernation-core-22May2011.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110522/71096fef/attachment.bin>
