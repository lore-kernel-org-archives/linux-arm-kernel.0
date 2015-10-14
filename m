From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 14 Oct 2015 16:17:43 +0200
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
Message-ID: <561E6407.6000002@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM

On my platform, Linux v4.2 running in non-secure mode panics in
l2c310_enable() with the pc pointing at this instruction:

c03390cc: ee013f30 mcr 15, 0, r3, cr1, cr0, {1}

which corresponds to set_auxcr IIUC.

static inline void set_auxcr(unsigned int val)
{
  asm volatile("mcr p15, 0, %0, c1, c0, 1  @ set AUXCR" : : "r" (val));
  isb();
}

which comes from this part in l2c310_enable:

	if (aux & L310_AUX_CTRL_FULL_LINE_ZERO) {
		set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
		cpu_notifier(l2c310_cpu_enable_flz, 0);
	}


The L2C-310 documentation states:
> When the L2C-310 AXI slave ports receive a write transaction with
> AWUSERSx[10], it indicates that the write actually targets a whole
> cache line and that all data of this cache line must be reset to
> zero. The Cortex-A9 processor is likely to use this feature when a
> CPU is executing a memset routine to initialise a particular memory
> area. When the L2C-310 receives such a write transaction it ignores
> the AXI attributes attached to the transaction, size, length, data,
> and strobes for example, because the whole cache line must be reset.
> This behavior is not compatible with the AXI protocol, it is disabled
> by default. You can enable it by setting the Full Line of Zero Enable
> bit of the Auxiliary Control Register, bit[0]. This behavior also
> relies on an enable bit in the Cortex-A9 processor. You must take
> care if you enable this feature because correct behavior relies on
> consistent enabling in both the Cortex-A9 processor and the L2C-310.


According to the Cortex A9 documentation,
ACTLR is RO in non-secure mode if NSACR[18]=0 and RW if NSACR[18]=1

I suppose writing to a RO register cause the exception I see?


Commit 8abd259f657d5 ("l2c: provide generic hook to intercept
writes to secure registers") introduced a mechanism for non-secure
platforms to define how to write to the L2CC AUXCTRL register.

>    When Linux is running in the non-secure world, any write to a secure
>    L2C register will generate an abort.  Platforms normally have to call
>    firmware to work around this.  Provide a hook for them to intercept
>    any L2C secure register write.

Is there a similar mechanism for asking the firmware to write
to the CP15 ACTRL?

I suppose a work-around might be to set NSACR[18]?

Regards.
