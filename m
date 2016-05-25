From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 26 May 2016 07:15:45 +0800
Subject: [rjarzmik:work/ac97 5/7] sound/ac97/bus.c:203:5: error: redefinition
 of 'snd_ac97_controller_register'
Message-ID: <201605260742.grC8535B%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/ac97
head:   6ebaee487a55e240a38df1557d9e6bde652589d2
commit: 4a88e9608287031bea0c753218347fddf8a26f30 [5/7] ASoC: pxa: switch to new ac97 bus support
config: arm-cm_x300_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4a88e9608287031bea0c753218347fddf8a26f30
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the rjarzmik/work/ac97 HEAD 6ebaee487a55e240a38df1557d9e6bde652589d2 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> sound/ac97/bus.c:154:5: error: redefinition of 'snd_ac97_codec_driver_register'
    int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
        ^
   In file included from sound/ac97/bus.c:18:0:
   include/sound/ac97/codec.h:84:12: note: previous definition of 'snd_ac97_codec_driver_register' was here
    static int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
               ^
>> sound/ac97/bus.c:174:6: error: redefinition of 'snd_ac97_codec_driver_unregister'
    void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
         ^
   In file included from sound/ac97/bus.c:18:0:
   include/sound/ac97/codec.h:88:13: note: previous definition of 'snd_ac97_codec_driver_unregister' was here
    static void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
                ^
