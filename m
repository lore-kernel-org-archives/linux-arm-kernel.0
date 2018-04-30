From: lkp@intel.com (kbuild test robot)
Date: Mon, 30 Apr 2018 21:13:22 +0800
Subject: [xlnx:master 1618/1631] drivers/misc/xilinx_sdfec.c:1032:38: sparse:
 cast removes address space of expression
Message-ID: <201804302121.oQF2GvNi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   59e8b54e301b89d4f05b0cb02dc1777ee6bd3a1f
commit: 1474437194a6a7721a25b846053bc9556228fe58 [1618/1631] misc: xilinx-sdfec: Improve the IOCTL Handling
reproduce:
        # apt-get install sparse
        git checkout 1474437194a6a7721a25b846053bc9556228fe58
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/misc/xilinx_sdfec.c:1032:38: sparse: cast removes address space of expression
   drivers/misc/xilinx_sdfec.c:1061:35: sparse: cast removes address space of expression
   drivers/misc/xilinx_sdfec.c:1212:24: sparse: cast removes address space of expression
>> drivers/misc/xilinx_sdfec.c:1212:24: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:1>*<noident> @@    got sn:1>*<noident> @@
   drivers/misc/xilinx_sdfec.c:1212:24:    expected void const volatile [noderef] <asn:1>*<noident>
   drivers/misc/xilinx_sdfec.c:1212:24:    got void *<noident>
   drivers/misc/xilinx_sdfec.c:1212:24: sparse: cast removes address space of expression
   drivers/misc/xilinx_sdfec.c:1214:24: sparse: cast removes address space of expression
   drivers/misc/xilinx_sdfec.c:1214:24: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:1>*<noident> @@    got sn:1>*<noident> @@
   drivers/misc/xilinx_sdfec.c:1214:24:    expected void const volatile [noderef] <asn:1>*<noident>
   drivers/misc/xilinx_sdfec.c:1214:24:    got void *<noident>
   drivers/misc/xilinx_sdfec.c:1214:24: sparse: cast removes address space of expression
   drivers/misc/xilinx_sdfec.c:1090:10: sparse: dereference of noderef expression

