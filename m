From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 Dec 2015 18:32:57 +0800
Subject: [PATCH v6 4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1449568153-15643-5-git-send-email-yong.wu@mediatek.com>
Message-ID: <201512081824.Uccd3ovL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

[auto build test ERROR on tegra/for-next]
[also build test ERROR on v4.4-rc4 next-20151208]

url:    https://github.com/0day-ci/linux/commits/Yong-Wu/MT8173-IOMMU-SUPPORT/20151208-175252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux for-next
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/iommu/dma-iommu.c: In function '__iommu_dma_alloc_pages':
>> drivers/iommu/dma-iommu.c:198:11: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
      pages = vzalloc(array_size);
              ^
>> drivers/iommu/dma-iommu.c:198:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      pages = vzalloc(array_size);
            ^
   cc1: some warnings being treated as errors
--
>> drivers/iommu/mtk_iommu.c:176:19: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
     .tlb_add_flush = mtk_iommu_tlb_add_flush_nosync,
                      ^
   drivers/iommu/mtk_iommu.c:176:19: note: (near initialization for 'mtk_iommu_gather_ops.tlb_add_flush')
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_domain_finalise':
>> drivers/iommu/mtk_iommu.c:239:4: error: 'IO_PGTABLE_QUIRK_NO_PERMS' undeclared (first use in this function)
       IO_PGTABLE_QUIRK_NO_PERMS |
       ^
   drivers/iommu/mtk_iommu.c:239:4: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/iommu/mtk_iommu.c:240:4: error: 'IO_PGTABLE_QUIRK_TLBI_ON_MAP' undeclared (first use in this function)
       IO_PGTABLE_QUIRK_TLBI_ON_MAP,
       ^
>> drivers/iommu/mtk_iommu.c:248:34: error: 'ARM_V7S' undeclared (first use in this function)
     dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
                                     ^
   In file included from arch/x86/include/asm/realmode.h:5:0,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:12,
                    from arch/x86/include/asm/smp.h:12,
                    from arch/x86/include/asm/mmzone_64.h:10,
                    from arch/x86/include/asm/mmzone.h:4,
                    from include/linux/mmzone.h:856,
                    from include/linux/topology.h:32,
                    from include/linux/of.h:24,
                    from include/linux/iommu.h:24,
                    from include/linux/dma-iommu.h:23,
                    from drivers/iommu/mtk_iommu.c:16:
>> drivers/iommu/mtk_iommu.c:257:35: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                                      ^
   arch/x86/include/asm/io.h:81:39: note: in definition of macro 'writel_relaxed'
    #define writel_relaxed(v, a) __writel(v, a)
                                          ^
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_resume':
   drivers/iommu/mtk_iommu.c:702:35: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                                      ^
   arch/x86/include/asm/io.h:81:39: note: in definition of macro 'writel_relaxed'
    #define writel_relaxed(v, a) __writel(v, a)
                                          ^

vim +/IO_PGTABLE_QUIRK_NO_PERMS +239 drivers/iommu/mtk_iommu.c

   170		/* Clear the CPE status */
   171		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
   172	}
   173	
   174	static const struct iommu_gather_ops mtk_iommu_gather_ops = {
   175		.tlb_flush_all = mtk_iommu_tlb_flush_all,
 > 176		.tlb_add_flush = mtk_iommu_tlb_add_flush_nosync,
   177		.tlb_sync = mtk_iommu_tlb_sync,
   178	};
   179	
   180	static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
   181	{
   182		struct mtk_iommu_data *data = dev_id;
   183		struct mtk_iommu_domain *dom = data->m4u_dom;
   184		u32 int_state, regval, fault_iova, fault_pa;
   185		unsigned int fault_larb, fault_port;
   186		bool layer, write;
   187	
   188		/* Read error info from registers */
   189		int_state = readl_relaxed(data->base + REG_MMU_FAULT_ST1);
   190		fault_iova = readl_relaxed(data->base + REG_MMU_FAULT_VA);
   191		layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
   192		write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
   193		fault_iova &= F_MMU_FAULT_VA_MSK;
   194		fault_pa = readl_relaxed(data->base + REG_MMU_INVLD_PA);
   195		regval = readl_relaxed(data->base + REG_MMU_INT_ID);
   196		fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
   197		fault_port = F_MMU0_INT_ID_PORT_ID(regval);
   198	
   199		if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
   200				       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
   201			dev_err_ratelimited(
   202				data->dev,
   203				"fault type=0x%x iova=0x%x pa=0x%x larb=%d port=%d layer=%d %s\n",
   204				int_state, fault_iova, fault_pa, fault_larb, fault_port,
   205				layer, write ? "write" : "read");
   206		}
   207	
   208		/* Interrupt clear */
   209		regval = readl_relaxed(data->base + REG_MMU_INT_CONTROL0);
   210		regval |= F_INT_CLR_BIT;
   211		writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
   212	
   213		mtk_iommu_tlb_flush_all(data);
   214	
   215		return IRQ_HANDLED;
   216	}
   217	
   218	static void mtk_iommu_config(struct mtk_iommu_data *data,
   219				     struct device *dev, bool enable)
   220	{
   221		struct mtk_iommu_client_priv *head, *cur, *next;
   222	
   223		head = dev->archdata.iommu;
   224		list_for_each_entry_safe(cur, next, &head->client, client) {
   225			mtk_smi_config_port(
   226				data->larbdev[MTK_M4U_TO_LARB(cur->mtk_m4u_id)],
   227				MTK_M4U_TO_PORT(cur->mtk_m4u_id), enable);
   228		}
   229	}
   230	
   231	static int mtk_iommu_domain_finalise(struct mtk_iommu_data *data)
   232	{
   233		struct mtk_iommu_domain *dom = data->m4u_dom;
   234	
   235		spin_lock_init(&dom->pgtlock);
   236	
   237		dom->cfg = (struct io_pgtable_cfg) {
   238			.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 > 239				IO_PGTABLE_QUIRK_NO_PERMS |
 > 240				IO_PGTABLE_QUIRK_TLBI_ON_MAP,
   241			.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
   242			.ias = 32,
   243			.oas = 32,
   244			.tlb = &mtk_iommu_gather_ops,
   245			.iommu_dev = data->dev,
   246		};
   247	
 > 248		dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
   249		if (!dom->iop) {
   250			dev_err(data->dev, "Failed to alloc io pgtable\n");
   251			return -EINVAL;
   252		}
   253	
   254		/* Update our support page sizes bitmap */
   255		mtk_iommu_ops.pgsize_bitmap = dom->cfg.pgsize_bitmap;
   256	
 > 257		writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
   258			       data->base + REG_MMU_PT_BASE_ADDR);
   259		return 0;
   260	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51073 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/f5640be5/attachment-0001.obj>
