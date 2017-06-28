From: lkp@intel.com (kbuild test robot)
Date: Thu, 29 Jun 2017 06:06:47 +0800
Subject: [PATCH v5] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <20170627143652.13075-1-net147@gmail.com>
Message-ID: <201706290511.fnS8VkKo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

[auto build test WARNING on next-20170627]
[cannot apply to v4.12-rc7 v4.12-rc6 v4.12-rc5 v4.12-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jonathan-Liu/drm-sun4i-hdmi-Implement-I2C-adapter-for-A10s-DDC-bus/20170629-001335
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c: In function 'fifo_transfer':
>> drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c:65:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     int level = (int)(fifo_status & SUN4I_HDMI_DDC_FIFO_STATUS_LEVEL_MASK);
     ^~~

vim +65 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c

    49		int ret;
    50	
    51		/* Wait until error or FIFO ready */
    52		ret = readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG,
    53					 int_status,
    54					 is_err_status(int_status) ||
    55					 is_fifo_flag_unset(hdmi, &fifo_status, flag),
    56					 min(len, SUN4I_HDMI_DDC_FIFO_SIZE) * byte_time,
    57					 100000);
    58	
    59		if (is_err_status(int_status))
    60			return -EIO;
    61		if (ret)
    62			return -ETIMEDOUT;
    63	
    64		/* Read FIFO level */
  > 65		int level = (int)(fifo_status & SUN4I_HDMI_DDC_FIFO_STATUS_LEVEL_MASK);
    66	
    67		/* Limit transfer length using FIFO level to avoid underflow/overflow */
    68		len = min(len, read ? level : (SUN4I_HDMI_DDC_FIFO_SIZE - level));
    69	
    70		if (read)
    71			readsb(hdmi->base + SUN4I_HDMI_DDC_FIFO_DATA_REG, buf, len);
    72		else
    73			writesb(hdmi->base + SUN4I_HDMI_DDC_FIFO_DATA_REG, buf, len);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21231 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/d6760e51/attachment-0001.gz>