vim +1032 drivers/misc/xilinx_sdfec.c

  1027	
  1028	static int
  1029	xsdfec_set_order(struct xsdfec_dev *xsdfec, void __user *arg)
  1030	{
  1031		bool order_out_of_range;
> 1032		enum xsdfec_order order = *((enum xsdfec_order *)arg);
  1033	
  1034		order_out_of_range = (order <= XSDFEC_INVALID_ORDER) ||
  1035				     (order >= XSDFEC_ORDER_MAX);
  1036		if (order_out_of_range) {
  1037			dev_err(xsdfec->dev,
  1038				"%s invalid order value %d for SDFEC%d",
  1039				__func__, order, xsdfec->fec_id);
  1040			return -EINVAL;
  1041		}
  1042	
  1043		/* Verify Device has not started */
  1044		if (xsdfec->state == XSDFEC_STARTED) {
  1045			dev_err(xsdfec->dev,
  1046				"%s attempting to set Order while started for SDFEC%d",
  1047				__func__, xsdfec->fec_id);
  1048			return -EIO;
  1049		}
  1050	
  1051		xsdfec_regwrite(xsdfec, XSDFEC_ORDER_ADDR, (order - 1));
  1052	
  1053		xsdfec->order = order;
  1054	
  1055		return 0;
  1056	}
  1057	
  1058	static int
  1059	xsdfec_set_bypass(struct xsdfec_dev *xsdfec, void __user *arg)
  1060	{
  1061		unsigned long bypass = *((unsigned long *)arg);
  1062	
  1063		if (bypass > 1) {
  1064			dev_err(xsdfec->dev,
  1065				"%s invalid bypass value %ld for SDFEC%d",
  1066				__func__, bypass, xsdfec->fec_id);
  1067			return -EINVAL;
  1068		}
  1069	
  1070		/* Verify Device has not started */
  1071		if (xsdfec->state == XSDFEC_STARTED) {
  1072			dev_err(xsdfec->dev,
  1073				"%s attempting to set bypass while started for SDFEC%d",
  1074				__func__, xsdfec->fec_id);
  1075			return -EIO;
  1076		}
  1077	
  1078		xsdfec_regwrite(xsdfec, XSDFEC_BYPASS_ADDR, bypass);
  1079	
  1080		return 0;
  1081	}
  1082	
  1083	static int
  1084	xsdfec_is_active(struct xsdfec_dev *xsdfec, bool __user *is_active)
  1085	{
  1086		u32 reg_value;
  1087	
  1088		reg_value = xsdfec_regread(xsdfec, XSDFEC_ACTIVE_ADDR);
  1089		/* using a double ! operator instead of casting */
  1090		*is_active = !!(reg_value & XSDFEC_IS_ACTIVITY_SET);
  1091	
  1092		return 0;
  1093	}
  1094	
  1095	static int xsdfec_start(struct xsdfec_dev *xsdfec)
  1096	{
  1097		u32 regread;
  1098	
  1099		/* Verify Code is loaded */
  1100		if (xsdfec->code == XSDFEC_CODE_INVALID) {
  1101			dev_err(xsdfec->dev,
  1102				"%s : set code before start for SDFEC%d",
  1103				__func__, xsdfec->fec_id);
  1104			return -EINVAL;
  1105		}
  1106		regread = xsdfec_regread(xsdfec, XSDFEC_FEC_CODE_ADDR);
  1107		regread &= 0x1;
  1108		if (regread != (xsdfec->code - 1)) {
  1109			dev_err(xsdfec->dev,
  1110				"%s SDFEC HW code does not match driver code, reg %d, code %d",
  1111				__func__, regread, (xsdfec->code - 1));
  1112			return -EINVAL;
  1113		}
  1114	
  1115		/* Verify Order has been set */
  1116		if (xsdfec->order == XSDFEC_INVALID_ORDER) {
  1117			dev_err(xsdfec->dev,
  1118				"%s : set order before starting SDFEC%d",
  1119				__func__, xsdfec->fec_id);
  1120			return -EINVAL;
  1121		}
  1122	
  1123		/* Set AXIS width */
  1124		xsdfec_regwrite(xsdfec, XSDFEC_AXIS_WIDTH_ADDR, 0);
  1125		/* Set AXIS enable */
  1126		xsdfec_regwrite(xsdfec,
  1127				XSDFEC_AXIS_ENABLE_ADDR,
  1128				XSDFEC_AXIS_ENABLE_MASK);
  1129		/* Write Protect Code and Registers */
  1130		xsdfec_wr_protect(xsdfec, true);
  1131		/* Done */
  1132		xsdfec->state = XSDFEC_STARTED;
  1133		return 0;
  1134	}
  1135	
  1136	static int
  1137	xsdfec_stop(struct xsdfec_dev *xsdfec)
  1138	{
  1139		u32 regread;
  1140	
  1141		if (xsdfec->state != XSDFEC_STARTED)
  1142			dev_err(xsdfec->dev, "Device not started correctly");
  1143		/* Disable Write Protect */
  1144		xsdfec_wr_protect(xsdfec, false);
  1145		/* Disable AXIS_ENABLE register */
  1146		regread = xsdfec_regread(xsdfec, XSDFEC_AXIS_ENABLE_ADDR);
  1147		regread &= (~XSDFEC_AXIS_ENABLE_MASK);
  1148		xsdfec_regwrite(xsdfec, XSDFEC_AXIS_ENABLE_ADDR, regread);
  1149		/* Stop */
  1150		xsdfec->state = XSDFEC_STOPPED;
  1151		return 0;
  1152	}
  1153	
  1154	/*
  1155	 * Reset will happen asynchronously
  1156	 * since there is no in-band reset register
  1157	 * Prepare driver for reset
  1158	 */
  1159	
  1160	static int
  1161	xsdfec_reset_req(struct xsdfec_dev *xsdfec)
  1162	{
  1163		xsdfec->state = XSDFEC_INIT;
  1164		xsdfec->order = XSDFEC_INVALID_ORDER;
  1165		xsdfec->sc_off = 0;
  1166		xsdfec->la_off = 0;
  1167		xsdfec->qc_off = 0;
  1168		xsdfec->wr_protect = false;
  1169		atomic_set(&xsdfec->isr_err_count, 0);
  1170		atomic_set(&xsdfec->uecc_count, 0);
  1171		atomic_set(&xsdfec->cecc_count, 0);
  1172		atomic_inc(&xsdfec->reset_count);
  1173		return 0;
  1174	}
  1175	
  1176	static long
  1177	xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd, unsigned long data)
  1178	{
  1179		struct xsdfec_dev *xsdfec = fptr->private_data;
  1180		void __user *arg = NULL;
  1181		int rval = -EINVAL;
  1182		int err = 0;
  1183	
  1184		if (!xsdfec)
  1185			return rval;
  1186	
  1187		/* In failed state allow only reset and get status IOCTLs */
  1188		if (xsdfec->state == XSDFEC_NEEDS_RESET &&
  1189		    (cmd != XSDFEC_RESET_REQ && cmd != XSDFEC_GET_STATUS)) {
  1190			dev_err(xsdfec->dev,
  1191				"SDFEC%d in failed state. Reset Required",
  1192				xsdfec->fec_id);
  1193			return -EPERM;
  1194		}
  1195	
  1196		if (_IOC_TYPE(cmd) != XSDFEC_MAGIC) {
  1197			dev_err(xsdfec->dev, "Not a xilinx sdfec ioctl");
  1198			return -ENOTTY;
  1199		}
  1200	
  1201		/* check if ioctl argument is present and valid */
  1202		if (_IOC_DIR(cmd) != _IOC_NONE) {
  1203			arg = (void __user *)data;
  1204			if (!arg) {
  1205				dev_err(xsdfec->dev, "xilinx sdfec ioctl argument is NULL Pointer");
  1206				return rval;
  1207			}
  1208		}
  1209	
  1210		/* Access check of the argument if present */
  1211		if (_IOC_DIR(cmd) & _IOC_READ)
> 1212			err = !access_ok(VERIFY_WRITE, (void *)arg, _IOC_SIZE(cmd));
  1213		else if (_IOC_DIR(cmd) & _IOC_WRITE)
  1214			err = !access_ok(VERIFY_READ, (void *)arg, _IOC_SIZE(cmd));
  1215	
  1216		if (err) {
  1217			dev_err(xsdfec->dev, "Invalid xilinx sdfec ioctl argument");
  1218			return -EFAULT;
  1219		}
  1220	
  1221		switch (cmd) {
  1222		case XSDFEC_START_DEV:
  1223			rval = xsdfec_start(xsdfec);
  1224			break;
  1225		case XSDFEC_STOP_DEV:
  1226			rval = xsdfec_stop(xsdfec);
  1227			break;
  1228		case XSDFEC_RESET_REQ:
  1229			rval = xsdfec_reset_req(xsdfec);
  1230			break;
  1231		case XSDFEC_GET_STATUS:
  1232			rval = xsdfec_get_status(xsdfec, arg);
  1233			break;
  1234		case XSDFEC_GET_CONFIG:
  1235			rval = xsdfec_get_config(xsdfec, arg);
  1236			break;
  1237		case XSDFEC_SET_IRQ:
  1238			rval = xsdfec_set_irq(xsdfec, arg);
  1239			break;
  1240		case XSDFEC_SET_TURBO:
  1241			rval = xsdfec_set_turbo(xsdfec, arg);
  1242			break;
  1243		case XSDFEC_GET_TURBO:
  1244			rval = xsdfec_get_turbo(xsdfec, arg);
  1245			break;
  1246		case XSDFEC_ADD_LDPC_CODE_PARAMS:
  1247			rval  = xsdfec_add_ldpc(xsdfec, arg);
  1248			break;
  1249		case XSDFEC_GET_LDPC_CODE_PARAMS:
  1250			rval = xsdfec_get_ldpc_code_params(xsdfec, arg);
  1251			break;
  1252		case XSDFEC_SET_ORDER:
  1253			rval = xsdfec_set_order(xsdfec, arg);
  1254			break;
  1255		case XSDFEC_SET_BYPASS:
  1256			rval = xsdfec_set_bypass(xsdfec, arg);
  1257			break;
  1258		case XSDFEC_IS_ACTIVE:
  1259			rval = xsdfec_is_active(xsdfec, (bool __user *)arg);
  1260			break;
  1261		default:
  1262			/* Should not get here */
  1263			dev_err(xsdfec->dev, "Undefined SDFEC IOCTL");
  1264			break;
  1265		}
  1266		return rval;
  1267	}
  1268	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
