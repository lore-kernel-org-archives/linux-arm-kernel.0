From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 6 Nov 2015 10:52:38 +0800
Subject: [arm:drm-etnaviv-devel 148/148]
 drivers/staging/etnaviv/etnaviv_dump.c:82:26: sparse: restricted __le32
 degrades to integer
Message-ID: <201511061035.0BkN4O5q%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git drm-etnaviv-devel
head:   bd1b8b0fa6076246d48362fbb7ec1107836bf1c7
commit: bd1b8b0fa6076246d48362fbb7ec1107836bf1c7 [148/148] staging: etnaviv: add devcoredump support
reproduce:
        # apt-get install sparse
        git checkout bd1b8b0fa6076246d48362fbb7ec1107836bf1c7
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/staging/etnaviv/etnaviv_dump.c:82:26: sparse: restricted __le32 degrades to integer
>> drivers/staging/etnaviv/etnaviv_dump.c:92:26: sparse: incorrect type in assignment (different base types)
   drivers/staging/etnaviv/etnaviv_dump.c:92:26:    expected restricted __le32 [usertype] reg
   drivers/staging/etnaviv/etnaviv_dump.c:92:26:    got unsigned short const [unsigned] [short] <noident>
>> drivers/staging/etnaviv/etnaviv_dump.c:93:28: sparse: incorrect type in assignment (different base types)
   drivers/staging/etnaviv/etnaviv_dump.c:93:28:    expected restricted __le32 [usertype] value
   drivers/staging/etnaviv/etnaviv_dump.c:93:28:    got unsigned int
>> drivers/staging/etnaviv/etnaviv_dump.c:199:43: sparse: incorrect type in assignment (different base types)
   drivers/staging/etnaviv/etnaviv_dump.c:199:43:    expected restricted __le32 <noident>
   drivers/staging/etnaviv/etnaviv_dump.c:199:43:    got long

vim +82 drivers/staging/etnaviv/etnaviv_dump.c

    76		hdr->magic = cpu_to_le32(ETDUMP_MAGIC);
    77		hdr->type = cpu_to_le32(type);
    78		hdr->file_offset = cpu_to_le32(iter->data - iter->start);
    79		hdr->file_size = cpu_to_le32(data_end - iter->data);
    80	
    81		iter->hdr++;
  > 82		iter->data += hdr->file_size;
    83	}
    84	
    85	static void etnaviv_core_dump_registers(struct core_dump_iterator *iter,
    86		struct etnaviv_gpu *gpu)
    87	{
    88		struct etnaviv_dump_registers *reg = iter->data;
    89		unsigned int i;
    90	
    91		for (i = 0; i < ARRAY_SIZE(etnaviv_dump_registers); i++, reg++) {
  > 92			reg->reg = etnaviv_dump_registers[i];
  > 93			reg->value = gpu_read(gpu, etnaviv_dump_registers[i]);
    94		}
    95	
    96		etnaviv_core_dump_header(iter, ETDUMP_BUF_REG, reg);
    97	}
    98	
    99	static void etnaviv_core_dump_mmu(struct core_dump_iterator *iter,
   100		struct etnaviv_gpu *gpu, size_t mmu_size)
   101	{
   102		etnaviv_iommu_dump(gpu->mmu, iter->data);
   103	
   104		etnaviv_core_dump_header(iter, ETDUMP_BUF_MMU, iter->data + mmu_size);
   105	}
   106	
   107	static void etnaviv_core_dump_mem(struct core_dump_iterator *iter, u32 type,
   108		void *ptr, size_t size, u64 iova)
   109	{
   110		memcpy(iter->data, ptr, size);
   111	
   112		iter->hdr->iova = cpu_to_le64(iova);
   113	
   114		etnaviv_core_dump_header(iter, type, iter->data + size);
   115	}
   116	
   117	void etnaviv_core_dump(struct etnaviv_gpu *gpu)
   118	{
   119		struct core_dump_iterator iter;
   120		struct etnaviv_gem_object *obj;
   121		struct etnaviv_cmdbuf *cmd;
   122		unsigned int n_obj, n_bomap_pages;
   123		size_t file_size, mmu_size;
   124		__le64 *bomap, *bomap_start;
   125	
   126		mmu_size = etnaviv_iommu_dump_size(gpu->mmu);
   127	
   128		/* We always dump registers, mmu, ring and end marker */
   129		n_obj = 4;
   130		n_bomap_pages = 0;
   131		file_size = ARRAY_SIZE(etnaviv_dump_registers) *
   132				sizeof(struct etnaviv_dump_registers) +
   133			    mmu_size + gpu->buffer->size;
   134	
   135		/* Add in the active command buffers */
   136		list_for_each_entry(cmd, &gpu->active_cmd_list, gpu_active_list) {
   137			file_size += cmd->size;
   138			n_obj++;
   139		}
   140	
   141		/* Add in the active buffer objects */
   142		list_for_each_entry(obj, &gpu->active_list, mm_list) {
   143			file_size += obj->base.size;
   144			n_bomap_pages += obj->base.size >> PAGE_SHIFT;
   145			n_obj++;
   146		}
   147	
   148		/* If we have any buffer objects, add a bomap object */
   149		if (n_bomap_pages) {
   150			file_size += n_bomap_pages * sizeof(__le64);
   151			n_obj++;
   152		}
   153	
   154		/* Add the size of the headers */
   155		file_size += sizeof(*iter.hdr) * n_obj;
   156	
   157		/* Allocate the file in vmalloc memory, it's likely to be big */
   158		iter.start = vmalloc(file_size);
   159		if (!iter.start) {
   160			dev_warn(gpu->dev, "failed to allocate devcoredump file\n");
   161			return;
   162		}
   163	
   164		/* Point the data member after the headers */
   165		iter.hdr = iter.start;
   166		iter.data = &iter.hdr[n_obj];
   167	
   168		memset(iter.hdr, 0, iter.data - iter.start);
   169	
   170		etnaviv_core_dump_registers(&iter, gpu);
   171		etnaviv_core_dump_mmu(&iter, gpu, mmu_size);
   172		etnaviv_core_dump_mem(&iter, ETDUMP_BUF_RING, gpu->buffer->vaddr,
   173				      gpu->buffer->size, gpu->buffer->paddr);
   174	
   175		list_for_each_entry(cmd, &gpu->active_cmd_list, gpu_active_list)
   176			etnaviv_core_dump_mem(&iter, ETDUMP_BUF_CMD, cmd->vaddr,
   177					      cmd->size, cmd->paddr);
   178	
   179		/* Reserve space for the bomap */
   180		if (n_bomap_pages) {
   181			bomap_start = bomap = iter.data;
   182			memset(bomap, 0, sizeof(*bomap) * n_bomap_pages);
   183			etnaviv_core_dump_header(&iter, ETDUMP_BUF_BOMAP,
   184						 bomap + n_bomap_pages);
   185		} else {
   186			/* Silence warning */
   187			bomap_start = bomap = NULL;
   188		}
   189	
   190		list_for_each_entry(obj, &gpu->active_list, mm_list) {
   191			struct etnaviv_vram_mapping *vram;
   192			struct page **pages;
   193			void *vaddr;
   194	
   195			pages = etnaviv_gem_get_pages(obj);
   196			if (pages) {
   197				int j;
   198	
 > 199				iter.hdr->data[0] = bomap - bomap_start;
   200	
   201				for (j = 0; j < obj->base.size >> PAGE_SHIFT; j++)
   202					*bomap++ = cpu_to_le64(page_to_phys(*pages++));

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
