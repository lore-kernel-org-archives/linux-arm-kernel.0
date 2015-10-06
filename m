From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 11:12:53 +0200
Subject: [PATCH 0/2] ARM: EXYNOS: Allow to use architected timer
In-Reply-To: <00d801d10014$e6d994a0$b48cbde0$@samsung.com>
References: <cover.1444119342.git.p.fedin@samsung.com>
 <6613638.q5qyQZxXy7@wuerfel> <00d801d10014$e6d994a0$b48cbde0$@samsung.com>
Message-ID: <5008072.V9UdTVvpUS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 11:56:33 Pavel Fedin wrote:
>  Hello!
> 
> > IIRC the use of the CP15 timer is not reliable on this platform.
> > I don't have a link ready, but this has come up a few times.
> 
>  I know that Samsung SoC guys are not very keen on this, therefore i actually made this optional. If
> you want, you could omit the second patch, and by default Exynos platform will use MCT. But if
> someone wants to use KVM, it would be enough only to modify device tree in order to enable CP15.
> Would this be a good compromise?
> 
> > Regarding KVM usage, would it be possible to emulate the architected
> > timer from qemu instead?
> 
>  Unfortunately no. Accesses to virtual timer registers cannot be trapped. It is possible to trap
> physical timer accesses, and trick the kernel into using it, but it's slow, and it is a different
> story, which you can read here: http://www.spinics.net/lists/kvm/msg121714.html.
>  So, i think that having an option to use CP15 would be a good solution.

My feeling is that is shouldn't be keyed off the presence of the device in DT
though. Maybe we can find a way that allows you to put the device into DT
but not have it used by default unless the user explicitly enables it, e.g. though
a kernel command line option like "force_broken_archtimer"?

Or maybe we could find a way to keep using MCT in the host but use the
arch timer in the guest only? At least that would not potentially break
anything that works today.

> It is known to work, and i use this configuration here on SMDK5410 without any problems.

For all I can tell, nobody every /saw/ the problem, we just know that it
hasn't passed verification (or something like that) and you shouldn't
use it in production.

	Arnd
