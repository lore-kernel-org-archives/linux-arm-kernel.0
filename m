From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 10 Dec 2016 09:41:19 +0800
Subject: [arm:mcbin 32/52]
 drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_ethtool.c:171:32: warning:
 integer overflow in expression
Message-ID: <201612100917.24i3oIB2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git mcbin
head:   9c14c9238518271b6f94c9d5a0210ae9154ec27b
commit: 56413dbd2c3aa08a1e3f0cfd66c539227278e7d2 [32/52] net: marvell: add mvpp2x driver
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 56413dbd2c3aa08a1e3f0cfd66c539227278e7d2
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:13:0,
                    from drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_ethtool.c:19:
   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_ethtool.c: In function 'mv_pp2x_ethtool_valid_coalesce':
>> drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_ethtool.c:171:32: warning: integer overflow in expression [-Woverflow]
       (MVPP2_MAX_ISR_RX_THRESHOLD * USEC_PER_SEC)
                                   ^
   include/linux/printk.h:277:33: note: in definition of macro 'pr_err'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                    ^~~~~~~~~~~
   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_ethtool.c:177:33: warning: integer overflow in expression [-Woverflow]
       (MVPP22_MAX_ISR_TX_THRESHOLD * USEC_PER_SEC)
                                    ^
   include/linux/printk.h:277:33: note: in definition of macro 'pr_err'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                    ^~~~~~~~~~~
   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_ethtool.c:180:33: warning: integer overflow in expression [-Woverflow]
       (MVPP22_MAX_ISR_TX_THRESHOLD * USEC_PER_SEC)
                                    ^
--
   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_hw.c: In function 'mv_pp2x_rx_time_coal_set':
>> drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_hw.c:3486:48: warning: integer overflow in expression [-Woverflow]
      rxq->time_coal = (MVPP2_MAX_ISR_RX_THRESHOLD *
                                                   ^
--
   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c: In function 'mv_pp2x_bm_pools_init':
   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c:510:2: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
     for (i = i - 1; i >= 0; i--)
     ^~~
   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c:512:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'for'
      return err;
      ^~~~~~
   drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c: In function 'mv_pp2x_buff_hdr_rx':
>> drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_main.c:2265:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      skb = (struct sk_buff *)(u64)buff_virt_addr;
            ^

vim +171 drivers/net/ethernet/marvell/mvpp2x/mv_pp2x_ethtool.c

    13	*
    14	* You should have received a copy of the GNU General Public License
    15	* along with this program.  If not, see <http://www.gnu.org/licenses/>.
    16	* ***************************************************************************
    17	*/
    18	
  > 19	#include <linux/kernel.h>
    20	#include <linux/netdevice.h>
    21	#include <linux/etherdevice.h>
    22	#include <linux/platform_device.h>
    23	#include <linux/skbuff.h>
    24	#include <linux/inetdevice.h>
    25	#include <linux/mbus.h>
    26	#include <linux/module.h>
    27	#include <linux/interrupt.h>
    28	#include <linux/cpumask.h>
    29	#include <linux/version.h>
    30	#include <linux/of.h>
    31	#include <linux/of_irq.h>
    32	#include <linux/of_mdio.h>
    33	#include <linux/of_net.h>
    34	#include <linux/of_address.h>
    35	#include <linux/phy.h>
    36	#include <linux/clk.h>
    37	#include <uapi/linux/ppp_defs.h>
    38	#include <net/ip.h>
    39	#include <net/ipv6.h>
    40	#include <linux/phy/phy.h>
    41	#ifdef CONFIG_PHY_MVEBU_COMPHY
    42	#include <dt-bindings/phy/phy-mvebu-comphy.h>
    43	#endif
    44	
    45	#include "mv_pp2x.h"
    46	#include "mv_pp2x_hw.h"
    47	#include "mv_gop110_hw.h"
    48	
    49	#define MV_PP2_STATS_LEN	ARRAY_SIZE(mv_pp2x_gstrings_stats)
    50	#define MV_PP2_TEST_LEN		ARRAY_SIZE(mv_pp2x_gstrings_test)
    51	#define MV_PP2_REGS_GMAC_LEN	54
    52	#define MV_PP2_REGS_XLG_LEN	25
    53	#define MV_PP2_TEST_MASK1	0xFFFF
    54	#define MV_PP2_TEST_MASK2	0x00FE
    55	#define MV_PP2_TEST_MASK3	0x0
    56	#define MV_PP2_TEST_PATTERN1	0xFFFF
    57	#define MV_PP2_TEST_PATTERN2	0x00FE
    58	#define MV_PP2_TEST_PATTERN3	0x0
    59	
    60	static const char mv_pp2x_gstrings_test[][ETH_GSTRING_LEN] = {
    61		"Link test        (on/offline)",
    62		"register test    (on/offline)",
    63	};
    64	
    65	static const char mv_pp2x_gstrings_stats[][ETH_GSTRING_LEN] = {
    66		/* device-specific stats */
    67		"rx_bytes", "rx_frames", "rx_unicast", "rx_mcast", "rx_bcast",
    68		"tx_bytes", "tx_frames", "tx_unicast", "tx_mcast", "tx_bcast",
    69		"rx_pause", "tx_pause", "rx_overrun", "rx_crc", "rx_runt", "rx_giant",
    70		"rx_fragments_err", "rx_mac_err", "rx_jabber", "rx_sw_drop", "rx_total_err",
    71		"tx_drop", "tx_crc_sent", "collision", "late_collision",
    72	};
    73	
    74	static int mv_pp2x_check_speed_duplex_valid(struct ethtool_cmd *cmd,
    75						struct mv_port_link_status *pstatus)
    76	{
    77		switch (cmd->duplex) {
    78		case DUPLEX_FULL:
    79			pstatus->duplex = MV_PORT_DUPLEX_FULL;
    80			break;
    81		case DUPLEX_HALF:
    82			pstatus->duplex = MV_PORT_DUPLEX_HALF;
    83			break;
    84		case DUPLEX_UNKNOWN:
    85			if (cmd->speed == SPEED_1000)
    86				pstatus->duplex = MV_PORT_DUPLEX_FULL;
    87			else {
    88				pstatus->duplex = MV_PORT_DUPLEX_FULL;
    89				pr_err("Unknown duplex configuration, full duplex set\n");
    90			}
    91			break;
    92		default:
    93			pr_err("Wrong duplex configuration\n");
    94			return -1;
    95		}
    96	
    97		switch (cmd->speed) {
    98		case SPEED_100:
    99			pstatus->speed = MV_PORT_SPEED_100;
   100			return 0;
   101		case SPEED_10:
   102			pstatus->speed = MV_PORT_SPEED_10;
   103			return 0;
   104		case SPEED_1000:
   105			pstatus->speed = MV_PORT_SPEED_1000;
   106			if (cmd->duplex)
   107				return 0;
   108			pr_err("1G port doesn't support half duplex\n");
   109			return -1;
   110		default:
   111			pr_err("Wrong speed configuration\n");
   112			return -1;
   113		}
   114	}
   115	
   116	static int mv_pp2x_autoneg_gmac_check_valid(struct mv_mac_data *mac, struct gop_hw *gop,
   117				struct ethtool_cmd *cmd, struct mv_port_link_status *pstatus)
   118	{
   119	
   120		int port_num = mac->gop_index;
   121		int err;
   122	
   123		err = mv_gop110_check_port_type(gop, port_num);
   124		if (err) {
   125			if (cmd->autoneg) {
   126				pr_err("GOP %d set to 1000Base-X and doesn't support autonegotiation\n", port_num);
   127				return -EINVAL;
   128			}
   129			return 0;
   130		}
   131		if (!cmd->autoneg) {
   132			err = mv_pp2x_check_speed_duplex_valid(cmd, pstatus);
   133			if (err)
   134				return -EINVAL;
   135		}
   136	
   137		return 0;
   138	}
   139	
   140	static int mv_pp2x_autoneg_xlg_check_valid(struct mv_mac_data *mac, struct ethtool_cmd *cmd)
   141	{
   142	
   143		int port_num = mac->gop_index;
   144	
   145		if (cmd->autoneg) {
   146			pr_err("XLG GOP %d doesn't support autonegotiation\n", port_num);
   147			return -EINVAL;
   148		}
   149	
   150		return 0;
   151	}
   152	
   153	void mv_pp2x_ethtool_valid_coalesce(struct ethtool_coalesce *c,
   154					struct mv_pp2x_port *port)
   155	{
   156		u64 val;
   157	
   158		if (c->rx_max_coalesced_frames > MVPP2_MAX_OCCUPIED_THRESH)
   159			pr_err("RX coalesced frames value too high, rounded to %d\n",
   160				MVPP2_MAX_OCCUPIED_THRESH);
   161	
   162		if (c->tx_max_coalesced_frames > MVPP2_MAX_TRANSMITTED_THRESH) {
   163			pr_err("TX coalesced frames value too high, rounded to %d\n",
   164				MVPP2_MAX_TRANSMITTED_THRESH);
   165			c->tx_max_coalesced_frames = MVPP2_MAX_TRANSMITTED_THRESH;
   166		}
   167	
   168		val = (port->priv->hw.tclk / USEC_PER_SEC) * c->rx_coalesce_usecs;
   169		if (val > MVPP2_MAX_ISR_RX_THRESHOLD)
   170			pr_err("RX coalesced time value too high, rounded to %ld usecs\n",
 > 171				(MVPP2_MAX_ISR_RX_THRESHOLD * USEC_PER_SEC)
   172				/ port->priv->hw.tclk);
   173	
   174		val = (port->priv->hw.tclk / USEC_PER_SEC) * c->tx_coalesce_usecs;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59440 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161210/90e95cf0/attachment-0001.gz>
