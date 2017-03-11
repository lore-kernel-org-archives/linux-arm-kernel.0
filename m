From: lkp@intel.com (kbuild test robot)
Date: Sat, 11 Mar 2017 13:07:10 +0800
Subject: [PATCH 1/3] ata: add Palmchip BK3710 PATA controller driver
In-Reply-To: <1489064496-6270-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <201703111348.iFVyt3mM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

[auto build test WARNING on tj-libata/for-next]
[also build test WARNING on v4.11-rc1 next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartlomiej-Zolnierkiewicz/ata-add-Palmchip-BK3710-PATA-controller-driver/20170311-095152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-next
config: arm-davinci_all_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/ata/pata_bk3710.c: In function 'pata_bk3710_set_piomode':
>> drivers/ata/pata_bk3710.c:223:5: warning: 'cycle_time' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (!cycle_time)
        ^

vim +/cycle_time +223 drivers/ata/pata_bk3710.c

   207		const u16 *id = adev->id;
   208		unsigned int cycle_time;
   209		int is_slave = adev->devno;
   210		const u8 pio = adev->pio_mode - XFER_PIO_0;
   211	
   212		if (id[ATA_ID_FIELD_VALID] & 2) {
   213			if (ata_id_has_iordy(id))
   214				cycle_time = id[ATA_ID_EIDE_PIO_IORDY];
   215			else
   216				cycle_time = id[ATA_ID_EIDE_PIO];
   217	
   218			/* conservative "downgrade" for all pre-ATA2 drives */
   219			if (pio < 3 && cycle_time < t->cycle)
   220				cycle_time = 0; /* use standard timing */
   221		}
   222	
 > 223		if (!cycle_time)
   224			cycle_time = t->cycle;
   225	
   226		pata_bk3710_setpiomode(base, pair, is_slave, cycle_time, pio);
   227	}
   228	
   229	static void pata_bk3710_chipinit(void __iomem *base)
   230	{
   231		/*

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24160 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170311/76bb192a/attachment-0001.gz>
