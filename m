From: lkp@intel.com (kbuild test robot)
Date: Sun, 10 Jun 2018 23:49:55 +0800
Subject: [PATCH v5 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
In-Reply-To: <1528186420-6615-5-git-send-email-changbin.du@intel.com>
References: <1528186420-6615-5-git-send-email-changbin.du@intel.com>
Message-ID: <201806101929.E2oiistg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Changbin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17 next-20180608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/changbin-du-intel-com/kernel-hacking-GCC-optimization-for-better-debug-experience-Og/20180606-001415
config: i386-randconfig-x076-06101602 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers//usb/typec/fusb302/fusb302.c: In function 'fusb302_handle_togdone_src':
>> drivers//usb/typec/fusb302/fusb302.c:1413:10: warning: 'ra_comp' may be used uninitialized in this function [-Wmaybe-uninitialized]
     else if (ra_comp)
             ^
--
   drivers/infiniband/ulp/ipoib/ipoib_main.c: In function 'ipoib_get_netdev':
>> drivers/infiniband/ulp/ipoib/ipoib_main.c:2021:30: warning: 'dev' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (!hca->alloc_rdma_netdev || PTR_ERR(dev) == -EOPNOTSUPP)
--
   kernel//cgroup/cgroup-v1.c: In function 'cgroup1_mount':
>> kernel//cgroup/cgroup-v1.c:1268:3: warning: 'root' may be used uninitialized in this function [-Wmaybe-uninitialized]
      percpu_ref_reinit(&root->cgrp.self.refcnt);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   kernel//trace/bpf_trace.c: In function 'bpf_trace_printk':
>> kernel//trace/bpf_trace.c:226:20: warning: 'unsafe_addr' may be used uninitialized in this function [-Wmaybe-uninitialized]
              (void *) (long) unsafe_addr,
                       ^~~~~~~~~~~~~~~~~~
   kernel//trace/bpf_trace.c:170:6: note: 'unsafe_addr' was declared here
     u64 unsafe_addr;
         ^~~~~~~~~~~
--
   net//6lowpan/iphc.c: In function 'lowpan_header_decompress':
   net//6lowpan/iphc.c:617:12: warning: 'iphc1' may be used uninitialized in this function [-Wmaybe-uninitialized]
     u8 iphc0, iphc1, cid = 0;
               ^~~~~
>> net//6lowpan/iphc.c:617:5: warning: 'iphc0' may be used uninitialized in this function [-Wmaybe-uninitialized]
     u8 iphc0, iphc1, cid = 0;
        ^~~~~
--
   net//netfilter/nf_tables_api.c: In function 'nf_tables_dump_set':
>> net//netfilter/nf_tables_api.c:3625:2: warning: 'set' may be used uninitialized in this function [-Wmaybe-uninitialized]
     set->ops->walk(&dump_ctx->ctx, set, &args.iter);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/media/dvb-frontends/mn88472.c: In function 'mn88472_set_frontend':
>> drivers/media/dvb-frontends/mn88472.c:339:27: warning: 'bandwidth_vals_ptr' may be used uninitialized in this function [-Wmaybe-uninitialized]
            bandwidth_vals_ptr[i]);
                              ^
>> drivers/media/dvb-frontends/mn88472.c:320:8: warning: 'bandwidth_val' may be used uninitialized in this function [-Wmaybe-uninitialized]
     ret = regmap_write(dev->regmap[2], 0x04, bandwidth_val);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/media/dvb-frontends/mn88473.c: In function 'mn88473_set_frontend':
>> drivers/media/dvb-frontends/mn88473.c:162:7: warning: 'conf_val_ptr' may be used uninitialized in this function [-Wmaybe-uninitialized]
      ret = regmap_bulk_write(dev->regmap[1], 0x10, conf_val_ptr, 6);
      ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   net//netfilter/ipvs/ip_vs_sync.c: In function 'ip_vs_sync_conn':
>> net//netfilter/ipvs/ip_vs_sync.c:731:13: warning: 'm' may be used uninitialized in this function [-Wmaybe-uninitialized]
     m->nr_conns++;
     ~~~~~~~~~~~^~
--
   drivers//hwspinlock/hwspinlock_core.c: In function 'of_hwspin_lock_get_id':
>> drivers//hwspinlock/hwspinlock_core.c:339:19: warning: 'id' may be used uninitialized in this function [-Wmaybe-uninitialized]
     return ret ? ret : id;
            ~~~~~~~~~~^~~~
--
   drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c: In function 'mlxsw_sp_nexthop_group_update':
>> drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3078:7: warning: 'err' may be used uninitialized in this function [-Wmaybe-uninitialized]
       if (err)
          ^

vim +/ra_comp +1413 drivers//usb/typec/fusb302/fusb302.c

