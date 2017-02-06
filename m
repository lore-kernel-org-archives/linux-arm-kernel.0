From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 03:32:53 +0800
Subject: [hisi:topic-lpc-4.10-libio 48/148]
 drivers/scsi/hisi_sas/hisi_sas_main.c:459:4: warning: this 'if' clause does
 not guard...
Message-ID: <201702070349.w8gmauhW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: c6f387dfed7cb1d816463818dead210c16bdfeea [48/148] {noup} hisi_sas: initialize dev when dev found
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout c6f387dfed7cb1d816463818dead210c16bdfeea
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/scsi/hisi_sas/hisi_sas_main.c: In function 'hisi_sas_init_disk':
>> drivers/scsi/hisi_sas/hisi_sas_main.c:459:4: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
       if (!rc)
       ^~
   drivers/scsi/hisi_sas/hisi_sas_main.c:461:5: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
        retry--;
        ^~~~~

vim +/if +459 drivers/scsi/hisi_sas/hisi_sas_main.c

   443		int retry = HISI_SAS_SRST_ATA_DISK_CNT;
   444	
   445		switch (device->dev_type) {
   446		case SAS_END_DEVICE:
   447			int_to_scsilun(0, &lun);
   448	
   449			tmf_task.tmf = TMF_CLEAR_TASK_SET;
   450			rc = hisi_sas_debug_issue_ssp_tmf(device, lun.scsi_lun,
   451				&tmf_task);
   452			break;
   453		case SAS_SATA_DEV:
   454		case SAS_SATA_PM:
   455		case SAS_SATA_PM_PORT:
   456		case SAS_SATA_PENDING:
   457			while (retry > 0) {
   458				rc = hisi_sas_softreset_ata_disk(device);
 > 459				if (!rc)
   460					break;
   461					retry--;
   462				}
   463			break;
   464		case SAS_EDGE_EXPANDER_DEVICE:
   465		case SAS_FANOUT_EXPANDER_DEVICE:
   466		default:
   467			break;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57924 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/3f293d0c/attachment-0001.gz>
