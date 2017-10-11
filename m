From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Oct 2017 12:49:05 +0100
Subject: [PATCH v2 4/5] arm64: locking: Move rwlock implementation over
 to qrwlocks
In-Reply-To: <909c3e84-745c-20db-a071-f9e0f2cbe63a@redhat.com>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
 <1507296882-18721-5-git-send-email-will.deacon@arm.com>
 <909c3e84-745c-20db-a071-f9e0f2cbe63a@redhat.com>
Message-ID: <20171011114905.GA27426@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Waiman,

On Mon, Oct 09, 2017 at 09:34:08PM -0400, Waiman Long wrote:
> On 10/06/2017 09:34 AM, Will Deacon wrote:
> > Now that the qrwlock can make use of WFE, remove our homebrew rwlock
> > code in favour of the generic queued implementation.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/Kconfig                      |  17 ++++
> >  arch/arm64/include/asm/Kbuild           |   1 +
> >  arch/arm64/include/asm/spinlock.h       | 164 +-------------------------------
> >  arch/arm64/include/asm/spinlock_types.h |   6 +-
> >  4 files changed, 20 insertions(+), 168 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 0df64a6a56d4..6d32c9b0d4bb 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -22,7 +22,24 @@ config ARM64
> >  	select ARCH_HAS_STRICT_MODULE_RWX
> >  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> >  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if ACPI_APEI_SEA
> > +	select ARCH_INLINE_READ_LOCK if !PREEMPT
> > +	select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
> > +	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPT
> > +	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPT
> > +	select ARCH_INLINE_READ_UNLOCK if !PREEMPT
> > +	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPT
> > +	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPT
> > +	select ARCH_INLINE_READ_UNLOCK_IRQSAVE if !PREEMPT
> > +	select ARCH_INLINE_WRITE_LOCK if !PREEMPT
> > +	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPT
> > +	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPT
> > +	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPT
> > +	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPT
> > +	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPT
> > +	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPT
> > +	select ARCH_INLINE_WRITE_UNLOCK_IRQSAVE if !PREEMPT
> >  	select ARCH_USE_CMPXCHG_LOCKREF
> > +	select ARCH_USE_QUEUED_RWLOCKS
> >  	select ARCH_SUPPORTS_MEMORY_FAILURE
> >  	select ARCH_SUPPORTS_ATOMIC_RMW
> >  	select ARCH_SUPPORTS_NUMA_BALANCING
> 
> Inlining is good for performance, but it may come with an increase in
> kernel text size. Inlining unlock and unlock_irq are OK, but the other
> inlines will increase the text size of the kernel. Have you measured how
> much size increase will that be? Is there any concern about the
> increased text size?

Yes, I did look at the disassembly and bloat-o-meter results. Inlining
these functions means that the fastpath sits entirely within a 64-byte
cacheline and bloat-o-meter shows a relatively small increase in vmlinux
size for a defconfig build with CONFIG_PREEMPT disabled:

Total: Before=13800924, After=13812904, chg +0.09%

(I also just noticed my typos in ARCH_INLINE_{READ.WRITE}_UNLOCK_IRQSAVE
so I regenerated the numbers!)

Will
