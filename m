From: ptesarik@suse.cz (Petr Tesarik)
Date: Fri, 1 Jul 2011 16:54:06 +0200
Subject: [PATCH 00/10] Enhance /dev/mem to allow read/write of arbitrary
	physical addresses
In-Reply-To: <20110701144641.GA23272@elte.hu>
References: <201106171038.25988.ptesarik@suse.cz>
	<20110701144129.GA10052@infradead.org>
	<20110701144641.GA23272@elte.hu>
Message-ID: <201107011654.06651.ptesarik@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 1. ?ervence 2011 16:46:41 Ingo Molnar napsal(a):
> * Christoph Hellwig <hch@infradead.org> wrote:
> > On Fri, Jul 01, 2011 at 04:37:35PM +0200, Ingo Molnar wrote:
> > > After initial modules have loaded i essentially disable crash.ko
> > > via /proc/sys/kernel/modules_disabled so rootkits have to work a
> > > bit harder than that.
> > 
> > Not sure for fedora as I don'[t have a kernel tree at hand right
> > now, but for x86 systems at least RHEL6 has the module built in.
> > [...]
> 
> Fedora Rawhide has it modular:
> 
>  # grep CRASH /boot/config-2.6.38-0.rc7.git2.3.fc16.x86_64
>  CONFIG_CRASH=m
> 
>  # rpm -ql kernel-2.6.38-0.rc7.git2.3.fc16.x86_64 | grep crash
>  /lib/modules/2.6.38-0.rc7.git2.3.fc16.x86_64/kernel/drivers/char/crash.ko
> 
> > [...]  Either way we'll need some way to support crash properly in
> > mainline, preferably in a boot-time opt-in way. [...]
> 
> Yes, boot-time opt-in was what i suggested.
> 
> > [...] I'd tend slightly toward optionally enabling /dev/mem for it
> > instead of a separate driver, but if people prefer a different
> > route I'm fine, too.
> 
> No, sharing the driver is perfectly fine and sane as long as this
> weird usage is not enabled widely.

Note that if you want to solve the Fedora case, you want to make STRICT_DEVMEM 
run-time configurable. My patch set does nothing about it. It merely tries to 
fix the highmem deficiency (actually, the first patch is a plain bugfix on any 
architecture where loff_t is larger than long).

The STRICT_DEVMEM logic is implemented in range_is_allowed(), and I leave it 
as-is.

> > Note that for normal crash usage read only access is just fine.
> 
> That's true as well. Petr?

Yes, that's true. Although there is some write support in crash, I have never 
ever felt the need to use it, and I've been using crash a lot in the last 5 
years.

Thanks,
Petr Tesarik
