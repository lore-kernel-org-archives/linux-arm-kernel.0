From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 26 Aug 2013 08:16:29 -0700
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <521B4FCF.5000904@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
 <20130823073250.GB30135@pengutronix.de>
 <521B38BF.6040400@monstr.eu>
 <20130826120716.GB24795@pengutronix.de>
 <521B4FCF.5000904@gmail.com>
Message-ID: <c46b466a-1f8a-4b22-9dad-9d2419100b06@TX2EHSMHS043.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 02:53:35PM +0200, Sebastian Hesselbarth wrote:
> On 08/26/13 14:07, Steffen Trumtrar wrote:
> >On Mon, Aug 26, 2013 at 01:15:11PM +0200, Michal Simek wrote:
> >>I agree with Soren - let's fix the current problem and then when Steffen has patches with syscon
> >>we can look at them.
> >>
> >>If there is any discussion about early syscon registration please let me know.
> >>
> >
> >Where I'm stuck at the moment is: if I map the whole register space to the
> >parent node, how do I get its mapped address in the clkc?
> 
> Steffen,
> 
> if slcr is such an essential part of the SoC, you can choose to provide
> zynq_slcr_readl/writel callbacks. You can then use those callback in the
> clock driver without knowing the base address. Also, it allows you to
> hide slcr specific locking details from subsequent drivers using the
> callbacks.

I don't think that'll work. The clkc just wraps the cock primitives and
does not provide a lot of own clock drivers - actually only one. Those
clock primitives receive an iomapped address for the clock control which
is then accessed using readl/writel(). So, wrapping all SLCR accesses in
special accessors would mean to have almost identical reimplementations
of all used clock primitives, just to replace readl/writel with
zynq_slcr_write/read. Or is there some way to make this actually work?


S?ren
