From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 4 Mar 2013 17:28:50 +0100
Subject: [PATCH 05/32] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <201302122236.37491.arnd@arndb.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302121800.48723.arnd@arndb.de> <20130212195816.6e34b3ce@skate>
 <201302122236.37491.arnd@arndb.de>
Message-ID: <20130304172850.5e18fbfb@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 12 Feb 2013 22:36:37 +0000, Arnd Bergmann wrote:

> > I have the feeling that the problem is more complex than that. My
> > understanding is that the pcim_iomap_regions() function used by
> > drivers/ata/libata-sff.c can perfectly be used to map memory BARs, and
> > not necessarily I/O BARs. Therefore, this driver can perfectly be used
> > in an architecture where CONFIG_NO_IOPORT is selected.
> 
> That is correct.
> 
> > The thing is that pcim_iomap_regions() transparently allows to remap an
> > I/O BAR is such a BAR is passed as argument, or a memory BAR if such a
> > BAR is passed as argument.
> > 
> > Therefore, I continue to believe that the pcim_*() functions are useful
> > even if the platform doesn't have CONFIG_HAS_IOPORT.
> 
> Yes, the pcim_ functions are useful in principle, but it falls back
> to the __pci_ioport_map() for IORESOURCE_IO, and that needs to
> return an error if CONFIG_HAS_IOPORT is not set.
> I think it would be correct if you add this hunk:
> 
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index 0d83ea8..f9b6387 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -33,7 +33,7 @@ void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
>                 return NULL;
>         if (maxlen && len > maxlen)
>                 len = maxlen;
> -       if (flags & IORESOURCE_IO)
> +       if (IS_ENABLED(CONFIG_HAS_IOPORT) && (flags & IORESOURCE_IO))
>                 return __pci_ioport_map(dev, start, len);
>         if (flags & IORESOURCE_MEM) {
>                 if (flags & IORESOURCE_CACHEABLE)
> 
> in order to prevent a link error when CONFIG_HAS_IOPORT is unset.

FWIW, a patch that is doing what I was initially proposing has been
merged for 3.9, and it doesn't contain the
IS_ENABLED(CONFIG_HAS_IOPORT) test you were proposing (and which I
think was correct). See:

commit 9ed8a30f3471347c1b763bd062fa78ae80f18eae
Author: Jingoo Han <jg1.han@samsung.com>
Date:   Wed Feb 27 17:02:42 2013 -0800

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
