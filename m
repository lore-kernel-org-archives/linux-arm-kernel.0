From: linuxzsc@gmail.com (Richard Zhao)
Date: Sun, 3 Mar 2013 21:27:52 +0800
Subject: [PATCH 2/5] clk: notifier handler for dynamic voltage scaling
In-Reply-To: <20130303105424.6210.1196@quantum>
References: <1362026969-11457-1-git-send-email-mturquette@linaro.org>
 <1362026969-11457-3-git-send-email-mturquette@linaro.org>
 <1362130891.19498.12.camel@bilhuang-vm1>
 <20130301182234.6210.63879@quantum>
 <20130301204832.6210.40653@quantum>
 <1362192954.2407.26.camel@bilhuang-vm1>
 <20130302082216.GA4581@richard-laptop>
 <20130303105424.6210.1196@quantum>
Message-ID: <20130303132749.GA5887@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Sun, Mar 03, 2013 at 02:54:24AM -0800, Mike Turquette wrote:
> Quoting Richard Zhao (2013-03-02 00:22:19)
> > On Fri, Mar 01, 2013 at 06:55:54PM -0800, Bill Huang wrote:
> > > On Sat, 2013-03-02 at 04:48 +0800, Mike Turquette wrote:
> > > > Quoting Mike Turquette (2013-03-01 10:22:34)
> > > > > Quoting Bill Huang (2013-03-01 01:41:31)
> > > > > > On Thu, 2013-02-28 at 12:49 +0800, Mike Turquette wrote:
> > > > > > > Dynamic voltage and frequency scaling (dvfs) is a common power saving
> > > > > > > technique in many of today's modern processors.  This patch introduces a
> > > > > > > common clk rate-change notifier handler which scales voltage
> > > > > > > appropriately whenever clk_set_rate is called on an affected clock.
> > > > > > 
> > > > > > I really think clk_enable and clk_disable should also be triggering
> > > > > > notifier call and DVFS should act accordingly since there are cases
> > > > > > drivers won't set clock rate but instead disable its clock directly, do
> > > > > > you agree?
> > > > > > > 
> > > > > 
> > > > > Hi Bill,
> > > > > 
> > > > > I'll think about this.  Perhaps a better solution would be to adapt
> > > > > these drivers to runtime PM.  Then a call to runtime_pm_put() would
> > > > > result in a call to clk_disable(...) and regulator_set_voltage(...).
> > > > > 
> > > > > There is no performance-based equivalent to runtime PM, which is one
> > > > > reason why clk_set_rate is a likely entry point into dvfs.  But for
> > > > > operations that have nice api's like runtime PM it would be better to
> > > > > use those interfaces and not overload the clk.h api unnecessarily.
> > > > > 
> > > > 
> > > > Bill,
> > > > 
> > > > I wasn't thinking at all when I wrote this.  Trying to rush to the
> > > > airport I guess...
> > > > 
> > > > clk_enable() and clk_disable() must not sleep and all operations are
> > > > done under a spinlock.  So this rules out most use of notifiers.  It is
> > > > expected for some drivers to very aggressively enable/disable clocks in
> > > > interrupt handlers so scaling voltage as a function of clk_{en|dis}able
> > > > calls is also likely out of the question.
> > > 
> > > Yeah for those existing drivers to call enable/disable clocks in
> > > interrupt have ruled out this, I didn't think through when I was asking.
> > > > 
> > > > Some platforms have chosen to implement voltage scaling in their
> > > > .prepare callbacks.  I personally do not like this and still prefer
> > > > drivers be adapted to runtime pm and let those callbacks handle voltage
> > > > scaling along with clock handling.
> > Voltage scaling in clock notifiers seems similar. Clock and regulater
> > embedded code into each other will cause things complicated.
> 
> Hi Richard,
> 
> Sorry, I do not follow the above statement.  Can you clarify what you
> mean?
As we have agreement that a operating point may have multiple clocks
and regulators, this patch is impossible to support multi clocks. And
it might mislead dvfs implementer to use clock notifier. It may be good
to have unified api like dvfs_set_opp(opp), or drivers can handle clocks
and regulators theirselves which is more flexible. What do you think?

Thanks
Richard
