From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 15 Mar 2013 11:39:51 +0200
Subject: [RFC 1/1] clk: Add notifier support in
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <5142B027.4040403@wwwdotorg.org>
References: <1363151317.3311.9.camel@bilhuang-vm1>
 <51400D9D.9060305@wwwdotorg.org>
 <1363153204.3311.14.camel@bilhuang-vm1>
 <5140C12A.4060900@wwwdotorg.org>
 <1363227311.3311.30.camel@bilhuang-vm1>
 <20130314092132.GE18519@tbergstrom-lnx.Nvidia.com>
 <1363253287.3311.32.camel@bilhuang-vm1>
 <51420EBB.7080503@wwwdotorg.org>
 <1363310454.3311.44.camel@bilhuang-vm1>
 <5142B027.4040403@wwwdotorg.org>
Message-ID: <20130315093951.GV18519@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 06:22:47AM +0100, Stephen Warren wrote:
> On 03/14/2013 07:20 PM, Bill Huang wrote:
> > On Fri, 2013-03-15 at 01:54 +0800, Stephen Warren wrote:
> >> On 03/14/2013 03:28 AM, Bill Huang wrote:
> >>> On Thu, 2013-03-14 at 17:21 +0800, Peter De Schrijver wrote:
> >>>> On Thu, Mar 14, 2013 at 03:15:11AM +0100, Bill Huang wrote:
> >>>>
> >>>>> I don't think deferring will work either, considering the usage of DVFS,
> >>>>> device voltage is tightly coupled with frequency, when clock rate is
> >>>>> about to increase, we have to boost voltage first and we can lower the
> >>>>> voltage after the clock rate has decreased. All the above sequence have
> >>>>> to be guaranteed or you might crash, so deferring not only make thing
> >>>>> complicated in controlling the order but also hurt performance.
> >>>>
> >>>> But we could use notifiers in clk_prepare/clk_unprepare to set the voltage no?
> >>>> As clk_prepare/clk_unprepare have to be called before clk_enable or after
> >>>> clk_disable, the voltage can be raised to a safe level, before the clock
> >>>> becomes active.
> >>>
> >>> Thanks Peter, actually I'm just about to propose my v2 RFC which add
> >>> notifier in clk_prepare/clk_unprepare.
> >>
> >> Can't clk_set_rate() be called while the clock is prepared, or even
> >> enabled? I don't see how your proposal would work.
> >
> > I think it works with just a little sacrifice on saving more power but
> > that's related minor. Taking clk_prepare as an indicator on that clock
> > will be enabled later, so we can raise the voltage to a safe level
> > (according to the current rate or maybe default rate when clk_prepare is
> > called, some time late when clk_set_rate() is called we can adjust again
> > according to the requested rate change)
> 
> Is clk_set_rate() only legal to call in non-atomic contexts then? The
> header file doesn't say, although I guess since many other functions
> explicitly say they can't, then by omission it can...

Yes. Only clk_enable() and clk_disable() can be called in an atomic context.

Cheers,

Peter.
