From: lkp@intel.com (kbuild test robot)
Date: Wed, 9 May 2018 21:55:46 +0800
Subject: [xlnx:xlnx_rebase_v4.14 809/917] drivers/ptp/ptp_clock.c:274:
 undefined reference to `posix_clock_register'
Message-ID: <201805092143.HD1hzh6X%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   a24ae3acb778c948234fa8f227bacd818034055d
commit: b1b0dab4c89c1a42e4108cef8aa118373302b33d [809/917] net: macb: Select PTP_1588_CLOCK in Kconfig
config: i386-randconfig-i1-201818 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout b1b0dab4c89c1a42e4108cef8aa118373302b33d
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/ptp/ptp_clock.o: In function `ptp_clock_register':
>> drivers/ptp/ptp_clock.c:274: undefined reference to `posix_clock_register'
   drivers/ptp/ptp_clock.o: In function `ptp_clock_unregister':
>> drivers/ptp/ptp_clock.c:320: undefined reference to `posix_clock_unregister'

vim +274 drivers/ptp/ptp_clock.c

d94ba80e Richard Cochran    2011-04-22  202  
1ef76158 Richard Cochran    2012-09-22  203  struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
1ef76158 Richard Cochran    2012-09-22  204  				     struct device *parent)
d94ba80e Richard Cochran    2011-04-22  205  {
d94ba80e Richard Cochran    2011-04-22  206  	struct ptp_clock *ptp;
d94ba80e Richard Cochran    2011-04-22  207  	int err = 0, index, major = MAJOR(ptp_devt);
d94ba80e Richard Cochran    2011-04-22  208  
d94ba80e Richard Cochran    2011-04-22  209  	if (info->n_alarm > PTP_MAX_ALARMS)
d94ba80e Richard Cochran    2011-04-22  210  		return ERR_PTR(-EINVAL);
d94ba80e Richard Cochran    2011-04-22  211  
d94ba80e Richard Cochran    2011-04-22  212  	/* Initialize a clock structure. */
d94ba80e Richard Cochran    2011-04-22  213  	err = -ENOMEM;
d94ba80e Richard Cochran    2011-04-22  214  	ptp = kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
d94ba80e Richard Cochran    2011-04-22  215  	if (ptp == NULL)
d94ba80e Richard Cochran    2011-04-22  216  		goto no_memory;
d94ba80e Richard Cochran    2011-04-22  217  
7356a764 Jiri Benc          2013-04-12  218  	index = ida_simple_get(&ptp_clocks_map, 0, MINORMASK + 1, GFP_KERNEL);
7356a764 Jiri Benc          2013-04-12  219  	if (index < 0) {
7356a764 Jiri Benc          2013-04-12  220  		err = index;
7356a764 Jiri Benc          2013-04-12  221  		goto no_slot;
7356a764 Jiri Benc          2013-04-12  222  	}
7356a764 Jiri Benc          2013-04-12  223  
d94ba80e Richard Cochran    2011-04-22  224  	ptp->clock.ops = ptp_clock_ops;
d94ba80e Richard Cochran    2011-04-22  225  	ptp->clock.release = delete_ptp_clock;
d94ba80e Richard Cochran    2011-04-22  226  	ptp->info = info;
d94ba80e Richard Cochran    2011-04-22  227  	ptp->devid = MKDEV(major, index);
d94ba80e Richard Cochran    2011-04-22  228  	ptp->index = index;
d94ba80e Richard Cochran    2011-04-22  229  	spin_lock_init(&ptp->tsevq.lock);
d94ba80e Richard Cochran    2011-04-22  230  	mutex_init(&ptp->tsevq_mux);
6092315d Richard Cochran    2014-03-20  231  	mutex_init(&ptp->pincfg_mux);
d94ba80e Richard Cochran    2011-04-22  232  	init_waitqueue_head(&ptp->tsev_wq);
d94ba80e Richard Cochran    2011-04-22  233  
d9535cb7 Grygorii Strashko  2017-07-28  234  	if (ptp->info->do_aux_work) {
d9535cb7 Grygorii Strashko  2017-07-28  235  		char *worker_name = kasprintf(GFP_KERNEL, "ptp%d", ptp->index);
d9535cb7 Grygorii Strashko  2017-07-28  236  
d9535cb7 Grygorii Strashko  2017-07-28  237  		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
d9535cb7 Grygorii Strashko  2017-07-28  238  		ptp->kworker = kthread_create_worker(0, worker_name ?
d9535cb7 Grygorii Strashko  2017-07-28  239  						     worker_name : info->name);
d9535cb7 Grygorii Strashko  2017-07-28  240  		kfree(worker_name);
d9535cb7 Grygorii Strashko  2017-07-28  241  		if (IS_ERR(ptp->kworker)) {
d9535cb7 Grygorii Strashko  2017-07-28  242  			err = PTR_ERR(ptp->kworker);
d9535cb7 Grygorii Strashko  2017-07-28  243  			pr_err("failed to create ptp aux_worker %d\n", err);
d9535cb7 Grygorii Strashko  2017-07-28  244  			goto kworker_err;
d9535cb7 Grygorii Strashko  2017-07-28  245  		}
d9535cb7 Grygorii Strashko  2017-07-28  246  	}
d9535cb7 Grygorii Strashko  2017-07-28  247  
85a66e55 Dmitry Torokhov    2017-02-14  248  	err = ptp_populate_pin_groups(ptp);
85a66e55 Dmitry Torokhov    2017-02-14  249  	if (err)
85a66e55 Dmitry Torokhov    2017-02-14  250  		goto no_pin_groups;
85a66e55 Dmitry Torokhov    2017-02-14  251  
d94ba80e Richard Cochran    2011-04-22  252  	/* Create a new device in our class. */
85a66e55 Dmitry Torokhov    2017-02-14  253  	ptp->dev = device_create_with_groups(ptp_class, parent, ptp->devid,
85a66e55 Dmitry Torokhov    2017-02-14  254  					     ptp, ptp->pin_attr_groups,
d94ba80e Richard Cochran    2011-04-22  255  					     "ptp%d", ptp->index);
d94ba80e Richard Cochran    2011-04-22  256  	if (IS_ERR(ptp->dev))
d94ba80e Richard Cochran    2011-04-22  257  		goto no_device;
d94ba80e Richard Cochran    2011-04-22  258  
d94ba80e Richard Cochran    2011-04-22  259  	/* Register a new PPS source. */
d94ba80e Richard Cochran    2011-04-22  260  	if (info->pps) {
d94ba80e Richard Cochran    2011-04-22  261  		struct pps_source_info pps;
d94ba80e Richard Cochran    2011-04-22  262  		memset(&pps, 0, sizeof(pps));
d94ba80e Richard Cochran    2011-04-22  263  		snprintf(pps.name, PPS_MAX_NAME_LEN, "ptp%d", index);
d94ba80e Richard Cochran    2011-04-22  264  		pps.mode = PTP_PPS_MODE;
d94ba80e Richard Cochran    2011-04-22  265  		pps.owner = info->owner;
d94ba80e Richard Cochran    2011-04-22  266  		ptp->pps_source = pps_register_source(&pps, PTP_PPS_DEFAULTS);
d94ba80e Richard Cochran    2011-04-22  267  		if (!ptp->pps_source) {
d94ba80e Richard Cochran    2011-04-22  268  			pr_err("failed to register pps source\n");
d94ba80e Richard Cochran    2011-04-22  269  			goto no_pps;
d94ba80e Richard Cochran    2011-04-22  270  		}
d94ba80e Richard Cochran    2011-04-22  271  	}
d94ba80e Richard Cochran    2011-04-22  272  
d94ba80e Richard Cochran    2011-04-22  273  	/* Create a posix clock. */
d94ba80e Richard Cochran    2011-04-22 @274  	err = posix_clock_register(&ptp->clock, ptp->devid);
d94ba80e Richard Cochran    2011-04-22  275  	if (err) {
d94ba80e Richard Cochran    2011-04-22  276  		pr_err("failed to create posix clock\n");
d94ba80e Richard Cochran    2011-04-22  277  		goto no_clock;
d94ba80e Richard Cochran    2011-04-22  278  	}
d94ba80e Richard Cochran    2011-04-22  279  
d94ba80e Richard Cochran    2011-04-22  280  	return ptp;
d94ba80e Richard Cochran    2011-04-22  281  
d94ba80e Richard Cochran    2011-04-22  282  no_clock:
d94ba80e Richard Cochran    2011-04-22  283  	if (ptp->pps_source)
d94ba80e Richard Cochran    2011-04-22  284  		pps_unregister_source(ptp->pps_source);
d94ba80e Richard Cochran    2011-04-22  285  no_pps:
d94ba80e Richard Cochran    2011-04-22  286  	device_destroy(ptp_class, ptp->devid);
d94ba80e Richard Cochran    2011-04-22  287  no_device:
85a66e55 Dmitry Torokhov    2017-02-14  288  	ptp_cleanup_pin_groups(ptp);
85a66e55 Dmitry Torokhov    2017-02-14  289  no_pin_groups:
d9535cb7 Grygorii Strashko  2017-07-28  290  	if (ptp->kworker)
d9535cb7 Grygorii Strashko  2017-07-28  291  		kthread_destroy_worker(ptp->kworker);
d9535cb7 Grygorii Strashko  2017-07-28  292  kworker_err:
d94ba80e Richard Cochran    2011-04-22  293  	mutex_destroy(&ptp->tsevq_mux);
6092315d Richard Cochran    2014-03-20  294  	mutex_destroy(&ptp->pincfg_mux);
b9118b72 Christophe Jaillet 2016-10-02  295  	ida_simple_remove(&ptp_clocks_map, index);
7356a764 Jiri Benc          2013-04-12  296  no_slot:
d94ba80e Richard Cochran    2011-04-22  297  	kfree(ptp);
d94ba80e Richard Cochran    2011-04-22  298  no_memory:
d94ba80e Richard Cochran    2011-04-22  299  	return ERR_PTR(err);
d94ba80e Richard Cochran    2011-04-22  300  }
d94ba80e Richard Cochran    2011-04-22  301  EXPORT_SYMBOL(ptp_clock_register);
d94ba80e Richard Cochran    2011-04-22  302  
d94ba80e Richard Cochran    2011-04-22  303  int ptp_clock_unregister(struct ptp_clock *ptp)
d94ba80e Richard Cochran    2011-04-22  304  {
d94ba80e Richard Cochran    2011-04-22  305  	ptp->defunct = 1;
d94ba80e Richard Cochran    2011-04-22  306  	wake_up_interruptible(&ptp->tsev_wq);
d94ba80e Richard Cochran    2011-04-22  307  
d9535cb7 Grygorii Strashko  2017-07-28  308  	if (ptp->kworker) {
d9535cb7 Grygorii Strashko  2017-07-28  309  		kthread_cancel_delayed_work_sync(&ptp->aux_work);
d9535cb7 Grygorii Strashko  2017-07-28  310  		kthread_destroy_worker(ptp->kworker);
d9535cb7 Grygorii Strashko  2017-07-28  311  	}
d9535cb7 Grygorii Strashko  2017-07-28  312  
d94ba80e Richard Cochran    2011-04-22  313  	/* Release the clock's resources. */
d94ba80e Richard Cochran    2011-04-22  314  	if (ptp->pps_source)
d94ba80e Richard Cochran    2011-04-22  315  		pps_unregister_source(ptp->pps_source);
85a66e55 Dmitry Torokhov    2017-02-14  316  
d94ba80e Richard Cochran    2011-04-22  317  	device_destroy(ptp_class, ptp->devid);
85a66e55 Dmitry Torokhov    2017-02-14  318  	ptp_cleanup_pin_groups(ptp);
d94ba80e Richard Cochran    2011-04-22  319  
d94ba80e Richard Cochran    2011-04-22 @320  	posix_clock_unregister(&ptp->clock);
d94ba80e Richard Cochran    2011-04-22  321  	return 0;
d94ba80e Richard Cochran    2011-04-22  322  }
d94ba80e Richard Cochran    2011-04-22  323  EXPORT_SYMBOL(ptp_clock_unregister);
d94ba80e Richard Cochran    2011-04-22  324  

:::::: The code at line 274 was first introduced by commit
:::::: d94ba80ebbea17f036cecb104398fbcd788aa742 ptp: Added a brand new class driver for ptp clocks.

:::::: TO: Richard Cochran <richardcochran@gmail.com>
:::::: CC: John Stultz <john.stultz@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180509/bf7d5c28/attachment-0001.gz>
