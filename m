From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 09:30:19 +0200
Subject: [PATCH v7 3/5] clk: Supply the critical clock {init, enable,
 disable} framework
In-Reply-To: <20150730224720.23791.6722@quantum>
References: <1437570255-21049-1-git-send-email-lee.jones@linaro.org>
 <1437570255-21049-4-git-send-email-lee.jones@linaro.org>
 <20150727072549.GP2564@lukather> <20150727085338.GW3436@x1>
 <20150728114022.GW2564@lukather> <20150728130055.GV14943@x1>
 <20150730011932.642.85168@quantum> <20150730095014.GD14642@x1>
 <20150730224720.23791.6722@quantum>
Message-ID: <20150731073019.GU2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 03:47:20PM -0700, Michael Turquette wrote:
> > > >    */
> > > > 
> > > > Resume:
> > > >   /* Order is unimportant */
> > > >   SPI enables Clock 4 (ref == 1)
> > > >   RAM enables Clock 4 and re-enables .leave_on (ref == 2)
> > > >   I2C enables Clock 4 (ref == 3)
> > > 
> > > Same again. As soon as RAM calls clk_enable_critical the ref count goes
> > > up. .leave_on does nothing as far as I can tell. The all works because
> > > of the reference counting, which already exists before this patch
> > > series.
> > 
> > So fundamentally you're right in what you say.  All you really need to
> > disable a critical clock is write a knowledgeable driver, which is
> > intentionally unbalanced i.e. just calls clk_disable().  All this
> 
> OK, the line above is helpful. What you really want is a formalized
> hand-off mechanism, whereby the clock is enabled at registration-time
> and it cannot be turned off until the right driver claims it and decides
> turning it off is OK (with a priori knowledge that the clock is already
> enabled).

There's two things that should be covered, and are related, yet can be
done in two steps:

  - Have a way to, no matter what (which configuration we have, if we
    have multiple users or not that might reparent or disable their
    clocks, etc.), make sure that a clock will always be running by
    default. This is done through the call in clk-conf, and we
    identify such clocks using critical-clocks in the DT.

  - Now, even though that information is true, some driver who are
    aware of that fact might want to disable those critical
    clocks. This is what the clk_disable_critical and
    clk_enable_critical functions are here for.

> Note that I don't think this implementation can really work in the near
> future. Today we do not catch unbalanced calls to clk_enable and
> clk_disable, but I have a patch that catches this and WARNs loudly in my
> private tree. More on that in the next stanza.
> 
> What I don't understand is if there is ever a case for a clock consumer
> driver to ever call clk_enable_critical... I do not think there is. What
> you're trying to protect against is having the clock disabled BEFORE
> that "knowledgeable driver" has a chance to enable it.

It's really about what we want the API to look like in the second
case.

Do we want such drivers to still call clk_prepare_enable? Some other
function? Should they assume that the clock has already been enabled,
or do we want a handover, or a force disable, or whatever.

I guess we should discuss those questions, before starting to think
about how to implement it.

IMHO, I think that the existing way of doing should be used, or at
least with the same mindset to avoid confusion, errors, and
misinformed reviews.

So I'd expect the drivers to do something like:

probe:
  clk_get
  clk_critical_enable

remove / probe error path:
  clk_critical_disable
  clk_put

and use the clk_critical_enable and clk_critical_disable whenever
needed, and thing would just work as intended.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/9e5c7098/attachment.sig>
