From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Mar 2018 01:49:21 +0800
Subject: [PATCH v2 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <1521941356-12361-3-git-send-email-rishabhb@codeaurora.org>
References: <1521941356-12361-3-git-send-email-rishabhb@codeaurora.org>
Message-ID: <201803280154.UyCtKB7v%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rishabh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc7 next-20180327]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rishabh-Bhatnagar/SDM845-System-Cache-Driver/20180325-233519
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'drivers/soc/qcom/llcc-core.c', needed by 'drivers/soc/qcom/llcc-core.o'.
   make[4]: *** [drivers/soc/qcom/llcc-slice.o] Error 1
   make[4]: Target '__build' not remade because of errors.
--
>> drivers/soc/qcom/llcc-slice.c:130:25: error: redefinition of 'llcc_slice_getd'
    struct llcc_slice_desc *llcc_slice_getd(struct device *dev, const char *name)
                            ^~~~~~~~~~~~~~~
   In file included from drivers/soc/qcom/llcc-slice.c:28:0:
   include/linux/soc/qcom/llcc-qcom.h:137:39: note: previous definition of 'llcc_slice_getd' was here
    static inline struct llcc_slice_desc *llcc_slice_getd(struct device *dev,
                                          ^~~~~~~~~~~~~~~
>> drivers/soc/qcom/llcc-slice.c:163:6: error: redefinition of 'llcc_slice_putd'
    void llcc_slice_putd(struct llcc_slice_desc *desc)
         ^~~~~~~~~~~~~~~
   In file included from drivers/soc/qcom/llcc-slice.c:28:0:
   include/linux/soc/qcom/llcc-qcom.h:143:20: note: previous definition of 'llcc_slice_putd' was here
    static inline void llcc_slice_putd(struct llcc_slice_desc *desc)
                       ^~~~~~~~~~~~~~~
>> drivers/soc/qcom/llcc-slice.c:206:5: error: redefinition of 'llcc_slice_activate'
    int llcc_slice_activate(struct llcc_slice_desc *desc)
        ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/soc/qcom/llcc-slice.c:28:0:
   include/linux/soc/qcom/llcc-qcom.h:157:19: note: previous definition of 'llcc_slice_activate' was here
    static inline int llcc_slice_activate(struct llcc_slice_desc *desc)
                      ^~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/llcc-slice.c:245:5: error: redefinition of 'llcc_slice_deactivate'
    int llcc_slice_deactivate(struct llcc_slice_desc *desc)
        ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/soc/qcom/llcc-slice.c:28:0:
   include/linux/soc/qcom/llcc-qcom.h:162:19: note: previous definition of 'llcc_slice_deactivate' was here
    static inline int llcc_slice_deactivate(struct llcc_slice_desc *desc)
                      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/llcc-slice.c:283:5: error: redefinition of 'llcc_get_slice_id'
    int llcc_get_slice_id(struct llcc_slice_desc *desc)
        ^~~~~~~~~~~~~~~~~
   In file included from drivers/soc/qcom/llcc-slice.c:28:0:
   include/linux/soc/qcom/llcc-qcom.h:148:19: note: previous definition of 'llcc_get_slice_id' was here
    static inline int llcc_get_slice_id(struct llcc_slice_desc *desc)
                      ^~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/llcc-slice.c:299:8: error: redefinition of 'llcc_get_slice_size'
    size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
           ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/soc/qcom/llcc-slice.c:28:0:
   include/linux/soc/qcom/llcc-qcom.h:153:22: note: previous definition of 'llcc_get_slice_size' was here
    static inline size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
                         ^~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/llcc-slice.c:368:5: error: redefinition of 'qcom_llcc_probe'
    int qcom_llcc_probe(struct platform_device *pdev,
        ^~~~~~~~~~~~~~~
   In file included from drivers/soc/qcom/llcc-slice.c:28:0:
   include/linux/soc/qcom/llcc-qcom.h:166:19: note: previous definition of 'qcom_llcc_probe' was here
    static inline int qcom_llcc_probe(struct platform_device *pdev,
                      ^~~~~~~~~~~~~~~
>> drivers/soc/qcom/llcc-slice.c:441:5: error: redefinition of 'qcom_llcc_remove'
    int qcom_llcc_remove(struct platform_device *pdev)
        ^~~~~~~~~~~~~~~~
   In file included from drivers/soc/qcom/llcc-slice.c:28:0:
   include/linux/soc/qcom/llcc-qcom.h:172:19: note: previous definition of 'qcom_llcc_remove' was here
    static inline int qcom_llcc_remove(struct platform_device *pdev)
                      ^~~~~~~~~~~~~~~~

vim +/llcc_slice_getd +130 drivers/soc/qcom/llcc-slice.c

   121	
   122	/**
   123	 * llcc_slice_getd - get llcc slice descriptor
   124	 * @dev: Device pointer of the client
   125	 * @name: Name of the use case
   126	 *
   127	 * A pointer to llcc slice descriptor will be returned on success and
   128	 * and error pointer is returned on failure
   129	 */
 > 130	struct llcc_slice_desc *llcc_slice_getd(struct device *dev, const char *name)
   131	{
   132		struct device_node *np = dev->of_node;
   133		int index = 0;
   134		const char *slice_name;
   135		struct property *prop;
   136	
   137		if (!np) {
   138			dev_err(dev, "%s() currently only supports DT\n", __func__);
   139			return ERR_PTR(-ENOENT);
   140		}
   141	
   142		if (!of_get_property(np, "cache-slice-names", NULL)) {
   143			dev_err(dev,
   144				"%s() requires a \"cache-slice-names\" property\n",
   145				__func__);
   146			return ERR_PTR(-ENOENT);
   147		}
   148	
   149		of_property_for_each_string(np, "cache-slice-names", prop, slice_name) {
   150			if (!strcmp(name, slice_name))
   151				break;
   152			index++;
   153		}
   154	
   155		return llcc_slice_get_entry(dev, index);
   156	}
   157	EXPORT_SYMBOL(llcc_slice_getd);
   158	
   159	/**
   160	 * llcc_slice_putd - llcc slice descritpor
   161	 * @desc: Pointer to llcc slice descriptor
   162	 */
 > 163	void llcc_slice_putd(struct llcc_slice_desc *desc)
   164	{
   165		kfree(desc);
   166	}
   167	EXPORT_SYMBOL(llcc_slice_putd);
   168	
   169	static int llcc_update_act_ctrl(struct llcc_drv_data *drv, u32 sid,
   170					u32 act_ctrl_reg_val, u32 status)
   171	{
   172		u32 act_ctrl_reg;
   173		u32 status_reg;
   174		u32 slice_status;
   175		unsigned long timeout;
   176	
   177		act_ctrl_reg = drv->b_off + LLCC_TRP_ACT_CTRLn(sid);
   178		status_reg = drv->b_off + LLCC_TRP_STATUSn(sid);
   179	
   180		regmap_write(drv->llcc_map, act_ctrl_reg, act_ctrl_reg_val);
   181	
   182		/* Make sure the activate trigger is applied before clearing it */
   183		mb();
   184	
   185		/* Clear the ACTIVE trigger */
   186		act_ctrl_reg_val &= ~ACT_CTRL_ACT_TRIG;
   187		regmap_write(drv->llcc_map, act_ctrl_reg, act_ctrl_reg_val);
   188	
   189		timeout = jiffies + usecs_to_jiffies(LLCC_STATUS_READ_DELAY);
   190		while (time_before(jiffies, timeout)) {
   191			regmap_read(drv->llcc_map, status_reg, &slice_status);
   192			if (!(slice_status & status))
   193				return 0;
   194		}
   195	
   196		return -ETIMEDOUT;
   197	}
   198	
   199	/**
   200	 * llcc_slice_activate - Activate the llcc slice
   201	 * @desc: Pointer to llcc slice descriptor
   202	 *
   203	 * A value zero will be returned on success and a negative errno will
   204	 * be returned in error cases
   205	 */
 > 206	int llcc_slice_activate(struct llcc_slice_desc *desc)
   207	{
   208		int rc = -EINVAL;
   209		u32 act_ctrl_val;
   210		struct llcc_drv_data *drv;
   211	
   212		if (desc == NULL)
   213			return rc;
   214	
   215		drv = dev_get_drvdata(desc->dev);
   216		if (!drv)
   217			return rc;
   218	
   219		mutex_lock(&drv->slice_mutex);
   220		if (test_bit(desc->llcc_slice_id, drv->llcc_slice_map)) {
   221			mutex_unlock(&drv->slice_mutex);
   222			return 0;
   223		}
   224	
   225		act_ctrl_val = ACT_CTRL_OPCODE_ACTIVATE << ACT_CTRL_OPCODE_SHIFT;
   226		act_ctrl_val |= ACT_CTRL_ACT_TRIG;
   227	
   228		rc = llcc_update_act_ctrl(drv, desc->llcc_slice_id, act_ctrl_val,
   229					  DEACTIVATE);
   230	
   231		__set_bit(desc->llcc_slice_id, drv->llcc_slice_map);
   232		mutex_unlock(&drv->slice_mutex);
   233	
   234		return rc;
   235	}
   236	EXPORT_SYMBOL(llcc_slice_activate);
   237	
   238	/**
   239	 * llcc_slice_deactivate - Deactivate the llcc slice
   240	 * @desc: Pointer to llcc slice descriptor
   241	 *
   242	 * A value zero will be returned on success and a negative errno will
   243	 * be returned in error cases
   244	 */
 > 245	int llcc_slice_deactivate(struct llcc_slice_desc *desc)
   246	{
   247		u32 act_ctrl_val;
   248		int rc = -EINVAL;
   249		struct llcc_drv_data *drv;
   250	
   251		if (desc == NULL)
   252			return rc;
   253	
   254		drv = dev_get_drvdata(desc->dev);
   255		if (!drv)
   256			return rc;
   257	
   258		mutex_lock(&drv->slice_mutex);
   259		if (!test_bit(desc->llcc_slice_id, drv->llcc_slice_map)) {
   260			mutex_unlock(&drv->slice_mutex);
   261			return 0;
   262		}
   263		act_ctrl_val = ACT_CTRL_OPCODE_DEACTIVATE << ACT_CTRL_OPCODE_SHIFT;
   264		act_ctrl_val |= ACT_CTRL_ACT_TRIG;
   265	
   266		rc = llcc_update_act_ctrl(drv, desc->llcc_slice_id, act_ctrl_val,
   267					  ACTIVATE);
   268	
   269		__clear_bit(desc->llcc_slice_id, drv->llcc_slice_map);
   270		mutex_unlock(&drv->slice_mutex);
   271	
   272		return rc;
   273	}
   274	EXPORT_SYMBOL(llcc_slice_deactivate);
   275	
   276	/**
   277	 * llcc_get_slice_id - return the slice id
   278	 * @desc: Pointer to llcc slice descriptor
   279	 *
   280	 * A positive value will be returned on success and a negative errno will
   281	 * be returned on error
   282	 */
 > 283	int llcc_get_slice_id(struct llcc_slice_desc *desc)
   284	{
   285		if (!desc)
   286			return -EINVAL;
   287	
   288		return desc->llcc_slice_id;
   289	}
   290	EXPORT_SYMBOL(llcc_get_slice_id);
   291	
   292	/**
   293	 * llcc_get_slice_size - return the slice id
   294	 * @desc: Pointer to llcc slice descriptor
   295	 *
   296	 * A positive value will be returned on success and zero will returned on
   297	 * error
   298	 */
 > 299	size_t llcc_get_slice_size(struct llcc_slice_desc *desc)
   300	{
   301		if (!desc)
   302			return 0;
   303	
   304		return desc->llcc_slice_size;
   305	}
   306	EXPORT_SYMBOL(llcc_get_slice_size);
   307	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65164 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/5c0f8780/attachment-0001.gz>
