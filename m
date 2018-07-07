From: lkp@intel.com (kbuild test robot)
Date: Sat, 7 Jul 2018 15:08:29 +0800
Subject: [PATCH 3/3] i2c: mediatek: Use DMA safe buffers for i2c
 transactions
In-Reply-To: <1530931753-8264-4-git-send-email-jun.gao@mediatek.com>
References: <1530931753-8264-4-git-send-email-jun.gao@mediatek.com>
Message-ID: <201807071243.pOTrx6hC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on v4.18-rc3 next-20180706]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jun-Gao/Register-i2c-adapter-driver-earlier-and-use-DMA-safe-buffers/20180707-105514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/i2c//busses/i2c-mt65xx.c: In function 'mtk_i2c_do_transfer':
>> drivers/i2c//busses/i2c-mt65xx.c:635:3: warning: 'dma_wr_buf' may be used uninitialized in this function [-Wmaybe-uninitialized]
      i2c_release_dma_safe_msg_buf(msgs, dma_wr_buf);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c//busses/i2c-mt65xx.c:636:3: warning: 'dma_rd_buf' may be used uninitialized in this function [-Wmaybe-uninitialized]
      i2c_release_dma_safe_msg_buf((msgs + 1), dma_rd_buf);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/dma_wr_buf +635 drivers/i2c//busses/i2c-mt65xx.c

   435	
   436	static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
   437				       int num, int left_num)
   438	{
   439		u16 addr_reg;
   440		u16 start_reg;
   441		u16 control_reg;
   442		u16 restart_flag = 0;
   443		u32 reg_4g_mode;
   444		u8 *dma_rd_buf;
   445		u8 *dma_wr_buf;
   446		dma_addr_t rpaddr = 0;
   447		dma_addr_t wpaddr = 0;
   448		int ret;
   449	
   450		i2c->irq_stat = 0;
   451	
   452		if (i2c->auto_restart)
   453			restart_flag = I2C_RS_TRANSFER;
   454	
   455		reinit_completion(&i2c->msg_complete);
   456	
   457		control_reg = readw(i2c->base + OFFSET_CONTROL) &
   458				~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
   459		if ((i2c->speed_hz > 400000) || (left_num >= 1))
   460			control_reg |= I2C_CONTROL_RS;
   461	
   462		if (i2c->op == I2C_MASTER_WRRD)
   463			control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
   464	
   465		writew(control_reg, i2c->base + OFFSET_CONTROL);
   466	
   467		/* set start condition */
   468		if (i2c->speed_hz <= 100000)
   469			writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
   470		else
   471			writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
   472	
   473		addr_reg = i2c_8bit_addr_from_msg(msgs);
   474		writew(addr_reg, i2c->base + OFFSET_SLAVE_ADDR);
   475	
   476		/* Clear interrupt status */
   477		writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
   478		       I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
   479		writew(I2C_FIFO_ADDR_CLR, i2c->base + OFFSET_FIFO_ADDR_CLR);
   480	
   481		/* Enable interrupt */
   482		writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
   483		       I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_MASK);
   484	
   485		/* Set transfer and transaction len */
   486		if (i2c->op == I2C_MASTER_WRRD) {
   487			if (i2c->dev_comp->aux_len_reg) {
   488				writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
   489				writew((msgs + 1)->len, i2c->base +
   490				       OFFSET_TRANSFER_LEN_AUX);
   491			} else {
   492				writew(msgs->len | ((msgs + 1)->len) << 8,
   493				       i2c->base + OFFSET_TRANSFER_LEN);
   494			}
   495			writew(I2C_WRRD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
   496		} else {
   497			writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
   498			writew(num, i2c->base + OFFSET_TRANSAC_LEN);
   499		}
   500	
   501		/* Prepare buffer data to start transfer */
   502		if (i2c->op == I2C_MASTER_RD) {
   503			writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
   504			writel(I2C_DMA_CON_RX, i2c->pdmabase + OFFSET_CON);
   505	
   506			dma_rd_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
   507			if (!dma_rd_buf)
   508				return -ENOMEM;
   509	
   510			rpaddr = dma_map_single(i2c->dev, dma_rd_buf,
   511						msgs->len, DMA_FROM_DEVICE);
   512			if (dma_mapping_error(i2c->dev, rpaddr)) {
   513				i2c_free_dma_safe_msg_buf(msgs, dma_rd_buf);
   514	
   515				return -ENOMEM;
   516			}
   517	
   518			if (i2c->dev_comp->support_33bits) {
   519				reg_4g_mode = mtk_i2c_set_4g_mode(rpaddr);
   520				writel(reg_4g_mode, i2c->pdmabase + OFFSET_RX_4G_MODE);
   521			}
   522	
   523			writel((u32)rpaddr, i2c->pdmabase + OFFSET_RX_MEM_ADDR);
   524			writel(msgs->len, i2c->pdmabase + OFFSET_RX_LEN);
   525		} else if (i2c->op == I2C_MASTER_WR) {
   526			writel(I2C_DMA_INT_FLAG_NONE, i2c->pdmabase + OFFSET_INT_FLAG);
   527			writel(I2C_DMA_CON_TX, i2c->pdmabase + OFFSET_CON);
   528	
   529			dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
   530			if (!dma_wr_buf)
   531				return -ENOMEM;
   532	
   533			wpaddr = dma_map_single(i2c->dev, dma_wr_buf,
   534						msgs->len, DMA_TO_DEVICE);
   535			if (dma_mapping_error(i2c->dev, wpaddr)) {
   536				i2c_free_dma_safe_msg_buf(msgs, dma_wr_buf);
   537	
   538				return -ENOMEM;
   539			}
   540	
   541			if (i2c->dev_comp->support_33bits) {
   542				reg_4g_mode = mtk_i2c_set_4g_mode(wpaddr);
   543				writel(reg_4g_mode, i2c->pdmabase + OFFSET_TX_4G_MODE);
   544			}
   545	
   546			writel((u32)wpaddr, i2c->pdmabase + OFFSET_TX_MEM_ADDR);
   547			writel(msgs->len, i2c->pdmabase + OFFSET_TX_LEN);
   548		} else {
   549			writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_INT_FLAG);
   550			writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_CON);
   551	
   552			dma_wr_buf = i2c_get_dma_safe_msg_buf(msgs, 0);
   553			if (!dma_wr_buf)
   554				return -ENOMEM;
   555	
   556			wpaddr = dma_map_single(i2c->dev, dma_wr_buf,
   557						msgs->len, DMA_TO_DEVICE);
   558			if (dma_mapping_error(i2c->dev, wpaddr)) {
   559				i2c_free_dma_safe_msg_buf(msgs, dma_wr_buf);
   560	
   561				return -ENOMEM;
   562			}
   563	
   564			dma_rd_buf = i2c_get_dma_safe_msg_buf((msgs + 1), 0);
   565			if (!dma_rd_buf) {
   566				dma_unmap_single(i2c->dev, wpaddr,
   567						 msgs->len, DMA_TO_DEVICE);
   568	
   569				i2c_free_dma_safe_msg_buf(msgs, dma_wr_buf);
   570	
   571				return -ENOMEM;
   572			}
   573	
   574			rpaddr = dma_map_single(i2c->dev, dma_rd_buf,
   575						(msgs + 1)->len,
   576						DMA_FROM_DEVICE);
   577			if (dma_mapping_error(i2c->dev, rpaddr)) {
   578				dma_unmap_single(i2c->dev, wpaddr,
   579						 msgs->len, DMA_TO_DEVICE);
   580	
   581				i2c_free_dma_safe_msg_buf(msgs, dma_wr_buf);
   582				i2c_free_dma_safe_msg_buf((msgs + 1), dma_rd_buf);
   583	
   584				return -ENOMEM;
   585			}
   586	
   587			if (i2c->dev_comp->support_33bits) {
   588				reg_4g_mode = mtk_i2c_set_4g_mode(wpaddr);
   589				writel(reg_4g_mode, i2c->pdmabase + OFFSET_TX_4G_MODE);
   590	
   591				reg_4g_mode = mtk_i2c_set_4g_mode(rpaddr);
   592				writel(reg_4g_mode, i2c->pdmabase + OFFSET_RX_4G_MODE);
   593			}
   594	
   595			writel((u32)wpaddr, i2c->pdmabase + OFFSET_TX_MEM_ADDR);
   596			writel((u32)rpaddr, i2c->pdmabase + OFFSET_RX_MEM_ADDR);
   597			writel(msgs->len, i2c->pdmabase + OFFSET_TX_LEN);
   598			writel((msgs + 1)->len, i2c->pdmabase + OFFSET_RX_LEN);
   599		}
   600	
   601		writel(I2C_DMA_START_EN, i2c->pdmabase + OFFSET_EN);
   602	
   603		if (!i2c->auto_restart) {
   604			start_reg = I2C_TRANSAC_START;
   605		} else {
   606			start_reg = I2C_TRANSAC_START | I2C_RS_MUL_TRIG;
   607			if (left_num >= 1)
   608				start_reg |= I2C_RS_MUL_CNFG;
   609		}
   610		writew(start_reg, i2c->base + OFFSET_START);
   611	
   612		ret = wait_for_completion_timeout(&i2c->msg_complete,
   613						  i2c->adap.timeout);
   614	
   615		/* Clear interrupt mask */
   616		writew(~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
   617		       I2C_TRANSAC_COMP), i2c->base + OFFSET_INTR_MASK);
   618	
   619		if (i2c->op == I2C_MASTER_WR) {
   620			dma_unmap_single(i2c->dev, wpaddr,
   621					 msgs->len, DMA_TO_DEVICE);
   622	
   623			i2c_release_dma_safe_msg_buf(msgs, dma_wr_buf);
   624		} else if (i2c->op == I2C_MASTER_RD) {
   625			dma_unmap_single(i2c->dev, rpaddr,
   626					 msgs->len, DMA_FROM_DEVICE);
   627	
   628			i2c_release_dma_safe_msg_buf(msgs, dma_rd_buf);
   629		} else {
   630			dma_unmap_single(i2c->dev, wpaddr, msgs->len,
   631					 DMA_TO_DEVICE);
   632			dma_unmap_single(i2c->dev, rpaddr, (msgs + 1)->len,
   633					 DMA_FROM_DEVICE);
   634	
 > 635			i2c_release_dma_safe_msg_buf(msgs, dma_wr_buf);
 > 636			i2c_release_dma_safe_msg_buf((msgs + 1), dma_rd_buf);
   637		}
   638	
   639		if (ret == 0) {
   640			dev_dbg(i2c->dev, "addr: %x, transfer timeout\n", msgs->addr);
   641			mtk_i2c_init_hw(i2c);
   642			return -ETIMEDOUT;
   643		}
   644	
   645		completion_done(&i2c->msg_complete);
   646	
   647		if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
   648			dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
   649			mtk_i2c_init_hw(i2c);
   650			return -ENXIO;
   651		}
   652	
   653		return 0;
   654	}
   655	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54028 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180707/0b799393/attachment-0001.gz>
