From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Oct 2015 12:53:33 +0200
Subject: "clk: sunxi: Add a simple gates driver" breaks kernel with older
 DTB
In-Reply-To: <560E5767.2040502@citrix.com>
References: <1443689231.16718.225.camel@citrix.com>
 <20151001204506.GR7104@lukather> <560E5767.2040502@citrix.com>
Message-ID: <20151002105333.GA2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 02, 2015 at 11:07:35AM +0100, Julien Grall wrote:
> Hi Maxime,
> 
> On 01/10/15 21:45, Maxime Ripard wrote:
> > On Thu, Oct 01, 2015 at 09:47:11AM +0100, Ian Campbell wrote:
> >> Booting a recent kernel with the DTB supplied with Debian Jessie (3.16
> >> based) breaks on Cubietruck because that DTB lacks the clock-indices nodes
> >> which the new driver from the commit below adds (replacing the hardcoding
> >> which used to be in clk-sunxi.c).
> >>
> >> It is panicing in drivers/clocksource/timer-sun5i.c with:
> >>
> >> [    0.015413] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
> >> [    0.025049] Kernel panic - not syncing: Can't get timer clock
> >> [    0.030794] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.3.0-rc2-arm-native+ #6
> >> [    0.038002] Hardware name: Allwinner sun7i (A20) Family
> >> [    0.043253] [<c0219794>] (unwind_backtrace) from [<c0214e44>] (show_stack+0x10/0x14)
> >> [    0.050992] [<c0214e44>] (show_stack) from [<c048159c>] (dump_stack+0x88/0x98)
> >> [    0.058213] [<c048159c>] (dump_stack) from [<c02caa98>] (panic+0xa4/0x22c)
> >> [    0.065090] [<c02caa98>] (panic) from [<c0d7c518>] (sun5i_timer_init+0x80/0x384)
> >> [    0.072482] [<c0d7c518>] (sun5i_timer_init) from [<c0d7aad0>] (clocksource_of_init+0x4c/0x8c)
> >> [    0.081001] [<c0d7aad0>] (clocksource_of_init) from [<c0d39b48>] (start_kernel+0x28c/0x3c4)
> >> [    0.089343] [<c0d39b48>] (start_kernel) from [<4020807c>] (0x4020807c)
> >> [    0.095866] ---[ end Kernel panic - not syncing: Can't get timer clock
> >>
> >> Reverting ee38b2698ae2 fixes this specific issue for me (it boots further,
> >> but there seems to be other problems later when earlycon hands over to
> >> proper console, which I've not yet looked into).
> >>
> >> Is this considered acceptable linkage between the kernel and the dtbs?
> >>
> >> I suspect that even if anyone does care this is going to be an uphill
> >> struggle for that minority so I'm going to adjust our test infrastructure
> >> to pickup the dtbs from the kernel it is trying to test rather then reusing
> >> the one from the OS install.
> > 
> > It's never been something we supported (or even claim to support), so
> > it's actually surprising that it's the only commit that need to be
> > reverted, but yeah, you should keep your DTB in sync.
> 
> I would have though the bindings are stable, i.e the compatibility with
> old DT would have been kept in newer kernel.
> 
> So is it something specific to cubietruck?

Nope. All the platforms I've been using on a regular basis do not
guarantee this. Allwinner, obviously, but also:

Atmel:
  * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/arm/Atmel/README#n110

OMAP:
  * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8b9a2810b02e3d9806ba2bf307c8e8dcedaf902d

Berlin:
  * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fd26031ba6356d2b0f7aa214ebff4b12736b6529

Rockchip:
  * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=26ab69cb4c1f77060bece483f2ec210163867782

etc...

> If no, that's very unfortunate because it means that you can't
> re-use the same DT across multiple OS and the DT provided by the
> firmware (if it's built-in).

Is there such OS yet (and by that, I mean one that actually shares our
DT, instead of rewriting its own) ?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/f4bbaa38/attachment.sig>
