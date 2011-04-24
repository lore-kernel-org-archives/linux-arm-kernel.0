From: linuxzsc@gmail.com (Richard Zhao)
Date: Sun, 24 Apr 2011 17:55:54 +0800
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <BANLkTi=-nV4=KV-Zodsbor8TG1faB_PhwA@mail.gmail.com>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1104212146400.3323@ionos>
	<20110422002805.GA2268@richard-laptop>
	<alpine.LFD.2.02.1104221122410.3323@ionos>
	<20110423140839.GA3229@richard-laptop>
	<alpine.LFD.2.02.1104231701320.3323@ionos>
	<BANLkTi=-nV4=KV-Zodsbor8TG1faB_PhwA@mail.gmail.com>
Message-ID: <20110424095554.GB2310@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 24, 2011 at 09:20:30AM +0200, Linus Walleij wrote:
> 2011/4/23 Thomas Gleixner <tglx@linutronix.de>:
> > On Sat, 23 Apr 2011, Richard Zhao wrote:
> >> On Fri, Apr 22, 2011 at 11:23:49AM +0200, Thomas Gleixner wrote:
> >> > On Fri, 22 Apr 2011, Richard Zhao wrote:
> >> > > > One does a try_module_get(clk->owner), which should be done in generic
> >> > > > code. The other does special clock enabling magic which wants to go to
> >> > > > clk->prepare().
> >> > > >
> >> > > You forget mach-u300 __clk_get. It updates some registers.
> >> > > The ops get/put let arch clock driver have a chance to do special things at the
> >> > > time when a user begins to use the clock.
> >> >
> >> > No I did not forget. It's exactly the code which wants to go into
> >> > clk->prepare. Which you have to call _before_ doing anything with the
> >> > clock, so there is no need for an extra callback.
> >>
> >> No. clk_prepare only have to be called before clk_enable, but not have to for
> >> other operations, set_rate/set_parent etc.
> >
> > And why do you need those registers set before you actually
> > prepare/enable the clock? Just to set the rate register? You can store
> > that information and set it on prepare. Before prepare/enable the
> > value of the rate register is totally irrelevant.
> >
> > The point of anything whats named get and put in the kernel is to
> > obtain or drop a reference to an object.
> >
> > Putting arbitrary initialization into such functions is a really bad
> > hack.
> >
> > And looking at that u300 code, it's borken:
> >
> > ? ?user1: clk_get("MCLK");
> > ? ? ? ? ? clk_set_rate(.....);
> >
> > ? ?user2: clk_get("MCLK");
> >
> > The second clk_get() call will overwrite what ?
> 
> Heh yeah that is the case, and this code can just as well live in the
> ->prepare() function.
> 
> The clock that goes to "MCLK" and "MSPRO" is utilizing a common
> clock divider, which sounds backwards, but in practice this is because
> it's and MMC or Memory Stick Pro block clock, and you cannot pinmux
> in both in the ASIC, they are connected to the same pins and either
> function need its own support electronics. So naturally only one of
> them is ever active at the same time.
> 
> This should be *properly* reflected by creating the pin/padmux
> framework and have the clock prepare() call hook back into that,
> so that when you try to activate say "mclk" you need to mux in these
> pins and if the mspro is muxed in at that time you return -ENODEV
> and the clock code bails out.
> 
> We should just move it to prepare() and I'll fix it up if need be.
Great, so we don't need __clk_get/put. The only purpose of clk_get is
to return pointer of clk.

Thanks
Richard
> 
> Linus Walleij
