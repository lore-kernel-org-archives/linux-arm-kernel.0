From: lkp@intel.com (kbuild test robot)
Date: Mon, 11 Jul 2016 19:41:34 +0800
Subject: [PATCH 06/15] net: thunderx: Enable mailbox interrupts on
 81xx/83xx
In-Reply-To: <1468231317-24023-7-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <201607111923.Qq6FbAa9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.7-rc7 next-20160711]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/sunil-kovvuri-gmail-com/net-thunderx-Add-support-for-81xx-and-83xx/20160711-181138
config: x86_64-randconfig-i0-201628 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/cavium/thunder/nic_main.c: In function 'nic_enable_msix':
>> drivers/net/ethernet/cavium/thunder/nic_main.c:944:30: warning: iteration 10 invokes undefined behavior [-Waggressive-loop-optimizations]
      nic->msix_entries[i].entry = i;
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/net/ethernet/cavium/thunder/nic_main.c:943:2: note: within this loop
     for (i = 0; i < nic->num_vec; i++)
     ^~~

vim +944 drivers/net/ethernet/cavium/thunder/nic_main.c

4863dea3 Sunil Goutham 2015-05-26  928  				vf + (mbx * vf_per_mbx_reg));
92dc8769 Sunil Goutham 2015-08-30  929  
4863dea3 Sunil Goutham 2015-05-26  930  			nic_handle_mbx_intr(nic, vf + (mbx * vf_per_mbx_reg));
4863dea3 Sunil Goutham 2015-05-26  931  			nic_clear_mbx_intr(nic, vf, mbx);
4863dea3 Sunil Goutham 2015-05-26  932  		}
4863dea3 Sunil Goutham 2015-05-26  933  	}
4863dea3 Sunil Goutham 2015-05-26  934  	return IRQ_HANDLED;
4863dea3 Sunil Goutham 2015-05-26  935  }
4863dea3 Sunil Goutham 2015-05-26  936  
4863dea3 Sunil Goutham 2015-05-26  937  static int nic_enable_msix(struct nicpf *nic)
4863dea3 Sunil Goutham 2015-05-26  938  {
4863dea3 Sunil Goutham 2015-05-26  939  	int i, ret;
4863dea3 Sunil Goutham 2015-05-26  940  
45ff737f Sunil Goutham 2016-07-11  941  	nic->num_vec = pci_msix_vec_count(nic->pdev);
4863dea3 Sunil Goutham 2015-05-26  942  
4863dea3 Sunil Goutham 2015-05-26  943  	for (i = 0; i < nic->num_vec; i++)
4863dea3 Sunil Goutham 2015-05-26 @944  		nic->msix_entries[i].entry = i;
4863dea3 Sunil Goutham 2015-05-26  945  
4863dea3 Sunil Goutham 2015-05-26  946  	ret = pci_enable_msix(nic->pdev, nic->msix_entries, nic->num_vec);
4863dea3 Sunil Goutham 2015-05-26  947  	if (ret) {
4863dea3 Sunil Goutham 2015-05-26  948  		dev_err(&nic->pdev->dev,
45ff737f Sunil Goutham 2016-07-11  949  			"Request for #%d msix vectors failed, returned %d\n",
45ff737f Sunil Goutham 2016-07-11  950  			   nic->num_vec, ret);
4863dea3 Sunil Goutham 2015-05-26  951  		return ret;
4863dea3 Sunil Goutham 2015-05-26  952  	}

:::::: The code at line 944 was first introduced by commit
:::::: 4863dea3fab01734768c9f7fc2c1590a8f1f6266 net: Adding support for Cavium ThunderX network controller

:::::: TO: Sunil Goutham <sgoutham@cavium.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25088 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160711/e42fcee4/attachment-0001.obj>
