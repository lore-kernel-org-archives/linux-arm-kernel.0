From: linux.melwyn@gmail.com (melwyn lobo)
Date: Wed, 14 Apr 2010 12:16:56 +0530
Subject: DMA Engine API performance issues
In-Reply-To: <p2q121039231004132344pae57964atbd6587f6ed38c471@mail.gmail.com>
References: <x2i121039231004132342sa230bfd4k832950fce534113f@mail.gmail.com>
	<p2q121039231004132344pae57964atbd6587f6ed38c471@mail.gmail.com>
Message-ID: <o2h121039231004132346q558648d5k55ea6f733f4ba871@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject edited to allow posting on ARM kernel list

On Wed, Apr 14, 2010 at 12:14 PM, melwyn lobo <linux.melwyn@gmail.com> wrote:
> Forwarding the query also to arm kernel mailiing list.
>
> Regards,
> M.
>
>
> ---------- Forwarded message ----------
> From: melwyn lobo <linux.melwyn@gmail.com>
> Date: Wed, Apr 14, 2010 at 12:12 PM
> Subject: DMA Engine API performance issues
> To: dan.j.williams at intel.com, linux-arm-kernel at lists.arm.linux.org.uk,
> linux-kernel at vger.kernel.org
>
>
> Hello Dan,
> I have some doubts regarding DMA API usage on its clients for example
> MMC, ALSA, USB etc.
>
> I am going to take example of the ALSA framework. Audio data transfer
> is initiated in soc_pcm_trigger(). This is called in an atomic
> context,
> with spinlock held and irqs disabled. Here most drivers enable data
> transfer from the MSP peripheral to the audio codec via tx_submit
> implementation
> of the DMA engine driver. This enqueues the transaction in an active
> list which calls for using spinlocks with bottom half disabled.
> It is in this function when spin_unlock_bh() is called the kernel
> detects irq's disabled and generates a warning.
> So the workaround here for ALSA drivers would be to use tasklet or
> workqueues to defer calling this in an interruptible context, which
> would
> cause performance problems (the same function soc_pcm_trigger is
> called for stoppping the transfer) in cases where the stream has to be
> repeatedly
> stopped and started.
>
> So the core issue is use of spin_unlock_bh in an atomic context.
> Workaround for removing the warnings would be:
> 1. Use spin_lock with irqsave and corresponding unlock function which
> does not generate a warning in a similar situation.
> ?But this could be futile in one case where the tasklet is scheduled
> from ksoftirqd which could lead to corruption.
> ?Also this means the interrupts would be disabled (on the local cpu)
> till the function executed which is not something
> ?desirable.
> 2. Use local_irq_enable() before calling the DMA APIs and disable once
> done. This is a crude solution and understandably undesirable and
> dangerous.
>
> The DMA Engine framework assumes that the channel interrupt handling
> is done in a tasklet (dma_run_dependencies), which I believe is the
> reason for the issue.
>
> Regards,
> M.
>
