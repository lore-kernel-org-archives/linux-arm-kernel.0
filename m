From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Jan 2018 17:41:12 +0000
Subject: [PATCH v7 05/10] PCI: Add support for relative addressing in
 quirk tables
In-Reply-To: <20180102200549.22984-6-ard.biesheuvel@linaro.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-6-ard.biesheuvel@linaro.org>
Message-ID: <20180105174112.jk3mvo5qwg7l4vzo@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 08:05:44PM +0000, Ard Biesheuvel wrote:
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 10684b17d0bd..b6d51b4d5ce1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3556,9 +3556,16 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>  		     f->vendor == (u16) PCI_ANY_ID) &&
>  		    (f->device == dev->device ||
>  		     f->device == (u16) PCI_ANY_ID)) {
> -			calltime = fixup_debug_start(dev, f->hook);
> -			f->hook(dev);
> -			fixup_debug_report(dev, calltime, f->hook);
> +			void (*hook)(struct pci_dev *dev);
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +			hook = (void *)((unsigned long)&f->hook_offset +
> +					f->hook_offset);
> +#else
> +			hook = f->hook;
> +#endif

More of a nitpick but I've seen this pattern in several places in your
code, maybe worth defining a macro (couldn't come up with a better
name):

#define offset_to_ptr(off) \
	((void *)((unsigned long)&(off) + (off)))

-- 
Catalin
