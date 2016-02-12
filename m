From: lkp@intel.com (kbuild test robot)
Date: Fri, 12 Feb 2016 12:38:18 +0800
Subject: [PATCH v4 2/8] Staging: rts5208: rtsx_transport.c: Align to open
 parenthesis
In-Reply-To: <1455250080-9897-3-git-send-email-shaun.ren@linux.com>
Message-ID: <201602121205.F88kAao7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaun,

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v4.5-rc3 next-20160211]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Shaun-Ren/Staging-rts5208-Fix-coding-style/20160212-122003
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   drivers/staging/rts5208/rtsx_transport.c: In function 'rtsx_stor_access_xfer_buf':
>> drivers/staging/rts5208/rtsx_transport.c:59:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      unsigned char *sgbuffer = (unsigned char *)scsi_sglist(srb) +
      ^

vim +59 drivers/staging/rts5208/rtsx_transport.c

    43	
    44	unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
    45					       unsigned int buflen,
    46					       struct scsi_cmnd *srb,
    47					       unsigned int *index,
    48					       unsigned int *offset,
    49					       enum xfer_buf_dir dir)
    50	{
    51		unsigned int cnt;
    52	
    53		/* If not using scatter-gather, just transfer the data directly. */
    54		if (scsi_sg_count(srb) == 0) {
    55			if (*offset >= scsi_bufflen(srb))
    56				return 0;
    57			cnt = min(buflen, scsi_bufflen(srb) - *offset);
    58	
  > 59			unsigned char *sgbuffer = (unsigned char *)scsi_sglist(srb) +
    60				*offset;
    61	
    62			if (dir == TO_XFER_BUF)
    63				memcpy(sgbuffer, buffer, cnt);
    64			else
    65				memcpy(buffer, sgbuffer, cnt);
    66			*offset += cnt;
    67	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44081 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/e0fa3a29/attachment-0001.obj>
