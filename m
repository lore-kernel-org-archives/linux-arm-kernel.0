From: davem@davemloft.net (David Miller)
Date: Wed, 10 Jan 2018 15:43:22 -0500 (EST)
Subject: [PATCH net-next 2/2 v10] net: ethernet: Add a driver for
 Gemini gigabit ethernet
In-Reply-To: <20180110.154113.1759667248487481665.davem@davemloft.net>
References: <20180109221053.927-1-linus.walleij@linaro.org>
 <20180109221053.927-2-linus.walleij@linaro.org>
 <20180110.154113.1759667248487481665.davem@davemloft.net>
Message-ID: <20180110.154322.2235369645563224203.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Actually I had to revert these two patches, this stuff doesn't even
build.

[davem at dhcp-10-15-49-227 net-next]$ make -s -j16
In file included from ./include/linux/printk.h:329:0,
                 from ./include/linux/kernel.h:14,
                 from ./include/linux/list.h:9,
                 from ./include/linux/module.h:9,
                 from drivers/net/ethernet/cortina/gemini.c:16:
drivers/net/ethernet/cortina/gemini.c: In function ?geth_freeq_alloc_map_page?:
drivers/net/ethernet/cortina/gemini.c:821:21: warning: format ?%x? expects argument of type ?unsigned int?, but argument 5 has type ?dma_addr_t {aka long long unsigned int}? [-Wformat=]
  dev_dbg(geth->dev, "page %d, DMA addr: %08x, page %p\n",
                     ^
./include/linux/dynamic_debug.h:135:39: note: in definition of macro ?dynamic_dev_dbg?
   __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                       ^~~
drivers/net/ethernet/cortina/gemini.c:821:2: note: in expansion of macro ?dev_dbg?
  dev_dbg(geth->dev, "page %d, DMA addr: %08x, page %p\n",
  ^~~~~~~
drivers/net/ethernet/cortina/gemini.c: In function ?gmac_rx?:
drivers/net/ethernet/cortina/gemini.c:1410:50: warning: format ?%x? expects argument of type ?unsigned int?, but argument 3 has type ?dma_addr_t {aka long long unsigned int}? [-Wformat=]
    dev_err(geth->dev, "could not find mapping %08x (page = %08x, page off = %08x)\n",
                                               ~~~^
                                               %08llx
drivers/net/ethernet/cortina/gemini.c:1410:63: warning: format ?%x? expects argument of type ?unsigned int?, but argument 4 has type ?long long unsigned int? [-Wformat=]
    dev_err(geth->dev, "could not find mapping %08x (page = %08x, page off = %08x)\n",
                                                            ~~~^
                                                            %08llx
drivers/net/ethernet/cortina/gemini.c: In function ?gemini_ethernet_port_probe?:
drivers/net/ethernet/cortina/gemini.c:2456:28: warning: format ?%x? expects argument of type ?unsigned int?, but argument 4 has type ?resource_size_t {aka long long unsigned int}? [-Wformat=]
        "irq %d, DMA @ 0x%08x, GMAC @ 0x%08x\n",
                         ~~~^
                         %08llx
        port->irq, dmares->start,
                   ~~~~~~~~~~~~~
drivers/net/ethernet/cortina/gemini.c:2456:43: warning: format ?%x? expects argument of type ?unsigned int?, but argument 5 has type ?resource_size_t {aka long long unsigned int}? [-Wformat=]
        "irq %d, DMA @ 0x%08x, GMAC @ 0x%08x\n",
                                        ~~~^
                                        %08llx
drivers/net/ethernet/cortina/gemini.c:2458:8:
        gmacres->start);
        ~~~~~~~~~~~~~~                      
In file included from drivers/net/ethernet/cortina/gemini.c:16:0:
drivers/net/ethernet/cortina/gemini.c: At top level:
./include/linux/module.h:129:42: error: redefinition of ?__inittest?
  static inline initcall_t __maybe_unused __inittest(void)  \
                                          ^
./include/linux/device.h:1513:1: note: in expansion of macro ?module_init?
 module_init(__driver##_init); \
 ^~~~~~~~~~~
./include/linux/platform_device.h:228:2: note: in expansion of macro ?module_driver?
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro ?module_platform_driver?
 module_platform_driver(gemini_ethernet_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:129:42: note: previous definition of ?__inittest? was here
  static inline initcall_t __maybe_unused __inittest(void)  \
                                          ^
./include/linux/device.h:1513:1: note: in expansion of macro ?module_init?
 module_init(__driver##_init); \
 ^~~~~~~~~~~
./include/linux/platform_device.h:228:2: note: in expansion of macro ?module_driver?
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro ?module_platform_driver?
 module_platform_driver(gemini_ethernet_port_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:131:6: error: redefinition of ?init_module?
  int init_module(void) __attribute__((alias(#initfn)));
      ^
./include/linux/device.h:1513:1: note: in expansion of macro ?module_init?
 module_init(__driver##_init); \
 ^~~~~~~~~~~
./include/linux/platform_device.h:228:2: note: in expansion of macro ?module_driver?
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro ?module_platform_driver?
 module_platform_driver(gemini_ethernet_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:131:6: note: previous definition of ?init_module? was here
  int init_module(void) __attribute__((alias(#initfn)));
      ^
./include/linux/device.h:1513:1: note: in expansion of macro ?module_init?
 module_init(__driver##_init); \
 ^~~~~~~~~~~
./include/linux/platform_device.h:228:2: note: in expansion of macro ?module_driver?
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro ?module_platform_driver?
 module_platform_driver(gemini_ethernet_port_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:135:42: error: redefinition of ?__exittest?
  static inline exitcall_t __maybe_unused __exittest(void)  \
                                          ^
./include/linux/device.h:1518:1: note: in expansion of macro ?module_exit?
 module_exit(__driver##_exit);
 ^~~~~~~~~~~
./include/linux/platform_device.h:228:2: note: in expansion of macro ?module_driver?
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro ?module_platform_driver?
 module_platform_driver(gemini_ethernet_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:135:42: note: previous definition of ?__exittest? was here
  static inline exitcall_t __maybe_unused __exittest(void)  \
                                          ^
./include/linux/device.h:1518:1: note: in expansion of macro ?module_exit?
 module_exit(__driver##_exit);
 ^~~~~~~~~~~
./include/linux/platform_device.h:228:2: note: in expansion of macro ?module_driver?
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro ?module_platform_driver?
 module_platform_driver(gemini_ethernet_port_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:137:7: error: redefinition of ?cleanup_module?
  void cleanup_module(void) __attribute__((alias(#exitfn)));
       ^
./include/linux/device.h:1518:1: note: in expansion of macro ?module_exit?
 module_exit(__driver##_exit);
 ^~~~~~~~~~~
./include/linux/platform_device.h:228:2: note: in expansion of macro ?module_driver?
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro ?module_platform_driver?
 module_platform_driver(gemini_ethernet_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/module.h:137:7: note: previous definition of ?cleanup_module? was here
  void cleanup_module(void) __attribute__((alias(#exitfn)));
       ^
./include/linux/device.h:1518:1: note: in expansion of macro ?module_exit?
 module_exit(__driver##_exit);
 ^~~~~~~~~~~
./include/linux/platform_device.h:228:2: note: in expansion of macro ?module_driver?
  module_driver(__platform_driver, platform_driver_register, \
  ^~~~~~~~~~~~~
drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro ?module_platform_driver?
 module_platform_driver(gemini_ethernet_port_driver);
 ^~~~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:317: drivers/net/ethernet/cortina/gemini.o] Error 1
make[3]: *** [scripts/Makefile.build:569: drivers/net/ethernet/cortina] Error 2
make[3]: *** Waiting for unfinished jobs....
