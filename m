From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Nov 2018 16:07:59 +0000
Subject: [PATCH v2] arm64/module: use mod->klp_info section header
 information for livepatch modules
In-Reply-To: <20181030131910.zuqw523rq4pi7apb@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
 <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
 <20181029152834.GA16289@arm.com>
 <20181030131910.zuqw523rq4pi7apb@linux-8ccs>
Message-ID: <20181101160759.GB17659@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Jessica,

On Tue, Oct 30, 2018 at 02:19:10PM +0100, Jessica Yu wrote:
> +++ Will Deacon [29/10/18 15:28 +0000]:
> >On Fri, Oct 26, 2018 at 07:25:01PM +0200, Jessica Yu wrote:
> >>diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> >>index fef773c94e9d..ac9b97f9ae5e 100644
> >>--- a/arch/arm64/include/asm/module.h
> >>+++ b/arch/arm64/include/asm/module.h
> >>@@ -25,6 +25,7 @@ struct mod_plt_sec {
> >>	struct elf64_shdr	*plt;
> >>	int			plt_num_entries;
> >>	int			plt_max_entries;
> >>+	int			plt_shndx;
> >>};
> >
> >Does this mean we can drop the plt pointer from this struct altogether, and
> >simply offset into the section headers when applying the relocations?
> 
> Hmm, if everyone is OK with dropping the plt pointer from struct
> mod_plt_sec, then I think we can simplify this patch even further.
> 
> With the plt shndx saved, we can additionally pass a pointer to
> sechdrs to module_emit_plt_entry(), and with that just offset into the
> section headers as you suggest. Since livepatch *already* passes in
> the correct copy of the section headers (mod->klp_info->sechdrs) to
> apply_relocate_add(), we wouldn't even need to modify the arm64
> module_finalize() to change mod->arch.core.plt to point into
> mod->klp_info->sechdrs anymore and we can drop all the changes to the
> module loader too.
> 
> Something like the following maybe?

This looks pretty good, thanks! My only (minor) objection is that the
renaming of plt_sec -> plt_info throughout makes the patch a lot more
churny than it needs to be, for questionable gain.

Anyway, it looks functionally correct and I've tested loading/unloading
the "hello world" test module with both PLTs enabled and disabled.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
