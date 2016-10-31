From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 1 Nov 2016 07:04:55 +0800
Subject: [rjarzmik:work/ac97 15/15] sound/ac97/bus.c:285:5: error:
 redefinition of 'snd_ac97_controller_register'
Message-ID: <201611010754.pJ01bZM7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/ac97
head:   84dce0ccc786a2af4266cb85cab983abf4c53a91
commit: 84dce0ccc786a2af4266cb85cab983abf4c53a91 [15/15] ASoC: pxa: switch to new ac97 bus support
config: arm-em_x270_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 84dce0ccc786a2af4266cb85cab983abf4c53a91
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> sound/ac97/bus.c:168:5: error: redefinition of 'snd_ac97_codec_driver_register'
    int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/ac97/bus.c:19:0:
   include/sound/ac97/codec.h:85:1: note: previous definition of 'snd_ac97_codec_driver_register' was here
    snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/ac97/bus.c:188:6: error: redefinition of 'snd_ac97_codec_driver_unregister'
    void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/ac97/bus.c:19:0:
   include/sound/ac97/codec.h:90:1: note: previous definition of 'snd_ac97_codec_driver_unregister' was here
    snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/ac97/bus.c:285:5: error: redefinition of 'snd_ac97_controller_register'
    int snd_ac97_controller_register(const struct ac97_controller_ops *ops,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/ac97/bus.c:20:0:
   include/sound/ac97/controller.h:71:1: note: previous definition of 'snd_ac97_controller_register' was here
    snd_ac97_controller_register(const struct ac97_controller_ops *ops,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/ac97/bus.c:324:5: error: redefinition of 'snd_ac97_controller_unregister'
    int snd_ac97_controller_unregister(struct device *dev)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from sound/ac97/bus.c:20:0:
   include/sound/ac97/controller.h:79:19: note: previous definition of 'snd_ac97_controller_unregister' was here
    static inline int snd_ac97_controller_unregister(struct device *dev)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   sound/soc/codecs/wm9712.c: In function 'ac97_read':
   sound/soc/codecs/wm9712.c:497:10: error: 'soc_ac97_ops' undeclared (first use in this function)
      return soc_ac97_ops->read(wm9712->ac97, reg);
             ^~~~~~~~~~~~
   sound/soc/codecs/wm9712.c:497:10: note: each undeclared identifier is reported only once for each function it appears in
   sound/soc/codecs/wm9712.c: In function 'ac97_write':
   sound/soc/codecs/wm9712.c:514:2: error: 'soc_ac97_ops' undeclared (first use in this function)
     soc_ac97_ops->write(wm9712->ac97, reg, val);
     ^~~~~~~~~~~~
   sound/soc/codecs/wm9712.c: In function 'wm9712_soc_resume':
   sound/soc/codecs/wm9712.c:638:4: error: 'soc_ac97_ops' undeclared (first use in this function)
       soc_ac97_ops->write(wm9712->ac97, i, cache[i>>1]);
       ^~~~~~~~~~~~
   sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
>> sound/soc/codecs/wm9712.c:650:17: error: implicit declaration of function 'snd_soc_new_ac97_codec' [-Werror=implicit-function-declaration]
     wm9712->ac97 = snd_soc_new_ac97_codec(codec, WM9712_VENDOR_ID,
                    ^~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/codecs/wm9712.c:650:15: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     wm9712->ac97 = snd_soc_new_ac97_codec(codec, WM9712_VENDOR_ID,
                  ^
   sound/soc/codecs/wm9712.c: In function 'wm9712_soc_remove':
>> sound/soc/codecs/wm9712.c:668:2: error: implicit declaration of function 'snd_soc_free_ac97_codec' [-Werror=implicit-function-declaration]
     snd_soc_free_ac97_codec(wm9712->ac97);
     ^~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/wm9712.c: In function 'ac97_read':
   sound/soc/codecs/wm9712.c:506:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors

vim +/snd_ac97_controller_register +285 sound/ac97/bus.c

92c123dd Robert Jarzmik 2016-04-16  162   *
92c123dd Robert Jarzmik 2016-04-16  163   * Register an AC97 codec driver to the ac97 bus driver, aka. the AC97 digital
92c123dd Robert Jarzmik 2016-04-16  164   * controller.
92c123dd Robert Jarzmik 2016-04-16  165   *
92c123dd Robert Jarzmik 2016-04-16  166   * Returns 0 on success or error code
92c123dd Robert Jarzmik 2016-04-16  167   */
92c123dd Robert Jarzmik 2016-04-16 @168  int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
92c123dd Robert Jarzmik 2016-04-16  169  {
92c123dd Robert Jarzmik 2016-04-16  170  	int ret;
92c123dd Robert Jarzmik 2016-04-16  171  
92c123dd Robert Jarzmik 2016-04-16  172  	drv->driver.bus = &ac97_bus_type;
92c123dd Robert Jarzmik 2016-04-16  173  
92c123dd Robert Jarzmik 2016-04-16  174  	ret = driver_register(&drv->driver);
92c123dd Robert Jarzmik 2016-04-16  175  	if (!ret)
92c123dd Robert Jarzmik 2016-04-16  176  		ac97_rescan_all_controllers();
92c123dd Robert Jarzmik 2016-04-16  177  
92c123dd Robert Jarzmik 2016-04-16  178  	return ret;
92c123dd Robert Jarzmik 2016-04-16  179  }
92c123dd Robert Jarzmik 2016-04-16  180  EXPORT_SYMBOL(snd_ac97_codec_driver_register);
92c123dd Robert Jarzmik 2016-04-16  181  
92c123dd Robert Jarzmik 2016-04-16  182  /**
92c123dd Robert Jarzmik 2016-04-16  183   * snd_ac97_codec_driver_unregister - unregister an AC97 codec driver
92c123dd Robert Jarzmik 2016-04-16  184   * @dev: AC97 codec driver to unregister
92c123dd Robert Jarzmik 2016-04-16  185   *
92c123dd Robert Jarzmik 2016-04-16  186   * Unregister a previously registered ac97 codec driver.
92c123dd Robert Jarzmik 2016-04-16  187   */
92c123dd Robert Jarzmik 2016-04-16 @188  void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
92c123dd Robert Jarzmik 2016-04-16  189  {
92c123dd Robert Jarzmik 2016-04-16  190  	driver_unregister(&drv->driver);
92c123dd Robert Jarzmik 2016-04-16  191  }
92c123dd Robert Jarzmik 2016-04-16  192  EXPORT_SYMBOL(snd_ac97_codec_driver_unregister);
92c123dd Robert Jarzmik 2016-04-16  193  
92c123dd Robert Jarzmik 2016-04-16  194  /**
92c123dd Robert Jarzmik 2016-04-16  195   * snd_ac97_codec_get_platdata - get platform_data
92c123dd Robert Jarzmik 2016-04-16  196   * @adev: the ac97 codec device
92c123dd Robert Jarzmik 2016-04-16  197   *
92c123dd Robert Jarzmik 2016-04-16  198   * For legacy platforms, in order to have platform_data in codec drivers
92c123dd Robert Jarzmik 2016-04-16  199   * available, while ac97 device are auto-created upon probe, this retrieves the
92c123dd Robert Jarzmik 2016-04-16  200   * platdata which was setup on ac97 controller registration.
92c123dd Robert Jarzmik 2016-04-16  201   *
92c123dd Robert Jarzmik 2016-04-16  202   * Returns the platform data pointer
92c123dd Robert Jarzmik 2016-04-16  203   */
92c123dd Robert Jarzmik 2016-04-16  204  void *snd_ac97_codec_get_platdata(const struct ac97_codec_device *adev)
92c123dd Robert Jarzmik 2016-04-16  205  {
92c123dd Robert Jarzmik 2016-04-16  206  	struct ac97_controller *ac97_ctrl = adev->ac97_ctrl;
92c123dd Robert Jarzmik 2016-04-16  207  
92c123dd Robert Jarzmik 2016-04-16  208  	return ac97_ctrl->codecs_pdata[adev->num];
92c123dd Robert Jarzmik 2016-04-16  209  }
92c123dd Robert Jarzmik 2016-04-16  210  EXPORT_SYMBOL(snd_ac97_codec_get_platdata);
92c123dd Robert Jarzmik 2016-04-16  211  
92c123dd Robert Jarzmik 2016-04-16  212  static struct ac97_controller *ac97_ctrl_find(struct device *dev)
92c123dd Robert Jarzmik 2016-04-16  213  {
92c123dd Robert Jarzmik 2016-04-16  214  	struct ac97_controller *ac97_ctrl, *tmp;
92c123dd Robert Jarzmik 2016-04-16  215  
92c123dd Robert Jarzmik 2016-04-16  216  	list_for_each_entry_safe(ac97_ctrl, tmp, &ac97_controllers,
92c123dd Robert Jarzmik 2016-04-16  217  				 controllers)
92c123dd Robert Jarzmik 2016-04-16  218  		if (ac97_ctrl->dev == dev)
92c123dd Robert Jarzmik 2016-04-16  219  			return ac97_ctrl;
92c123dd Robert Jarzmik 2016-04-16  220  
92c123dd Robert Jarzmik 2016-04-16  221  	return NULL;
92c123dd Robert Jarzmik 2016-04-16  222  }
92c123dd Robert Jarzmik 2016-04-16  223  static int ac97_ctrl_codecs_unregister(struct ac97_controller *ac97_ctrl)
92c123dd Robert Jarzmik 2016-04-16  224  {
92c123dd Robert Jarzmik 2016-04-16  225  	int i;
92c123dd Robert Jarzmik 2016-04-16  226  
92c123dd Robert Jarzmik 2016-04-16  227  	for (i = 0; i < AC97_BUS_MAX_CODECS; i++)
92c123dd Robert Jarzmik 2016-04-16  228  		if (ac97_ctrl->codecs[i])
92c123dd Robert Jarzmik 2016-04-16  229  			put_device(&ac97_ctrl->codecs[i]->dev);
92c123dd Robert Jarzmik 2016-04-16  230  
92c123dd Robert Jarzmik 2016-04-16  231  	return 0;
92c123dd Robert Jarzmik 2016-04-16  232  }
92c123dd Robert Jarzmik 2016-04-16  233  
92c123dd Robert Jarzmik 2016-04-16  234  static ssize_t cold_reset_store(struct device *dev,
92c123dd Robert Jarzmik 2016-04-16  235  				struct device_attribute *attr, const char *buf,
92c123dd Robert Jarzmik 2016-04-16  236  				size_t len)
92c123dd Robert Jarzmik 2016-04-16  237  {
92c123dd Robert Jarzmik 2016-04-16  238  	struct ac97_controller *ac97_ctrl = ac97_ctrl_find(dev);
92c123dd Robert Jarzmik 2016-04-16  239  
92c123dd Robert Jarzmik 2016-04-16  240  	if (!dev)
92c123dd Robert Jarzmik 2016-04-16  241  		return -ENODEV;
92c123dd Robert Jarzmik 2016-04-16  242  
92c123dd Robert Jarzmik 2016-04-16  243  	ac97_ctrl->ops->reset(ac97_ctrl);
92c123dd Robert Jarzmik 2016-04-16  244  	return len;
92c123dd Robert Jarzmik 2016-04-16  245  }
92c123dd Robert Jarzmik 2016-04-16  246  static DEVICE_ATTR_WO(cold_reset);
92c123dd Robert Jarzmik 2016-04-16  247  
92c123dd Robert Jarzmik 2016-04-16  248  static ssize_t warm_reset_store(struct device *dev,
92c123dd Robert Jarzmik 2016-04-16  249  				struct device_attribute *attr, const char *buf,
92c123dd Robert Jarzmik 2016-04-16  250  				size_t len)
92c123dd Robert Jarzmik 2016-04-16  251  {
92c123dd Robert Jarzmik 2016-04-16  252  	struct ac97_controller *ac97_ctrl = ac97_ctrl_find(dev);
92c123dd Robert Jarzmik 2016-04-16  253  
92c123dd Robert Jarzmik 2016-04-16  254  	if (!dev)
92c123dd Robert Jarzmik 2016-04-16  255  		return -ENODEV;
92c123dd Robert Jarzmik 2016-04-16  256  
92c123dd Robert Jarzmik 2016-04-16  257  	ac97_ctrl->ops->warm_reset(ac97_ctrl);
92c123dd Robert Jarzmik 2016-04-16  258  	return len;
92c123dd Robert Jarzmik 2016-04-16  259  }
92c123dd Robert Jarzmik 2016-04-16  260  static DEVICE_ATTR_WO(warm_reset);
92c123dd Robert Jarzmik 2016-04-16  261  
92c123dd Robert Jarzmik 2016-04-16  262  static struct attribute *ac97_controller_device_attrs[] = {
92c123dd Robert Jarzmik 2016-04-16  263  	&dev_attr_cold_reset.attr,
92c123dd Robert Jarzmik 2016-04-16  264  	&dev_attr_warm_reset.attr,
92c123dd Robert Jarzmik 2016-04-16  265  	NULL
92c123dd Robert Jarzmik 2016-04-16  266  };
92c123dd Robert Jarzmik 2016-04-16  267  
92c123dd Robert Jarzmik 2016-04-16  268  static const struct attribute_group ac97_controller_attr_group = {
92c123dd Robert Jarzmik 2016-04-16  269  	.name	= "ac97_operations",
92c123dd Robert Jarzmik 2016-04-16  270  	.attrs	= ac97_controller_device_attrs,
92c123dd Robert Jarzmik 2016-04-16  271  };
92c123dd Robert Jarzmik 2016-04-16  272  
92c123dd Robert Jarzmik 2016-04-16  273  /**
92c123dd Robert Jarzmik 2016-04-16  274   * snd_ac97_controller_register - register an ac97 controller
92c123dd Robert Jarzmik 2016-04-16  275   * @ops: the ac97 bus operations
92c123dd Robert Jarzmik 2016-04-16  276   * @dev: the device providing the ac97 DC function
92c123dd Robert Jarzmik 2016-04-16  277   * @slots_available: mask of the ac97 codecs that can be scanned and probed
92c123dd Robert Jarzmik 2016-04-16  278   *                   bit0 => codec 0, bit1 => codec 1 ... bit 3 => codec 3
92c123dd Robert Jarzmik 2016-04-16  279   *
92c123dd Robert Jarzmik 2016-04-16  280   * Register a digital controller which can control up to 4 ac97 codecs. This is
92c123dd Robert Jarzmik 2016-04-16  281   * the controller side of the AC97 AC-link, while the slave side are the codecs.
92c123dd Robert Jarzmik 2016-04-16  282   *
92c123dd Robert Jarzmik 2016-04-16  283   * Returns 0 upon success, negative value upon error
92c123dd Robert Jarzmik 2016-04-16  284   */
92c123dd Robert Jarzmik 2016-04-16 @285  int snd_ac97_controller_register(const struct ac97_controller_ops *ops,
92c123dd Robert Jarzmik 2016-04-16  286  				 struct device *dev,
92c123dd Robert Jarzmik 2016-04-16  287  				 unsigned short slots_available,
92c123dd Robert Jarzmik 2016-04-16  288  				 void **codecs_pdata)
92c123dd Robert Jarzmik 2016-04-16  289  {
92c123dd Robert Jarzmik 2016-04-16  290  	struct ac97_controller *ac97_ctrl;
92c123dd Robert Jarzmik 2016-04-16  291  	int ret, i;
92c123dd Robert Jarzmik 2016-04-16  292  
92c123dd Robert Jarzmik 2016-04-16  293  	ac97_ctrl = kzalloc(sizeof(*ac97_ctrl), GFP_KERNEL);
92c123dd Robert Jarzmik 2016-04-16  294  	if (!ac97_ctrl)
92c123dd Robert Jarzmik 2016-04-16  295  		return -ENOMEM;
92c123dd Robert Jarzmik 2016-04-16  296  
92c123dd Robert Jarzmik 2016-04-16  297  	for (i = 0; i < AC97_BUS_MAX_CODECS && codecs_pdata; i++)
92c123dd Robert Jarzmik 2016-04-16  298  		ac97_ctrl->codecs_pdata[i] = codecs_pdata[i];
92c123dd Robert Jarzmik 2016-04-16  299  
92c123dd Robert Jarzmik 2016-04-16  300  	ret = sysfs_create_group(&dev->kobj, &ac97_controller_attr_group);
92c123dd Robert Jarzmik 2016-04-16  301  	if (ret)
92c123dd Robert Jarzmik 2016-04-16  302  		return ret;
92c123dd Robert Jarzmik 2016-04-16  303  
92c123dd Robert Jarzmik 2016-04-16  304  	mutex_lock(&ac97_controllers_mutex);
92c123dd Robert Jarzmik 2016-04-16  305  	ac97_ctrl->ops = ops;
92c123dd Robert Jarzmik 2016-04-16  306  	ac97_ctrl->slots_available = slots_available;
92c123dd Robert Jarzmik 2016-04-16  307  	ac97_ctrl->dev = dev;
92c123dd Robert Jarzmik 2016-04-16  308  	list_add(&ac97_ctrl->controllers, &ac97_controllers);
92c123dd Robert Jarzmik 2016-04-16  309  	mutex_unlock(&ac97_controllers_mutex);
92c123dd Robert Jarzmik 2016-04-16  310  
92c123dd Robert Jarzmik 2016-04-16  311  	ac97_bus_reset(ac97_ctrl);
92c123dd Robert Jarzmik 2016-04-16  312  	ac97_bus_scan(ac97_ctrl);
92c123dd Robert Jarzmik 2016-04-16  313  
92c123dd Robert Jarzmik 2016-04-16  314  	return 0;
92c123dd Robert Jarzmik 2016-04-16  315  }
92c123dd Robert Jarzmik 2016-04-16  316  EXPORT_SYMBOL(snd_ac97_controller_register);
92c123dd Robert Jarzmik 2016-04-16  317  
92c123dd Robert Jarzmik 2016-04-16  318  /**
92c123dd Robert Jarzmik 2016-04-16  319   * snd_ac97_controller_unregister - unregister an ac97 controller
92c123dd Robert Jarzmik 2016-04-16  320   * @dev: the device previously provided to ac97_controller_register()
92c123dd Robert Jarzmik 2016-04-16  321   *
92c123dd Robert Jarzmik 2016-04-16  322   * Returns 0 on success, negative upon error
92c123dd Robert Jarzmik 2016-04-16  323   */
92c123dd Robert Jarzmik 2016-04-16 @324  int snd_ac97_controller_unregister(struct device *dev)
92c123dd Robert Jarzmik 2016-04-16  325  {
92c123dd Robert Jarzmik 2016-04-16  326  	struct ac97_controller *ac97_ctrl;
92c123dd Robert Jarzmik 2016-04-16  327  	int ret = -ENODEV, i;

:::::: The code at line 285 was first introduced by commit
:::::: 92c123ddf9fbf8eb9fbcbde0ce958a888cc15081 ALSA: ac97: add an ac97 bus

:::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
:::::: CC: Robert Jarzmik <robert.jarzmik@free.fr>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 18037 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161101/11cd59ce/attachment-0001.gz>
