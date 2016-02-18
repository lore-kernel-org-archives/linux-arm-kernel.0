From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Feb 2016 14:37:09 +0000
Subject: [PATCH 2/9] ARM: change NR_IPIS to 8
In-Reply-To: <1455804123-2526139-3-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-3-git-send-email-arnd@arndb.de>
Message-ID: <20160218143709.GQ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 03:01:54PM +0100, Arnd Bergmann wrote:
> When function tracing for IPIs is enabled, we get a warning for an
> overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
> as triggered by raise_nmi():
> 
> arch/arm/kernel/smp.c: In function 'raise_nmi':
> arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
>   trace_ipi_raise(target, ipi_types[ipinr]);

We really don't want to treat the backtrace IPI as a normal IPI at all -
we want it to invoke the least amount of code possible.  Hence this code
which avoids the issue:

        if ((unsigned)ipinr < NR_IPI) {
                trace_ipi_entry_rcuidle(ipi_types[ipinr]);
                __inc_irq_stat(cpu, ipi_irqs[ipinr]);
        }

However, what's missing is that the addition of tracing here missed
that CPU_BACKTRACE is not to be traced.  The call in raise_nmi()
should have been converted to __smp_cross_call() to avoid the
tracing code.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
