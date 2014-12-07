From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 7 Dec 2014 19:08:08 +0100
Subject: [PATCH 3/9] clk: sunxi: Add prcm mod0 clock driver
In-Reply-To: <547EDCA0.4040805@redhat.com>
References: <20141126211318.GN25249@lukather> <5476E3A5.4000708@redhat.com>
 <CAGb2v652m0bCdPWFF4LWwjcrCJZvnLibFPw8xXJ3Q-Ge+_-p7g@mail.gmail.com>
 <5476F8AB.2000601@redhat.com> <20141127190509.GR25249@lukather>
 <54787A8A.6040209@redhat.com> <20141202154524.GD30256@lukather>
 <547EDCA0.4040805@redhat.com>
Message-ID: <20141207180808.GO12434@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 10:49:20AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 12/02/2014 04:45 PM, Maxime Ripard wrote:
> 
> >> Ok, so thinking more about this, I'm still convinced that the MFD
> >>framework is only getting in the way here.
> >
> >You still haven't said of what exactly it's getting in the way of.
> 
> Of using of_clk_define to bind to the mod0 clk in the prcm, because the
> ir_clk node does not have its own reg property when the mfd framework is
> used and of_clk_define requires the node to have its own reg property.

Yes. And the obvious solution to that is to just not use
OF_CLK_DECLARE but a platform_driver, which is totally fine.

> 
> >>But I can see having things represented in devicetree properly, with
> >>the clocks, etc. as child nodes of the prcm being something which we
> >>want.
> >
> >Clocks and reset are the only thing set so far, because we need
> >reference to them from the DT itself, nothing more.
> >
> >We could very much have more devices instatiated from the MFD itself.
> >
> >>So since all we are using the MFD for is to instantiate platform
> >>devices under the prcm nodes, and assign an io resource for the regs
> >>to them, why not simply make the prcm node itself a simple-bus.
> >
> >No, this is really not a bus. It shouldn't be described at all as
> >such. It is a device, that has multiple functionnalities in the system
> >=> MFD. It really is that simple.
> 
> Ok, I can live with that, but likewise the clocks node is not a bus either!

True, and just like we just saw with Chen-Yu patches, it can even leak
implementation details. Which was one of the arguments from Mark
against it iirc.

> So it should not have a simple-bus compatible either, and as such we cannot
> simply change the mod0 driver from of_clk_define to a platform driver because
> then we need to instantiate platform devs for the mod0 clock nodes, which
> means making the clock node a simple-bus.

I guess we can do that as a temporary measure until we get things
right on that front. I'm totally open to doing that work, so I'm not
asking you to do it.

> I can see your logic in wanting the ir_clk prcm sub-node to use the
> mod0 compatible string, so how about we make the mod0 driver both
> register through of_declare and as a platform driver. Note this means
> that it will try to bind twice to the ir_clk node, since of_clk_declare
> will cause it to try and bind there too AFAIK.

Hmmm, I could live with that for a while too. That shouldn't even
require too much work, since the first thing we check in the mod0 code
is that we actually have something in reg, which will not be the case
in the OF_CLK_DECLARE case.

> The of_clk_declare bind will fail though because there is no regs
> property, so this double bind is not an issue as long as we do not
> log errors on the first bind failure.

Yep, exactly.

> Note that the ir_clk node will still need an "ir-clk" compatible as
> well for the MFD to find it and assign the proper resources to it.

No, it really doesn't. At least for now, we have a single mod0 clock
under the PRCM MFD. If (and only if) one day, we find ourselves in a
position where we have two mod0 clocks under the PRCM, then we'll fix
the MFD code to deal with that, because it really should deal with it.

> But this way we will have the clk driver binding to the mod0 clk
> compatible, which is what you want, while having the MFD assign
> resources on the fact that it is the ir-clk node, so that things
> will still work if there are multiple mod0 clks in the prcm.

I really think having a different compatible is both wrong on a
theoritical point of view and doesn't bring anything to the table now
(and might never do)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141207/267b81d5/attachment.sig>
