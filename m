From: yong.shen@linaro.org (Yong Shen)
Date: Wed, 16 Feb 2011 10:25:35 +0100
Subject: [PATCH v2 1/2] ARM: IMX5: cpuidle driver
In-Reply-To: <20110216091326.GD26437@pengutronix.de>
References: <1297416973-32740-1-git-send-email-yong.shen@linaro.org>
	<1297416973-32740-2-git-send-email-yong.shen@linaro.org>
	<20110216081103.GE2027@pengutronix.de>
	<AANLkTinj_8wqZ36TKdcx3L6CLaYyLD36ymFRq+KnyZXF@mail.gmail.com>
	<20110216091326.GD26437@pengutronix.de>
Message-ID: <AANLkTikH5svzLY8CCaydNxN-8PRuBTnOFg=eFXXwpe9+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 10:13 AM, Sascha Hauer <s.hauer@pengutronix.de>wrote:

> On Wed, Feb 16, 2011 at 09:37:47AM +0100, Yong Shen wrote:
> > Hi Sascha,
> >
> >
> > > > +     local_irq_disable();
> > > > +     do_gettimeofday(&before);
> > > > +
> > > > +     plat_lpc = __raw_readl(MXC_CORTEXA8_PLAT_LPC) &
> > > > +         ~(MXC_CORTEXA8_PLAT_LPC_DSM);
> > >
> > > One thing that strikes me here is the fact that this code can probably
> > > run on i.MX53 aswell, right? It's only that these registers have
> > > different addresses on i.MX53. The MXC_ prefix is therefore not a good
> > > idea. Switching this to MX51_ and having an additional MX53_ register
> > > leads to code duplication. This shows that it's a bad idea to code
> > > fixed addresses in the code. We should go for base + offset instead
> > > so that this code will have a better start on i.MX53. This of course
> > > needs changes in the current crm_regs.h and probably in the i.MX51/53
> > > clock code.
> > >
> > Yes, for mx53, it is similar.
> > But for the case you are talking about, is it easier that we keep MXC_
> > prefix in this file and define MXC_ to MX51 or MX53 in crm_regs.h
> according
> > to which board is running?
>
> I don't understand. How can we 'define' (which is compile time) to
> something depending on the board (which is runtime)?

I ignored the goal is one image running on multiple SOCs.

>


> > In addition, registers for this code are not in one section, which means
> > many BASEx + offset there, if I understand right. Do you have a sample
> for
> > 'base + offset' case? since mx53 just came in, I am not sure about such
> > case.
>
> Forget it. I just realized that more or less by accident the virtual
> addresses for the i.MX51 and i.MX53 are the same.
>
So, the conclusion is: still using MXC_ prefix in this period. right?
Correct me.

Yong

>
> Sascha
>
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110216/1d858dad/attachment-0001.html>
