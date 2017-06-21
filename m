From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Jun 2017 11:00:08 +0100
Subject: [PATCH v3 2/4] arm64: kgdb: disable interrupts while a software
 step is enabled
In-Reply-To: <20170621024304.GI4820@linaro.org>
References: <20170523043058.5463-1-takahiro.akashi@linaro.org>
 <20170523043058.5463-3-takahiro.akashi@linaro.org>
 <20170605162919.GN21944@arm.com>
 <20170607053449.GE26483@linaro.org> <20170607165018.GD2669@arm.com>
 <20170620024333.GE4820@linaro.org> <20170620170659.GB28035@arm.com>
 <20170621024304.GI4820@linaro.org>
Message-ID: <20170621100008.GI3768@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 11:43:05AM +0900, AKASHI Takahiro wrote:
> On Tue, Jun 20, 2017 at 06:07:00PM +0100, Will Deacon wrote:
> > On Tue, Jun 20, 2017 at 11:43:34AM +0900, AKASHI Takahiro wrote:
> > > On Wed, Jun 07, 2017 at 05:50:18PM +0100, Will Deacon wrote:
> > > > On Wed, Jun 07, 2017 at 02:34:50PM +0900, AKASHI Takahiro wrote:
> >
> > > > Ok, but don't we need to re-enable interrupts, otherwise we can't safely
> > > > handle the fault (which might involve blocking)?
> > > 
> > > I thought a lot, but have got no other way to solve the issue, which
> > > totally makes stepi in vain.
> > > In theory, you might be right, but in practice, people don't always expect
> > > to step through the whole sequence of fault recovery with single stepping.
> > > Once we do 'c(ontinue),' interrupts are enabled again and the execution
> > > will follow as expected.
> > 
> > It's not the stepping guarantees I'm worried about. I'm more worried that
> > the fault handler panics because it's called with IRQs disabled,
> 
> I'm still wondering how it can cause panic.

Well you're calling the page fault path with interrupts disabled. It might
try to allocate page tables without passing GFP_ATOMIC, or it might block on
I/O or reschedule.

The answer might well be "you can't step put_user and friends", but perhaps
we should try to enforce that rather than go horribly wrong if you do it.

Will
