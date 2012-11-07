From: fengguang.wu@intel.com (Fengguang Wu)
Date: Wed, 7 Nov 2012 18:05:25 +0800
Subject: drivers/staging/ced1401/ced_ioc.c:918 GetTransfer() error: potential
 null dereference 'tx'.  (kzalloc returns null)
In-Reply-To: <509a31bd.DqNZ+8tDIvryTj7L%yuanhan.liu@linux.intel.com>
Message-ID: <20121107100525.GA31190@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git testing/defconfig-warnings
head:   ee68ab14f293996cc746aeb016fd2c124e2914f0
commit: 47b83e2bd41f9cc656b7b933cefec484f4d12026 Fix potential stack overflow locations
date:   2 hours ago

  drivers/staging/ced1401/ced_ioc.c:875 WaitEvent() warn: inconsistent returns mutex:&pdx->io_mutex: locked (853) unlocked (841,875)
+ drivers/staging/ced1401/ced_ioc.c:918 GetTransfer() error: potential null dereference 'tx'.  (kzalloc returns null)
  drivers/staging/ced1401/ced_ioc.c:1079 CheckSelfTest() warn: check that 'gst.code' doesn't leak information
  drivers/staging/ced1401/ced_ioc.c:1515 FreeCircBlock() warn: inconsistent returns mutex:&pdx->io_mutex: locked (1512) unlocked (1424,1515)
--
  drivers/staging/wlan-ng/hfa384x_usb.c:3517 hfa384x_usbin_rx() error: potential NULL dereference 'rxmeta'.
  drivers/staging/wlan-ng/prism2fw.c:594 mkpdrlist() error: buffer overflow 'pda16' 512 <= 512
  drivers/staging/wlan-ng/prism2fw.c:635 mkpdrlist() error: buffer overflow 'pda16' 512 <= 512
+ drivers/staging/wlan-ng/prism2fw.c:773 read_cardpda() error: potential null dereference 'msg'.  (kmalloc returns null)
--
  drivers/misc/lkdtm.c:268 recursive_loop() warn: 'buf' puts 512 bytes on stack
+ drivers/misc/lkdtm.c:270 recursive_loop() error: __builtin_memset() 'buf' too small (512 vs 1024)
  drivers/misc/lkdtm.c:301 lkdtm_do_action() error: buffer overflow 'p' 8 <= 12
  drivers/misc/lkdtm.c:320 lkdtm_do_action() error: potential null dereference 'data'.  (kmalloc returns null)
  drivers/misc/lkdtm.c:320 lkdtm_do_action() error: buffer overflow 'data' 255 <= 256

vim +918 +/tx drivers/staging/ced1401/ced_ioc.c

2eae6bdc Alois Schl?gl      2012-09-17  902  ** GetTransferInfo
2eae6bdc Alois Schl?gl      2012-09-17  903  ** Puts the current state of the 1401 in a TGET_TX_BLOCK.
2eae6bdc Alois Schl?gl      2012-09-17  904  *****************************************************************************/
cd915200 Greg Kroah-Hartman 2012-09-17  905  int GetTransfer(DEVICE_EXTENSION * pdx, TGET_TX_BLOCK __user * pTX)
2eae6bdc Alois Schl?gl      2012-09-17  906  {
cd915200 Greg Kroah-Hartman 2012-09-17  907  	int iReturn = U14ERR_NOERROR;
cd915200 Greg Kroah-Hartman 2012-09-17  908  	unsigned int dwIdent;
cd915200 Greg Kroah-Hartman 2012-09-17  909  
cd915200 Greg Kroah-Hartman 2012-09-17  910  	mutex_lock(&pdx->io_mutex);
cd915200 Greg Kroah-Hartman 2012-09-17  911  	dwIdent = pdx->StagedId;	// area ident for last xfer
cd915200 Greg Kroah-Hartman 2012-09-17  912  	if (dwIdent >= MAX_TRANSAREAS)
cd915200 Greg Kroah-Hartman 2012-09-17  913  		iReturn = U14ERR_BADAREA;
cd915200 Greg Kroah-Hartman 2012-09-17  914  	else {
cd915200 Greg Kroah-Hartman 2012-09-17  915  		// Return the best information we have - we don't have physical addresses
47b83e2b Arnd Bergmann      2012-10-16  916  		TGET_TX_BLOCK *tx;
47b83e2b Arnd Bergmann      2012-10-16  917  		tx = kzalloc(sizeof *tx, GFP_KERNEL);
47b83e2b Arnd Bergmann      2012-10-16 @918  		tx->size = pdx->rTransDef[dwIdent].dwLength;
47b83e2b Arnd Bergmann      2012-10-16  919  		tx->linear = (long long)((long)pdx->rTransDef[dwIdent].lpvBuff);
47b83e2b Arnd Bergmann      2012-10-16  920  		tx->avail = GET_TX_MAXENTRIES;	// how many blocks we could return
47b83e2b Arnd Bergmann      2012-10-16  921  		tx->used = 1;	// number we actually return
47b83e2b Arnd Bergmann      2012-10-16  922  		tx->entries[0].physical =
47b83e2b Arnd Bergmann      2012-10-16  923  		   (long long)(tx->linear + pdx->StagedOffset);
47b83e2b Arnd Bergmann      2012-10-16  924  		tx->entries[0].size = tx->size;
47b83e2b Arnd Bergmann      2012-10-16  925  
47b83e2b Arnd Bergmann      2012-10-16  926  		if (copy_to_user(pTX, tx, sizeof(*tx)))

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
