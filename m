From: bilhuang@nvidia.com (Bill Huang)
Date: Thu, 14 Mar 2013 18:20:54 -0700
Subject: [RFC 1/1] clk: Add notifier support in
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <51420EBB.7080503@wwwdotorg.org>
References: <1363091861-21534-1-git-send-email-bilhuang@nvidia.com>
 <20130312134032.GU4977@n2100.arm.linux.org.uk>
 <1363139273.21694.11.camel@bilhuang-vm1> <514003B6.8020904@wwwdotorg.org>
 <1363151317.3311.9.camel@bilhuang-vm1> <51400D9D.9060305@wwwdotorg.org>
 <1363153204.3311.14.camel@bilhuang-vm1> <5140C12A.4060900@wwwdotorg.org>
 <1363227311.3311.30.camel@bilhuang-vm1>
 <20130314092132.GE18519@tbergstrom-lnx.Nvidia.com>
 <1363253287.3311.32.camel@bilhuang-vm1> <51420EBB.7080503@wwwdotorg.org>
Message-ID: <1363310454.3311.44.camel@bilhuang-vm1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-15 at 01:54 +0800, Stephen Warren wrote:
> On 03/14/2013 03:28 AM, Bill Huang wrote:
> > On Thu, 2013-03-14 at 17:21 +0800, Peter De Schrijver wrote:
> >> On Thu, Mar 14, 2013 at 03:15:11AM +0100, Bill Huang wrote:
> >>
> >>> I don't think deferring will work either, considering the usage of DVFS,
> >>> device voltage is tightly coupled with frequency, when clock rate is
> >>> about to increase, we have to boost voltage first and we can lower the
> >>> voltage after the clock rate has decreased. All the above sequence have
> >>> to be guaranteed or you might crash, so deferring not only make thing
> >>> complicated in controlling the order but also hurt performance.
> >>
> >> But we could use notifiers in clk_prepare/clk_unprepare to set the voltage no?
> >> As clk_prepare/clk_unprepare have to be called before clk_enable or after
> >> clk_disable, the voltage can be raised to a safe level, before the clock
> >> becomes active.
> > 
> > Thanks Peter, actually I'm just about to propose my v2 RFC which add
> > notifier in clk_prepare/clk_unprepare.
> 
> Can't clk_set_rate() be called while the clock is prepared, or even
> enabled? I don't see how your proposal would work.
> 
I think it works with just a little sacrifice on saving more power but
that's related minor. Taking clk_prepare as an indicator on that clock
will be enabled later, so we can raise the voltage to a safe level
(according to the current rate or maybe default rate when clk_prepare is
called, some time late when clk_set_rate() is called we can adjust again
according to the requested rate change) but there should be case that
clock will not be enabled after clk_prepare (I'm not sure is normal
though), that the case power might be wasted. Similarly, taking
clk_unprepare as an indicator on clock has been disabled but there might
be case clock is disabled but do not call clk_unprepare any time soon,
this is another case power is wasted but this should not be normal case.
So the point is, we can get notified on runtime clock change events (no
matter it is clock enable/disable or clock rate change) and act (get
best balance on power saving and system stability) accordingly.