>> sound/ac97/bus.c:203:5: error: redefinition of 'snd_ac97_controller_register'
    int snd_ac97_controller_register(const struct ac97_controller_ops *ops,
        ^
   In file included from sound/ac97/bus.c:19:0:
   include/sound/ac97/controller.h:42:12: note: previous definition of 'snd_ac97_controller_register' was here
    static int snd_ac97_controller_register(const struct ac97_controller_ops *ops,
               ^
>> sound/ac97/bus.c:233:5: error: redefinition of 'snd_ac97_controller_unregister'
    int snd_ac97_controller_unregister(const struct device *dev)
        ^
   In file included from sound/ac97/bus.c:19:0:
   include/sound/ac97/controller.h:49:12: note: previous definition of 'snd_ac97_controller_unregister' was here
    static int snd_ac97_controller_unregister(const struct device *dev)
               ^
   In file included from sound/ac97/bus.c:18:0:
   include/sound/ac97/codec.h:84:12: warning: 'snd_ac97_codec_driver_register' defined but not used [-Wunused-function]
    static int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
               ^
   include/sound/ac97/codec.h:88:13: warning: 'snd_ac97_codec_driver_unregister' defined but not used [-Wunused-function]
    static void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
                ^
   In file included from sound/ac97/bus.c:19:0:
   include/sound/ac97/controller.h:42:12: warning: 'snd_ac97_controller_register' defined but not used [-Wunused-function]
    static int snd_ac97_controller_register(const struct ac97_controller_ops *ops,
               ^
   include/sound/ac97/controller.h:49:12: warning: 'snd_ac97_controller_unregister' defined but not used [-Wunused-function]
    static int snd_ac97_controller_unregister(const struct device *dev)
               ^

vim +/snd_ac97_controller_register +203 sound/ac97/bus.c

0db28e61 Robert Jarzmik 2016-04-16  148   *
0db28e61 Robert Jarzmik 2016-04-16  149   * Register an AC97 codec driver to the ac97 bus driver, aka. the AC97 digital
0db28e61 Robert Jarzmik 2016-04-16  150   * controller.
0db28e61 Robert Jarzmik 2016-04-16  151   *
0db28e61 Robert Jarzmik 2016-04-16  152   * Returns 0 on success or error code
0db28e61 Robert Jarzmik 2016-04-16  153   */
0db28e61 Robert Jarzmik 2016-04-16 @154  int snd_ac97_codec_driver_register(struct ac97_codec_driver *drv)
0db28e61 Robert Jarzmik 2016-04-16  155  {
0db28e61 Robert Jarzmik 2016-04-16  156  	int ret;
0db28e61 Robert Jarzmik 2016-04-16  157  
0db28e61 Robert Jarzmik 2016-04-16  158  	drv->driver.bus = &ac97_bus_type;
0db28e61 Robert Jarzmik 2016-04-16  159  
0db28e61 Robert Jarzmik 2016-04-16  160  	ret = driver_register(&drv->driver);
0db28e61 Robert Jarzmik 2016-04-16  161  	if (!ret)
0db28e61 Robert Jarzmik 2016-04-16  162  		ac97_rescan_all_controllers();
0db28e61 Robert Jarzmik 2016-04-16  163  
0db28e61 Robert Jarzmik 2016-04-16  164  	return ret;
0db28e61 Robert Jarzmik 2016-04-16  165  }
0db28e61 Robert Jarzmik 2016-04-16  166  EXPORT_SYMBOL(snd_ac97_codec_driver_register);
0db28e61 Robert Jarzmik 2016-04-16  167  
0db28e61 Robert Jarzmik 2016-04-16  168  /**
0db28e61 Robert Jarzmik 2016-04-16  169   * snd_ac97_codec_driver_unregister - unregister an AC97 codec driver
0db28e61 Robert Jarzmik 2016-04-16  170   * @dev: AC97 codec driver to unregister
0db28e61 Robert Jarzmik 2016-04-16  171   *
0db28e61 Robert Jarzmik 2016-04-16  172   * Unregister a previously registered ac97 codec driver.
0db28e61 Robert Jarzmik 2016-04-16  173   */
0db28e61 Robert Jarzmik 2016-04-16 @174  void snd_ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
0db28e61 Robert Jarzmik 2016-04-16  175  {
0db28e61 Robert Jarzmik 2016-04-16  176  	driver_unregister(&drv->driver);
0db28e61 Robert Jarzmik 2016-04-16  177  }
0db28e61 Robert Jarzmik 2016-04-16  178  EXPORT_SYMBOL(snd_ac97_codec_driver_unregister);
0db28e61 Robert Jarzmik 2016-04-16  179  
0db28e61 Robert Jarzmik 2016-04-16  180  static int ac97_ctrl_codecs_unregister(struct ac97_controller *ac97_ctrl)
0db28e61 Robert Jarzmik 2016-04-16  181  {
0db28e61 Robert Jarzmik 2016-04-16  182  	int i;
0db28e61 Robert Jarzmik 2016-04-16  183  
0db28e61 Robert Jarzmik 2016-04-16  184  	for (i = 0; i < AC97_BUS_MAX_CODECS; i++)
0db28e61 Robert Jarzmik 2016-04-16  185  		if (ac97_ctrl->codecs[i])
0db28e61 Robert Jarzmik 2016-04-16  186  			put_device(&ac97_ctrl->codecs[i]->dev);
0db28e61 Robert Jarzmik 2016-04-16  187  
0db28e61 Robert Jarzmik 2016-04-16  188  	return 0;
0db28e61 Robert Jarzmik 2016-04-16  189  }
0db28e61 Robert Jarzmik 2016-04-16  190  
0db28e61 Robert Jarzmik 2016-04-16  191  /**
0db28e61 Robert Jarzmik 2016-04-16  192   * snd_ac97_controller_register - register an ac97 controller
0db28e61 Robert Jarzmik 2016-04-16  193   * @ops: the ac97 bus operations
0db28e61 Robert Jarzmik 2016-04-16  194   * @dev: the device providing the ac97 DC function
0db28e61 Robert Jarzmik 2016-04-16  195   * @slots_available: mask of the ac97 codecs that can be scanned and probed
0db28e61 Robert Jarzmik 2016-04-16  196   *                   bit0 => codec 0, bit1 => codec 1 ... bit 3 => codec 3
0db28e61 Robert Jarzmik 2016-04-16  197   *
0db28e61 Robert Jarzmik 2016-04-16  198   * Register a digital controller which can control up to 4 ac97 codecs. This is
0db28e61 Robert Jarzmik 2016-04-16  199   * the controller side of the AC97 AC-link, while the slave side are the codecs.
0db28e61 Robert Jarzmik 2016-04-16  200   *
0db28e61 Robert Jarzmik 2016-04-16  201   * Returns 0 upon success, negative value upon error
0db28e61 Robert Jarzmik 2016-04-16  202   */
0db28e61 Robert Jarzmik 2016-04-16 @203  int snd_ac97_controller_register(const struct ac97_controller_ops *ops,
0db28e61 Robert Jarzmik 2016-04-16  204  				 struct device *dev,
0db28e61 Robert Jarzmik 2016-04-16  205  				 unsigned short slots_available)
0db28e61 Robert Jarzmik 2016-04-16  206  {
0db28e61 Robert Jarzmik 2016-04-16  207  	struct ac97_controller *ac97_ctrl;
0db28e61 Robert Jarzmik 2016-04-16  208  
0db28e61 Robert Jarzmik 2016-04-16  209  	ac97_ctrl = kzalloc(sizeof(*ac97_ctrl), GFP_KERNEL);
0db28e61 Robert Jarzmik 2016-04-16  210  	if (!ac97_ctrl)
0db28e61 Robert Jarzmik 2016-04-16  211  		return -ENOMEM;
0db28e61 Robert Jarzmik 2016-04-16  212  
0db28e61 Robert Jarzmik 2016-04-16  213  	mutex_lock(&ac97_controllers_mutex);
0db28e61 Robert Jarzmik 2016-04-16  214  	ac97_ctrl->ops = ops;
0db28e61 Robert Jarzmik 2016-04-16  215  	ac97_ctrl->slots_available = slots_available;
0db28e61 Robert Jarzmik 2016-04-16  216  	ac97_ctrl->dev = dev;
0db28e61 Robert Jarzmik 2016-04-16  217  	list_add(&ac97_ctrl->controllers, &ac97_controllers);
0db28e61 Robert Jarzmik 2016-04-16  218  	mutex_unlock(&ac97_controllers_mutex);
0db28e61 Robert Jarzmik 2016-04-16  219  
0db28e61 Robert Jarzmik 2016-04-16  220  	ac97_bus_reset(ac97_ctrl);
0db28e61 Robert Jarzmik 2016-04-16  221  	ac97_bus_scan(ac97_ctrl);
0db28e61 Robert Jarzmik 2016-04-16  222  
0db28e61 Robert Jarzmik 2016-04-16  223  	return 0;
0db28e61 Robert Jarzmik 2016-04-16  224  }
0db28e61 Robert Jarzmik 2016-04-16  225  EXPORT_SYMBOL(snd_ac97_controller_register);
0db28e61 Robert Jarzmik 2016-04-16  226  
0db28e61 Robert Jarzmik 2016-04-16  227  /**
0db28e61 Robert Jarzmik 2016-04-16  228   * snd_ac97_controller_unregister - unregister an ac97 controller
0db28e61 Robert Jarzmik 2016-04-16  229   * @dev: the device previously provided to ac97_controller_register()
0db28e61 Robert Jarzmik 2016-04-16  230   *
0db28e61 Robert Jarzmik 2016-04-16  231   * Returns 0 on success, negative upon error
0db28e61 Robert Jarzmik 2016-04-16  232   */
0db28e61 Robert Jarzmik 2016-04-16 @233  int snd_ac97_controller_unregister(const struct device *dev)
0db28e61 Robert Jarzmik 2016-04-16  234  {
0db28e61 Robert Jarzmik 2016-04-16  235  	struct ac97_controller *ac97_ctrl, *tmp;
0db28e61 Robert Jarzmik 2016-04-16  236  	int ret = -ENODEV, i;

:::::: The code at line 203 was first introduced by commit
:::::: 0db28e61f85c1ce51190acf236629fb33d65b2cd ALSA: ac97: add an ac97 bus

:::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
:::::: CC: Robert Jarzmik <robert.jarzmik@free.fr>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 17696 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160526/fcc30950/attachment-0001.obj>
