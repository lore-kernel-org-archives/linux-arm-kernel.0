From: lkp@intel.com (kbuild test robot)
Date: Wed, 17 Feb 2016 17:24:16 +0800
Subject: [PATCH] ALSA: jack: Allow building the jack layer without input
In-Reply-To: <s5h8u2j6749.wl-tiwai@suse.de>
Message-ID: <201602171732.VPVdhvvI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takashi,

[auto build test ERROR on sound/for-next]
[also build test ERROR on v4.5-rc4 next-20160217]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Takashi-Iwai/ALSA-jack-Allow-building-the-jack-layer-without-input/20160217-171209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: x86_64-randconfig-x012-201607 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> sound/core/jack.c:184:5: error: redefinition of 'snd_jack_add_new_kctl'
    int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask)
        ^
   In file included from sound/core/jack.c:25:0:
   include/sound/jack.h:108:19: note: previous definition of 'snd_jack_add_new_kctl' was here
    static inline int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask)
                      ^
>> sound/core/jack.c:212:5: error: redefinition of 'snd_jack_new'
    int snd_jack_new(struct snd_card *card, const char *id, int type,
        ^
   In file included from sound/core/jack.c:25:0:
   include/sound/jack.h:102:19: note: previous definition of 'snd_jack_new' was here
    static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
                      ^
>> sound/core/jack.c:296:6: error: redefinition of 'snd_jack_set_parent'
    void snd_jack_set_parent(struct snd_jack *jack, struct device *parent)
         ^
   In file included from sound/core/jack.c:25:0:
   include/sound/jack.h:120:20: note: previous definition of 'snd_jack_set_parent' was here
    static inline void snd_jack_set_parent(struct snd_jack *jack,
                       ^
>> sound/core/jack.c:331:5: error: redefinition of 'snd_jack_set_key'
    int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
        ^
   In file included from sound/core/jack.c:25:0:
   include/sound/jack.h:125:19: note: previous definition of 'snd_jack_set_key' was here
    static inline int snd_jack_set_key(struct snd_jack *jack,
                      ^
>> sound/core/jack.c:354:6: error: redefinition of 'snd_jack_report'
    void snd_jack_report(struct snd_jack *jack, int status)
         ^
   In file included from sound/core/jack.c:25:0:
   include/sound/jack.h:113:20: note: previous definition of 'snd_jack_report' was here
    static inline void snd_jack_report(struct snd_jack *jack, int status)
                       ^

vim +/snd_jack_add_new_kctl +184 sound/core/jack.c

9058cbe1e Jie Yang         2015-04-27  178   *         by this snd_jack_kctl object.
9058cbe1e Jie Yang         2015-04-27  179   *
9058cbe1e Jie Yang         2015-04-27  180   * Creates a new snd_kcontrol object and adds it to the jack kctl_list.
9058cbe1e Jie Yang         2015-04-27  181   *
9058cbe1e Jie Yang         2015-04-27  182   * Return: Zero if successful, or a negative error code on failure.
9058cbe1e Jie Yang         2015-04-27  183   */
9058cbe1e Jie Yang         2015-04-27 @184  int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask)
9058cbe1e Jie Yang         2015-04-27  185  {
9058cbe1e Jie Yang         2015-04-27  186  	struct snd_jack_kctl *jack_kctl;
9058cbe1e Jie Yang         2015-04-27  187  
9058cbe1e Jie Yang         2015-04-27  188  	jack_kctl = snd_jack_kctl_new(jack->card, name, mask);
9058cbe1e Jie Yang         2015-04-27  189  	if (!jack_kctl)
9058cbe1e Jie Yang         2015-04-27  190  		return -ENOMEM;
9058cbe1e Jie Yang         2015-04-27  191  
9058cbe1e Jie Yang         2015-04-27  192  	snd_jack_kctl_add(jack, jack_kctl);
9058cbe1e Jie Yang         2015-04-27  193  	return 0;
9058cbe1e Jie Yang         2015-04-27  194  }
9058cbe1e Jie Yang         2015-04-27  195  EXPORT_SYMBOL(snd_jack_add_new_kctl);
9058cbe1e Jie Yang         2015-04-27  196  
e76d8ceaa Mark Brown       2008-07-28  197  /**
e76d8ceaa Mark Brown       2008-07-28  198   * snd_jack_new - Create a new jack
e76d8ceaa Mark Brown       2008-07-28  199   * @card:  the card instance
e76d8ceaa Mark Brown       2008-07-28  200   * @id:    an identifying string for this jack
e76d8ceaa Mark Brown       2008-07-28  201   * @type:  a bitmask of enum snd_jack_type values that can be detected by
e76d8ceaa Mark Brown       2008-07-28  202   *         this jack
e76d8ceaa Mark Brown       2008-07-28  203   * @jjack: Used to provide the allocated jack object to the caller.
4e3f0dc65 Jie Yang         2015-04-27  204   * @initial_kctl: if true, create a kcontrol and add it to the jack list.
4e3f0dc65 Jie Yang         2015-04-27  205   * @phantom_jack: Don't create a input device for phantom jacks.
e76d8ceaa Mark Brown       2008-07-28  206   *
e76d8ceaa Mark Brown       2008-07-28  207   * Creates a new jack object.
e76d8ceaa Mark Brown       2008-07-28  208   *
eb7c06e8e Yacine Belkadi   2013-03-11  209   * Return: Zero if successful, or a negative error code on failure.
eb7c06e8e Yacine Belkadi   2013-03-11  210   * On success @jjack will be initialised.
e76d8ceaa Mark Brown       2008-07-28  211   */
e76d8ceaa Mark Brown       2008-07-28 @212  int snd_jack_new(struct snd_card *card, const char *id, int type,
4e3f0dc65 Jie Yang         2015-04-27  213  		 struct snd_jack **jjack, bool initial_kctl, bool phantom_jack)
e76d8ceaa Mark Brown       2008-07-28  214  {
e76d8ceaa Mark Brown       2008-07-28  215  	struct snd_jack *jack;
4e3f0dc65 Jie Yang         2015-04-27  216  	struct snd_jack_kctl *jack_kctl = NULL;
e76d8ceaa Mark Brown       2008-07-28  217  	int err;
e76d8ceaa Mark Brown       2008-07-28  218  	static struct snd_device_ops ops = {
e76d8ceaa Mark Brown       2008-07-28  219  		.dev_free = snd_jack_dev_free,
dbe821f46 Takashi Iwai     2016-02-17  220  #ifdef CONFIG_SND_JACK_INPUT_DEV
e76d8ceaa Mark Brown       2008-07-28  221  		.dev_register = snd_jack_dev_register,
32b854429 Takashi Iwai     2013-11-14  222  		.dev_disconnect = snd_jack_dev_disconnect,
dbe821f46 Takashi Iwai     2016-02-17  223  #endif /* CONFIG_SND_JACK_INPUT_DEV */
e76d8ceaa Mark Brown       2008-07-28  224  	};
e76d8ceaa Mark Brown       2008-07-28  225  
4e3f0dc65 Jie Yang         2015-04-27  226  	if (initial_kctl) {
4e3f0dc65 Jie Yang         2015-04-27  227  		jack_kctl = snd_jack_kctl_new(card, id, type);
4e3f0dc65 Jie Yang         2015-04-27  228  		if (!jack_kctl)
4e3f0dc65 Jie Yang         2015-04-27  229  			return -ENOMEM;
4e3f0dc65 Jie Yang         2015-04-27  230  	}
4e3f0dc65 Jie Yang         2015-04-27  231  
e76d8ceaa Mark Brown       2008-07-28  232  	jack = kzalloc(sizeof(struct snd_jack), GFP_KERNEL);
e76d8ceaa Mark Brown       2008-07-28  233  	if (jack == NULL)
e76d8ceaa Mark Brown       2008-07-28  234  		return -ENOMEM;
e76d8ceaa Mark Brown       2008-07-28  235  
282cd76ff Matthew Ranostay 2008-10-25  236  	jack->id = kstrdup(id, GFP_KERNEL);
e76d8ceaa Mark Brown       2008-07-28  237  
4e3f0dc65 Jie Yang         2015-04-27  238  	/* don't creat input device for phantom jack */
4e3f0dc65 Jie Yang         2015-04-27  239  	if (!phantom_jack) {
dbe821f46 Takashi Iwai     2016-02-17  240  #ifdef CONFIG_SND_JACK_INPUT_DEV
dbe821f46 Takashi Iwai     2016-02-17  241  		int i;
dbe821f46 Takashi Iwai     2016-02-17  242  
e76d8ceaa Mark Brown       2008-07-28  243  		jack->input_dev = input_allocate_device();
e76d8ceaa Mark Brown       2008-07-28  244  		if (jack->input_dev == NULL) {
e76d8ceaa Mark Brown       2008-07-28  245  			err = -ENOMEM;
e76d8ceaa Mark Brown       2008-07-28  246  			goto fail_input;
e76d8ceaa Mark Brown       2008-07-28  247  		}
e76d8ceaa Mark Brown       2008-07-28  248  
e76d8ceaa Mark Brown       2008-07-28  249  		jack->input_dev->phys = "ALSA";
e76d8ceaa Mark Brown       2008-07-28  250  
e76d8ceaa Mark Brown       2008-07-28  251  		jack->type = type;
e76d8ceaa Mark Brown       2008-07-28  252  
53803aead Mark Brown       2012-02-07  253  		for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
bd8a71a7b Mark Brown       2009-01-03  254  			if (type & (1 << i))
e76d8ceaa Mark Brown       2008-07-28  255  				input_set_capability(jack->input_dev, EV_SW,
1c6e555c3 Mark Brown       2010-03-17  256  						     jack_switch_types[i]);
e76d8ceaa Mark Brown       2008-07-28  257  
dbe821f46 Takashi Iwai     2016-02-17  258  #endif /* CONFIG_SND_JACK_INPUT_DEV */
4e3f0dc65 Jie Yang         2015-04-27  259  	}
4e3f0dc65 Jie Yang         2015-04-27  260  
e76d8ceaa Mark Brown       2008-07-28  261  	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
e76d8ceaa Mark Brown       2008-07-28  262  	if (err < 0)
e76d8ceaa Mark Brown       2008-07-28  263  		goto fail_input;
e76d8ceaa Mark Brown       2008-07-28  264  
9058cbe1e Jie Yang         2015-04-27  265  	jack->card = card;
9058cbe1e Jie Yang         2015-04-27  266  	INIT_LIST_HEAD(&jack->kctl_list);
9058cbe1e Jie Yang         2015-04-27  267  
4e3f0dc65 Jie Yang         2015-04-27  268  	if (initial_kctl)
4e3f0dc65 Jie Yang         2015-04-27  269  		snd_jack_kctl_add(jack, jack_kctl);
4e3f0dc65 Jie Yang         2015-04-27  270  
e76d8ceaa Mark Brown       2008-07-28  271  	*jjack = jack;
e76d8ceaa Mark Brown       2008-07-28  272  
e76d8ceaa Mark Brown       2008-07-28  273  	return 0;
e76d8ceaa Mark Brown       2008-07-28  274  
e76d8ceaa Mark Brown       2008-07-28  275  fail_input:
dbe821f46 Takashi Iwai     2016-02-17  276  #ifdef CONFIG_SND_JACK_INPUT_DEV
e76d8ceaa Mark Brown       2008-07-28  277  	input_free_device(jack->input_dev);
dbe821f46 Takashi Iwai     2016-02-17  278  #endif
eeda276be Lu Guanqun       2011-02-21  279  	kfree(jack->id);
e76d8ceaa Mark Brown       2008-07-28  280  	kfree(jack);
e76d8ceaa Mark Brown       2008-07-28  281  	return err;
e76d8ceaa Mark Brown       2008-07-28  282  }
e76d8ceaa Mark Brown       2008-07-28  283  EXPORT_SYMBOL(snd_jack_new);
e76d8ceaa Mark Brown       2008-07-28  284  
dbe821f46 Takashi Iwai     2016-02-17  285  #ifdef CONFIG_SND_JACK_INPUT_DEV
e76d8ceaa Mark Brown       2008-07-28  286  /**
e76d8ceaa Mark Brown       2008-07-28  287   * snd_jack_set_parent - Set the parent device for a jack
e76d8ceaa Mark Brown       2008-07-28  288   *
e76d8ceaa Mark Brown       2008-07-28  289   * @jack:   The jack to configure
e76d8ceaa Mark Brown       2008-07-28  290   * @parent: The device to set as parent for the jack.
e76d8ceaa Mark Brown       2008-07-28  291   *
a2e888f0d Mark Brown       2012-05-07  292   * Set the parent for the jack devices in the device tree.  This
e76d8ceaa Mark Brown       2008-07-28  293   * function is only valid prior to registration of the jack.  If no
e76d8ceaa Mark Brown       2008-07-28  294   * parent is configured then the parent device will be the sound card.
e76d8ceaa Mark Brown       2008-07-28  295   */
e76d8ceaa Mark Brown       2008-07-28 @296  void snd_jack_set_parent(struct snd_jack *jack, struct device *parent)
e76d8ceaa Mark Brown       2008-07-28  297  {
e76d8ceaa Mark Brown       2008-07-28  298  	WARN_ON(jack->registered);
43b2cd547 Takashi Iwai     2015-04-30  299  	if (!jack->input_dev)
43b2cd547 Takashi Iwai     2015-04-30  300  		return;
e76d8ceaa Mark Brown       2008-07-28  301  
e76d8ceaa Mark Brown       2008-07-28  302  	jack->input_dev->dev.parent = parent;
e76d8ceaa Mark Brown       2008-07-28  303  }
e76d8ceaa Mark Brown       2008-07-28  304  EXPORT_SYMBOL(snd_jack_set_parent);
e76d8ceaa Mark Brown       2008-07-28  305  
e76d8ceaa Mark Brown       2008-07-28  306  /**
ebb812cb8 Mark Brown       2010-03-17  307   * snd_jack_set_key - Set a key mapping on a jack
ebb812cb8 Mark Brown       2010-03-17  308   *
ebb812cb8 Mark Brown       2010-03-17  309   * @jack:    The jack to configure
ebb812cb8 Mark Brown       2010-03-17  310   * @type:    Jack report type for this key
ebb812cb8 Mark Brown       2010-03-17  311   * @keytype: Input layer key type to be reported
ebb812cb8 Mark Brown       2010-03-17  312   *
ebb812cb8 Mark Brown       2010-03-17  313   * Map a SND_JACK_BTN_ button type to an input layer key, allowing
ebb812cb8 Mark Brown       2010-03-17  314   * reporting of keys on accessories via the jack abstraction.  If no
ebb812cb8 Mark Brown       2010-03-17  315   * mapping is provided but keys are enabled in the jack type then
ebb812cb8 Mark Brown       2010-03-17  316   * BTN_n numeric buttons will be reported.
ebb812cb8 Mark Brown       2010-03-17  317   *
a2e888f0d Mark Brown       2012-05-07  318   * If jacks are not reporting via the input API this call will have no
a2e888f0d Mark Brown       2012-05-07  319   * effect.
a2e888f0d Mark Brown       2012-05-07  320   *
ebb812cb8 Mark Brown       2010-03-17  321   * Note that this is intended to be use by simple devices with small
ebb812cb8 Mark Brown       2010-03-17  322   * numbers of keys that can be reported.  It is also possible to
ebb812cb8 Mark Brown       2010-03-17  323   * access the input device directly - devices with complex input
ebb812cb8 Mark Brown       2010-03-17  324   * capabilities on accessories should consider doing this rather than
ebb812cb8 Mark Brown       2010-03-17  325   * using this abstraction.
ebb812cb8 Mark Brown       2010-03-17  326   *
ebb812cb8 Mark Brown       2010-03-17  327   * This function may only be called prior to registration of the jack.
eb7c06e8e Yacine Belkadi   2013-03-11  328   *
eb7c06e8e Yacine Belkadi   2013-03-11  329   * Return: Zero if successful, or a negative error code on failure.
ebb812cb8 Mark Brown       2010-03-17  330   */
ebb812cb8 Mark Brown       2010-03-17 @331  int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
ebb812cb8 Mark Brown       2010-03-17  332  		     int keytype)
ebb812cb8 Mark Brown       2010-03-17  333  {
ebb812cb8 Mark Brown       2010-03-17  334  	int key = fls(SND_JACK_BTN_0) - fls(type);
ebb812cb8 Mark Brown       2010-03-17  335  
ebb812cb8 Mark Brown       2010-03-17  336  	WARN_ON(jack->registered);
ebb812cb8 Mark Brown       2010-03-17  337  
ebb812cb8 Mark Brown       2010-03-17  338  	if (!keytype || key >= ARRAY_SIZE(jack->key))
ebb812cb8 Mark Brown       2010-03-17  339  		return -EINVAL;
ebb812cb8 Mark Brown       2010-03-17  340  
ebb812cb8 Mark Brown       2010-03-17  341  	jack->type |= type;
ebb812cb8 Mark Brown       2010-03-17  342  	jack->key[key] = keytype;
ebb812cb8 Mark Brown       2010-03-17  343  	return 0;
ebb812cb8 Mark Brown       2010-03-17  344  }
ebb812cb8 Mark Brown       2010-03-17  345  EXPORT_SYMBOL(snd_jack_set_key);
dbe821f46 Takashi Iwai     2016-02-17  346  #endif /* CONFIG_SND_JACK_INPUT_DEV */
ebb812cb8 Mark Brown       2010-03-17  347  
ebb812cb8 Mark Brown       2010-03-17  348  /**
e76d8ceaa Mark Brown       2008-07-28  349   * snd_jack_report - Report the current status of a jack
e76d8ceaa Mark Brown       2008-07-28  350   *
e76d8ceaa Mark Brown       2008-07-28  351   * @jack:   The jack to report status for
e76d8ceaa Mark Brown       2008-07-28  352   * @status: The current status of the jack
e76d8ceaa Mark Brown       2008-07-28  353   */
e76d8ceaa Mark Brown       2008-07-28 @354  void snd_jack_report(struct snd_jack *jack, int status)
e76d8ceaa Mark Brown       2008-07-28  355  {
9058cbe1e Jie Yang         2015-04-27  356  	struct snd_jack_kctl *jack_kctl;
dbe821f46 Takashi Iwai     2016-02-17  357  #ifdef CONFIG_SND_JACK_INPUT_DEV

:::::: The code at line 184 was first introduced by commit
:::::: 9058cbe1eed29381f84dec9f96980f5a4ea1025f ALSA: jack: implement kctl creating for jack devices

:::::: TO: Jie Yang <yang.jie@intel.com>
:::::: CC: Takashi Iwai <tiwai@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27529 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/e0faed33/attachment-0001.obj>
