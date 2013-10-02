From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Oct 2013 22:01:33 +0100
Subject: [RFC PATCH] ARM: Flush L2 cache on soft_restart
In-Reply-To: <20131002124902.GB29213@mudshark.cambridge.arm.com>
References: <1380713656-24752-1-git-send-email-taras.kondratiuk@linaro.org>
 <20131002124902.GB29213@mudshark.cambridge.arm.com>
Message-ID: <20131002210133.GY12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 01:49:03PM +0100, Will Deacon wrote:
> On Wed, Oct 02, 2013 at 12:34:16PM +0100, Taras Kondratiuk wrote:
> > Kexec disables L2 cache before jumping to reboot code,
> > but it doesn't flush it. So often just copied reboot code
> > gets corrupted, because part of it is stored in L2 cache
> > and have not reached memory.
> > 
> > Flushing cache prevents this corruption.
> > 
> > I'm facing this issue on Pandaboard ES, but it looks like
> > similar issue is observed on TC2 board [1].
> 
> TC2 doesn't have an outer cache, so that report is not relevant to this
> patch.
> 
> > [1] http://www.spinics.net/lists/arm-kernel/msg264339.html
> > 
> > Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> > ---
> >  arch/arm/kernel/process.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index 94f6b05..e359b62 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -103,9 +103,11 @@ void soft_restart(unsigned long addr)
> >  	local_irq_disable();
> >  	local_fiq_disable();
> >  
> > -	/* Disable the L2 if we're the last man standing. */
> > -	if (num_online_cpus() == 1)
> > +	/* Flush and disable the L2 if we're the last man standing. */
> > +	if (num_online_cpus() == 1) {
> > +		outer_flush_all();
> >  		outer_disable();
> 
> l2x0_disable already contains a flush, so this doesn't change anything.

The disable call _has_ to contain the flush as that's the only way it
can be disabled to avoid any loss of data when the outer cache stops
being searched for cache hits.
