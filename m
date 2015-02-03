From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Feb 2015 07:22:15 -0800
Subject: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
In-Reply-To: <54D08AFB.7040203@ti.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <20150201212432.22722.70917@quantum> <54CFD0B1.2000003@ti.com>
 <20150202224139.421.84094@quantum> <54D072AC.5090206@collabora.com>
 <54D08AFB.7040203@ti.com>
Message-ID: <20150203152214.GA25235@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150203 00:49]:
> On 02/03/2015 09:03 AM, Tomeu Vizoso wrote:
> >
> >I think you got it right, just wanted to mention that we can and
> >probably should make the clk_get_parent_* calls in the consumer API to
> >return per-user clk instances but that we need to make sure first that
> >callers call clk_put afterwards.
> >
> >This should also allow us to remove the reference to struct clk from
> >clk_hw, which is at best awkward.
> 
> For the DPLL code it should just be fine to be able to get the current
> parent index (not parent clock handle), and read a parent clock rate based
> on an arbitrary index (not just the current one.) I don't think there is any
> other need for having the clk_ref / clk_bypass clock handles around.

I'd like to avoid the situation where the children have know that
certain parent index and parent rate means bypass mode for both
parent and children. 

Maybe we can hide that knowledge into some Linux generic PLL code so
the children can get the PLL output as a mux clock. For a PLL, there
can be three mux clock outputs: refclk*multi/div, bypass clock, or no
output.

Regards,

Tony
