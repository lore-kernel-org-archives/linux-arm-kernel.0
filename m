From: lkp@intel.com (kbuild test robot)
Date: Fri, 21 Sep 2018 14:29:22 +0800
Subject: [PATCH v2 2/7] mfd: Add ST Multi-Function eXpander (STMFX) core
 driver
In-Reply-To: <1537363669-25991-3-git-send-email-amelie.delaunay@st.com>
References: <1537363669-25991-3-git-send-email-amelie.delaunay@st.com>
Message-ID: <201809211450.iSGhRxSU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amelie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ljones-mfd/for-mfd-next]
[also build test WARNING on v4.19-rc4 next-20180920]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Amelie-Delaunay/dt-bindings-mfd-Add-ST-Multi-Function-eXpander-STMFX-core-bindings/20180920-185854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/mfd/stmfx.c: In function 'stmfx_function_enable':
>> drivers/mfd/stmfx.c:103:8: warning: 'mask' may be used uninitialized in this function [-Wmaybe-uninitialized]
      mask |= STMFX_REG_SYS_CTRL_GPIO_EN;
   drivers/mfd/stmfx.c:100:5: note: 'mask' was declared here
     u8 mask;
        ^~~~
   drivers/mfd/stmfx.c: In function 'stmfx_function_disable':
>> drivers/mfd/stmfx.c:103:8: warning: 'mask' may be used uninitialized in this function [-Wmaybe-uninitialized]
      mask |= STMFX_REG_SYS_CTRL_GPIO_EN;
   drivers/mfd/stmfx.c:100:5: note: 'mask' was declared here
     u8 mask;
        ^~~~

vim +/mask +103 drivers/mfd/stmfx.c

    97	
    98	static u8 stmfx_func_to_mask(u32 func)
    99	{
   100		u8 mask;
   101	
   102		if (func & STMFX_FUNC_GPIO)
 > 103			mask |= STMFX_REG_SYS_CTRL_GPIO_EN;
   104	
   105		if ((func & STMFX_FUNC_ALTGPIO_LOW) || (func & STMFX_FUNC_ALTGPIO_HIGH))
   106			mask |= STMFX_REG_SYS_CTRL_ALTGPIO_EN;
   107	
   108		if (func & STMFX_FUNC_TS)
   109			mask |= STMFX_REG_SYS_CTRL_TS_EN;
   110	
   111		if (func & STMFX_FUNC_IDD)
   112			mask |= STMFX_REG_SYS_CTRL_IDD_EN;
   113	
   114		return mask;
   115	}
   116	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65161 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/0317e9ad/attachment-0001.gz>
