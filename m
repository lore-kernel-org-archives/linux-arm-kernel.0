From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 24 Aug 2013 01:22:40 +0200
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <52179F63.4060008@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
 <52172BAA.7020009@gmail.com>
 <bfd173dc-3be5-421c-b7f7-af181bfb7032@DB8EHSMHS026.ehs.local>
 <52179F63.4060008@gmail.com>
Message-ID: <20130823232240.GG30135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 07:44:03PM +0200, Sebastian Hesselbarth wrote:
> On 08/23/13 19:19, S?ren Brinkmann wrote:
> >On Fri, Aug 23, 2013 at 11:30:18AM +0200, Sebastian Hesselbarth wrote:
> >>On 08/23/13 02:59, S?ren Brinkmann wrote:
> >>>On Thu, Aug 22, 2013 at 05:26:47PM -0700, S?ren Brinkmann wrote:
> >>>>On Tue, Aug 20, 2013 at 04:04:31AM +0200, Sebastian Hesselbarth wrote:
> >>>>>With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> >>>>>remove it from corresponding drivers/clk code.
> >>>>
> >>>>I think that would break Zynq.
> >>>>If I see this correctly you call of_clk_init() from common code,
> >>>>_before_ the SOC specific time init function is called.
> >>>>The problem is, that we have code setting up a global pointer which is
> >>>>required by zynq_clk_setup() which is triggered when of_clk_init() is
> >>>>called.
> >[ ... ]
> >>thanks for looking into this. I also had a look at the files in
> >>question. Based on Steffen's proposal, I prepared a diff that should do
> >>the trick. It moves zynq_slcr_init() to early_init, instead of reusing
> >>another hook that has magic cow powers (it calls irqchip_init that zynq
> >>also wants sooner or later).
> >>
> >>Also, it removes zynq_clock_init() and let zynq_clk_setup() map the
> >>register itself by finding the node and use of_iomap(). I realized that
> >>clock registers are quite separated within slcr, so you can consider
> >>to have your own node for the clk-provider. As Steffen is proposing
> >>this but mentioned incompatible DT changes, I chose that intermediate
> >>step above.
> >>
> >>It would be great, if you test the diff and prepare a patch out of
> >>it, that I pick-up in the patch set. That way, we also have your
> >>Signed-off on it.
> >
> >I looked into this. Looks like init_early() happens to early. I suspect
> >slab is missing to make zynq_slcr_init() work. So, I moved it into
> >init_irq(). Is there any init_call() type which is called at the correct
> >time?
> 
> S?ren,
> 
> I mistakenly assumed init_early is after mm, so of course my proposal
> does not work as it should. I am fine with moving it to init_irq() until
> you find the best solution (or until we have the same "mess" with
> default init_irq hook).
> 
> >I looked briefly into syscon and regmap, and that does actually look
> >promising and to really fix this mess, I guess we have to wait a little
> >until Steffen finishes his work on it.
> 
> IIRC, both syscon and regmap will require you to have devices ready.
> I haven't followed all recent discussions about early device
> registration. Anyway, it will not help much in the current approach
> to get rid of custom .init_timer and maybe .init_irq later.
> 

Yes. The syscon driver can not be used that early. It only makes sense
for later stages. Therefore the slcr has to be mapped early to unlock
and than remapped later. But with the current drivers, it is not essential
to have the slcr as a seperate driver.

> >To facilitate Sebastian's series I came up with the patch below.
> >The problem I have is, I do not really want the clkc to map the
> >registers. They are in the SLCR and the SLCR driver is doing it, hence
> >we should work with what that driver provides - which ideally would be
> >based on regmap and syscon, but we're not there yet. Hence I somehow
> >need to pass the SLCR pointer to the clkc. To avoid accessing the global
> >pointer directly I kept the zynq_clock_init() routine which is called
> >from zynq_slcr_init().
> 
> For this patch set I'd be fine with the proposal below. For the short
> run, you could consider to hide register accesses to slcr by providing
> zynq_slcr_readl/writel instead of passing just the base address.
> 
> But again, that will require either custom .init_time or .init_irq
> to set up slcr before clocks.
> 
> >That is the best I could come up with quickly and w/o investing a lot of
> >time to figure out the regmap and syscon stuff, which seems to be handled
> >by Steffen already, anyway.
> >It is essentially a stripped down version of Sebastian's proposal.
> 
> If there are no general objections, I take that one for the real patch
> set.

I haven't tested this, but I hope S?ren did. For the time being, I am
okay with it.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
