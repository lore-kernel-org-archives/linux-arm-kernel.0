From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 17:14:27 +0000
Subject: [RFC PATCH] arm: asm/cmpxchg.h: Add support half-word xchg()
In-Reply-To: <16818946.F4B9s6bbtr@wuerfel>
References: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
 <3465519.0ga9zC7F7b@wuerfel>
 <CAJhHMCCoFhi2a=qtO3EkX_Y-iy0C=STUt0ULtXMAyGEZJR_Vtw@mail.gmail.com>
 <16818946.F4B9s6bbtr@wuerfel>
Message-ID: <20150225171427.GE8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 05:21:54PM +0100, Arnd Bergmann wrote:
> On Wednesday 25 February 2015 11:11:28 Pranith Kumar wrote:
> > On Wed, Feb 25, 2015 at 10:58 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wednesday 25 February 2015 10:36:20 Pranith Kumar wrote:
> > >> This patch adds support for a half-word xchg() for ARM using ldrexh/strexh
> > >> instructions. It also fixes an asm comment  for __cmpxchg2.
> > >>
> > >> Currently using a half-word xchg() results in the following splat on an ARMv7
> > >> machine.
> > >>
> > >> [   45.833303] xchg: bad data size: pc 0xbe806020, ptr 0xeb18deee, size 2
> > >> [   45.833324] ------------[ cut here ]------------
> > >> [   45.837939] kernel BUG at /dvs/git/dirty/git-master_linux/kernel/arch/arm/kernel/traps.c:727!
> > >>
> > >> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> > >
> > > Unfortunately, the BUG message seems incomplete, can you reproduce this
> > > with CONFIG_DEBUG_BUGVERBOSE enabled?
> > 
> > The bug here is in a module caused when xchg() was used on uint16_t
> > variable. It is caused by the __bad_xchg() for 2 byte swap.
> > 
> > More information:
> > [   45.833303] xchg: bad data size: pc 0xbe806020, ptr 0xeb18deee, size 2
> > [   45.833324] ------------[ cut here ]------------
> > [   45.837939] kernel BUG at
> > /dvs/git/dirty/git-master_linux/kernel/arch/arm/kernel/traps.c:727!
> > [   45.846450] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> > [   45.852275] Modules linked in: test(O+) nvhost_vi
> > [   45.857012] CPU: 0 PID: 1848 Comm: insmod Tainted: G           O
> > 3.10.24-g6a2d13a #1
> > [   45.864744] task: ee406580 ti: eb18c000 task.ti: eb18c000
> > [   45.870141] PC is at __bad_xchg+0x24/0x28
> > [   45.874146] LR is at __bad_xchg+0x24/0x28
> 
> I'm more interested in the backtrace here, it's possible we should fix the
> driver instead.

Actually, I think we ought to get rid of __bad_xchg() so that cases
like this cause a link error instead of a runtime error, just like we
do in other cases as well.

That's something that goes back ages (it used to be called something
like invalidptr in 2.0 kernels...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
