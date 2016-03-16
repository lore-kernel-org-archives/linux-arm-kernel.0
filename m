From: bert@a20.net (Bert Lindner)
Date: Wed, 16 Mar 2016 12:19:25 +0100
Subject: 4.5.0 on sun7i-a20-olinuxino-lime2: libphy: PHY stmmac-0:ffffffff not
 found (regression from rc7)
Message-ID: <56E9413D.9010902@a20.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Hopefully this is the correct place and way to report this.

For the board sun7i-a20-olinuxino-lime2, there seems to be a problem 
with the eth0 PHY in mainline kernel 4.5.0 that developed since 
4.5.0-rc7. Ethernet does not work, although eth0 is reported:

root at lime2-079f:~# ip a l eth0
2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group 
default qlen 1000
     link/ether 02:c9:05:02:07:9f brd ff:ff:ff:ff:ff:ff

  Difference reported in dmesg:

4.5.0-rc7:
[    9.379279] NET: Registered protocol family 10
[   10.217148]  RX IPC Checksum Offload disabled
[   10.217195]  No MAC Management Counters available
[   10.217627] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   15.206250] sun7i-dwmac 1c50000.ethernet eth0: Link is Up - 
1Gbps/Full - flow control off
[   15.206360] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

4.5.0:
[    9.767125] NET: Registered protocol family 10
[   10.357405] libphy: PHY stmmac-0:ffffffff not found
[   10.362382] eth0: Could not attach to PHY
[   10.366557] stmmac_open: Cannot attach to PHY (error: -19)

.config is identical for both, also after make oldconfig, apart from 
comment with version number. DTB file is also identical between the two 
versions.

Kernels are compiled on the board itself. /proc/version string:
Linux version 4.5.0-rc7 (root at lime2-079f) (gcc version 4.9.1 
(Ubuntu/Linaro 4.9.1-16ubuntu6) ) #1 SMP Mon Mar 7 11:57:25 UTC 2016
Linux version 4.5.0 (root at lime2-079f) (gcc version 4.9.1 (Ubuntu/Linaro 
4.9.1-16ubuntu6) ) #1 SMP Tue Mar 15 11:39:01 UTC 2016

Please let me know if more info is needed, if I should post complete 
.config, test compile with a particular config or patch, etc. Part of 
.config below.

Best,

     -Bert

grep -i 'mac\|eth\|sun[457]' config-4.5.0-rc7
CONFIG_MAC_PARTITION=y
# CONFIG_MACH_SUN4I is not set
# CONFIG_MACH_SUN5I is not set
# CONFIG_MACH_SUN6I is not set
CONFIG_MACH_SUN7I=y
# CONFIG_MACH_SUN8I is not set
# CONFIG_MACH_SUN9I is not set
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
CONFIG_L2TP_ETH=m
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
CONFIG_MAC80211_RC_MINSTREL_VHT=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MACVLAN is not set
# CONFIG_VETH is not set
CONFIG_ETHERNET=y
CONFIG_SUN4I_EMAC=m
# CONFIG_HIX5HD2_GMAC is not set
# CONFIG_HIP04_ETH is not set
# CONFIG_ETHOC is not set
CONFIG_STMMAC_ETH=y
CONFIG_STMMAC_PLATFORM=y
CONFIG_DWMAC_GENERIC=m
CONFIG_DWMAC_IPQ806X=m
CONFIG_DWMAC_LPC18XX=m
CONFIG_DWMAC_MESON=m
CONFIG_DWMAC_ROCKCHIP=m
CONFIG_DWMAC_SOCFPGA=m
CONFIG_DWMAC_STI=m
CONFIG_DWMAC_SUNXI=y
# CONFIG_SYNOPSYS_DWC_ETH_QOS is not set
CONFIG_MDIO_SUN4I=m
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_USB_KAWETH is not set
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
# CONFIG_MAC80211_HWSIM is not set
CONFIG_TOUCHSCREEN_SUN4I=m
CONFIG_SERIO_SUN4I_PS2=y
CONFIG_SPI_SUN4I=y
# CONFIG_PINCTRL_SUN4I_A10 is not set
# CONFIG_PINCTRL_SUN5I_A10S is not set
# CONFIG_PINCTRL_SUN5I_A13 is not set
CONFIG_PINCTRL_SUN7I_A20=y
# CONFIG_FB_MACMODES is not set
# CONFIG_USB_ETH is not set
CONFIG_DMA_SUN4I=y
# CONFIG_DW_DMAC is not set
CONFIG_SUN4I_TIMER=y
CONFIG_SUN5I_HSTIMER=y
CONFIG_PWM_SUN4I=m
CONFIG_PHY_SUN4I_USB=y
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DEV_SUN4I_SS is not set
