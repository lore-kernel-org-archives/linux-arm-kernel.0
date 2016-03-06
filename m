From: lkp@intel.com (kbuild test robot)
Date: Mon, 7 Mar 2016 04:55:28 +0800
Subject: [PATCH v4 net-next 7/9] net: mvneta: bm: add support for
 hardware buffer management
In-Reply-To: <1457217507-10778-8-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201603070403.Jh1SlLfR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

[auto build test ERROR on v4.5-rc6]
[also build test ERROR on next-20160304]
[cannot apply to net-next/master robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/API-set-for-HW-Buffer-management/20160306-064411
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/mvneta_bm.c:119:5: error: redefinition of 'mvneta_bm_pool_refill'
    int mvneta_bm_pool_refill(struct mvneta_bm *priv,
        ^
   In file included from drivers/net/ethernet/marvell/mvneta_bm.c:23:0:
   drivers/net/ethernet/marvell/mvneta_bm.h:175:5: note: previous definition of 'mvneta_bm_pool_refill' was here
    int mvneta_bm_pool_refill(struct mvneta_bm *priv,
        ^
>> drivers/net/ethernet/marvell/mvneta_bm.c:136:5: error: redefinition of 'mvneta_bm_bufs_add'
    int mvneta_bm_bufs_add(struct mvneta_bm *priv, struct mvneta_bm_pool *bm_pool,
        ^
   In file included from drivers/net/ethernet/marvell/mvneta_bm.c:23:0:
   drivers/net/ethernet/marvell/mvneta_bm.h:173:5: note: previous definition of 'mvneta_bm_bufs_add' was here
    int mvneta_bm_bufs_add(struct mvneta_bm *priv, struct mvneta_bm_pool *bm_pool,
        ^
>> drivers/net/ethernet/marvell/mvneta_bm.c:222:24: error: redefinition of 'mvneta_bm_pool_use'
    struct mvneta_bm_pool *mvneta_bm_pool_use(struct mvneta_bm *priv, u8 pool_id,
                           ^
   In file included from drivers/net/ethernet/marvell/mvneta_bm.c:23:0:
   drivers/net/ethernet/marvell/mvneta_bm.h:177:24: note: previous definition of 'mvneta_bm_pool_use' was here
    struct mvneta_bm_pool *mvneta_bm_pool_use(struct mvneta_bm *priv, u8 pool_id,
                           ^
>> drivers/net/ethernet/marvell/mvneta_bm.c:275:6: error: redefinition of 'mvneta_bm_bufs_free'
    void mvneta_bm_bufs_free(struct mvneta_bm *priv, struct mvneta_bm_pool *bm_pool,
         ^
   In file included from drivers/net/ethernet/marvell/mvneta_bm.c:23:0:
   drivers/net/ethernet/marvell/mvneta_bm.h:171:6: note: previous definition of 'mvneta_bm_bufs_free' was here
    void mvneta_bm_bufs_free(struct mvneta_bm *priv, struct mvneta_bm_pool *bm_pool,
         ^
>> drivers/net/ethernet/marvell/mvneta_bm.c:315:6: error: redefinition of 'mvneta_bm_pool_destroy'
    void mvneta_bm_pool_destroy(struct mvneta_bm *priv,
         ^
   In file included from drivers/net/ethernet/marvell/mvneta_bm.c:23:0:
   drivers/net/ethernet/marvell/mvneta_bm.h:169:6: note: previous definition of 'mvneta_bm_pool_destroy' was here
    void mvneta_bm_pool_destroy(struct mvneta_bm *priv,
         ^

vim +/mvneta_bm_pool_refill +119 drivers/net/ethernet/marvell/mvneta_bm.c

   113		*buf_phys_addr = phys_addr;
   114	
   115		return buf;
   116	}
   117	
   118	/* Refill processing for HW buffer management */
 > 119	int mvneta_bm_pool_refill(struct mvneta_bm *priv,
   120				  struct mvneta_bm_pool *bm_pool)
   121	{
   122		dma_addr_t buf_phys_addr;
   123		void *buf;
   124	
   125		buf = mvneta_buf_alloc(priv, bm_pool, &buf_phys_addr);
   126		if (!buf)
   127			return -ENOMEM;
   128	
   129		mvneta_bm_pool_put_bp(priv, bm_pool, buf_phys_addr);
   130	
   131		return 0;
   132	}
   133	EXPORT_SYMBOL_GPL(mvneta_bm_pool_refill);
   134	
   135	/* Allocate buffers for the pool */
 > 136	int mvneta_bm_bufs_add(struct mvneta_bm *priv, struct mvneta_bm_pool *bm_pool,
   137			       int buf_num)
   138	{
   139		int err, i;
   140	
   141		if (bm_pool->buf_num == bm_pool->size) {
   142			dev_dbg(&priv->pdev->dev, "pool %d already filled\n",
   143				bm_pool->id);
   144			return bm_pool->buf_num;
   145		}
   146	
   147		if (buf_num < 0 ||
   148		    (buf_num + bm_pool->buf_num > bm_pool->size)) {
   149			dev_err(&priv->pdev->dev,
   150				"cannot allocate %d buffers for pool %d\n",
   151				buf_num, bm_pool->id);
   152			return 0;
   153		}
   154	
   155		for (i = 0; i < buf_num; i++) {
   156			err = mvneta_bm_pool_refill(priv, bm_pool);
   157			if (err < 0)
   158				break;
   159		}
   160	
   161		/* Update BM driver with number of buffers added to pool */
   162		bm_pool->buf_num += i;
   163	
   164		dev_dbg(&priv->pdev->dev,
   165			"%s pool %d: pkt_size=%4d, buf_size=%4d, frag_size=%4d\n",
   166			bm_pool->type == MVNETA_BM_SHORT ? "short" : "long",
   167			bm_pool->id, bm_pool->pkt_size, bm_pool->buf_size,
   168			bm_pool->frag_size);
   169	
   170		dev_dbg(&priv->pdev->dev,
   171			"%s pool %d: %d of %d buffers added\n",
   172			bm_pool->type == MVNETA_BM_SHORT ? "short" : "long",
   173			bm_pool->id, i, buf_num);
   174	
   175		return i;
   176	}
   177	
   178	/* Create pool */
   179	static int mvneta_bm_pool_create(struct mvneta_bm *priv,
   180					 struct mvneta_bm_pool *bm_pool)
   181	{
   182		struct platform_device *pdev = priv->pdev;
   183		u8 target_id, attr;
   184		int size_bytes, err;
   185	
   186		size_bytes = sizeof(u32) * bm_pool->size;
   187		bm_pool->virt_addr = dma_alloc_coherent(&pdev->dev, size_bytes,
   188							&bm_pool->phys_addr,
   189							GFP_KERNEL);
   190		if (!bm_pool->virt_addr)
   191			return -ENOMEM;
   192	
   193		if (!IS_ALIGNED((u32)bm_pool->virt_addr, MVNETA_BM_POOL_PTR_ALIGN)) {
   194			dma_free_coherent(&pdev->dev, size_bytes, bm_pool->virt_addr,
   195					  bm_pool->phys_addr);
   196			dev_err(&pdev->dev, "BM pool %d is not %d bytes aligned\n",
   197				bm_pool->id, MVNETA_BM_POOL_PTR_ALIGN);
   198			return -ENOMEM;
   199		}
   200	
   201		err = mvebu_mbus_get_dram_win_info(bm_pool->phys_addr, &target_id,
   202						   &attr);
   203		if (err < 0) {
   204			dma_free_coherent(&pdev->dev, size_bytes, bm_pool->virt_addr,
   205					  bm_pool->phys_addr);
   206			return err;
   207		}
   208	
   209		/* Set pool address */
   210		mvneta_bm_write(priv, MVNETA_BM_POOL_BASE_REG(bm_pool->id),
   211				bm_pool->phys_addr);
   212	
   213		mvneta_bm_pool_target_set(priv, bm_pool->id, target_id,  attr);
   214		mvneta_bm_pool_enable(priv, bm_pool->id);
   215	
   216		return 0;
   217	}
   218	
   219	/* Notify the driver that BM pool is being used as specific type and return the
   220	 * pool pointer on success
   221	 */
 > 222	struct mvneta_bm_pool *mvneta_bm_pool_use(struct mvneta_bm *priv, u8 pool_id,
   223						  enum mvneta_bm_type type, u8 port_id,
   224						  int pkt_size)
   225	{
   226		struct mvneta_bm_pool *new_pool = &priv->bm_pools[pool_id];
   227		int num, err;
   228	
   229		if (new_pool->type == MVNETA_BM_LONG &&
   230		    new_pool->port_map != 1 << port_id) {
   231			dev_err(&priv->pdev->dev,
   232				"long pool cannot be shared by the ports\n");
   233			return NULL;
   234		}
   235	
   236		if (new_pool->type == MVNETA_BM_SHORT && new_pool->type != type) {
   237			dev_err(&priv->pdev->dev,
   238				"mixing pools' types between the ports is forbidden\n");
   239			return NULL;
   240		}
   241	
   242		if (new_pool->pkt_size == 0 || type != MVNETA_BM_SHORT)
   243			new_pool->pkt_size = pkt_size;
   244	
   245		/* Allocate buffers in case BM pool hasn't been used yet */
   246		if (new_pool->type == MVNETA_BM_FREE) {
   247			new_pool->type = type;
   248			new_pool->buf_size = MVNETA_RX_BUF_SIZE(new_pool->pkt_size);
   249			new_pool->frag_size =
   250				SKB_DATA_ALIGN(MVNETA_RX_BUF_SIZE(new_pool->pkt_size)) +
   251				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
   252	
   253			/* Create new pool */
   254			err = mvneta_bm_pool_create(priv, new_pool);
   255			if (err) {
   256				dev_err(&priv->pdev->dev, "fail to create pool %d\n",
   257					new_pool->id);
   258				return NULL;
   259			}
   260	
   261			/* Allocate buffers for this pool */
   262			num = mvneta_bm_bufs_add(priv, new_pool, new_pool->size);
   263			if (num != new_pool->size) {
   264				WARN(1, "pool %d: %d of %d allocated\n",
   265				     new_pool->id, num, new_pool->size);
   266				return NULL;
   267			}
   268		}
   269	
   270		return new_pool;
   271	}
   272	EXPORT_SYMBOL_GPL(mvneta_bm_pool_use);
   273	
   274	/* Free all buffers from the pool */
 > 275	void mvneta_bm_bufs_free(struct mvneta_bm *priv, struct mvneta_bm_pool *bm_pool,
   276				 u8 port_map)
   277	{
   278		int i;
   279	
   280		bm_pool->port_map &= ~port_map;
   281		if (bm_pool->port_map)
   282			return;
   283	
   284		mvneta_bm_config_set(priv, MVNETA_BM_EMPTY_LIMIT_MASK);
   285	
   286		for (i = 0; i < bm_pool->buf_num; i++) {
   287			dma_addr_t buf_phys_addr;
   288			u32 *vaddr;
   289	
   290			/* Get buffer physical address (indirect access) */
   291			buf_phys_addr = mvneta_bm_pool_get_bp(priv, bm_pool);
   292	
   293			/* Work-around to the problems when destroying the pool,
   294			 * when it occurs that a read access to BPPI returns 0.
   295			 */
   296			if (buf_phys_addr == 0)
   297				continue;
   298	
   299			vaddr = phys_to_virt(buf_phys_addr);
   300			if (!vaddr)
   301				break;
   302	
   303			dma_unmap_single(&priv->pdev->dev, buf_phys_addr,
   304					 bm_pool->buf_size, DMA_FROM_DEVICE);
   305			mvneta_frag_free(bm_pool->frag_size, vaddr);
   306		}
   307	
   308		mvneta_bm_config_clear(priv, MVNETA_BM_EMPTY_LIMIT_MASK);
   309	
   310		/* Update BM driver with number of buffers removed from pool */
   311		bm_pool->buf_num -= i;
   312	}
   313	
   314	/* Cleanup pool */
 > 315	void mvneta_bm_pool_destroy(struct mvneta_bm *priv,
   316				    struct mvneta_bm_pool *bm_pool, u8 port_map)
   317	{
   318		bm_pool->port_map &= ~port_map;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56268 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160307/84ca55a1/attachment-0001.obj>
