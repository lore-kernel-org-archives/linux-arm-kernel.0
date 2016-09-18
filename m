From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Sep 2016 01:27:27 +0800
Subject: [PATCH] ASoC: samsung: make audio interface/controller explicitly
In-Reply-To: <1474207751-9804-2-git-send-email-ayaka@soulik.info>
Message-ID: <201609190119.wK4Of0VL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on v4.8-rc6 next-20160916]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Randy-Li/ASoC-samsung-make-audio-interface-controller-explicitly/20160918-222618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: parisc-allmodconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All error/warnings (new ones prefixed by >>):

>> sound/soc/samsung/i2s.c:106:26: error: field 'clk_data' has incomplete type
     struct clk_onecell_data clk_data;
                             ^~~~~~~~
   sound/soc/samsung/i2s.c: In function 'i2s_unregister_clocks':
>> sound/soc/samsung/i2s.c:1141:4: error: implicit declaration of function 'clk_unregister' [-Werror=implicit-function-declaration]
       clk_unregister(i2s->clk_table[i]);
       ^~~~~~~~~~~~~~
   sound/soc/samsung/i2s.c: In function 'i2s_unregister_clock_provider':
>> sound/soc/samsung/i2s.c:1149:2: error: implicit declaration of function 'of_clk_del_provider' [-Werror=implicit-function-declaration]
     of_clk_del_provider(pdev->dev.of_node);
     ^~~~~~~~~~~~~~~~~~~
   sound/soc/samsung/i2s.c: In function 'i2s_register_clock_provider':
>> sound/soc/samsung/i2s.c:1172:16: error: implicit declaration of function '__clk_get_name' [-Werror=implicit-function-declaration]
      p_names[i] = __clk_get_name(rclksrc);
                   ^~~~~~~~~~~~~~
>> sound/soc/samsung/i2s.c:1172:14: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      p_names[i] = __clk_get_name(rclksrc);
                 ^
>> sound/soc/samsung/i2s.c:1181:38: error: implicit declaration of function 'clk_register_mux' [-Werror=implicit-function-declaration]
      i2s->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(NULL,
                                         ^~~~~~~~~~~~~~~~
>> sound/soc/samsung/i2s.c:1183:5: error: 'CLK_SET_RATE_NO_REPARENT' undeclared (first use in this function)
        CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
        ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/samsung/i2s.c:1183:5: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/samsung/i2s.c:1183:32: error: 'CLK_SET_RATE_PARENT' undeclared (first use in this function)
        CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
                                   ^~~~~~~~~~~~~~~~~~~
>> sound/soc/samsung/i2s.c:1187:38: error: implicit declaration of function 'clk_register_divider' [-Werror=implicit-function-declaration]
      i2s->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(NULL,
                                         ^~~~~~~~~~~~~~~~~~~~
>> sound/soc/samsung/i2s.c:1198:34: error: implicit declaration of function 'clk_register_gate' [-Werror=implicit-function-declaration]
     i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(NULL, clk_name[0],
                                     ^~~~~~~~~~~~~~~~~
>> sound/soc/samsung/i2s.c:1201:5: error: 'CLK_GATE_SET_TO_DISABLE' undeclared (first use in this function)
        CLK_GATE_SET_TO_DISABLE, i2s->lock);
        ^~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/samsung/i2s.c:1206:8: error: implicit declaration of function 'of_clk_add_provider' [-Werror=implicit-function-declaration]
     ret = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
           ^~~~~~~~~~~~~~~~~~~
>> sound/soc/samsung/i2s.c:1206:42: error: 'of_clk_src_onecell_get' undeclared (first use in this function)
     ret = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
                                             ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/clk_data +106 sound/soc/samsung/i2s.c

69e7a69a2 sound/soc/samsung/i2s.c Sylwester Nawrocki 2016-08-04   90  	struct snd_dmaengine_dai_dma_data dma_playback;
69e7a69a2 sound/soc/samsung/i2s.c Sylwester Nawrocki 2016-08-04   91  	struct snd_dmaengine_dai_dma_data dma_capture;
69e7a69a2 sound/soc/samsung/i2s.c Sylwester Nawrocki 2016-08-04   92  	struct snd_dmaengine_dai_dma_data idma_playback;
9bdca822c sound/soc/samsung/i2s.c Arnd Bergmann      2015-11-18   93  	dma_filter_fn filter;
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22   94  	u32	quirks;
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22   95  	u32	suspend_i2smod;
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22   96  	u32	suspend_i2scon;
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22   97  	u32	suspend_i2spsr;
a5a56871f sound/soc/samsung/i2s.c Padmavathi Venna   2014-11-07   98  	const struct samsung_i2s_variant_regs *variant_regs;
f36705366 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14   99  
f36705366 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14  100  	/* Spinlock protecting access to the device's registers */
f36705366 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14  101  	spinlock_t spinlock;
f36705366 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14  102  	spinlock_t *lock;
074b89bb5 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14  103  
074b89bb5 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14  104  	/* Below fields are only valid if this is the primary FIFO */
074b89bb5 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14  105  	struct clk *clk_table[3];
074b89bb5 sound/soc/samsung/i2s.c Sylwester Nawrocki 2015-01-14 @106  	struct clk_onecell_data clk_data;
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  107  };
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  108  
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  109  /* Lock for cross i/f checks */
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  110  static DEFINE_SPINLOCK(lock);
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  111  
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  112  /* If this is the 'overlay' stereo DAI */
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  113  static inline bool is_secondary(struct i2s_dai *i2s)
1c7ac0180 sound/soc/s3c24xx/i2s.c Jassi Brar         2010-11-22  114  {

:::::: The code at line 106 was first introduced by commit
:::::: 074b89bb5fb7e80e0f98f1b45f276b0386269e3d ASoC: samsung: i2s: Add clock provider for the I2S internal clocks

:::::: TO: Sylwester Nawrocki <s.nawrocki@samsung.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46238 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/baaa6098/attachment-0001.gz>
