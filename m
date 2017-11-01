From: lkp@intel.com (kbuild test robot)
Date: Thu, 2 Nov 2017 05:43:43 +0800
Subject: [patch v10 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1509365528-28803-2-git-send-email-oleksandrs@mellanox.com>
References: <1509365528-28803-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <201711020505.KCJRigIt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleksandr,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc7]
[cannot apply to next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20171102-045624
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

   drivers/jtag/jtag.c: In function 'jtag_ioctl':
>> drivers/jtag/jtag.c:130:10: error: too many arguments to function 'jtag->ops->xfer'
       err = jtag->ops->xfer(jtag, &xfer, xfer_data);
             ^~~~
   At top level:
   drivers/jtag/jtag.c:42:21: warning: 'jtag_class' defined but not used [-Wunused-variable]
    static struct class jtag_class = {
                        ^~~~~~~~~~

vim +130 drivers/jtag/jtag.c

    46	
    47	static long jtag_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
    48	{
    49		struct jtag *jtag = file->private_data;
    50		struct jtag_run_test_idle idle;
    51		struct jtag_xfer xfer;
    52		u8 *xfer_data;
    53		u32 data_size;
    54		u32 value;
    55		int err;
    56	
    57		if (!arg)
    58			return -EINVAL;
    59	
    60		switch (cmd) {
    61		case JTAG_GIOCFREQ:
    62	
    63			if (jtag->ops->freq_get)
    64				err = jtag->ops->freq_get(jtag, &value);
    65			else
    66				err = -EOPNOTSUPP;
    67			if (err)
    68				break;
    69	
    70			if (put_user(value, (__u32 *)arg))
    71				err = -EFAULT;
    72			break;
    73	
    74		case JTAG_SIOCFREQ:
    75			if (get_user(value, (__u32 *)arg))
    76				return -EFAULT;
    77			if (value == 0)
    78				return -EINVAL;
    79	
    80			if (jtag->ops->freq_set)
    81				err = jtag->ops->freq_set(jtag, value);
    82			else
    83				err = -EOPNOTSUPP;
    84			break;
    85	
    86		case JTAG_IOCRUNTEST:
    87			if (copy_from_user(&idle, (void *)arg,
    88					   sizeof(struct jtag_run_test_idle)))
    89				return -EFAULT;
    90	
    91			if (idle.mode > JTAG_XFER_SW_MODE)
    92				return -EINVAL;
    93	
    94			if (idle.endstate > JTAG_STATE_PAUSEDR)
    95				return -EINVAL;
    96	
    97			if (jtag->ops->idle)
    98				err = jtag->ops->idle(jtag, &idle);
    99			else
   100				err = -EOPNOTSUPP;
   101			break;
   102	
   103		case JTAG_IOCXFER:
   104			if (copy_from_user(&xfer, (void *)arg,
   105					   sizeof(struct jtag_xfer)))
   106				return -EFAULT;
   107	
   108			if (xfer.length >= JTAG_MAX_XFER_DATA_LEN)
   109				return -EINVAL;
   110	
   111			if (xfer.mode > JTAG_XFER_SW_MODE)
   112				return -EINVAL;
   113	
   114			if (xfer.type > JTAG_SDR_XFER)
   115				return -EINVAL;
   116	
   117			if (xfer.direction > JTAG_WRITE_XFER)
   118				return -EINVAL;
   119	
   120			if (xfer.endstate > JTAG_STATE_PAUSEDR)
   121				return -EINVAL;
   122	
   123			data_size = DIV_ROUND_UP(xfer.length, BITS_PER_BYTE);
   124			xfer_data = memdup_user(u64_to_user_ptr(xfer.tdio), data_size);
   125	
   126			if (!xfer_data)
   127				return -EFAULT;
   128	
   129			if (jtag->ops->xfer) {
 > 130				err = jtag->ops->xfer(jtag, &xfer, xfer_data);
   131			} else {
   132				kfree(xfer_data);
   133				return -EOPNOTSUPP;
   134			}
   135	
   136			if (err) {
   137				return -EFAULT;
   138				kfree(xfer_data);
   139			}
   140	
   141			err = copy_to_user(u64_to_user_ptr(xfer.tdio),
   142					   (void *)(xfer_data), data_size);
   143	
   144			if (err) {
   145				kfree(xfer_data);
   146				return -EFAULT;
   147			}
   148	
   149			kfree(xfer_data);
   150			if (copy_to_user((void *)arg, &xfer, sizeof(struct jtag_xfer)))
   151				return -EFAULT;
   152			break;
   153	
   154		case JTAG_GIOCSTATUS:
   155			if (jtag->ops->status_get)
   156				err = jtag->ops->status_get(jtag, &value);
   157			else
   158				err = -EOPNOTSUPP;
   159			if (err)
   160				break;
   161	
   162			err = put_user(value, (__u32 *)arg);
   163			if (err)
   164				err = -EFAULT;
   165			break;
   166	
   167		default:
   168			return -EINVAL;
   169		}
   170		return err;
   171	}
   172	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46042 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171102/535aaa77/attachment-0001.gz>
