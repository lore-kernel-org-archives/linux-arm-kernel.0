From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Mar 2015 17:19:03 +0100
Subject: [PATCH 4/4] arm64: align PHYS_OFFSET to block size
In-Reply-To: <20150331144931.GF9119@e104818-lin.cambridge.arm.com>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-5-git-send-email-ard.biesheuvel@linaro.org>
 <20150325145949.GE26903@localhost>
 <CAKv+Gu8LQGNVDw36B+Lv4xMQkcGN=M=uHxey-94cqrmE=AZDvg@mail.gmail.com>
 <CAKv+Gu_3PG7ffwn+TK7PdUPeovVoamb4XX1PSfor-3sNKW-0AQ@mail.gmail.com>
 <20150330123011.GB5964@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84YezZSQmyf4cV34TxMKRPytcFyrrTGO3RFx=_17i-Mg@mail.gmail.com>
 <20150330150008.GD5964@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-C5c0Ma+KEWkPWbxhcgvGfZXyDp4OXxG_BMyR7Hwtk1A@mail.gmail.com>
 <20150331144931.GF9119@e104818-lin.cambridge.arm.com>
Message-ID: <20150331161902.GH9119@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 03:49:32PM +0100, Catalin Marinas wrote:
> On Mon, Mar 30, 2015 at 08:08:52PM +0200, Ard Biesheuvel wrote:
> > But using early_fixmap() implies using the ordinary page tables
> > manipulation code, which uses __pa/__va
> > So instead, I should refactor those patches to simply pick a VA offset
> > and map the FDT there from head.S
> 
> I haven't dug out those patches yet but in principle you should not care
> about __va, just __pa for populating the pmd/pud/pgd. Since with
> fixmap we pre-allocate the page tables in the kernel data section
> (bm_pud/pmd/pte), a __pa implementation that takes KERNEL_PAGE_OFFSET
> into account (as per these patches) is enough, you don't really care
> about the linear PAGE_OFFSET at this stage since you would not provide
> __pa with such virtual address until after setup_machine_fdt().

Actually, that's wrong, early_fixmap_init() uses pud/pmd_offset which in
turn use the pmd_offset etc. and pmd_page_vaddr. These would not be
mapped in the linear mapping at this stage. create_mapping() also uses
the *_offset() functions, so we have the same issue.

So I think we still need to calculate the default initial PHYS_OFFSET in
head.S as we currently do, based on the kernel load address so that
__va() returns a mapping in the initial KERNEL_PAGE_OFFSET range. During
our own early_init_dt_add_memory_arch(), we calculate the real
PHYS_OFFSET but don't set it yet. We should defer the setting of the
real PHYS_OFFSET until we map the first block of memory via
create_mapping(). We know that we can't cope with allocations before the
first block anyway, so this approach may work.

-- 
Catalin
