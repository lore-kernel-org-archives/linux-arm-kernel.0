From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 10:54:46 +0800
Subject: [PATCH v2 04/18] drm/sun4i: tcon-top: Cleanup clock handling
In-Reply-To: <201807110632.6k3QA7Vs%fengguang.wu@intel.com>
References: <20180710203511.18454-5-jernej.skrabec@siol.net>
 <201807110632.6k3QA7Vs%fengguang.wu@intel.com>
Message-ID: <CAGb2v64h4PvgGkn_q7WW5k0mEjv9_bQ40zOK6KK+S3xdpJCzgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 7:20 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Jernej,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on next-20180710]
> [cannot apply to sunxi/sunxi/for-next drm/drm-next robh/for-next v4.18-rc4 v4.18-rc3 v4.18-rc2 v4.18-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Jernej-Skrabec/Allwinner-R40-HDMI-refactoring/20180711-043932
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm64
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/kernel.h:10:0,
>                     from include/linux/list.h:9,
>                     from include/linux/agp_backend.h:33,
>                     from include/drm/drmP.h:35,
>                     from drivers/gpu//drm/sun4i/sun8i_tcon_top.c:4:
>    drivers/gpu//drm/sun4i/sun8i_tcon_top.c: In function 'sun8i_tcon_top_register_gate':
>    include/linux/err.h:22:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
>                                                     ^
>    include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
>     # define unlikely(x) __builtin_expect(!!(x), 0)
>                                              ^
>>> drivers/gpu//drm/sun4i/sun8i_tcon_top.c:56:6: note: in expansion of macro 'IS_ERR_VALUE'
>      if (IS_ERR_VALUE(index))
>          ^~~~~~~~~~~~
>
> vim +/IS_ERR_VALUE +56 drivers/gpu//drm/sun4i/sun8i_tcon_top.c
>
>      3
>    > 4  #include <drm/drmP.h>
>      5
>      6  #include <dt-bindings/clock/sun8i-tcon-top.h>
>      7
>      8  #include <linux/bitfield.h>
>      9  #include <linux/component.h>
>     10  #include <linux/device.h>
>     11  #include <linux/module.h>
>     12  #include <linux/of_graph.h>
>     13  #include <linux/platform_device.h>
>     14
>     15  #include "sun8i_tcon_top.h"
>     16
>     17  static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
>     18                                                int port_id)
>     19  {
>     20          struct device_node *ep, *remote, *port;
>     21          struct of_endpoint endpoint;
>     22
>     23          port = of_graph_get_port_by_id(node, port_id);
>     24          if (!port)
>     25                  return -ENOENT;
>     26
>     27          for_each_available_child_of_node(port, ep) {
>     28                  remote = of_graph_get_remote_port_parent(ep);
>     29                  if (!remote)
>     30                          continue;
>     31
>     32                  if (of_device_is_available(remote)) {
>     33                          of_graph_parse_endpoint(ep, &endpoint);
>     34
>     35                          of_node_put(remote);
>     36
>     37                          return endpoint.id;
>     38                  }
>     39
>     40                  of_node_put(remote);
>     41          }
>     42
>     43          return -ENOENT;
>     44  }
>     45
>     46  static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
>     47                                                     const char *parent,
>     48                                                     void __iomem *regs,
>     49                                                     spinlock_t *lock,
>     50                                                     u8 bit, int name_index)
>     51  {
>     52          const char *clk_name, *parent_name;
>     53          int ret, index;
>     54
>     55          index = of_property_match_string(dev->of_node, "clock-names", parent);
>   > 56          if (IS_ERR_VALUE(index))

Yeah. This is incorrect usage. IS_ERR_VALUE should be used on pointers.
Checking for a negative value here should suffice.

ChenYu

>     57                  return ERR_PTR(index);
>     58
>     59          parent_name = of_clk_get_parent_name(dev->of_node, index);
>     60
>     61          ret = of_property_read_string_index(dev->of_node,
>     62                                              "clock-output-names", name_index,
>     63                                              &clk_name);
>     64          if (ret)
>     65                  return ERR_PTR(ret);
>     66
>     67          return clk_hw_register_gate(dev, clk_name, parent_name,
>     68                                      CLK_SET_RATE_PARENT,
>     69                                      regs + TCON_TOP_GATE_SRC_REG,
>     70                                      bit, 0, lock);
>     71  };
>     72
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
