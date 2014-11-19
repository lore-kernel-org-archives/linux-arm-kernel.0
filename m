From: treding@nvidia.com (Thierry Reding)
Date: Wed, 19 Nov 2014 14:56:42 +0100
Subject: arm64 pci_iomap, was: Re: next build: 258 warnings 9 failures
 (next/next-20141119)
In-Reply-To: <16479190.7SIDaKWfdW@wuerfel>
References: <546c75d7.6336460a.14b5.474d@mx.google.com>
 <16479190.7SIDaKWfdW@wuerfel>
Message-ID: <20141119135641.GD26258@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 12:15:45PM +0100, Arnd Bergmann wrote:
> On Wednesday 19 November 2014 02:49:59 Olof's autobuilder wrote:
> > 
> >         arm64.allmodconfig:
> > drivers/net/ethernet/dec/tulip/winbond-840.c:910:2: warning: #warning Processor architecture undefined [-Wcpp]
> >  #warning Processor architecture undefined
> > drivers/net/ethernet/dec/tulip/tulip_core.c:101:2: warning: #warning Processor architecture undefined! [-Wcpp]
> >  #warning Processor architecture undefined!
> > :(.text+0x42344): undefined reference to `pci_iomap'
> > :(.text+0x42ca0): undefined reference to `pci_iomap'
> > :(.text+0x11c10): undefined reference to `pci_iomap'
> > 
> >         arm64.defconfig:
> > drivers/pci/quirks.c:2965: undefined reference to `pci_iomap'
> > drivers/pci/quirks.c:3328: undefined reference to `pci_iomap'
> > drivers/tty/serial/8250/8250_pci.c:1044: undefined reference to `pci_iomap'
> > drivers/tty/serial/8250/8250_pci.c:1012: undefined reference to `pci_iomap'
> > lib/devres.c:273: undefined reference to `pci_iomap'
> > 
> 
> Hi Thierry,
> 
> This is another regression from your asm-generic change in arm64. We
> are now lacking a working pci_iomap function after you removed the
> 'select GENERIC_IOMAP' statement.
> 
> For all I can tell, this is the correct solution (note GENERIC_PCI_IOMAP
> instead of GENERIC_IOMAP):
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 37cd23625708..bc8879c283b9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -25,6 +25,7 @@ config ARM64
>         select GENERIC_EARLY_IOREMAP
>         select GENERIC_IRQ_PROBE
>         select GENERIC_IRQ_SHOW
> +       select GENERIC_PCI_IOMAP
>         select GENERIC_SCHED_CLOCK
>         select GENERIC_SMP_IDLE_THREAD
>         select GENERIC_STRNCPY_FROM_USER
> 
> 
> Any comments?

Oops, I just looked at that file on my system and I already have the
select GENERIC_PCI_IOMAP exactly where you have it. Turns out I have
that same patch, albeit with a somewhat obfuscated name in my tree
but never got around to clean up the commit message or sending it out.

Do you want to apply that patch on top or shall I redo the pull request
with that patch folded in so we can keep bisectability across the
series?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/fa6d8060/attachment-0001.sig>
