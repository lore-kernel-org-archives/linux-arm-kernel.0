From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 26 Aug 2013 08:20:41 -0700
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <52179F63.4060008@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
 <52172BAA.7020009@gmail.com>
 <bfd173dc-3be5-421c-b7f7-af181bfb7032@DB8EHSMHS026.ehs.local>
 <52179F63.4060008@gmail.com>
Message-ID: <d010f3ec-51d6-4d79-a754-095b89b77ae6@VA3EHSMHS029.ehs.local>
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

Looking at these two hooks. If the SOC provides init_irq(), the common
code does nothing, but calling it. Ergo, the SOC is now responsible for
otherwise commonly called code like of_irq_init().

It's probably an idea to design the common init_time() function the same
way. That way SOCs that don't need any custom init at that stage get
everything for free. And SOCs like Zynq have to still call of_clk_init()
manually, but can ensure that dependencies like our SLCR init are
satisfied before calling it.

Just an idea, not sure if it makes sense since I didn't look beyond Zynq
too much on this.

	S?ren
