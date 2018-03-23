From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 24 Mar 2018 07:58:31 +0800
Subject: [xlnx:master 1545/1550] drivers/misc/xilinx_sdfec.c:1038:31: sparse:
 dereference of noderef expression
Message-ID: <201803240729.pmaoRTrv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   6e1f0e8ae0acb992560a4e3206a372de271aa8b6
commit: a595ceb6c6d2a8d8517720e3757eb06b76859500 [1545/1550] misc: xilinx-sdfec: Add IOCTL XSDFEC_SET_ORDER
reproduce:
        # apt-get install sparse
        git checkout a595ceb6c6d2a8d8517720e3757eb06b76859500
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/misc/xilinx_sdfec.c:1038:31: sparse: dereference of noderef expression
   drivers/misc/xilinx_sdfec.c:1039:31: sparse: dereference of noderef expression
   drivers/misc/xilinx_sdfec.c:1043:35: sparse: dereference of noderef expression
   drivers/misc/xilinx_sdfec.c:1055:53: sparse: dereference of noderef expression
   drivers/misc/xilinx_sdfec.c:1057:25: sparse: dereference of noderef expression

vim +1038 drivers/misc/xilinx_sdfec.c

  1032	
  1033	static int
  1034	xsdfec_set_order(struct xsdfec_dev *xsdfec, enum xsdfec_order __user order)
  1035	{
  1036		bool order_out_of_range;
  1037	
> 1038		order_out_of_range = (order <= XSDFEC_INVALID_ORDER) ||
  1039				     (order >= XSDFEC_ORDER_MAX);
  1040		if (order_out_of_range) {
  1041			dev_err(xsdfec->dev,
  1042				"%s invalid order value %d for SDFEC%d",
  1043				__func__, order, xsdfec->fec_id);
  1044			return -EINVAL;
  1045		}
  1046	
  1047		/* Verify Device has not started */
  1048		if (xsdfec->state == XSDFEC_STARTED) {
  1049			dev_err(xsdfec->dev,
  1050				"%s attempting to set Order while started for SDFEC%d",
  1051				__func__, xsdfec->fec_id);
  1052			return -EIO;
  1053		}
  1054	
  1055		xsdfec_regwrite(xsdfec, XSDFEC_ORDER_ADDR, (order - 1));
  1056	
  1057		xsdfec->order = order;
  1058	
  1059		return 0;
  1060	}
  1061	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
