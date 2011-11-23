From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Nov 2011 22:51:24 +0000
Subject: BUG: sleeping function called from invalid context
In-Reply-To: <20111123183640.GQ19986@pengutronix.de>
References: <4ECCDAA2.4070502@prolan.hu>
 <CAOMZO5DSvLU0ACJPZ69tzY0PjMijibSzwCEwBhu=5=mg7ncF=g@mail.gmail.com>
 <20111123183640.GQ19986@pengutronix.de>
Message-ID: <20111123225124.GK9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 07:36:40PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Wed, Nov 23, 2011 at 10:44:50AM -0200, Fabio Estevam wrote:
> > Looks like the same error I faced before:
> > http://marc.info/?l=linux-arm-kernel&m=131914543319956&w=2
> which resulted in some concerns about locking correctness. On i.MX28 we
> usually use
> 
> 	http://thread.gmane.org/gmane.linux.ports.arm.kernel/100744/focus=100746
> 
> (though this patch wasn't accepted either. The right fix is to convert
> mxs to the upcoming clk framework, which didn't land into mainline yet.)

Irrespective of the clk framework.  If you convert to the clk_prepare()
methodology, then you fix this bug.  You can do this as a two-step thing.
First, convert _all_ your drivers to issue the correct clk_prepare() and
clk_unprepare() calls at the appropriate time.  Once that's all done,
convert your clk API implementation to doing the sleeping parts of your
existing clk_enable() in clk_prepare() and leave the non-sleeping parts
in clk_enable().  (Ditto for clk_disable() vs clk_unprepare().)

You'll need to do most of the driver work _before_ the clk framework
lands, because it becomes mandatory for your drivers to call clk_prepare()
with that.

Plus, on the implementation side, you'll already have done the work to
separate the two for the clk framework, which in theory should mean that
its easier to convert.

So really, there's no excuse not to fix this for the imx/mxwhatever SoCs
today - the clk framework is totally irrelevant as far as this goes.
