From: simon@sequanux.org (Simon Guinot)
Date: Wed, 6 Jul 2011 16:18:23 +0000
Subject: plat-orion multi purpose pins problem for mv78200
In-Reply-To: <4E132FD5.1090409@drewtech.com>
References: <4E0E1CA8.7090200@drewtech.com>
	<20110702122344.GJ31228@kw.sim.vm.gnt>
	<CAMAG_eexDoKrPsrd7+3bpsN3y0pptqwhFRP2NKqd_Nny+M+NGg@mail.gmail.com>
	<4E132FD5.1090409@drewtech.com>
Message-ID: <20110706161823.GB22857@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 11:37:57AM -0400, Joey Oravec wrote:
> On 7/3/2011 8:46 AM, saeed bishara wrote:
> >>It doesn't seems the code was behaving differently before 3.0-rc. I mean
> >>before the MPP and GPIO consolidation work. It was ?
> >that's right, this issue was before the consolidation work.
> Agreed. I only meant to say that the MPP code is broken for mv78200
> in 3.0-rc5, so the maintainers should consider a short-term fix of
> disabling the checks in orion_gpio_is_valid().

And break code relying on the orion_gpio_is_valid() correctness ?
IMHO, this kind of workaround is just not acceptable.

> 
> >>Does hardware allows a configuration like MPP0_GE0_COL and MPP32_GPIO
> >>simultaneously ?
> >yes, this is possible.
> Agreed. MPP is the pin that can be mux'ed to 7 resources. GPIO is
> just one of those resources. Yes the hardware supports your example.
> Most resources can be routed to several different pins to allow
> flexibility in board design.
> 
> Since MPP is just a pin-mux, it's possible for Marvell to build an
> SoC in the future that can route a few different GPIOs onto a given
> MPP pin. It seems like any solution should account for this.
> 
> >>If not (and only if not), the problem is simply mapping a MPP number on
> >>the correct GPIO number. Isn't it ?
> >>
> >>In that case, what about using the MPPxx_GPIO definitions (found in
> >>mach-mv78xx0/mpp.h) to map the right GPIO number ?
> >>
> >>For example:
> >>
> >>#define MPP32_GPIO        MPP(32, 0x1, 1, 1, 1)
> >>
> >>could be replaced by:
> >>
> >>#define MPP32_GPIO        MPP(0, 0x1, 1, 1, 1)
> >that won't work because the num (first number) is used as the mpp
> >index. see orion_mpp_conf() implementation.
> >I think the solution is to extend the MPP define to include the
> >explicit gpio number, so it will look like:
> >#define MPP(_num, _gpio _sel, _in, _out, _78100_A0)
> That could work as long as a value is reserved to mean "not gpio" like:
> 
> #define MPP0_GPIO        MPP(0, 0, 0x0, 1, 1, 1)
> #define MPP0_GE0_COL        MPP(0, -1, 0x1, 1, 0, 1)

Maybe we could add a function pointer to the parameter list for
orion_mpp_conf(). Something like: int (*mpp_to_gpio) (unsigned int num).

If given to orion_mpp_conf(), the function would be used to perform the
MPP to GPIO conversion. And if NULL, a 1:1 GPIO to MPP mapping would be
used (current code).

A such solution would let almost unchanged the code found in
mach-{kirkwood,orion5x,dove}.

> 
> Note that orion_gpio_set_valid() and orion_gpio_is_valid() would
> both need rework. The functions need to handle that a GPIO can be
> mux'ed onto any MPP pin. I described this problem in another email
> on the thread.

I don't understand what's wrong with the GPIO array.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110706/7c8a4a63/attachment.sig>
