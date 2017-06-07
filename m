From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jun 2017 17:50:18 +0100
Subject: [PATCH v3 2/4] arm64: kgdb: disable interrupts while a software
 step is enabled
In-Reply-To: <20170607053449.GE26483@linaro.org>
References: <20170523043058.5463-1-takahiro.akashi@linaro.org>
 <20170523043058.5463-3-takahiro.akashi@linaro.org>
 <20170605162919.GN21944@arm.com>
 <20170607053449.GE26483@linaro.org>
Message-ID: <20170607165018.GD2669@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 02:34:50PM +0900, AKASHI Takahiro wrote:
> On Mon, Jun 05, 2017 at 05:29:19PM +0100, Will Deacon wrote:
> > On Tue, May 23, 2017 at 01:30:56PM +0900, AKASHI Takahiro wrote:
> > > After entering kgdb mode, 'stepi' may unexpectedly breaks the execution
> > > somewhere in el1_irq.
> > > 
> > > This happens because a debug exception is always enabled in el1_irq
> > > due to the following commit merged in v3.16:
> > >   commit 2a2830703a23 ("arm64: debug: avoid accessing mdscr_el1 on fault
> > > 			paths where possible")
> > > A pending interrupt can be taken after kgdb has enabled a software step,
> > > but before a debug exception is actually taken.
> > > 
> > > This patch enforces interrupts to be masked while single stepping.
> > 
> > The desired behaviour here boils down to whether or not KGDB expects to step
> > into or over interrupts in response a stepi instruction. What do other
> > architectures do?
> 
> I don't know x86 case, but if we step into interrupt code here,
> doing stepi on a normal function will be almost useless as every
> attempt of stepi will end up falling into irq code (mostly for timer
> interrupt).
> 
> > What happens if the instruction being stepped faults?
> 
> Well, as a matter of fact, we get a gdb control somewhere in exception code
> (actually just after 'enable_dbg' in el1_sync).

Ok, but don't we need to re-enable interrupts, otherwise we can't safely
handle the fault (which might involve blocking)?

Will
