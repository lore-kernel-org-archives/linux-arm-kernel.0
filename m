From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 29 Aug 2016 16:57:58 +0800
Subject: [rjarzmik:work/ac97 8/11] sound/arm/pxa2xx-ac97.c:34:34: error:
 passing argument 1 of 'pxa2xx_ac97_try_cold_reset' from incompatible pointer
 type
Message-ID: <201608291653.nZLUVLoU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/ac97
head:   903569ff077d1ea992dfc69d2f3014ce0d10fa99
commit: 5ffdd64ea70a2f6909cb63f8606bdb88455c060c [8/11] ASoC: pxa: switch to new ac97 bus support
config: arm-pcm027_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 5ffdd64ea70a2f6909cb63f8606bdb88455c060c
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   sound/arm/pxa2xx-ac97.c: In function 'pxa2xx_ac97_reset':
>> sound/arm/pxa2xx-ac97.c:34:34: error: passing argument 1 of 'pxa2xx_ac97_try_cold_reset' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (!pxa2xx_ac97_try_cold_reset(ac97)) {
                                     ^
   In file included from sound/arm/pxa2xx-ac97.c:24:0:
   include/sound/pxa2xx-lib.h:31:13: note: expected 'struct ac97_controller *' but argument is of type 'struct snd_ac97 *'
    extern bool pxa2xx_ac97_try_cold_reset(struct ac97_controller *adrv);
                ^
>> sound/arm/pxa2xx-ac97.c:35:30: error: passing argument 1 of 'pxa2xx_ac97_try_warm_reset' from incompatible pointer type [-Werror=incompatible-pointer-types]
      pxa2xx_ac97_try_warm_reset(ac97);
                                 ^
   In file included from sound/arm/pxa2xx-ac97.c:24:0:
   include/sound/pxa2xx-lib.h:30:13: note: expected 'struct ac97_controller *' but argument is of type 'struct snd_ac97 *'
    extern bool pxa2xx_ac97_try_warm_reset(struct ac97_controller *adrv);
                ^
>> sound/arm/pxa2xx-ac97.c:38:27: error: passing argument 1 of 'pxa2xx_ac97_finish_reset' from incompatible pointer type [-Werror=incompatible-pointer-types]
     pxa2xx_ac97_finish_reset(ac97);
                              ^
   In file included from sound/arm/pxa2xx-ac97.c:24:0:
   include/sound/pxa2xx-lib.h:32:13: note: expected 'struct ac97_controller *' but argument is of type 'struct snd_ac97 *'
    extern void pxa2xx_ac97_finish_reset(struct ac97_controller *adrv);
                ^
   sound/arm/pxa2xx-ac97.c: At top level:
>> sound/arm/pxa2xx-ac97.c:42:10: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .read = pxa2xx_ac97_read,
             ^
   sound/arm/pxa2xx-ac97.c:42:10: note: (near initialization for 'pxa2xx_ac97_ops.read')
   sound/arm/pxa2xx-ac97.c:43:11: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .write = pxa2xx_ac97_write,
              ^
   sound/arm/pxa2xx-ac97.c:43:11: note: (near initialization for 'pxa2xx_ac97_ops.write')
   cc1: some warnings being treated as errors

vim +/pxa2xx_ac97_try_cold_reset +34 sound/arm/pxa2xx-ac97.c

a09e64fb Russell King            2008-08-05  28  #include <mach/audio.h>
2c484df0 Takashi Iwai            2005-06-30  29  
2c484df0 Takashi Iwai            2005-06-30  30  #include "pxa2xx-pcm.h"
2c484df0 Takashi Iwai            2005-06-30  31  
d18f8376 Takashi Iwai            2005-11-17  32  static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)
2c484df0 Takashi Iwai            2005-06-30  33  {
9c636342 Dmitry Eremin-Solenikov 2008-09-10 @34  	if (!pxa2xx_ac97_try_cold_reset(ac97)) {
9c636342 Dmitry Eremin-Solenikov 2008-09-10 @35  		pxa2xx_ac97_try_warm_reset(ac97);
2c484df0 Takashi Iwai            2005-06-30  36  	}
2c484df0 Takashi Iwai            2005-06-30  37  
9c636342 Dmitry Eremin-Solenikov 2008-09-10 @38  	pxa2xx_ac97_finish_reset(ac97);
2c484df0 Takashi Iwai            2005-06-30  39  }
2c484df0 Takashi Iwai            2005-06-30  40  
d18f8376 Takashi Iwai            2005-11-17  41  static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
2c484df0 Takashi Iwai            2005-06-30 @42  	.read	= pxa2xx_ac97_read,
2c484df0 Takashi Iwai            2005-06-30  43  	.write	= pxa2xx_ac97_write,
2c484df0 Takashi Iwai            2005-06-30  44  	.reset	= pxa2xx_ac97_reset,
2c484df0 Takashi Iwai            2005-06-30  45  };

:::::: The code at line 34 was first introduced by commit
:::::: 9c63634221f67450ead19820e33996b69691194f ALSA: Separate common pxa2xx-ac97 code

:::::: TO: Dmitry Baryshkov <dbaryshkov@gmail.com>
:::::: CC: Jaroslav Kysela <perex@perex.cz>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 14073 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/436956b3/attachment-0001.obj>
