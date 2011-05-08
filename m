From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 May 2011 10:42:15 +0100
Subject: Resend [PATCH 00/10] ARM: SMP initialization consolidation
In-Reply-To: <201105031557.42355.arnd@arndb.de>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
	<4DBBA509.6080203@codeaurora.org>
	<20110502234012.GJ28001@n2100.arm.linux.org.uk>
	<201105031557.42355.arnd@arndb.de>
Message-ID: <20110508094215.GC27807@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2011 at 03:57:42PM +0200, Arnd Bergmann wrote:
> On Tuesday 03 May 2011, Russell King - ARM Linux wrote:
> > Such a SoC may wish to do things differently from the current approach
> > (which is basically bring up all cores at boot) particularly as the
> > performance gained from each CPU is far from identical.  So I've been
> > nervous about moving the CPU map initialization into core code.
> > 
> > Note that the low power CPU may not be the last in the set, so merely
> > limiting the system to two CPUs is not the answer.
> 
> If I read the patches correctly, it's still strictly opt-in per platform.

Except where things are moved into the generic code, such as the setting
of present CPUs.

> When a platform wants to support the setup you mentioned or something
> even stranger, all it would have to do is provide its own versions of
> the SMP pen and scu init function, right?

No.

As I've already said in the past, I doubt that very many platforms actually
need the SMP pen stuff.  There are two situations where you need that:

1. If you have more than two CPUs, _and_ you have no way to control which
   of those CPUs are triggered to jump into the kernel.
2. If you have hotplug and you have no way to power down or reset the
   CPUs.

There seems to be few platforms which fall into (1) - most SMP
implementations are based around two CPUs today so if you only have one
secondary CPU, there's no point triggering it via a soft irq to enter the
kernel, then hold it in a pen, then release it from the pen, etc.

Those which seem to fall into (2) do so because they've cut'n'pasted the
code from the Realview platforms, along with its bugs with the auxillary
control register, which subseqently get tweaked.

My feeling is that most of the hotplug implementations are just basic "this
seems to approximately work" kind of things rather than someone taking a
look at what the hardware supports and doing something more useful (such
as powering down the CPU, placing it in reset, etc.)

However, (2) is dependent on (1) as both share pen_release.  (2) needs to
be sorted by platforms before the (1) can be eliminated from platform code.

I'd much rather see the pen_release stuff being eliminated from platforms
where it's not necessary, rather than being turned into a generic thing
which everyone uses because its there.  Not only should this simplify the
code, but also reduce the size of the platform SMP support code.
