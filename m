From: lkp@intel.com (kbuild test robot)
Date: Fri, 7 Sep 2018 12:48:13 +0800
Subject: [PATCH 05/13] nvmem: change the signature of nvmem_unregister()
In-Reply-To: <20180905095738.26406-6-brgl@bgdev.pl>
References: <20180905095738.26406-6-brgl@bgdev.pl>
Message-ID: <201809071258.0YDrDxfq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc2 next-20180906]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/nvmem-rework-of-the-subsystem-for-non-DT-users/20180907-112400
config: i386-randconfig-s3-09061342 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/rtc.h:18:0,
                    from include/linux/efi.h:20,
                    from drivers//char/tpm/eventlog/tpm1.c:24:
   include/linux/nvmem-provider.h: In function 'nvmem_unregister':
>> include/linux/nvmem-provider.h:86:9: warning: 'return' with a value, in function returning void
     return -ENOSYS;
            ^
   include/linux/nvmem-provider.h:84:20: note: declared here
    static inline void nvmem_unregister(struct nvmem_device *nvmem)
                       ^~~~~~~~~~~~~~~~
   include/linux/nvmem-provider.h: In function 'devm_nvmem_unregister':
>> include/linux/nvmem-provider.h:98:9: error: void value not ignored as it ought to be
     return nvmem_unregister(nvmem);
            ^~~~~~~~~~~~~~~~~~~~~~~

vim +98 include/linux/nvmem-provider.h

eace75cf Srinivas Kandagatla 2015-07-27  83  
fd7df99e Bartosz Golaszewski 2018-09-05  84  static inline void nvmem_unregister(struct nvmem_device *nvmem)
eace75cf Srinivas Kandagatla 2015-07-27  85  {
eace75cf Srinivas Kandagatla 2015-07-27 @86  	return -ENOSYS;
eace75cf Srinivas Kandagatla 2015-07-27  87  }
eace75cf Srinivas Kandagatla 2015-07-27  88  
f1f50eca Andrey Smirnov      2018-03-09  89  static inline struct nvmem_device *
f1f50eca Andrey Smirnov      2018-03-09  90  devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
f1f50eca Andrey Smirnov      2018-03-09  91  {
f1f50eca Andrey Smirnov      2018-03-09  92  	return nvmem_register(c);
f1f50eca Andrey Smirnov      2018-03-09  93  }
f1f50eca Andrey Smirnov      2018-03-09  94  
f1f50eca Andrey Smirnov      2018-03-09  95  static inline int
f1f50eca Andrey Smirnov      2018-03-09  96  devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
f1f50eca Andrey Smirnov      2018-03-09  97  {
f1f50eca Andrey Smirnov      2018-03-09 @98  	return nvmem_unregister(nvmem);
b3db17e4 Andrew Lunn         2018-05-11  99  

:::::: The code at line 98 was first introduced by commit
:::::: f1f50eca5f90527d2cca3479cda08883958777f6 nvmem: Introduce devm_nvmem_(un)register()

:::::: TO: Andrey Smirnov <andrew.smirnov@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27032 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/f9aef0bc/attachment-0001.gz>