c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1359  
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1360  static int fusb302_handle_togdone_src(struct fusb302_chip *chip,
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1361  				      u8 togdone_result)
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1362  {
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1363  	/*
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1364  	 * - set polarity (measure cc, vconn, tx)
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1365  	 * - set pull_up, pull_down
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1366  	 * - set cc1, cc2, and update to tcpm_port
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1367  	 * - set I_COMP interrupt on
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1368  	 */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1369  	int ret = 0;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1370  	u8 status0;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1371  	u8 ra_mda = ra_mda_value[chip->src_current_status];
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1372  	u8 rd_mda = rd_mda_value[chip->src_current_status];
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1373  	bool ra_comp, rd_comp;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1374  	enum typec_cc_polarity cc_polarity;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1375  	enum typec_cc_status cc_status_active, cc1, cc2;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1376  
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1377  	/* set pull_up, pull_down */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1378  	ret = fusb302_set_cc_pull(chip, true, false);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1379  	if (ret < 0) {
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1380  		fusb302_log(chip, "cannot set cc to pull up, ret=%d", ret);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1381  		return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1382  	}
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1383  	/* set polarity */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1384  	cc_polarity = (togdone_result == FUSB_REG_STATUS1A_TOGSS_SRC1) ?
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1385  		      TYPEC_POLARITY_CC1 : TYPEC_POLARITY_CC2;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1386  	ret = fusb302_set_cc_polarity(chip, cc_polarity);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1387  	if (ret < 0) {
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1388  		fusb302_log(chip, "cannot set cc polarity %s, ret=%d",
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1389  			    cc_polarity_name[cc_polarity], ret);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1390  		return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1391  	}
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1392  	/* fusb302_set_cc_polarity() has set the correct measure block */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1393  	ret = fusb302_i2c_write(chip, FUSB_REG_MEASURE, rd_mda);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1394  	if (ret < 0)
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1395  		return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1396  	usleep_range(50, 100);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1397  	ret = fusb302_i2c_read(chip, FUSB_REG_STATUS0, &status0);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1398  	if (ret < 0)
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1399  		return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1400  	rd_comp = !!(status0 & FUSB_REG_STATUS0_COMP);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1401  	if (!rd_comp) {
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1402  		ret = fusb302_i2c_write(chip, FUSB_REG_MEASURE, ra_mda);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1403  		if (ret < 0)
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1404  			return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1405  		usleep_range(50, 100);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1406  		ret = fusb302_i2c_read(chip, FUSB_REG_STATUS0, &status0);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1407  		if (ret < 0)
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1408  			return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1409  		ra_comp = !!(status0 & FUSB_REG_STATUS0_COMP);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1410  	}
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1411  	if (rd_comp)
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1412  		cc_status_active = TYPEC_CC_OPEN;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27 @1413  	else if (ra_comp)
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1414  		cc_status_active = TYPEC_CC_RD;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1415  	else
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1416  		/* Ra is not supported, report as Open */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1417  		cc_status_active = TYPEC_CC_OPEN;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1418  	/* restart toggling if the cc status on the active line is OPEN */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1419  	if (cc_status_active == TYPEC_CC_OPEN) {
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1420  		fusb302_log(chip, "restart toggling as CC_OPEN detected");
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1421  		ret = fusb302_set_toggling(chip, chip->toggling_mode);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1422  		return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1423  	}
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1424  	/* update tcpm with the new cc value */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1425  	cc1 = (cc_polarity == TYPEC_POLARITY_CC1) ?
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1426  	      cc_status_active : TYPEC_CC_OPEN;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1427  	cc2 = (cc_polarity == TYPEC_POLARITY_CC2) ?
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1428  	      cc_status_active : TYPEC_CC_OPEN;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1429  	if ((chip->cc1 != cc1) || (chip->cc2 != cc2)) {
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1430  		chip->cc1 = cc1;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1431  		chip->cc2 = cc2;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1432  		tcpm_cc_change(chip->tcpm_port);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1433  	}
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1434  	/* turn off toggling */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1435  	ret = fusb302_set_toggling(chip, TOGGLINE_MODE_OFF);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1436  	if (ret < 0) {
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1437  		fusb302_log(chip,
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1438  			    "cannot set toggling mode off, ret=%d", ret);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1439  		return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1440  	}
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1441  	/* set MDAC to Rd threshold, and unmask I_COMP for unplug detection */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1442  	ret = fusb302_i2c_write(chip, FUSB_REG_MEASURE, rd_mda);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1443  	if (ret < 0)
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1444  		return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1445  	/* unmask comp_chng interrupt */
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1446  	ret = fusb302_i2c_clear_bits(chip, FUSB_REG_MASK,
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1447  				     FUSB_REG_MASK_COMP_CHNG);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1448  	if (ret < 0) {
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1449  		fusb302_log(chip,
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1450  			    "cannot unmask bc_lcl interrupt, ret=%d", ret);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1451  		return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1452  	}
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1453  	chip->intr_comp_chng = true;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1454  	fusb302_log(chip, "detected cc1=%s, cc2=%s",
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1455  		    typec_cc_status_name[cc1],
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1456  		    typec_cc_status_name[cc2]);
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1457  
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1458  	return ret;
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1459  }
c034a43e drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu 2017-04-27  1460  

:::::: The code at line 1413 was first introduced by commit
:::::: c034a43e72dda58e4a184d71f5502ef356e04453 staging: typec: Fairchild FUSB302 Type-c chip driver

:::::: TO: Yueyao Zhu <yueyao@google.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30857 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180610/f9900427/attachment-0001.gz>
