From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2009 15:58:34 +0000
Subject: [PATCH 5/6] ARMv7: Improved page table format with TRE and AFE
In-Reply-To: <1260805824.17159.101.camel@pc1117.cambridge.arm.com>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
	<20091207141404.30429.85379.stgit@pc1117.cambridge.arm.com>
	<20091212112829.GB27020@n2100.arm.linux.org.uk>
	<1260805824.17159.101.camel@pc1117.cambridge.arm.com>
Message-ID: <1260806314.17159.108.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-14 at 15:50 +0000, Catalin Marinas wrote:
> On Sat, 2009-12-12 at 11:28 +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 07, 2009 at 02:14:10PM +0000, Catalin Marinas wrote:
> > > This patch enables the Access Flag in SCTLR and, together with the TEX
> > > remapping, allows the use of the spare bits in the page table entry thus
> > > removing the Linux specific PTEs. The simplified permission model is
> > > used which means that "kernel read/write, user read-only" is no longer
> > > available. This was used for the vectors page but with a dedicated TLS
> > > register it is no longer necessary.
> > 
> > I really do not want to go here without an explaination of how situations
> > such as:
> 
> I think we discussed some of these when I first posted the patch some
> time ago but I'm happy do it again here.
> 
> BTW, all the hardware implementations I'm aware of only raise an access
> flag fault when this bit is cleared rather than doing it in hardware.
> 
> But even if they do it in hardware, it can still work (you also have the
> option of disabling the hardware management via the SCTLR.HA bit).
> 
> > - Kernel reads PTE and modifies it
> 
> B3.3.5 in the ARM ARM describes the requirements for the Hardware
> management of the access flag:
> 
>         Any implementation of hardware management of the access flag
>         must ensure that any software changes to the translation table
>         are not lost. The architecture does not require software that
>         performs translation table changes to use interlocked
>         operations. The hardware management mechanisms for the access
>         flag must prevent any loss of data written to translation table
>         entries that might occur when, for example, a write by another
>         processor occurs between the read and write phases of a
>         translation table walk that updates the
>         access flag.
> 
> At the hardware level, it could be implemented similar to a LDREX/STREX
> block.

Just avoid a question on this - it is possible for the kernel to read a
PTE with AP[0] cleared, the hardware could set AP[0] to 1 as a result of
an access then the kernel clears it again when storing the modified PTE.

The above cannot be prevented since the PTE modifications are not atomic
but it doesn't actually matter. In the worst case, the kernel would
think that a page wasn't accessed for a longer time and it may decide to
swap it out. I doubt this would be a performance hit since trapping the
access faults takes much more time.

If precise access timing is required (not sure why), you can always
disable SCTLR.HA and handle the accesses in software.

-- 
Catalin
