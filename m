From: lkp@intel.com (kbuild test robot)
Date: Mon, 9 Apr 2018 17:01:50 +0800
Subject: [xlnx:xlnx_rebase_v4.14 567/842]
 drivers/usb/dwc3/gadget_hibernation.c:431: undefined reference to
 `dwc3_set_usb_core_power'
Message-ID: <201804091743.sI8Tzx3S%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   fe04d2ee0dfea6b5fdbb04f4f6dbcaa13bfd2fda
commit: 2af3084d6d18866b79a53622978509169cdee30f [567/842] usb: dwc3: Add hibernation support when operating as gadget
config: i386-randconfig-s0-201814 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 2af3084d6d18866b79a53622978509169cdee30f
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/gadget_hibernation.o: In function `gadget_wakeup_interrupt':
>> drivers/usb/dwc3/gadget_hibernation.c:431: undefined reference to `dwc3_set_usb_core_power'
   drivers/usb/dwc3/gadget_hibernation.o: In function `gadget_hibernation_interrupt':
   drivers/usb/dwc3/gadget_hibernation.c:399: undefined reference to `dwc3_set_usb_core_power'

vim +431 drivers/usb/dwc3/gadget_hibernation.c

   413	
   414	/**
   415	 * gadget_wakeup_interrupt - Interrupt handler of wakeup
   416	 * @dwc: pointer to our controller context structure
   417	 */
   418	void gadget_wakeup_interrupt(struct dwc3 *dwc)
   419	{
   420		u32 reg, link_state;
   421		int ret, retries;
   422		bool enter_hiber = false;
   423	
   424		/* On USB 2.0 we observed back to back wakeup interrupts */
   425		if (!dwc->is_hibernated) {
   426			dev_err(dwc->dev, "Not in hibernated state\n");
   427			goto err;
   428		}
   429	
   430		/* Restore power to USB core */
 > 431		if (dwc3_set_usb_core_power(dwc, true)) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34916 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/2fd3012d/attachment-0001.gz>
