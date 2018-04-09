From: lkp@intel.com (kbuild test robot)
Date: Mon, 9 Apr 2018 18:20:27 +0800
Subject: [xlnx:xlnx_rebase_v4.14 315/842] drivers/usb/dwc3/gadget.c:1131:34:
 error: 'dma' undeclared; did you mean 'cma'?
Message-ID: <201804091825.NcBvGAcu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   fe04d2ee0dfea6b5fdbb04f4f6dbcaa13bfd2fda
commit: bc64ac010c4d6375b22c488aad712ccfb072319b [315/842] usb: dwc3: gadget: fix queue remaining sg list trb first
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bc64ac010c4d6375b22c488aad712ccfb072319b
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the xlnx/xlnx_rebase_v4.14 HEAD fe04d2ee0dfea6b5fdbb04f4f6dbcaa13bfd2fda builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/gadget.c: In function 'dwc3_prepare_one_trb_sg':
>> drivers/usb/dwc3/gadget.c:1131:34: error: 'dma' undeclared (first use in this function); did you mean 'cma'?
      dwc3_prepare_one_trb(dep, req, dma, length,
                                     ^~~
                                     cma
   drivers/usb/dwc3/gadget.c:1131:34: note: each undeclared identifier is reported only once for each function it appears in
   drivers/usb/dwc3/gadget.c:1131:3: error: too many arguments to function 'dwc3_prepare_one_trb'
      dwc3_prepare_one_trb(dep, req, dma, length,
      ^~~~~~~~~~~~~~~~~~~~
   drivers/usb/dwc3/gadget.c:1015:13: note: declared here
    static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
                ^~~~~~~~~~~~~~~~~~~~

vim +1131 drivers/usb/dwc3/gadget.c

  1085	
  1086	static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
  1087			struct dwc3_request *req)
  1088	{
  1089		struct scatterlist *sg = req->sg_to_start;
  1090		struct scatterlist *s;
  1091		int		i;
  1092		unsigned int remaining = req->request.num_mapped_sgs
  1093			- req->num_queued_sgs;
  1094	
  1095		for_each_sg(sg, s, remaining, i) {
  1096			unsigned int length = req->request.length;
  1097			unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
  1098			unsigned int rem = length % maxp;
  1099			unsigned chain = true;
  1100	
  1101			if (sg_is_last(s))
  1102				chain = false;
  1103	
  1104			if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
  1105				struct dwc3	*dwc = dep->dwc;
  1106				struct dwc3_trb	*trb;
  1107	
  1108				req->unaligned = true;
  1109	
  1110				/* prepare normal TRB */
  1111				dwc3_prepare_one_trb(dep, req, true, i);
  1112	
  1113				/* Now prepare one extra TRB to align transfer size */
  1114				trb = &dep->trb_pool[dep->trb_enqueue];
  1115				__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr,
  1116						maxp - rem, false, 0,
  1117						req->request.stream_id,
  1118						req->request.short_not_ok,
  1119						req->request.no_interrupt);
  1120			} else {
  1121				dwc3_prepare_one_trb(dep, req, chain, i);
  1122			}
  1123	
  1124			/* In the case where not able to queue trbs for all sgs in
  1125			 * request because of trb not available, update sg_to_start
  1126			 * to next sg from which we can start queing trbs once trbs
  1127			 * availbale
  1128			 */
  1129			req->sg_to_start = sg_next(s);
  1130			req->num_queued_sgs++;
> 1131			dwc3_prepare_one_trb(dep, req, dma, length,
  1132					chain, i);
  1133	
  1134			if (!dwc3_calc_trbs_left(dep))
  1135				break;
  1136		}
  1137	}
  1138	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36882 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/26ea062c/attachment-0001.gz>
