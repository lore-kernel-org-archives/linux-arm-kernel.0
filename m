From: lkp@intel.com (kbuild test robot)
Date: Wed, 14 Jun 2017 09:57:04 +0800
Subject: [PATCH v2 3/4] phy: usb: phy-brcm-usb: Add Broadcom STB USB phy
 driver
In-Reply-To: <1497365721-31188-4-git-send-email-al.cooper@broadcom.com>
Message-ID: <201706140920.gV3HAiz4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

[auto build test ERROR on phy/next]
[also build test ERROR on next-20170613]
[cannot apply to linus/master v4.12-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Al-Cooper/Add-Broadcom-STB-USB-phy-driver/20170614-070044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All error/warnings (new ones prefixed by >>):

   drivers/phy//broadcom/phy-brcm-usb-init.c: In function 'brcmusb_usb_phy_ldo_fix':
>> drivers/phy//broadcom/phy-brcm-usb-init.c:139:49: error: 'USB_CTRL_0xFFC00000' undeclared (first use in this function)
    #define USB_CTRL_REG(base, reg) ((void *)base + USB_CTRL_##reg)
                                                    ^
>> drivers/phy//broadcom/phy-brcm-usb-init.c:157:31: note: in expansion of macro 'USB_CTRL_REG'
     brcmusb_writel(brcmusb_readl(USB_CTRL_REG(base, reg)) &  \
                                  ^~~~~~~~~~~~
>> drivers/phy//broadcom/phy-brcm-usb-init.c:569:2: note: in expansion of macro 'USB_CTRL_UNSET'
     USB_CTRL_UNSET(ctrl_base, PLL_CTL, PLL_RESETB);
     ^~~~~~~~~~~~~~
   drivers/phy//broadcom/phy-brcm-usb-init.c:139:49: note: each undeclared identifier is reported only once for each function it appears in
    #define USB_CTRL_REG(base, reg) ((void *)base + USB_CTRL_##reg)
                                                    ^
>> drivers/phy//broadcom/phy-brcm-usb-init.c:157:31: note: in expansion of macro 'USB_CTRL_REG'
     brcmusb_writel(brcmusb_readl(USB_CTRL_REG(base, reg)) &  \
                                  ^~~~~~~~~~~~
>> drivers/phy//broadcom/phy-brcm-usb-init.c:569:2: note: in expansion of macro 'USB_CTRL_UNSET'
     USB_CTRL_UNSET(ctrl_base, PLL_CTL, PLL_RESETB);
     ^~~~~~~~~~~~~~
   drivers/phy//broadcom/phy-brcm-usb-init.c: In function 'brcmusb_init_common':
>> drivers/phy//broadcom/phy-brcm-usb-init.c:139:49: error: 'USB_CTRL_0xFFC00000' undeclared (first use in this function)
    #define USB_CTRL_REG(base, reg) ((void *)base + USB_CTRL_##reg)
                                                    ^
   drivers/phy//broadcom/phy-brcm-usb-init.c:154:31: note: in expansion of macro 'USB_CTRL_REG'
     brcmusb_writel(brcmusb_readl(USB_CTRL_REG(base, reg)) |  \
                                  ^~~~~~~~~~~~
>> drivers/phy//broadcom/phy-brcm-usb-init.c:962:2: note: in expansion of macro 'USB_CTRL_SET'
     USB_CTRL_SET(ctrl, PLL_CTL, PLL_SUSPEND_EN);
     ^~~~~~~~~~~~
   drivers/phy//broadcom/phy-brcm-usb-init.c: In function 'brcmusb_init_common_mips':
>> drivers/phy//broadcom/phy-brcm-usb-init.c:139:49: error: 'USB_CTRL_0xFFC00000' undeclared (first use in this function)
    #define USB_CTRL_REG(base, reg) ((void *)base + USB_CTRL_##reg)
                                                    ^
   drivers/phy//broadcom/phy-brcm-usb-init.c:154:31: note: in expansion of macro 'USB_CTRL_REG'
     brcmusb_writel(brcmusb_readl(USB_CTRL_REG(base, reg)) |  \
                                  ^~~~~~~~~~~~
   drivers/phy//broadcom/phy-brcm-usb-init.c:1097:2: note: in expansion of macro 'USB_CTRL_SET'
     USB_CTRL_SET(ctrl, PLL_CTL, PLL_SUSPEND_EN);
     ^~~~~~~~~~~~

vim +/USB_CTRL_REG +157 drivers/phy//broadcom/phy-brcm-usb-init.c

   133		USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_SELECTOR,
   134		USB_CTRL_USB_PM_USB20_HC_RESETB_SELECTOR,
   135		USB_CTRL_SETUP_ENDIAN_SELECTOR,
   136		USB_CTRL_SELECTOR_COUNT,
   137	};
   138	
 > 139	#define USB_CTRL_REG(base, reg)	((void *)base + USB_CTRL_##reg)
   140	#define USB_XHCI_EC_REG(base, reg) ((void *)base + USB_XHCI_EC_##reg)
   141	#define USB_CTRL_MASK(reg, field) \
   142		USB_CTRL_##reg##_##field##_MASK
   143	#define USB_CTRL_MASK_FAMILY(params, reg, field)			\
   144		(params->usb_reg_bits_map[USB_CTRL_##reg##_##field##_SELECTOR])
   145	
   146	#define USB_CTRL_SET_FAMILY(params, reg, field)	\
   147		usb_ctrl_set_family(params, USB_CTRL_##reg,	\
   148				USB_CTRL_##reg##_##field##_SELECTOR)
   149	#define USB_CTRL_UNSET_FAMILY(params, reg, field)	\
   150		usb_ctrl_unset_family(params, USB_CTRL_##reg,	\
   151			USB_CTRL_##reg##_##field##_SELECTOR)
   152	
   153	#define USB_CTRL_SET(base, reg, field)	\
   154		brcmusb_writel(brcmusb_readl(USB_CTRL_REG(base, reg)) |		\
   155			USB_CTRL_##reg##_##field##_MASK, USB_CTRL_REG(base, reg))
   156	#define USB_CTRL_UNSET(base, reg, field)	\
 > 157		brcmusb_writel(brcmusb_readl(USB_CTRL_REG(base, reg)) &		\
   158			~USB_CTRL_##reg##_##field##_MASK, USB_CTRL_REG(base, reg))
   159	
   160	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44856 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/cc70bbad/attachment-0001.gz>
