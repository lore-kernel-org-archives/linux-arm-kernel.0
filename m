From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 26 Nov 2018 20:57:27 +0100
Subject: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
In-Reply-To: <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-3-kys@linuxonhyperv.com>
 <20181126192101.GC32208@kroah.com>
 <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
Message-ID: <20181126195727.GA9957@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 07:47:41PM +0000, Michael Kelley wrote:
> From: Greg KH <gregkh@linuxfoundation.org>  Monday, November 26, 2018 11:21 AM
> 
> > > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > > index 0d6271cce198..8d97bd3a13a6 100644
> > > --- a/arch/x86/include/asm/mshyperv.h
> > > +++ b/arch/x86/include/asm/mshyperv.h
> > > @@ -109,6 +109,10 @@ void hyperv_vector_handler(struct pt_regs *regs);
> > >  void hv_setup_vmbus_irq(void (*handler)(void));
> > >  void hv_remove_vmbus_irq(void);
> > >
> > > +/* On x86/x64, there isn't a real IRQ to be enabled/disable */
> > > +static inline void hv_enable_vmbus_irq(void) {}
> > > +static inline void hv_disable_vmbus_irq(void) {}
> > > +
> > >  void hv_setup_kexec_handler(void (*handler)(void));
> > >  void hv_remove_kexec_handler(void);
> > >  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
> > > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > > index 166c2501de17..d0bb09a4bd73 100644
> > > --- a/drivers/hv/hv.c
> > > +++ b/drivers/hv/hv.c
> > > @@ -307,6 +307,7 @@ int hv_synic_init(unsigned int cpu)
> > >  	hv_set_siefp(siefp.as_uint64);
> > >
> > >  	/* Setup the shared SINT. */
> > > +	hv_enable_vmbus_irq();
> > >  	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> > >
> > >  	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
> > > @@ -434,6 +435,7 @@ int hv_synic_cleanup(unsigned int cpu)
> > >  	/* Disable the global synic bit */
> > >  	sctrl.enable = 0;
> > >  	hv_set_synic_state(sctrl.as_uint64);
> > > +	hv_disable_vmbus_irq();
> > >
> > >  	return 0;
> > >  }
> > > --
> > > 2.19.1
> > 
> > You created "null" hooks that do nothing, for no one in this patch
> > series, why?
> > 
> 
> hv_enable_vmbus_irq() and hv_disable_vmbus_irq() have non-null
> implementations in the ARM64 code in patch 2 of this series.  The
> implementations are in the new file arch/arm64/hyperv/mshyperv.c.
> Or am I misunderstanding your point?

So you use a hook in an earlier patch and then add it in a later one?

Shouldn't you do it the other way around?  As it is, the earlier patch
should not work properly, right?

thanks,

greg k-h
