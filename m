From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 4 Jul 2017 18:15:08 +0800
Subject: [PATCH 2/2] misc: added Spreadtrum's radio driver
In-Reply-To: <20170704101508.30946-1-chunyan.zhang@spreadtrum.com>
References: <20170704101508.30946-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170704101508.30946-3-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch added FM radio driver for Spreadtrum's SC2342, which's
a WCN SoC, also added a new directory for Spreadtrum's WCN SoCs.

Signed-off-by: Songhe Wei <songhe.wei@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/misc/Kconfig                           |    1 +
 drivers/misc/Makefile                          |    1 +
 drivers/misc/sprd-wcn/Kconfig                  |   14 +
 drivers/misc/sprd-wcn/Makefile                 |    1 +
 drivers/misc/sprd-wcn/radio/Kconfig            |    8 +
 drivers/misc/sprd-wcn/radio/Makefile           |    2 +
 drivers/misc/sprd-wcn/radio/fmdrv.h            |  595 +++++++++++
 drivers/misc/sprd-wcn/radio/fmdrv_main.c       | 1245 ++++++++++++++++++++++++
 drivers/misc/sprd-wcn/radio/fmdrv_main.h       |  117 +++
 drivers/misc/sprd-wcn/radio/fmdrv_ops.c        |  447 +++++++++
 drivers/misc/sprd-wcn/radio/fmdrv_ops.h        |   17 +
 drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.c |  753 ++++++++++++++
 drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.h |  103 ++
 13 files changed, 3304 insertions(+)
 create mode 100644 drivers/misc/sprd-wcn/Kconfig
 create mode 100644 drivers/misc/sprd-wcn/Makefile
 create mode 100644 drivers/misc/sprd-wcn/radio/Kconfig
 create mode 100644 drivers/misc/sprd-wcn/radio/Makefile
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv.h
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_main.c
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_main.h
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_ops.c
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_ops.h
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.c
 create mode 100644 drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 07bbd4c..5e295b3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -510,4 +510,5 @@ source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
+source "drivers/misc/sprd-wcn/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ad13677..df75ea7 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
+obj-$(CONFIG_SPRD_WCN)		+= sprd-wcn/
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
diff --git a/drivers/misc/sprd-wcn/Kconfig b/drivers/misc/sprd-wcn/Kconfig
new file mode 100644
index 0000000..d2e7428
--- /dev/null
+++ b/drivers/misc/sprd-wcn/Kconfig
@@ -0,0 +1,14 @@
+config SPRD_WCN
+	tristate "Support for Spreadtrum's WCN SoCs"
+	depends on ARCH_SPRD
+	default n
+	help
+	  This enables Spreadtrum's WCN (wireless connectivity network)
+	  SoCs. In general, Spreadtrum's WCN SoCs consisted of some
+	  modules, such as FM, bluetooth, wifi, GPS, etc.
+
+if SPRD_WCN
+
+source "drivers/misc/sprd-wcn/radio/Kconfig"
+
+endif
diff --git a/drivers/misc/sprd-wcn/Makefile b/drivers/misc/sprd-wcn/Makefile
new file mode 100644
index 0000000..3ad5dad
--- /dev/null
+++ b/drivers/misc/sprd-wcn/Makefile
@@ -0,0 +1 @@
+obj-y		+= radio/
diff --git a/drivers/misc/sprd-wcn/radio/Kconfig b/drivers/misc/sprd-wcn/radio/Kconfig
new file mode 100644
index 0000000..3cc0f7e
--- /dev/null
+++ b/drivers/misc/sprd-wcn/radio/Kconfig
@@ -0,0 +1,8 @@
+## Spreadtrum SC2332 FM drivers
+
+config SPRD_RADIO_SC2332
+	tristate "Support for the Spreadtrum Radio SC2332"
+	default n
+	---help---
+	  Say Y to enable built-in FM radio controller for the
+	  Spreadtrum SC2332 SoC.
diff --git a/drivers/misc/sprd-wcn/radio/Makefile b/drivers/misc/sprd-wcn/radio/Makefile
new file mode 100644
index 0000000..16f1582
--- /dev/null
+++ b/drivers/misc/sprd-wcn/radio/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SPRD_RADIO_SC2332) := marlin2_fm.o
+marlin2_fm-objs := fmdrv_main.o fmdrv_ops.o fmdrv_rds_parser.o
diff --git a/drivers/misc/sprd-wcn/radio/fmdrv.h b/drivers/misc/sprd-wcn/radio/fmdrv.h
new file mode 100644
index 0000000..e74ff7f
--- /dev/null
+++ b/drivers/misc/sprd-wcn/radio/fmdrv.h
@@ -0,0 +1,595 @@
+/*
+ * SPREADTRUM SC2342 FM Radio driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _FM_DRV_H
+#define _FM_DRV_H
+
+#include <linux/completion.h>
+#include <linux/ioctl.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+
+#define FM_DEV_NAME	"fm"
+#define FM_RDS_ENABLE 0x01
+#define MARLIN_FM 0
+
+/* scan sort algorithm */
+enum {
+	FM_SCAN_SORT_NON = 0,
+	FM_SCAN_SORT_UP,
+	FM_SCAN_SORT_DOWN,
+	FM_SCAN_SORT_MAX
+};
+
+/* scan methods */
+enum {
+	/* select hardware scan, advantage: fast */
+	FM_SCAN_SEL_HW = 0,
+	/* select software scan, advantage: more accurate */
+	FM_SCAN_SEL_SW,
+	FM_SCAN_SEL_MAX
+};
+
+/* FM config for customer */
+/* FM radio long antenna RSSI threshold(11.375dBuV) */
+#define FMR_RSSI_TH_LONG    0x0301
+/* FM radio short antenna RSSI threshold(-1dBuV) */
+#define FMR_RSSI_TH_SHORT   0x02E0
+/* FM radio Channel quality indicator threshold(0x0000~0x00FF) */
+#define FMR_CQI_TH          0x00E9
+/* FM radio seek space,1:100KHZ; 2:200KHZ */
+#define FMR_SEEK_SPACE      1
+/* FM radio scan max channel size */
+#define FMR_SCAN_CH_SIZE    40
+/* FM radio band, 1:87.5MHz~108.0MHz;*/
+/* 2:76.0MHz~90.0MHz;*/
+/* 3:76.0MHz~108.0MHz; 4:special */
+#define FMR_BAND            1
+/* FM radio special band low freq(Default 87.5MHz) */
+#define FMR_BAND_FREQ_L     875
+/* FM radio special band high freq(Default 108.0MHz) */
+#define FMR_BAND_FREQ_H     1080
+#define FM_SCAN_SORT_SELECT FM_SCAN_SORT_NON
+#define FM_SCAN_SELECT      FM_SCAN_SEL_HW
+/* soft-mute threshold when software scan, rang: 0~3, */
+/* 0 means better audio quality but less channel */
+#define FM_SCAN_SOFT_MUTE_GAIN_TH  3
+/* rang: -102 ~ -72 */
+#define FM_CHIP_DESE_RSSI_TH (-102)
+
+/* FM config for engineer */
+/* FM radio MR threshold */
+#define FMR_MR_TH			0x01BD
+/* scan thrshold register */
+#define ADDR_SCAN_TH			0xE0
+/* scan CQI register */
+#define ADDR_CQI_TH			0xE1
+/* 4 sec */
+#define FM_DRV_TX_TIMEOUT		(4*HZ)
+/* 20 sec */
+#define FM_DRV_RX_SEEK_TIMEOUT		(20*HZ)
+
+/* errno */
+#define FM_SUCCESS      0
+#define FM_FAILED       1
+#define FM_EPARM        2
+#define FM_BADSTATUS    3
+#define FM_TUNE_FAILED  4
+#define FM_SEEK_FAILED  5
+#define FM_BUSY         6
+#define FM_SCAN_FAILED  7
+
+/* band */
+#define FM_BAND_UNKNOWN 0
+/* US/Europe band 87.5MHz ~ 108MHz (DEFAULT) */
+#define FM_BAND_UE      1
+/* Japan band 76MHz ~ 90MHz */
+#define FM_BAND_JAPAN   2
+/* Japan wideband 76MHZ ~ 108MHz */
+#define FM_BAND_JAPANW  3
+/* special band between 76MHZ and 108MHz */
+#define FM_BAND_SPECIAL 4
+#define FM_BAND_DEFAULT FM_BAND_UE
+
+#define FM_UE_FREQ_MIN  875
+#define FM_UE_FREQ_MAX  1080
+#define FM_JP_FREQ_MIN  760
+#define FM_JP_FREQ_MAX  1080
+#define FM_FREQ_MIN  FMR_BAND_FREQ_L
+#define FM_FREQ_MAX  FMR_BAND_FREQ_H
+#define FM_RAIDO_BAND FM_BAND_UE
+
+/* space */
+#define FM_SPACE_UNKNOWN    0
+#define FM_SPACE_100K       1
+#define FM_SPACE_200K       2
+#define FM_SPACE_50K        5
+#define FM_SPACE_DEFAULT    FM_SPACE_100K
+
+#define FM_SEEK_SPACE FMR_SEEK_SPACE
+
+/* max scan channel num */
+#define FM_MAX_CHL_SIZE FMR_SCAN_CH_SIZE
+/* auto HiLo */
+#define FM_AUTO_HILO_OFF    0
+#define FM_AUTO_HILO_ON     1
+
+/* seek direction */
+#define FM_SEEK_UP          0
+#define FM_SEEK_DOWN        1
+
+#define FM_VERSION	"v0.0"
+
+/* seek threshold */
+#define FM_SEEKTH_LEVEL_DEFAULT 4
+
+struct fm_tune_parm {
+	uint8_t err;
+	uint8_t band;
+	uint8_t space;
+	uint8_t hilo;
+	uint16_t freq;
+};
+
+struct fm_seek_parm {
+	uint8_t err;
+	uint8_t band;
+	uint8_t space;
+	uint8_t hilo;
+	uint8_t seekdir;
+	uint8_t seekth;
+	uint16_t freq;
+};
+
+/* Frequency offset, PDP_TH,PHP_TH, SNR_TH,RSS_THI */
+/* Frequency_Offset_Th        [0x0000 0xFFFF]   EXPERIENCE VALUES:0x5dc  */
+/* Pilot_Power_Th RANGES:   [0x0000 0x1FFF]   EXPERIENCE VALUES:0x190  */
+/* Noise_Power_Th RANGES:  [0x0000 0x1FFF]   EXPERIENCE VALUES:0xB0   */
+struct fm_seek_criteria_parm {
+	unsigned char rssi_th;
+	unsigned char snr_th;
+	unsigned short freq_offset_th;
+	unsigned short pilot_power_th;
+	unsigned short noise_power_th;
+} __packed;
+
+struct fm_audio_threshold_parm {
+	unsigned short hbound;
+	unsigned short lbound;
+	unsigned short power_th;
+	unsigned char phyt;
+	unsigned char snr_th;
+} __packed;
+/*__attribute__ ((packed));*/
+
+struct fm_reg_ctl_parm {
+	unsigned char err;
+	unsigned int addr;
+	unsigned int val;
+	/*0:write, 1:read*/
+	unsigned char rw_flag;
+} __packed;
+
+struct fm_scan_parm {
+	uint8_t  err;
+	uint8_t  band;
+	uint8_t  space;
+	uint8_t  hilo;
+	uint16_t freq;
+	uint16_t scantbl[16];
+	uint16_t scantblsize;
+};
+
+struct fm_scan_all_parm {
+	unsigned char band;/*87.5~108,76~*/
+	unsigned char space;/*50 or 100KHz */
+	unsigned char chanel_num;
+	unsigned short freq[36]; /* OUT parameter*/
+};
+
+struct fm_ch_rssi {
+	uint16_t freq;
+	int rssi;
+};
+
+enum fm_scan_cmd_t {
+	FM_SCAN_CMD_INIT = 0,
+	FM_SCAN_CMD_START,
+	FM_SCAN_CMD_GET_NUM,
+	FM_SCAN_CMD_GET_CH,
+	FM_SCAN_CMD_GET_RSSI,
+	FM_SCAN_CMD_GET_CH_RSSI,
+	FM_SCAN_CMD_MAX
+};
+
+struct fm_rssi_req {
+	uint16_t num;
+	uint16_t read_cnt;
+	struct fm_ch_rssi cr[16*16];
+};
+
+struct fm_hw_info {
+	int chip_id;
+	int eco_ver;
+	int rom_ver;
+	int patch_ver;
+	int reserve;
+};
+
+struct rdslag {
+	uint8_t TP;
+	uint8_t TA;
+	uint8_t music;
+	uint8_t stereo;
+	uint8_t artificial_head;
+	uint8_t compressed;
+	uint8_t dynamic_pty;
+	uint8_t text_ab;
+	uint32_t flag_status;
+};
+
+struct ct_info {
+	uint16_t month;
+	uint16_t day;
+	uint16_t year;
+	uint16_t hour;
+	uint16_t minute;
+	uint8_t local_time_offset_signbit;
+	uint8_t local_time_offset_half_hour;
+};
+
+struct  af_info {
+	int16_t AF_NUM;
+	int16_t AF[2][25];
+	uint8_t addr_cnt;
+	uint8_t ismethod_a;
+	uint8_t isafnum_get;
+};
+
+struct  ps_info {
+	uint8_t PS[4][8];
+	uint8_t addr_cnt;
+};
+
+struct  rt_info {
+	uint8_t textdata[4][64];
+	uint8_t getlength;
+	uint8_t isrtdisplay;
+	uint8_t textlength;
+	uint8_t istypea;
+	uint8_t bufcnt;
+	uint16_t addr_cnt;
+};
+
+struct rds_raw_data {
+	/* indicate if the data changed or not */
+	int dirty;
+	/* the data len form chip */
+	int len;
+	uint8_t data[146];
+};
+
+struct rds_group_cnt {
+	unsigned int total;
+	unsigned int groupA[16];
+	unsigned int groupB[16];
+};
+
+enum rds_group_cnt_opcode {
+	RDS_GROUP_CNT_READ = 0,
+	RDS_GROUP_CNT_WRITE,
+	RDS_GROUP_CNT_RESET,
+	RDS_GROUP_CNT_MAX
+};
+
+struct rds_group_cnt_req {
+	int err;
+	enum rds_group_cnt_opcode op;
+	struct rds_group_cnt gc;
+};
+
+struct fm_rds_data {
+	struct ct_info CT;
+	struct rdslag RDSFLAG;
+	uint16_t PI;
+	uint8_t switch_tp;
+	uint8_t PTY;
+	struct  af_info af_data;
+	struct  af_info afon_data;
+	uint8_t radio_page_code;
+	uint16_t program_item_number_code;
+	uint8_t extend_country_code;
+	uint16_t language_code;
+	struct  ps_info ps_data;
+	uint8_t ps_on[8];
+	struct  rt_info rt_data;
+	uint16_t event_status;
+	struct rds_group_cnt gc;
+};
+
+/* valid Rds Flag for notify */
+enum {
+	/* Program is a traffic program */
+	RDS_FLAG_IS_TP              = 0x0001,
+	/* Program currently broadcasts a traffic ann. */
+	RDS_FLAG_IS_TA              = 0x0002,
+	/* Program currently broadcasts music */
+	RDS_FLAG_IS_MUSIC           = 0x0004,
+	/* Program is transmitted in stereo */
+	RDS_FLAG_IS_STEREO          = 0x0008,
+	/* Program is an artificial head recording */
+	RDS_FLAG_IS_ARTIFICIAL_HEAD = 0x0010,
+	/* Program content is compressed */
+	RDS_FLAG_IS_COMPRESSED      = 0x0020,
+	/* Program type can change */
+	RDS_FLAG_IS_DYNAMIC_PTY     = 0x0040,
+	/* If this flag changes state, a new radio text string begins */
+	RDS_FLAG_TEXT_AB            = 0x0080
+};
+
+enum {
+	/* One of the RDS flags has changed state */
+	RDS_EVENT_FLAGS          = 0x0001,
+	/* The program identification code has changed */
+	RDS_EVENT_PI_CODE        = 0x0002,
+	/* The program type code has changed */
+	RDS_EVENT_PTY_CODE       = 0x0004,
+	/* The program name has changed */
+	RDS_EVENT_PROGRAMNAME    = 0x0008,
+	/* A new UTC date/time is available */
+	RDS_EVENT_UTCDATETIME    = 0x0010,
+	/* A new local date/time is available */
+	RDS_EVENT_LOCDATETIME    = 0x0020,
+	/* A radio text string was completed */
+	RDS_EVENT_LAST_RADIOTEXT = 0x0040,
+	/* Current Channel RF signal strength too weak, need do AF switch */
+	RDS_EVENT_AF             = 0x0080,
+	/* An alternative frequency list is ready */
+	RDS_EVENT_AF_LIST        = 0x0100,
+	/* An alternative frequency list is ready */
+	RDS_EVENT_AFON_LIST      = 0x0200,
+	/* Other Network traffic announcement start */
+	RDS_EVENT_TAON           = 0x0400,
+	/* Other Network traffic announcement finished. */
+	RDS_EVENT_TAON_OFF       = 0x0800,
+	/* RDS Interrupt had arrived durint timer period */
+	RDS_EVENT_RDS            = 0x2000,
+	/* RDS Interrupt not arrived durint timer period */
+	RDS_EVENT_NO_RDS         = 0x4000,
+	/* Timer for RDS Bler Check. ---- BLER  block error rate */
+	RDS_EVENT_RDS_TIMER      = 0x8000
+};
+
+enum {
+	FM_I2S_ON = 0,
+	FM_I2S_OFF,
+	FM_I2S_STATE_ERR
+};
+
+enum {
+	FM_I2S_MASTER = 0,
+	FM_I2S_SLAVE,
+	FM_I2S_MODE_ERR
+};
+
+enum {
+	FM_I2S_32K = 0,
+	FM_I2S_44K,
+	FM_I2S_48K,
+	FM_I2S_SR_ERR
+};
+
+struct fm_i2s_setting {
+	int onoff;
+	int mode;
+	int sample;
+};
+
+enum {
+	FM_RX = 0,
+	FM_TX = 1
+};
+
+struct fm_i2s_info_t {
+	/* 0:FM_I2S_ON, 1:FM_I2S_OFF,2:error */
+	int status;
+	/* 0:FM_I2S_MASTER, 1:FM_I2S_SLAVE,2:error */
+	int mode;
+	/* 0:FM_I2S_32K:32000, 1:FM_I2S_44K:44100,2:FM_I2S_48K:48000,3:error */
+	int rate;
+};
+
+enum fm_audio_path_e {
+	FM_AUD_ANALOG = 0,
+	FM_AUD_I2S = 1,
+	FM_AUD_MRGIF = 2,
+	FM_AUD_ERR
+};
+
+enum fm_i2s_pad_sel_e {
+	FM_I2S_PAD_CONN = 0,
+	FM_I2S_PAD_IO = 1,
+	FM_I2S_PAD_ERR
+};
+
+struct fm_audio_info_t {
+	enum fm_audio_path_e aud_path;
+	struct fm_i2s_info_t i2s_info;
+	enum fm_i2s_pad_sel_e i2s_pad;
+};
+
+struct fm_cqi {
+	int ch;
+	int rssi;
+	int reserve;
+};
+
+struct fm_cqi_req {
+	uint16_t ch_num;
+	int buf_size;
+	char *cqi_buf;
+};
+
+struct  fm_desense_check_t {
+	int freq;
+	int rssi;
+};
+
+struct  fm_full_cqi_log_t {
+	/* lower band, Eg, 7600 -> 76.0Mhz */
+	uint16_t lower;
+	/* upper band, Eg, 10800 -> 108.0Mhz */
+	uint16_t upper;
+	/* 0x1: 50KHz, 0x2: 100Khz, 0x4: 200Khz */
+	int space;
+	/* repeat times */
+	int cycle;
+};
+
+struct fm_rx_data {
+	unsigned char		*addr;
+	unsigned int		len;
+	unsigned int		fifo_id;
+	struct list_head	entry;
+};
+
+struct fm_rds_handle {
+	/* is RDS on or off */
+	unsigned char rds_flag;
+	wait_queue_head_t rx_queue;
+	unsigned short new_data_flag;
+};
+
+struct fmdrv_ops {
+	struct completion	completed;
+	unsigned int		rcv_len;
+	void			*read_buf;
+	void			*tx_buf_p;
+	void				*com_response;
+	void				*seek_response;
+	unsigned int		tx_len;
+	unsigned char		write_buf[64];
+	unsigned char		com_respbuf[12];
+	unsigned char		seek_respbuf[12];
+	struct tasklet_struct rx_task;
+	struct tasklet_struct tx_task;
+	struct fm_rds_data rds_data;
+	spinlock_t		rw_lock;
+	struct mutex		mutex;
+	struct list_head	rx_head;
+	struct completion commontask_completion;
+	struct completion seektask_completion;
+	struct completion *response_completion;
+	struct fm_rds_handle rds_han;
+};
+
+#define FM_IOC_MAGIC		0xf5
+#define FM_IOCTL_POWERUP       _IOWR(FM_IOC_MAGIC, 0, struct fm_tune_parm*)
+#define FM_IOCTL_POWERDOWN     _IOWR(FM_IOC_MAGIC, 1, int32_t*)
+#define FM_IOCTL_TUNE          _IOWR(FM_IOC_MAGIC, 2, struct fm_tune_parm*)
+#define FM_IOCTL_SEEK          _IOWR(FM_IOC_MAGIC, 3, struct fm_seek_parm*)
+#define FM_IOCTL_SETVOL        _IOWR(FM_IOC_MAGIC, 4, uint32_t*)
+#define FM_IOCTL_GETVOL        _IOWR(FM_IOC_MAGIC, 5, uint32_t*)
+#define FM_IOCTL_MUTE          _IOWR(FM_IOC_MAGIC, 6, uint32_t*)
+#define FM_IOCTL_GETRSSI       _IOWR(FM_IOC_MAGIC, 7, int32_t*)
+#define FM_IOCTL_SCAN          _IOWR(FM_IOC_MAGIC, 8, struct fm_scan_parm*)
+#define FM_IOCTL_STOP_SCAN     _IO(FM_IOC_MAGIC,   9)
+
+#define FM_IOCTL_GETCHIPID     _IOWR(FM_IOC_MAGIC, 10, uint16_t*)
+#define FM_IOCTL_EM_TEST       _IOWR(FM_IOC_MAGIC, 11, struct fm_em_parm*)
+
+#define FM_IOCTL_GETMONOSTERO  _IOWR(FM_IOC_MAGIC, 13, uint16_t*)
+#define FM_IOCTL_GETCURPAMD    _IOWR(FM_IOC_MAGIC, 14, uint16_t*)
+#define FM_IOCTL_GETGOODBCNT   _IOWR(FM_IOC_MAGIC, 15, uint16_t*)
+#define FM_IOCTL_GETBADBNT     _IOWR(FM_IOC_MAGIC, 16, uint16_t*)
+#define FM_IOCTL_GETBLERRATIO  _IOWR(FM_IOC_MAGIC, 17, uint16_t*)
+
+#define FM_IOCTL_RDS_ONOFF     _IOWR(FM_IOC_MAGIC, 18, uint16_t*)
+#define FM_IOCTL_RDS_SUPPORT   _IOWR(FM_IOC_MAGIC, 19, int32_t*)
+
+#define FM_IOCTL_RDS_SIM_DATA  _IOWR(FM_IOC_MAGIC, 23, uint32_t*)
+#define FM_IOCTL_IS_FM_POWERED_UP  _IOWR(FM_IOC_MAGIC, 24, uint32_t*)
+
+#define FM_IOCTL_OVER_BT_ENABLE  _IOWR(FM_IOC_MAGIC, 29, int32_t*)
+
+#define FM_IOCTL_ANA_SWITCH     _IOWR(FM_IOC_MAGIC, 30, int32_t*)
+#define FM_IOCTL_GETCAPARRAY	_IOWR(FM_IOC_MAGIC, 31, int32_t*)
+
+#define FM_IOCTL_I2S_SETTING  _IOWR(FM_IOC_MAGIC, 33, struct fm_i2s_setting*)
+
+#define FM_IOCTL_RDS_GROUPCNT   _IOWR(FM_IOC_MAGIC, 34, \
+				struct rds_group_cnt_req*)
+#define FM_IOCTL_RDS_GET_LOG    _IOWR(FM_IOC_MAGIC, 35, struct rds_raw_data*)
+
+#define FM_IOCTL_SCAN_GETRSSI   _IOWR(FM_IOC_MAGIC, 36, struct fm_rssi_req*)
+#define FM_IOCTL_SETMONOSTERO   _IOWR(FM_IOC_MAGIC, 37, int32_t)
+#define FM_IOCTL_RDS_BC_RST     _IOWR(FM_IOC_MAGIC, 38, int32_t*)
+#define FM_IOCTL_CQI_GET	_IOWR(FM_IOC_MAGIC, 39, struct fm_cqi_req*)
+#define FM_IOCTL_GET_HW_INFO    _IOWR(FM_IOC_MAGIC, 40, struct fm_hw_info*)
+#define FM_IOCTL_GET_I2S_INFO   _IOWR(FM_IOC_MAGIC, 41, struct fm_i2s_info_t*)
+#define FM_IOCTL_IS_DESE_CHAN   _IOWR(FM_IOC_MAGIC, 42, int32_t*)
+#define FM_IOCTL_TOP_RDWR	_IOWR(FM_IOC_MAGIC, 43, struct fm_top_rw_parm*)
+#define FM_IOCTL_HOST_RDWR	_IOWR(FM_IOC_MAGIC, 44, struct fm_host_rw_parm*)
+
+#define FM_IOCTL_PRE_SEARCH	_IOWR(FM_IOC_MAGIC, 45, int32_t)
+#define FM_IOCTL_RESTORE_SEARCH _IOWR(FM_IOC_MAGIC, 46, int32_t)
+
+#define FM_IOCTL_SET_SEARCH_THRESHOLD   _IOWR(FM_IOC_MAGIC, 47, \
+		fm_search_threshold_t*)
+
+#define FM_IOCTL_GET_AUDIO_INFO _IOWR(FM_IOC_MAGIC, 48, struct fm_audio_info_t*)
+
+#define FM_IOCTL_SCAN_NEW       _IOWR(FM_IOC_MAGIC, 60, struct fm_scan_t*)
+#define FM_IOCTL_SEEK_NEW       _IOWR(FM_IOC_MAGIC, 61, struct fm_seek_t*)
+#define FM_IOCTL_TUNE_NEW       _IOWR(FM_IOC_MAGIC, 62, struct fm_tune_t*)
+
+#define FM_IOCTL_SOFT_MUTE_TUNE _IOWR(FM_IOC_MAGIC, 63, \
+	struct fm_softmute_tune_t*)
+#define FM_IOCTL_DESENSE_CHECK   _IOWR(FM_IOC_MAGIC, 64, \
+	struct fm_desense_check_t*)
+
+
+/*IOCTL for SPRD SPECIAL */
+/*audio mode:0:mono, 1:stereo; 2:blending*/
+#define FM_IOCTL_SET_AUDIO_MODE       _IOWR(FM_IOC_MAGIC, 0x47, int32_t*)
+#define FM_IOCTL_SET_REGION       _IOWR(FM_IOC_MAGIC, 0x48, int32_t*)
+#define FM_IOCTL_SET_SCAN_STEP       _IOWR(FM_IOC_MAGIC, 0x49, int32_t*)
+#define FM_IOCTL_CONFIG_DEEMPHASIS       _IOWR(FM_IOC_MAGIC, 0x4A, int32_t*)
+#define FM_IOCTL_GET_AUDIO_MODE       _IOWR(FM_IOC_MAGIC, 0x4B, int32_t*)
+#define FM_IOCTL_GET_CUR_BLER       _IOWR(FM_IOC_MAGIC, 0x4C, int32_t*)
+#define FM_IOCTL_GET_SNR       _IOWR(FM_IOC_MAGIC, 0x4D, int32_t*)
+#define FM_IOCTL_SOFTMUTE_ONOFF       _IOWR(FM_IOC_MAGIC, 0x4E, int32_t*)
+/*Frequency offset, PDP_TH,PHP_TH, SNR_TH,RSS_THI*/
+#define FM_IOCTL_SET_SEEK_CRITERIA       _IOWR(FM_IOC_MAGIC, 0x4F, \
+			struct fm_seek_criteria_parm*)
+/*softmute ,blending ,snr_th*/
+#define FM_IOCTL_SET_AUDIO_THRESHOLD _IOWR(FM_IOC_MAGIC, 0x50, \
+			struct fm_audio_threshold_parm*)
+/*Frequency offset, PDP_TH,PHP_TH, SNR_TH,RSS_THI*/
+#define FM_IOCTL_GET_SEEK_CRITERIA       _IOWR(FM_IOC_MAGIC, 0x51, \
+			struct fm_seek_criteria_parm*)
+/*softmute ,blending ,snr_th*/
+#define FM_IOCTL_GET_AUDIO_THRESHOLD _IOWR(FM_IOC_MAGIC, 0x52, \
+			struct fm_audio_threshold_parm*)
+#define FM_IOCTL_RW_REG        _IOWR(FM_IOC_MAGIC, 0xC, struct fm_reg_ctl_parm*)
+#define FM_IOCTL_AF_ONOFF     _IOWR(FM_IOC_MAGIC, 0x53, uint16_t*)
+
+/* IOCTL for EM */
+#define FM_IOCTL_FULL_CQI_LOG _IOWR(FM_IOC_MAGIC, 70, \
+	struct fm_full_cqi_log_t *)
+
+#define FM_IOCTL_DUMP_REG   _IO(FM_IOC_MAGIC, 0xFF)
+
+#define MAX_FM_FREQ	        1080
+#define MIN_FM_FREQ	        875
+
+#define FM_CTL_STI_MODE_NORMAL	0x0
+#define	FM_CTL_STI_MODE_SEEK    0x1
+#define	FM_CTL_STI_MODE_TUNE    0x2
+
+#endif /* _FM_DRV_H */
diff --git a/drivers/misc/sprd-wcn/radio/fmdrv_main.c b/drivers/misc/sprd-wcn/radio/fmdrv_main.c
new file mode 100644
index 0000000..c48b534
--- /dev/null
+++ b/drivers/misc/sprd-wcn/radio/fmdrv_main.c
@@ -0,0 +1,1245 @@
+/*
+ * SPREADTRUM SC2342 FM Radio driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioctl.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+
+#include "fmdrv.h"
+#include "fmdrv_main.h"
+#include "fmdrv_ops.h"
+#include "fmdrv_rds_parser.h"
+
+#ifdef CONFIG_OF
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#endif
+
+#define FM_CHANNEL_WRITE		5
+#define FM_CHANNEL_READ			10
+#define FM_WRITE_SIZE			(64)
+#define FM_READ_SIZE			(128)
+#define FM_TYPE				1
+#define FM_SUBTYPE0			0
+#define FM_SUBTYPE1			1
+#define FM_SUBTYPE2			2
+#define FM_SUBTYPE3			3
+
+#define HCI_GRP_VENDOR_SPECIFIC		0x3F
+#define FM_SPRD_OP_CODE			0x008C
+#define hci_opcode_pack(ogf, ocf)	\
+	((unsigned short) ((ocf & 0x03ff) | (ogf << 10)))
+#define HCI_EV_CMD_COMPLETE		0x0e
+#define HCI_VS_EVENT			0xFF
+
+#define SEEKFORMAT "rssi_th =%d,snr_th =%d,freq_offset_th =%d," \
+		"pilot_power_th= %d,noise_power_th=%d"
+#define AUDIOFORMAT "hbound=%d,lbound =%d,power_th =%d," \
+		"phyt= %d,snr_th=%d"
+bool read_flag;
+struct fmdrv_ops *fmdev;
+static struct fm_rds_data *g_rds_data_string;
+
+/* for driver test */
+#define RX_NUM 100
+static unsigned char *buf_addr;
+static char a[RX_NUM] = {1, 2, 3, 4, 5};
+static unsigned char r1[11] = {0x04, 0x0e, 0x08, 0x01, 0x8c, 0xfc,
+	0x00, 0xa1, 0x23, 0x12, 0x2A};
+static unsigned char r2[9] = {0x04, 0xFF, 0x6, 0x30, 0x00, 0x12, 0x13,
+	0xb4, 0x23};
+static unsigned int (*rx_cb)(void *addr, unsigned int len,
+			unsigned int fifo_id);
+static unsigned int (*tx_cb)(void *addr);
+static struct timer_list test_timer;
+
+static void sdiom_register_pt_rx_process(unsigned int type,
+					 unsigned int subtype,
+					 void *func)
+{
+	rx_cb = func;
+}
+
+static void sdiom_register_pt_tx_release(unsigned int type,
+					 unsigned int subtype,
+					 void *func)
+{
+	tx_cb = func;
+}
+
+static unsigned int sdiom_pt_write(void *buf, unsigned int len,
+				   int type, int subtype)
+{
+	int i = 0;
+
+	buf_addr = buf;
+	pr_info("fmdrv sdiom_pt_write len is %d\n", len);
+	for (i = 0; i < len; i++)
+		pr_info("fmdrv send data is %x\n", *(buf_addr+i));
+
+	mod_timer(&test_timer, jiffies + msecs_to_jiffies(30));
+
+	return 0;
+}
+
+unsigned int sdiom_pt_read_release(unsigned int fifo_id)
+{
+	return 0;
+}
+
+int start_marlin(int type)
+{
+	return 0;
+}
+
+int stop_marlin(int type)
+{
+	return 0;
+}
+
+static void timer_cb(unsigned long data)
+{
+	rx_cb(r1, 11, 0);
+	if (*(buf_addr+4) == 0x04) {
+		mdelay(100);
+		rx_cb(r2, 9, 0);
+	}
+}
+
+static void test_init(void)
+{
+	int i;
+
+	for (i = 0; i < RX_NUM; i++)
+		a[i] = i;
+}
+
+static int fm_send_cmd(unsigned char subcmd, void *payload,
+		int payload_len)
+{
+	unsigned char *cmd_buf;
+	struct fm_cmd_hdr *cmd_hdr;
+	int size;
+	int ret = 0;
+
+	size = sizeof(struct fm_cmd_hdr) +
+		((payload == NULL) ? 0 : payload_len);
+
+	cmd_buf = kmalloc(size, GFP_KERNEL);
+	if (!cmd_buf)
+		return -ENOMEM;
+
+	/* Fill command information */
+	cmd_hdr = (struct fm_cmd_hdr *)cmd_buf;
+	cmd_hdr->header = 0x01;
+	cmd_hdr->opcode = hci_opcode_pack(HCI_GRP_VENDOR_SPECIFIC,
+		FM_SPRD_OP_CODE);
+	cmd_hdr->len = ((payload == NULL) ? 0 : payload_len) + 1;
+	cmd_hdr->fm_subcmd = subcmd;
+
+	if (payload != NULL)
+		memcpy(cmd_buf + sizeof(struct fm_cmd_hdr),
+		payload, payload_len);
+	fmdev->tx_buf_p = cmd_buf;
+	fmdev->tx_len = size;
+
+	ret = sdiom_pt_write(fmdev->tx_buf_p, size, FM_TYPE, FM_SUBTYPE0);
+	if (ret != 0) {
+		pr_err("fmdrv write cmd to sdiom fail Error number=%d\n", ret);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int fm_write_cmd(unsigned char subcmd, void *payload,
+		unsigned char payload_len,  void *response,
+		unsigned char *response_len)
+{
+	unsigned long timeleft;
+	int ret;
+
+	mutex_lock(&fmdev->mutex);
+	init_completion(&fmdev->commontask_completion);
+	ret = fm_send_cmd(subcmd, payload, payload_len);
+	if (ret < 0) {
+		mutex_unlock(&fmdev->mutex);
+		return ret;
+	}
+
+	timeleft = wait_for_completion_timeout(&fmdev->commontask_completion,
+		FM_DRV_TX_TIMEOUT);
+	if (!timeleft) {
+		pr_err("(fmdrv) %s(): Timeout(%d sec),didn't get fm SubCmd\n"
+			"0x%02X completion signal from RX tasklet\n",
+		__func__, jiffies_to_msecs(FM_DRV_TX_TIMEOUT) / 1000, subcmd);
+		mutex_unlock(&fmdev->mutex);
+		return -ETIMEDOUT;
+	}
+
+	mutex_unlock(&fmdev->mutex);
+	pr_debug("fmdrv wait command have complete\n");
+	/* 0:len; XX XX XX sttaus */
+	if ((fmdev->com_respbuf[4]) != 0) {
+		pr_err("(fmdrv) %s(): Response status not success for 0x%02X\n",
+			__func__, subcmd);
+		return -EFAULT;
+	}
+	pr_info("(fmdrv) %s(): Response status success for 0x%02X: %d\n",
+			__func__, subcmd, fmdev->com_respbuf[4]);
+	/* the event : 04 0e len 01 8C  fc  00(status) rssi snr freq .p->len */
+	if (response != NULL && response_len != NULL)
+		memcpy(response, &(fmdev->com_respbuf[5]),
+			fmdev->com_respbuf[0]-4);
+
+	return 0;
+}
+
+static void receive_tasklet(unsigned long arg)
+{
+	struct fmdrv_ops *fmdev;
+	struct fm_rx_data *rx = NULL;
+	/* the data from SDIO is event data */
+	unsigned char *pdata;
+
+	fmdev = (struct fmdrv_ops *)arg;
+	if (unlikely(!fmdev)) {
+		pr_err("fm_rx_task fmdev is NULL\n");
+		return;
+	}
+	pr_info("fm %s start running\n", __func__);
+	while (!list_empty(&fmdev->rx_head)) {
+		spin_lock_bh(&fmdev->rw_lock);
+
+		rx = list_first_entry_or_null(&fmdev->rx_head,
+				struct fm_rx_data, entry);
+		if (rx)
+			list_del(&rx->entry);
+
+		else {
+			spin_unlock_bh(&fmdev->rw_lock);
+			return;
+		}
+		pdata = rx->addr;
+
+		if ((*((rx->addr)+1)) == 0x0e) {
+			memcpy(fmdev->com_respbuf, pdata + 2, (*(pdata+2)) + 1);
+			pr_debug("fm RX before commontask_completion=0x%x\n",
+			fmdev->commontask_completion.done);
+			complete(&fmdev->commontask_completion);
+			pr_debug("fm RX after commontask_completion=0x%x\n",
+			fmdev->commontask_completion.done);
+			sdiom_pt_read_release(rx->fifo_id);
+			pr_info("fmdrv release fifo_id is %d\n", rx->fifo_id);
+		}
+
+		else if (((*((rx->addr)+1)) == 0xFF) &&
+					((*((rx->addr)+3)) == 0x30)) {
+			memcpy(fmdev->seek_respbuf, pdata + 2,
+					(*(pdata+2)) + 1);
+			/*fmdev->seek_response = rx;*/
+			pr_debug("fm RX before seektask_completion=0x%x\n",
+			fmdev->seektask_completion.done);
+			complete(&fmdev->seektask_completion);
+			pr_debug("fm RX after seektask_completion=0x%x\n",
+			fmdev->seektask_completion.done);
+			sdiom_pt_read_release(rx->fifo_id);
+			pr_info("fmdrv release fifo_id is %d\n", rx->fifo_id);
+		}
+
+		else if (((*((rx->addr)+1)) == 0xFF) &&
+					((*((rx->addr)+3)) == 0x00))
+			rds_parser(pdata + 4, 12, rx->fifo_id);
+		else {
+			pr_err("fmdrv error:unknown event !!!\n");
+			sdiom_pt_read_release(rx->fifo_id);
+			pr_info("fmdrv release fifo_id is %d\n", rx->fifo_id);
+		}
+
+		kfree(rx);
+		rx = NULL;
+		spin_unlock_bh(&fmdev->rw_lock);
+	}
+}
+
+ssize_t fm_read_rds_data(struct file *filp, char __user *buf,
+	size_t count, loff_t *pos)
+{
+	int timeout = -1;
+	int ret;
+
+	pr_info("(FM_RDS) fm start to read RDS data\n");
+
+	if (filp->f_flags & O_NONBLOCK) {
+		timeout = 0;
+		pr_err("fm_read_rds_data NON BLOCK!!!\n");
+		return -EWOULDBLOCK;
+	}
+
+	if (timeout < 0) {
+		/* wait forever */
+		ret = wait_event_interruptible((fmdev->rds_han.rx_queue),
+			((fmdev->rds_han.new_data_flag) == 1));
+		if (ret) {
+			pr_err("(FM RDS)wait_event_interruptible ret=%d\n",
+				ret);
+			return -EINTR;
+		}
+	}
+
+	fmdev->rds_data.rt_data.textlength =
+		strlen(fmdev->rds_data.rt_data.textdata[3]);
+	pr_info("fm RT len is %d\n", fmdev->rds_data.rt_data.textlength);
+	if (copy_to_user(buf, &(fmdev->rds_data), sizeof(fmdev->rds_data))) {
+		pr_info("fm_read_rds_data ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	pr_info("(fm drs) fm event is %x\n", fmdev->rds_data.event_status);
+	fmdev->rds_data.event_status = 0;
+
+	pr_info("fmevent_status=%x\n", fmdev->rds_data.event_status);
+	pr_info("PS=%s\n", fmdev->rds_data.ps_data.PS[3]);
+	pr_info("fm_read_rds_data end....\n");
+
+	return sizeof(fmdev->rds_data);
+}
+
+void parse_at_fm_cmd(unsigned int *freq_found)
+{
+	int comma_cou = 0;
+	int i = 0;
+	int cmdstart = 0;
+	int len = 0;
+	char *cur_ptr;
+	char num_str[6] = {0};
+	int result = 0;
+
+	cur_ptr = fmdev->read_buf;
+	read_flag = 0;
+	for (i = 0; i < 32 && cur_ptr[i] != '\0'; i++) {
+		if (cur_ptr[i] == ',')
+			comma_cou++;
+		if (comma_cou == 3) {
+			comma_cou = 0;
+			cmdstart = i;
+		}
+	}
+	for (i = 0, cmdstart++; cmdstart < 32 && cur_ptr[cmdstart] != '\0'
+		&& cur_ptr[cmdstart] != ','; i++, cmdstart++) {
+		if (cur_ptr[cmdstart] >= '0' && cur_ptr[cmdstart] <= '9')
+			num_str[i] = cur_ptr[cmdstart];
+		else if (cur_ptr[cmdstart] == ' ')
+			break;
+	}
+	len = strlen(num_str);
+	cur_ptr = num_str;
+	result = cur_ptr[0] - '0';
+	for (i = 1; i < len; i++)
+		result = result * 10 + cur_ptr[i] - '0';
+	*freq_found = result;
+	pr_info("fm seek event have come freq=%d\n", result);
+}
+
+int fm_open(struct inode *inode, struct file *filep)
+{
+	pr_info("start open SPRD fm module...\n");
+
+	return 0;
+}
+
+void fm_sdio_read(void)
+{
+	memset(fmdev->read_buf, 0, FM_READ_SIZE);
+	if (fmdev->rcv_len <= 0) {
+		pr_err("FM_CHANNEL_READ len err\n");
+		return;
+	}
+	if (fmdev->rcv_len > FM_READ_SIZE)
+		pr_err("The read data len:%d, beyond max read:%d",
+		fmdev->rcv_len, FM_READ_SIZE);
+	pr_info("* fmdev->read_buf: %s *\n", (char *)fmdev->read_buf);
+}
+
+int fm_sdio_write(unsigned char *buffer, unsigned int size)
+{
+	printk_ratelimited("%s size: %d\n", __func__, size);
+
+	return size;
+}
+
+int fm_sdio_init(void)
+{
+	return 0;
+}
+
+unsigned int fm_rx_cback(void *addr, unsigned int len, unsigned int fifo_id)
+{
+	unsigned char *buf;
+
+	buf = (unsigned char *)addr;
+
+	if (fmdev != NULL) {
+		struct fm_rx_data *rx =
+			kmalloc(sizeof(struct fm_rx_data), GFP_KERNEL);
+		if (!rx) {
+			pr_err("(fmdrv): %s(): No memory to create fm rx buf\n",
+					__func__);
+			sdiom_pt_read_release(fifo_id);
+			return -ENOMEM;
+		}
+		rx->addr = (unsigned char *)addr;
+		rx->len		= len;
+		rx->fifo_id	= fifo_id;
+		spin_lock_bh(&fmdev->rw_lock);
+		list_add_tail(&rx->entry, &fmdev->rx_head);
+		spin_unlock_bh(&fmdev->rw_lock);
+		pr_debug("(fmdrv) %s(): tasklet_schedule start\n", __func__);
+		tasklet_schedule(&fmdev->rx_task);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fm_rx_cback);
+
+void fm_tx_cback(void *tx_buff)
+{
+	if (tx_buff != NULL)
+		kfree(tx_buff);
+}
+EXPORT_SYMBOL_GPL(fm_tx_cback);
+
+int fm_write(unsigned char *array, unsigned char len)
+{
+	unsigned long timeleft;
+	int cnt = 0;
+
+	cnt = 0;
+	/* len = strlen(array); */
+	fm_sdio_write(array, len);
+
+	timeleft = wait_for_completion_timeout(&fmdev->completed,
+		FM_DRV_TX_TIMEOUT);
+	if (!timeleft) {
+		pr_err("Timeout, %d\n", ETIMEDOUT);
+		return -ETIMEDOUT;
+
+	}
+
+	pr_debug("success!\n");
+
+	return 0;
+}
+
+int fm_powerup(void *arg)
+{
+	struct fm_tune_parm parm;
+	unsigned short payload;
+	int ret = -1;
+
+	if (copy_from_user(&parm, arg, sizeof(parm))) {
+		pr_err("fm powerup 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+
+	if (start_marlin(MARLIN_FM)) {
+		pr_err("marlin2 chip %s failed\n", __func__);
+		return -ENODEV;
+	}
+
+	parm.freq *= 10;
+	pr_info("fm ioctl power up freq= %d\n", parm.freq);
+	payload = parm.freq;
+	ret = fm_write_cmd(FM_POWERUP_CMD, &payload,
+		sizeof(payload), NULL, NULL);
+	if (ret < 0)
+		pr_err("(fmdrv) %s FM write pwrup cmd status failed %d\n",
+			__func__, ret);
+
+	return ret;
+}
+
+int fm_powerdown(void)
+{
+	int ret = -EINVAL;
+	unsigned char payload = FM_OFF;
+
+	fmdev->rds_han.new_data_flag = 1;
+	wake_up_interruptible(&fmdev->rds_han.rx_queue);
+	ret = fm_write_cmd(FM_POWERDOWN_CMD, &payload, sizeof(payload),
+		NULL, NULL);
+	if (ret < 0)
+		pr_err("(fmdrv) %s FM write pwrdown cmd status failed %d\n",
+			__func__, ret);
+
+	return ret;
+}
+
+int fm_tune(void *arg)
+{   struct fm_tune_parm parm;
+	int ret = 0;
+	unsigned char respond_buf[4], respond_len;
+	unsigned short freq;
+
+	if (copy_from_user(&parm, arg, sizeof(parm))) {
+		pr_info("fm tune 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	parm.freq *= 10;
+	pr_debug("fm ioctl tune freq = %d\n", parm.freq);
+	ret = fm_write_cmd(FM_TUNE_CMD, &parm.freq, sizeof(parm.freq),
+		respond_buf, &respond_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write tune cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+	freq = respond_buf[2] + (respond_buf[3] << 8);
+	pr_debug("(fmdrv) fm tune have finshed!!status =0,RSSI=%d\n"
+		"(fmdrv) SNR=%d,freq=%d\n", respond_buf[0], respond_buf[1],
+			freq);
+
+	return ret;
+}
+
+/*
+ * seek cmd :01 8C FC 04(length) 04 freq(16bit) seekdir(8bit)
+ * payload == freq,seekdir
+ * seek event:status,RSSI,SNR,Freq
+ */
+int fm_seek(void *arg)
+{   struct fm_seek_parm parm;
+	int ret = 0;
+	unsigned char payload[3];
+	unsigned char respond_buf[5];
+	unsigned long timeleft;
+
+	if (copy_from_user(&parm, arg, sizeof(parm))) {
+		pr_info("fm seek 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	parm.freq *= 10;
+	payload[0] = (parm.freq & 0xFF);
+	payload[1] = (parm.freq >> 8);
+	payload[2] = parm.seekdir;
+	pr_info("fm ioctl seek freq=%d,dir =%d\n", parm.freq, parm.seekdir);
+	ret = fm_write_cmd(FM_SEEK_CMD, payload, sizeof(payload), NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write seek cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+	init_completion(&fmdev->seektask_completion);
+	timeleft = wait_for_completion_timeout(&fmdev->seektask_completion,
+		FM_DRV_RX_SEEK_TIMEOUT);
+	if (!timeleft) {
+		pr_err("(fmdrv) %s(): Timeout(%d sec),didn't get fm seek end !\n",
+		__func__, jiffies_to_msecs(FM_DRV_RX_SEEK_TIMEOUT) / 1000);
+		/* -110 */
+		return -ETIMEDOUT;
+	}
+
+	memcpy(respond_buf, &(fmdev->seek_respbuf[2]),
+		fmdev->seek_respbuf[0] - 1);
+
+	parm.freq = respond_buf[3] + (respond_buf[4] << 8);
+	parm.freq /= 10;
+	pr_info("(fmdrv) fm seek have finshed!!status = %d, RSSI=%d\n"
+		"(fmdrv) fm seek SNR=%d, freq=%d\n", respond_buf[0],
+		respond_buf[1], respond_buf[2], parm.freq);
+	/* pass the value to user space */
+	if (copy_to_user(arg, &parm, sizeof(parm)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+/*
+ * mute cmd :01 8C FC  02(length)  02 mute(8bit)
+ * mute event:status,ismute
+ */
+int fm_mute(void *arg)
+{
+	unsigned char mute = 0;
+	int ret = -1;
+
+	if (copy_from_user(&mute, arg, sizeof(mute))) {
+		pr_err("fm mute 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+
+	if (mute == 1)
+		pr_info("fm ioctl mute\n");
+	else if (mute == 0)
+		pr_info("fm ioctl unmute\n");
+	else
+		pr_info("fm ioctl unknown cmd mute\n");
+
+	ret = fm_write_cmd(FM_MUTE_CMD, &mute,
+		sizeof(mute), NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write mute cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_set_volume(void *arg)
+{
+	unsigned char vol;
+	int ret = 0;
+
+	if (copy_from_user(&vol, arg, sizeof(vol))) {
+		pr_err("fm set volume 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	pr_info("fm ioctl set_volume =%d\n", vol);
+	ret = fm_write_cmd(FM_SET_VOLUME_CMD, &vol, sizeof(vol),
+			NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM set volume status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_get_volume(void *arg)
+{
+	unsigned char payload = 0;
+	unsigned char res_len;
+	int volume;
+	unsigned char resp_buf[1];
+	int ret = -1;
+
+	pr_info("fm ioctl get volume =0x%x\n", volume);
+	ret = fm_write_cmd(FM_GET_VOLUME_CMD, &payload, sizeof(payload),
+		&resp_buf[0], &res_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write get volime cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	volume = (int)resp_buf[0];
+	if (copy_to_user(arg, &volume, sizeof(volume)))
+		ret = -EFAULT;
+
+	return ret;
+
+}
+
+int fm_stop_scan(void *arg)
+{
+	int ret = -EINVAL;
+
+	pr_info("fm ioctl stop scan\n");
+	ret = fm_write_cmd(FM_SEARCH_ABORT, NULL, 0,
+		NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write stop scan cmd status failed %d\n",
+			__func__, ret);
+
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_scan_all(void *arg)
+{
+	struct fm_scan_all_parm parm;
+	int ret = 0;
+	unsigned char respond_len;
+	struct fm_scan_all_parm respond_buf;
+
+
+	pr_info("fm ioctl scan all\n");
+	if (copy_from_user(&parm, arg, sizeof(parm))) {
+		pr_err("fm search all 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+
+	ret = fm_write_cmd(FM_SCAN_ALL_CMD, &parm, sizeof(parm),
+		&respond_buf, &respond_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write scan all cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+	if (copy_to_user(arg, &parm, sizeof(parm)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+int fm_rw_reg(void *arg)
+{
+	struct fm_reg_ctl_parm parm;
+	int ret = 0;
+	unsigned char  respond_len;
+
+	if (copy_from_user(&parm, arg, sizeof(parm))) {
+		pr_err("fm read and write register 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	pr_info("fm ioctl read write reg = %d\n", parm.rw_flag);
+	ret = fm_write_cmd(FM_READ_WRITE_REG_CMD, &parm, sizeof(parm),
+		&parm, &respond_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write register cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+	if (copy_to_user(arg, &parm, sizeof(parm)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+int fm_get_monostero(void *arg)
+{
+	return 0;
+}
+
+/* audio mode: 0:None   1: mono  2:steron  */
+int fm_set_audio_mode(void *arg)
+{
+	unsigned char mode;
+	int ret = 0;
+
+	if (copy_from_user(&mode, arg, sizeof(mode))) {
+		pr_err("fm set audio mode 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	pr_info("fm ioctl set audio mode =%d\n", mode);
+	ret = fm_write_cmd(FM_SET_AUDIO_MODE, &mode, sizeof(mode),
+			NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM set audio mode status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_set_region(void *arg)
+{
+	unsigned char region;
+	int ret = 0;
+
+	if (copy_from_user(&region, arg, sizeof(region))) {
+		pr_err("fm set region 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	pr_info("fm ioctl set region =%d\n", region);
+	ret = fm_write_cmd(FM_SET_REGION, &region, sizeof(region),
+			NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM set region status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_set_scan_step(void *arg)
+{
+	unsigned char step;
+	int ret = 0;
+
+	if (copy_from_user(&step, arg, sizeof(step))) {
+		pr_err("fm set scan step 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	pr_info("fm ioctl set scan step =%d\n", step);
+	ret = fm_write_cmd(FM_SET_SCAN_STEP, &step, sizeof(step),
+			NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM set scan step status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_config_deemphasis(void *arg)
+{
+	unsigned char dp;
+	int ret = 0;
+
+	if (copy_from_user(&dp, arg, sizeof(dp))) {
+		pr_err("fm config_deemphasis 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	pr_info("fm ioctl config_deemphasis =%d\n", dp);
+	ret = fm_write_cmd(FM_CONFIG_DEEMPHASIS, &dp, sizeof(dp),
+			NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM config_deemphasis status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_get_audio_mode(void *arg)
+{
+	unsigned char res_len;
+	int audio_mode;
+	unsigned char resp_buf[2];
+	int ret = -1;
+
+	pr_info("fm ioctl get audio mode\n");
+	ret = fm_write_cmd(FM_GET_AUDIO_MODE, NULL, 0,
+		&resp_buf[0], &res_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM get audio mode cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	audio_mode = (int)resp_buf[1];
+	if (copy_to_user(arg, &audio_mode, sizeof(audio_mode)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+int fm_get_current_bler(void *arg)
+{
+	unsigned char res_len;
+	int BLER;
+	unsigned char resp_buf[1];
+	int ret = -1;
+
+	pr_info("fm ioctl get current BLER\n");
+	ret = fm_write_cmd(DM_GET_CUR_BLER_CMD, NULL, 0,
+		&resp_buf[0], &res_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM get BLER cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	BLER = (int)resp_buf[0];
+	if (copy_to_user(arg, &BLER, sizeof(BLER)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+int fm_get_cur_snr(void *arg)
+{
+	unsigned char res_len;
+	int SNR;
+	unsigned char resp_buf[1];
+	int ret = -1;
+
+	pr_info("fm ioctl get current SNR\n");
+	ret = fm_write_cmd(FM_GET_SNR_CMD, NULL, 0,
+		&resp_buf[0], &res_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM get SNR cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	SNR = (int)resp_buf[0];
+	if (copy_to_user(arg, &SNR, sizeof(SNR)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+int fm_softmute_onoff(void *arg)
+{
+	unsigned char softmute_on;
+	int ret = 0;
+	unsigned char payload;
+
+	if (copy_from_user(&softmute_on, arg, sizeof(softmute_on))) {
+		pr_err("fm softmute_onoff 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	if (softmute_on == 0)
+		pr_info("fm ioctl softmute OFF\n");
+	else if (softmute_on == 1)
+		pr_info("fm ioctl softmute ON\n");
+	else
+		pr_info("fm ioctl unknown softmute\n");
+	payload = softmute_on;
+	ret = fm_write_cmd(FM_SOFTMUTE_ONOFF_CMD, &payload,
+		sizeof(payload), NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write softmute onoff cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_set_seek_criteria(void *arg)
+{
+	struct fm_seek_criteria_parm parm;
+	int ret = 0;
+
+	if (copy_from_user(&parm, arg, sizeof(parm))) {
+		pr_err("fm set_seek_criteria 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+
+	pr_info("fm ioctl set_seek_criteria "SEEKFORMAT"\n", parm.rssi_th,
+		parm.snr_th, parm.freq_offset_th,
+		parm.pilot_power_th, parm.noise_power_th);
+	ret = fm_write_cmd(FM_SET_SEEK_CRITERIA_CMD, &parm, sizeof(parm),
+		NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM set seek criteria cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+/*
+ * 1. soft_mute---soft mute parameters
+ *	hbound >= lbound;
+ *	hbound : valid range is 402 - 442(-70dbm ~ -110 dbm)
+ *	lbound: valid range is 402 - 442(-70dbm ~ -110 dbm)
+ * Example
+ *		lbound   422(-90dbm) hbound 427(-85dbm)
+ *		Inpwr < -85dbm,   enable softmute
+ *		Inpwr > -90dbm ,disable softmute
+ *
+ * 2. blend----stereo/mono blend threshold
+ *	power_th: the signal intensity,
+ *			 valid range 402~432(Mean:-80dbm~-110dbm)
+ *			 default value is 442
+ *	phyt:  Retardation coefficient valid range is 0~ 7; default value is 5
+ * Example:
+ *		Power_th 422(-90dbm), Hyst 2
+ *		inpwr< power_threshold- hyst\uff08420 mean-92dbm), switch mono
+ *		inpwr>power_threshold+hyst (424 mean -88dbm), switch stereo
+ * 3. SNR_TH
+ */
+int fm_set_audio_threshold(void *arg)
+{
+	 struct fm_audio_threshold_parm parm;
+	int ret = 0;
+
+	if (copy_from_user(&parm, arg, sizeof(parm))) {
+		pr_err("fm set_audio_threshold 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+
+	pr_info("fm ioctl set_audio_threshold" AUDIOFORMAT"\n",
+		parm.hbound, parm.lbound,
+		parm.power_th, parm.phyt, parm.snr_th);
+	ret = fm_write_cmd(FM_SET_AUDIO_THRESHOLD_CMD, &parm, sizeof(parm),
+		NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM set audio threshold cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_get_seek_criteria(void *arg)
+{
+
+	struct fm_seek_criteria_parm parm;
+	unsigned char res_len;
+
+	int ret = -1;
+
+	pr_info("fm ioctl get_seek_criteria\n");
+	ret = fm_write_cmd(FM_GET_SEEK_CRITERIA_CMD, NULL, 0,
+		&parm, &res_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write get seek_criteria cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	if (copy_to_user(arg, &parm, sizeof(parm)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+int fm_get_audio_threshold(void *arg)
+{
+	struct fm_audio_threshold_parm parm;
+	unsigned char res_len;
+	int ret = -1;
+
+	pr_info("fm ioctl get_audio_threshold\n");
+	ret = fm_write_cmd(FM_GET_AUDIO_THRESHOLD_CMD, NULL, 0,
+		&parm, &res_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write get audio_thresholdi cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	if (copy_to_user(arg, &parm, sizeof(parm)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+
+int fm_getrssi(void *arg)
+{
+	unsigned char payload = 0;
+	unsigned char res_len;
+	int rssi;
+	unsigned char resp_buf[1];
+	int ret = -1;
+
+	ret = fm_write_cmd(FM_GET_RSSI_CMD, &payload, sizeof(payload),
+		&resp_buf[0], &res_len);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write getrssi cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	rssi = (int)resp_buf[0];
+	if (copy_to_user(arg, &rssi, sizeof(rssi)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+struct fm_rds_data *get_rds_data(void)
+{
+	pr_info("fm get rds data\n");
+
+	return g_rds_data_string;
+}
+
+/*
+ * rdsonoff cmd :01 8C FC  03(length)  06 rdson(8bit) afon(8bit)
+ * rdsonoff event:status,rdson,afon
+ */
+int fm_rds_onoff(void *arg)
+{
+	unsigned char rds_on, af_on;
+	int ret = 0;
+	unsigned char payload[2];
+
+	if (copy_from_user(&rds_on, arg, sizeof(rds_on))) {
+		pr_err("fm rds_onoff 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	if (rds_on == 0) {
+		fmdev->rds_han.new_data_flag = 1;
+		memset(&fmdev->rds_data, 0, sizeof(fmdev->rds_data));
+		wake_up_interruptible(&fmdev->rds_han.rx_queue);
+		pr_info("fm ioctl RDS OFF\n");
+	} else if (rds_on == 1) {
+		fmdev->rds_han.new_data_flag = 0;
+		pr_info("fm ioctl RDS ON\n");
+	} else
+		pr_info("fm ioctl unknown RDS\n");
+	payload[0] = rds_on;
+	payload[1] = rds_on;
+	af_on = rds_on;
+	pr_debug("fm cmd: %d,%d,%d\n", FM_SET_RDS_MODE, rds_on, af_on);
+	ret = fm_write_cmd(FM_SET_RDS_MODE, payload,
+		sizeof(payload), NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write rds mode cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int fm_ana_switch(void *arg)
+{
+	int antenna;
+	int ret = 0;
+	unsigned char payload;
+
+	if (copy_from_user(&antenna, arg, sizeof(antenna))) {
+		pr_err("fm ana switch 's ret value is -eFAULT\n");
+		return -EFAULT;
+		}
+	pr_info("fm ioctl ana switch is %d\n", antenna);
+
+	payload = antenna;
+	ret = fm_write_cmd(FM_SET_ANA_SWITCH_CMD, &payload,
+		sizeof(payload), NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write ANA switch cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+
+}
+
+int fm_af_onoff(void *arg)
+{
+	unsigned char af_on;
+	int ret = 0;
+	unsigned char payload;
+
+	if (copy_from_user(&af_on, arg, sizeof(af_on))) {
+		pr_err("fm af_onoff 's ret value is -eFAULT\n");
+		return -EFAULT;
+	}
+	if (af_on == 0)
+		pr_info("fm ioctl AF OFF\n");
+	else if (af_on == 1)
+		pr_info("fm ioctl AF ON\n");
+	else
+		pr_info("fm ioctl unknown AF\n");
+	payload = af_on;
+	ret = fm_write_cmd(FM_SET_AF_ONOFF, &payload,
+		sizeof(payload), NULL, NULL);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write af on off cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+/*
+ * get RSSI for every freq in AF list
+ * rdsonoff cmd :01 8C FC  01(length)  0D
+ * rdsonoff event:status,rdson,afon
+ *
+ */
+int fm_getcur_pamd(void *arg)
+{
+	unsigned char PAMD_LEN;
+	unsigned short PAMD;
+	int ret = -1;
+	unsigned char resp_buf[1];
+
+	ret = fm_write_cmd(FM_GET_CURPAMD, NULL, 0,
+		&resp_buf[0], &PAMD_LEN);
+	if (ret < 0) {
+		pr_err("(fmdrv) %s FM write getcur PAMD cmd status failed %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	PAMD = (unsigned short)resp_buf[0];
+	pr_debug("fm get PAMD =%d\n", PAMD);
+	if (copy_to_user(arg, &PAMD, sizeof(PAMD)))
+		ret = -EFAULT;
+
+	return ret;
+}
+
+void set_rds_drv_data(struct fm_rds_data *fm_rds_info)
+{
+	g_rds_data_string = fm_rds_info;
+}
+
+void fm_rds_init(void)
+{
+	fmdev->rds_han.new_data_flag = 0;
+}
+
+int __init init_fm_driver(void)
+{
+	int ret = 0;
+	struct fm_rds_data *fm_rds_info;
+
+	fmdev = kzalloc(sizeof(struct fmdrv_ops), GFP_KERNEL);
+	if (!fmdev)
+		return -ENOMEM;
+
+	init_completion(&fmdev->completed);
+	init_completion(&fmdev->commontask_completion);
+	init_completion(&fmdev->seektask_completion);
+	spin_lock_init(&(fmdev->rw_lock));
+	mutex_init(&fmdev->mutex);
+	INIT_LIST_HEAD(&(fmdev->rx_head));
+
+	fmdev->read_buf =  kzalloc(FM_READ_SIZE, GFP_KERNEL);
+	/* malloc mem for rds struct */
+	fm_rds_info = kzalloc(sizeof(struct fm_rds_data), GFP_KERNEL);
+	if (fm_rds_info == NULL) {
+
+		pr_err("fm can't allocate FM RDS buffer\n");
+		return ret;
+	}
+	set_rds_drv_data(fm_rds_info);
+
+	/* Register FM Tx and Rx callback */
+	sdiom_register_pt_rx_process(FM_TYPE, FM_SUBTYPE0, fm_rx_cback);
+	sdiom_register_pt_tx_release(FM_TYPE, FM_SUBTYPE0, fm_tx_cback);
+	 /* retval = sdiodev_readchn_init(FM_CHANNEL_READ, fm_read, 0);*/
+	ret = fm_device_init_driver();
+
+	tasklet_init(&fmdev->rx_task, receive_tasklet, (unsigned long)fmdev);
+	/* RDS init */
+	fm_rds_init();
+	init_waitqueue_head(&fmdev->rds_han.rx_queue);
+
+	setup_timer(&test_timer, timer_cb, 0);
+	test_init();
+
+	return ret;
+}
+
+void __exit exit_fm_driver(void)
+{
+	fm_device_exit_driver();
+	tasklet_kill(&fmdev->tx_task);
+	tasklet_kill(&fmdev->rx_task);
+	kfree(fmdev->read_buf);
+	fmdev->read_buf = NULL;
+	kfree(fmdev);
+	fmdev = NULL;
+}
+
+module_init(init_fm_driver);
+module_exit(exit_fm_driver);
+MODULE_DESCRIPTION("SPREADTRUM SC2342 FM Radio driver");
+MODULE_AUTHOR("Songhe Wei<songhe.wei@spreadtrum.com>");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(FM_VERSION);
diff --git a/drivers/misc/sprd-wcn/radio/fmdrv_main.h b/drivers/misc/sprd-wcn/radio/fmdrv_main.h
new file mode 100644
index 0000000..7dc3e39
--- /dev/null
+++ b/drivers/misc/sprd-wcn/radio/fmdrv_main.h
@@ -0,0 +1,117 @@
+/*
+ * SPREADTRUM SC2342 FM Radio driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _FMDRV_MAIN_H
+#define _FMDRV_MAIN_H
+
+#include <linux/fs.h>
+
+#define FM_OFF			0x00
+#define FM_POWERUP_CMD		0x00
+#define FM_TUNE_CMD		0x01
+#define FM_MUTE_CMD 0x02
+#define FM_SCAN_ALL_CMD 0x03
+#define FM_SEEK_CMD 0x04
+#define FM_SEARCH_ABORT 0X05
+#define FM_SET_RDS_MODE 0x06
+#define FM_SET_RDS_TYPE 0x07
+/* audio mode:0:mono, 1:stereo; 2:blending */
+#define FM_SET_AUDIO_MODE 0x08
+#define FM_SET_AF_ONOFF 0x09
+/* #define FM_SET_AUDIO_PATH 0x09 */
+#define FM_SET_REGION 0x0A
+#define FM_SET_SCAN_STEP 0x0B
+#define FM_CONFIG_DEEMPHASIS 0x0C
+#define FM_GET_CURPAMD	0x0D
+/* audio mode:0:mono, 1:stereo; 2:blending */
+#define FM_GET_AUDIO_MODE 0x0E
+#define FM_GET_VOLUME_CMD		0x0F
+#define FM_SET_VOLUME_CMD		0x10
+#define DM_GET_CUR_BLER_CMD	0x11
+#define FM_POWERDOWN_CMD 0x12
+#define FM_GET_RSSI_CMD 0x13
+#define FM_GET_SNR_CMD	0x14
+#define FM_SOFTMUTE_ONOFF_CMD 0x15
+#define FM_SET_DEEMPHASIS_CMD		0x16
+/* Frequency offset, PDP_TH,PHP_TH, SNR_TH,RSS_THI */
+#define FM_SET_SEEK_CRITERIA_CMD	0x17
+/* softmute ,blending ,snr_th */
+#define FM_SET_AUDIO_THRESHOLD_CMD 0x18
+/* Frequency offset, PDP_TH,PHP_TH, SNR_TH,RSS_THI */
+#define FM_GET_SEEK_CRITERIA_CMD	0x19
+/* softmute ,blending ,snr_th */
+#define FM_GET_AUDIO_THRESHOLD_CMD 0x1A
+#define FM_SET_ANA_SWITCH_CMD		0x1B
+
+#define FM_READ_WRITE_REG_CMD		0x22
+
+extern struct fmdrv_ops *fmdev;
+
+int fm_open(struct inode *inode, struct file *filep);
+int fm_powerup(void *arg);
+int fm_powerdown(void);
+int fm_tune(void *arg);
+int fm_seek(void *arg);
+int fm_mute(void *arg);
+int fm_getrssi(void *arg);
+int fm_getcur_pamd(void *arg);
+int fm_rds_onoff(void *arg);
+int fm_ana_switch(void *arg);
+int fm_af_onoff(void *arg);
+int fm_set_volume(void *arg);
+int fm_get_volume(void *arg);
+int fm_stop_scan(void *arg);
+int fm_scan_all(void *arg);
+int fm_rw_reg(void *arg);
+int fm_get_monostero(void *arg);
+int fm_scan_all(void *arg);
+int fm_rw_reg(void *arg);
+int fm_stop_scan(void *arg);
+int fm_rw_reg(void *arg);
+int fm_get_monostero(void *arg);
+int fm_set_audio_mode(void *arg);
+int fm_set_region(void *arg);
+int fm_set_scan_step(void *arg);
+int fm_config_deemphasis(void *arg);
+int fm_get_audio_mode(void *arg);
+int fm_get_current_bler(void *arg);
+int fm_get_cur_snr(void *arg);
+int fm_softmute_onoff(void *arg);
+int fm_set_seek_criteria(void *arg);
+int fm_set_audio_threshold(void *arg);
+int fm_get_seek_criteria(void *arg);
+int fm_get_audio_threshold(void *arg);
+ssize_t fm_read_rds_data(struct file *filp, char __user *buf,
+	size_t count, loff_t *pos);
+int fm_sdio_write(unsigned char *buffer, unsigned int size);
+struct fm_rds_data *get_rds_data(void);
+int start_marlin(int type);
+int stop_marlin(int type);
+unsigned int sdiom_pt_read_release(unsigned int fifo_id);
+
+struct fm_cmd_hdr {
+	/* 01:cmd; 04:event */
+	unsigned char header;
+	/* vendor specific command 0xFC8C */
+	unsigned short opcode;
+	/* Number of bytes follows */
+	unsigned char len;
+	/* FM Sub Command */
+	unsigned char fm_subcmd;
+} __packed;
+
+struct fm_event_hdr {
+	/* 01:cmd; 04:event */
+	unsigned char header;
+	/* 0e:cmd complete event; FF:vendor specific event */
+	unsigned char id;
+	/* Number of bytes follows */
+	unsigned char len;
+} __packed;
+
+#endif /* _FMDRV_MAIN_H */
diff --git a/drivers/misc/sprd-wcn/radio/fmdrv_ops.c b/drivers/misc/sprd-wcn/radio/fmdrv_ops.c
new file mode 100644
index 0000000..bd3ec3f
--- /dev/null
+++ b/drivers/misc/sprd-wcn/radio/fmdrv_ops.c
@@ -0,0 +1,447 @@
+/*
+ * SPREADTRUM SC2342 FM Radio driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/ioctl.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+
+#ifdef CONFIG_OF
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#endif
+
+#include "fmdrv.h"
+#include "fmdrv_main.h"
+#include "fmdrv_ops.h"
+
+static long fm_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	long ret = 0;
+	u32 iarg = 0;
+
+	pr_debug("FM_IOCTL cmd: 0x%x.\n", cmd);
+	switch (cmd) {
+	case FM_IOCTL_POWERUP:
+		fm_powerup(argp);
+		ret = fm_tune(argp);
+		break;
+
+	case FM_IOCTL_POWERDOWN:
+		ret = fm_powerdown();
+		break;
+
+	case FM_IOCTL_TUNE:
+		ret = fm_tune(argp);
+		break;
+
+	case FM_IOCTL_SEEK:
+		ret = fm_seek(argp);
+		break;
+
+	case FM_IOCTL_SETVOL:
+		pr_info("fm ioctl set volume\n");
+		ret = fm_set_volume(argp);
+		break;
+
+	case FM_IOCTL_GETVOL:
+		pr_info("fm ioctl get volume\n");
+		ret = fm_get_volume(argp);
+		break;
+
+	case FM_IOCTL_MUTE:
+		ret = fm_mute(argp);
+		break;
+
+	case FM_IOCTL_GETRSSI:
+		pr_info("fm ioctl get RSSI\n");
+		ret = fm_getrssi(argp);
+		break;
+
+	case FM_IOCTL_SCAN:
+		pr_info("fm ioctl SCAN\n");
+		ret = fm_scan_all(argp);
+		break;
+
+	case FM_IOCTL_STOP_SCAN:
+		pr_info("fm ioctl STOP SCAN\n");
+		ret = fm_stop_scan(argp);
+		break;
+
+	case FM_IOCTL_GETCHIPID:
+		pr_info("fm ioctl GET chipID\n");
+		iarg = 0x2341;
+		if (copy_to_user(argp, &iarg, sizeof(iarg)))
+			ret = -EFAULT;
+		else
+			ret = 0;
+		break;
+
+	case FM_IOCTL_EM_TEST:
+		pr_info("fm ioctl EM_TEST\n");
+		ret = 0;
+		break;
+
+	case FM_IOCTL_RW_REG:
+		pr_info("fm ioctl RW_REG\n");
+		ret = fm_rw_reg(argp);
+		break;
+
+	case FM_IOCTL_GETMONOSTERO:
+		pr_info("fm ioctl GETMONOSTERO\n");
+		ret = fm_get_monostero(argp);
+		break;
+	case FM_IOCTL_GETCURPAMD:
+		pr_info("fm ioctl get PAMD\n");
+		ret = fm_getcur_pamd(argp);
+		break;
+
+	case FM_IOCTL_GETGOODBCNT:
+	case FM_IOCTL_GETBADBNT:
+	case FM_IOCTL_GETBLERRATIO:
+	case FM_IOCTL_RDS_SIM_DATA:
+	case FM_IOCTL_IS_FM_POWERED_UP:
+	case FM_IOCTL_OVER_BT_ENABLE:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_RDS_ONOFF:
+		pr_info("----RDS_ONOFF----");
+		ret = fm_rds_onoff(argp);
+		break;
+
+	case FM_IOCTL_RDS_SUPPORT:
+		pr_info("fm ioctl is RDS_SUPPORT\n");
+		ret = 0;
+		if (copy_from_user(&iarg, (void __user *)arg, sizeof(iarg))) {
+			pr_err("fm RDS support 's ret value is -eFAULT\n");
+			return -EFAULT;
+		}
+		iarg = FM_RDS_ENABLE;
+		if (copy_to_user((void __user *)arg, &iarg, sizeof(iarg)))
+			ret = -EFAULT;
+		break;
+
+	case FM_IOCTL_ANA_SWITCH:
+		ret = fm_ana_switch(argp);
+		break;
+
+	case FM_IOCTL_GETCAPARRAY:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_I2S_SETTING:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_RDS_GROUPCNT:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_RDS_GET_LOG:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_SCAN_GETRSSI:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_SETMONOSTERO:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_RDS_BC_RST:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_CQI_GET:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_GET_HW_INFO:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_GET_I2S_INFO:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_IS_DESE_CHAN:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_TOP_RDWR:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_HOST_RDWR:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_PRE_SEARCH:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_RESTORE_SEARCH:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_GET_AUDIO_INFO:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_SCAN_NEW:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_SEEK_NEW:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_TUNE_NEW:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_SOFT_MUTE_TUNE:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_DESENSE_CHECK:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_FULL_CQI_LOG:
+		ret = 0;
+		break;
+
+	case FM_IOCTL_SET_AUDIO_MODE:
+		ret = fm_set_audio_mode(argp);
+		break;
+
+	case FM_IOCTL_SET_REGION:
+		ret = fm_set_region(argp);
+		break;
+
+	case FM_IOCTL_SET_SCAN_STEP:
+		ret = fm_set_scan_step(argp);
+		break;
+
+	case FM_IOCTL_CONFIG_DEEMPHASIS:
+		ret = fm_config_deemphasis(argp);
+		break;
+
+	case FM_IOCTL_GET_AUDIO_MODE:
+		ret = fm_get_audio_mode(argp);
+		break;
+
+	case FM_IOCTL_GET_CUR_BLER:
+		ret = fm_get_current_bler(argp);
+		break;
+
+	case FM_IOCTL_GET_SNR:
+		ret = fm_get_cur_snr(argp);
+		break;
+
+	case FM_IOCTL_SOFTMUTE_ONOFF:
+		ret = fm_softmute_onoff(argp);
+		break;
+
+	case FM_IOCTL_SET_SEEK_CRITERIA:
+		ret = fm_set_seek_criteria(argp);
+		break;
+
+	case FM_IOCTL_SET_AUDIO_THRESHOLD:
+		ret = fm_set_audio_threshold(argp);
+		break;
+
+	case FM_IOCTL_GET_SEEK_CRITERIA:
+		ret = fm_get_seek_criteria(argp);
+		break;
+
+	case FM_IOCTL_GET_AUDIO_THRESHOLD:
+		ret = fm_get_audio_threshold(argp);
+		break;
+
+	case FM_IOCTL_AF_ONOFF:
+		ret = fm_af_onoff(argp);
+		break;
+
+	case FM_IOCTL_DUMP_REG:
+		ret = 0;
+		break;
+
+	default:
+		pr_info("Unknown FM IOCTL cmd=0x%x.\n", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int fm_release(struct inode *inode, struct file *filep)
+{
+	pr_info("fm_misc_release.\n");
+	fm_powerdown();
+	stop_marlin(MARLIN_FM);
+	wake_up_interruptible(&fmdev->rds_han.rx_queue);
+	fmdev->rds_han.new_data_flag = 1;
+
+	return 0;
+}
+
+#ifdef CONFIG_COMPAT
+static long fm_compat_ioctl(struct file *file,
+			unsigned int cmd, unsigned long data)
+{
+	pr_info("start_fm_compat_ioctl FM_IOCTL cmd: 0x%x.\n", cmd);
+	cmd = cmd & 0xFFF0FFFF;
+	cmd = cmd | 0x00080000;
+	pr_info("fm_compat_ioctl FM_IOCTL cmd: 0x%x.\n", cmd);
+	return fm_ioctl(file, cmd, (unsigned long)compat_ptr(data));
+}
+#endif
+
+const struct file_operations fm_misc_fops = {
+	.owner = THIS_MODULE,
+	.open = fm_open,
+	.read = fm_read_rds_data,
+	.unlocked_ioctl = fm_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = fm_compat_ioctl,
+#endif
+	.release = fm_release,
+};
+
+struct miscdevice fm_misc_device = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = FM_DEV_NAME,
+	.fops = &fm_misc_fops,
+};
+
+#ifdef CONFIG_OF
+
+static const struct of_device_id  of_match_table_fm[] = {
+	{ .compatible = "sprd,marlin2-fm", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_match_table_fm);
+#endif
+
+static int fm_probe(struct platform_device *pdev)
+{
+	int ret = -EINVAL;
+	char *ver_str = FM_VERSION;
+
+#ifdef CONFIG_OF
+	struct device_node *np;
+
+	np = pdev->dev.of_node;
+#endif
+
+	pr_info(" marlin2 FM driver\n");
+	pr_info(" Version: %s\n", ver_str);
+
+	ret = misc_register(&fm_misc_device);
+	if (ret < 0) {
+
+		pr_info("misc_register failed!\n");
+		return ret;
+	}
+
+	pr_info("fm_init success.\n");
+
+	return 0;
+}
+
+static int fm_remove(struct platform_device *pdev)
+{
+
+	pr_info("exit_fm_driver!\n");
+	misc_deregister(&fm_misc_device);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int fm_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int fm_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops fm_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fm_suspend, fm_resume)
+};
+
+static struct platform_driver fm_driver = {
+	.driver = {
+		.name = "sprd-fm",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_OF
+		 .of_match_table = of_match_ptr(of_match_table_fm),
+#endif
+		.pm = &fm_pmops,
+	},
+	.probe = fm_probe,
+	.remove = fm_remove,
+};
+
+#ifndef CONFIG_OF
+struct platform_device fm_device = {
+	.name = "sprd-fm",
+	.id = -1,
+};
+#endif
+
+int  fm_device_init_driver(void)
+{
+	int ret;
+#ifndef CONFIG_OF
+	ret = platform_device_register(&fm_device);
+	if (ret) {
+		pr_info("fm: platform_device_register failed: %d\n", ret);
+		return ret;
+	}
+#endif
+	ret = platform_driver_register(&fm_driver);
+	if (ret) {
+#ifndef CONFIG_OF
+		platform_device_unregister(&fm_device);
+#endif
+		pr_info("fm: probe failed: %d\n", ret);
+	}
+	pr_info("fm: probe success: %d\n", ret);
+
+	return ret;
+}
+
+void fm_device_exit_driver(void)
+{
+	platform_driver_unregister(&fm_driver);
+
+}
diff --git a/drivers/misc/sprd-wcn/radio/fmdrv_ops.h b/drivers/misc/sprd-wcn/radio/fmdrv_ops.h
new file mode 100644
index 0000000..b3a019e
--- /dev/null
+++ b/drivers/misc/sprd-wcn/radio/fmdrv_ops.h
@@ -0,0 +1,17 @@
+/*
+ * SPREADTRUM SC2342 FM Radio driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+
+#ifndef _FMDRV_OPS_H
+#define _FMDRV_OPS_H
+
+extern struct fmdrv_ops *fmdev;
+int  fm_device_init_driver(void);
+void fm_device_exit_driver(void);
+
+#endif /* _FMDRV_OPS_H */
diff --git a/drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.c b/drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.c
new file mode 100644
index 0000000..538b3b9
--- /dev/null
+++ b/drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.c
@@ -0,0 +1,753 @@
+/*
+ * SPREADTRUM SC2342 FM Radio driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include "fmdrv.h"
+#include "fmdrv_main.h"
+#include "fmdrv_rds_parser.h"
+
+static struct fm_rds_data *g_rds_data_p;
+/* the next ps: index = 0 */
+static unsigned char flag_next = 1;
+void rds_parser_init(void)
+{
+	g_rds_data_p = get_rds_data();
+}
+
+void  fmr_assert(unsigned short *a)
+{
+	if (a == NULL)
+		pr_info("%s,invalid pointer\n", __func__);
+}
+
+/*
+ * rds_event_set
+ * To set rds event, and user space can use this flag to juge
+ * which event happened
+ * If success return 0, else return error code
+ */
+static signed int rds_event_set(unsigned short *events, signed int event_mask)
+{
+	fmr_assert(events);
+	*events |= event_mask;
+	wake_up_interruptible(&fmdev->rds_han.rx_queue);
+	fmdev->rds_han.new_data_flag = 1;
+
+	return 0;
+}
+
+/*
+ * Group types which contain this information:
+ * TA(Traffic Program) code 0A 0B 14B 15B
+ */
+void rds_get_eon_ta(unsigned char *buf)
+{
+	unsigned char *blk_4 = buf + 3 * rds_data_unit_size;
+	unsigned char data = *(buf + rds_data_unit_size + 2);
+	unsigned char ta_tp;
+	unsigned int pi_on;
+
+	if (*blk_4  == 0)
+		return;
+	/* bit3: TA ON  bit4: TP ON */
+	ta_tp = (unsigned char)(((data & (1 << 4)) >> 4) | ((data & (1 << 3))
+			<< 1));
+	bytes_to_short(pi_on, blk_4 + 1);
+	/* need add some code to adapter google upper layer  here */
+}
+
+/*
+ * EON = Enhanced Other Networks information
+ * Group types which contain this information: EON : 14A
+ * variant code is in blockB low 4 bits
+ */
+void rds_get_eon(unsigned char *buf)
+{
+	unsigned char *blk_3 = buf + 2 * rds_data_unit_size;
+	unsigned char *blk_4 = buf + 3 * rds_data_unit_size;
+	unsigned short pi_on;
+
+	if ((*blk_3 == 0) || (*blk_4 == 0))
+		return;
+	/* if the upper Layer true */
+	bytes_to_short(pi_on, blk_4 + 1);
+}
+
+/*
+ * PTYN = Programme TYpe Name
+ * From Group 10A, it's a 8 character description transmitted in two 10A group
+ * block 2 bit0 is PTYN segment address.
+ * block3 and block4 is PTYN text character
+ */
+void rds_get_ptyn(unsigned char *buf)
+{
+	unsigned char *blk_2 = buf + rds_data_unit_size;
+	unsigned char *blk_head[2];
+	unsigned char seg_addr = ((*(blk_2 + 2)) & 0x01);
+	unsigned char ptyn[4], i, step;
+	unsigned char *blkc = buf + 2 * rds_data_unit_size;
+	unsigned char *blkd = buf + 2 * rds_data_unit_size;
+
+	blk_head[0] = buf + 2 * rds_data_unit_size;
+	blk_head[1] = buf + 3 * rds_data_unit_size;
+	memcpy((void *)&ptyn[0], (void *)(blk_head[0] + 1), 2);
+	memcpy((void *)&ptyn[2], (void *)(blk_head[1] + 1), 2);
+	for (i = 0; i < 2; i++) {
+		step = i >> 1;
+		/* update seg_addr[0,1] if blockC/D is reliable data */
+		if ((*blkc == 1) && (*blkd == 1)) {
+			/* it's a new PTYN */
+			if (memcmp((void *)&ptyn[seg_addr * 4 + step], (void *)
+				(ptyn + step), 2) != 0)
+				memcpy((void *)&ptyn[seg_addr * 4 + step],
+				(void *)(ptyn + step), 2);
+		}
+	}
+}
+
+/*
+ * EWS = Coding of Emergency Warning Systems
+ * EWS inclued belows:
+ * unsigned char data_5b;
+ * unsigned short data_16b_1;
+ * unsigned short data_16b_2;
+ */
+void rds_get_ews(unsigned char *buf)
+{
+	unsigned char data_5b;
+	unsigned short data_16b_1;
+	unsigned short data_16b_2;
+	unsigned char *blk_2 = buf + rds_data_unit_size;
+	unsigned char *blk_3 = buf + 2 * rds_data_unit_size;
+	unsigned char *blk_4 = buf + 3 * rds_data_unit_size;
+
+	data_5b = (unsigned char)((*(blk_2 + 2)) & 0x1F);
+	bytes_to_short(data_16b_1, (blk_3 + 1));
+	bytes_to_short(data_16b_2, (blk_4 + 1));
+}
+
+void rfd_get_rtplus(unsigned char *buf)
+{
+	unsigned char	*blk_b = buf + rds_data_unit_size;
+	unsigned char	*blk_c = buf + 2 * rds_data_unit_size;
+	unsigned char	*blk_d = buf + 3 * rds_data_unit_size;
+	unsigned char	content_type, s_marker, l_marker;
+	bool running;
+
+	running = ((*(blk_b + 2) & 0x08) != 0) ? 1 : 0;
+	if ((*blk_c == 1) && (*blk_b == 1)) {
+		content_type = ((*(blk_b + 2) & 0x07) << 3) + (*(blk_c + 1)
+			>> 5);
+		s_marker = (((*(blk_c + 1) & 0x1F) << 1) + (*(blk_c + 2)
+			>> 7));
+		l_marker = (((*(blk_c + 2)) & 0x7F) >> 1);
+	}
+	if ((*blk_c == 1) && (*blk_d == 1)) {
+		content_type = ((*(blk_c + 2) & 0x01) << 5) +
+			(*(blk_d + 1) >> 3);
+		s_marker = (*(blk_d + 2) >> 5) + ((*(blk_d + 1) & 0x07) << 3);
+		l_marker = (*(blk_d + 2) & 0x1f);
+	}
+}
+
+/* ODA = Open Data Applications */
+void rds_get_oda(unsigned char *buf)
+{
+	rfd_get_rtplus(buf);
+}
+
+/* TDC = Transparent Data Channel */
+void rds_get_tdc(unsigned char *buf, unsigned char version)
+{
+	/* 2nd  block */
+	unsigned char	*blk_b	= buf + rds_data_unit_size;
+	/* 3rd block */
+	unsigned char	*blk_c	= buf + 2*rds_data_unit_size;
+	/* 4rd block */
+	unsigned char	*blk_d	= buf + 3*rds_data_unit_size;
+	unsigned char chnl_num, len, tdc_seg[4];
+	/* unrecoverable block 3,or ERROR in block 4, discard this group */
+	if ((*blk_b == 0) || (*blk_c == 0) || (*blk_d == 0))
+		return;
+
+	/* read TDChannel number */
+	chnl_num = *(blk_b + 2) & 0x1f;
+	if (version == grp_ver_a) {
+		memcpy(tdc_seg, blk_c + 1, 2);
+		len = 2;
+	}
+
+	memcpy(tdc_seg +  len, blk_d + 1, 2);
+	len += 2;
+}
+
+/* CT = Programe Clock time */
+void rds_get_ct(unsigned char *buf)
+{
+	unsigned char *blk_2 = buf + rds_data_unit_size;
+	unsigned char *blk_3 = buf + 2 * rds_data_unit_size;
+	unsigned char *blk_4 = buf + 3 * rds_data_unit_size;
+	unsigned char b3_1 = *(blk_3 + 1), b3_2 = *(blk_3 + 2);
+	unsigned char b4_1 = *(blk_4 + 1), b4_2 = *(blk_4 + 2);
+	unsigned int temp1, temp2;
+
+	unsigned int day = 0;
+	unsigned char hour, minute, sense, offset;
+
+	if ((*(blk_3) == 0) || (*(blk_4) == 0))
+		return;
+	temp1 = (unsigned int) ((b3_1 << 8) | b3_2);
+	temp2 = (unsigned int) (*(blk_2 + 2) & 0x03);
+	day = (temp2 << 15) | (temp1 >> 1);
+
+	temp1 = (unsigned int)(b3_2 & 0x01);
+	temp2 = (unsigned int)(b4_1 & 0xF0);
+	hour = (unsigned char)((temp1 << 4) | (temp2 >> 4));
+	minute = ((b4_1 & 0x0F) << 2) | ((b4_2 & 0xC0) >> 6);
+	sense = (b4_2 & 0x20) >> 5;
+	offset = b4_2 & 0x1F;
+	/* set RDS EVENT FLAG  in here */
+	fmdev->rds_data.CT.day = day;
+	fmdev->rds_data.CT.hour = hour;
+	fmdev->rds_data.CT.minute = minute;
+	fmdev->rds_data.CT.local_time_offset_half_hour = offset;
+	fmdev->rds_data.CT.local_time_offset_signbit = sense;
+}
+
+void rds_get_oda_aid(unsigned char *buf)
+{
+}
+
+/*
+ * rt == Radio Text
+ * Group types which contain this information: 2A 2B
+ * 2A: address in block2 last 4bits, Text in block3 and block4
+ * 2B: address in block2 last 4bits, Text in block4(16bits)
+ */
+void rds_get_rt(unsigned char *buf, unsigned char grp_type)
+{
+	unsigned char *blk_3 = buf + 2 * rds_data_unit_size;
+	unsigned char *blk_4 = buf + 3 * rds_data_unit_size;
+	unsigned char addr = ((*(buf + rds_data_unit_size + 2)) & 0x0F);
+	unsigned char text_flag = ((*(buf + rds_data_unit_size + 2)) & 0x10);
+
+	pr_info("RT Text A/B Flag is %d\n", text_flag);
+
+	/* add for RT not support two types*/
+	if (text_flag != 0)
+		return;
+	if (grp_type == 0x2A) {
+		if (*(blk_3 + 1) == 0x0d)
+			*(blk_3 + 1) = '\0';
+		if (*(blk_3 + 2) == 0x0d)
+			*(blk_3 + 2) = '\0';
+		if (*(blk_4 + 1) == 0x0d)
+			*(blk_4 + 1) = '\0';
+		if (*(blk_4 + 2) == 0x0d)
+			*(blk_4 + 2) = '\0';
+		fmdev->rds_data.rt_data.textdata[3][addr * 4] = *(blk_3 + 1);
+		fmdev->rds_data.rt_data.textdata[3][addr * 4 + 1] =
+			*(blk_3 + 2);
+		fmdev->rds_data.rt_data.textdata[3][addr * 4 + 2] =
+			*(blk_4 + 1);
+		fmdev->rds_data.rt_data.textdata[3][addr * 4 + 3] =
+			*(blk_4 + 2);
+	}
+	/* group type = 2B */
+	else {
+		if (*(blk_3 + 1) == 0x0d)
+			*(blk_3 + 1) = '\0';
+		if (*(blk_3 + 2) == 0x0d)
+			*(blk_3 + 2) = '\0';
+		fmdev->rds_data.rt_data.textdata[3][addr * 2] = *(blk_3 + 1);
+		fmdev->rds_data.rt_data.textdata[3][addr * 2 + 1] =
+			*(blk_3 + 2);
+	}
+	rds_event_set(&(fmdev->rds_data.event_status),
+		RDS_EVENT_LAST_RADIOTEXT);
+	pr_info("RT is %s\n", fmdev->rds_data.rt_data.textdata[3]);
+}
+
+/* PIN = Programme Item Number */
+
+void rds_get_pin(unsigned char *buf)
+{
+	struct RDS_PIN {
+		unsigned char day;
+		unsigned char hour;
+		unsigned char minute;
+	} rds_pin;
+
+	unsigned char *blk_4 = buf + 3 * rds_data_unit_size;
+	unsigned char byte1 = *(blk_4 + 1), byte2 = *(blk_4 + 2);
+
+	if (*blk_4 == 0)
+		return;
+	rds_pin.day = ((byte1 & 0xF8) >> 3);
+	rds_pin.hour = (byte1 & 0x07) << 2 | ((byte2 & 0xC0) >> 6);
+	rds_pin.minute = (byte2 & 0x3F);
+}
+
+/*
+ * SLC = Slow Labelling codes from group 1A, block3
+ * LA 0 0 0 OPC ECC
+ */
+
+void rds_get_slc(unsigned char *buf)
+{
+	unsigned char *blk_3 = buf + 2 * rds_data_unit_size;
+	unsigned char variant_code, slc_type,  paging;
+	unsigned char ecc_code = 0;
+	unsigned short data;
+
+	if ((*blk_3) == 0)
+		return;
+	bytes_to_short(data, blk_3);
+	data &= 0x0FFF;
+	/* take bit12 ~ bit14 of block3 as variant code */
+	variant_code = ((*(blk_3 + 1) & 0x70) >> 4);
+	if ((variant_code == 0x04) || (variant_code == 0x05))
+		slc_type = 0x04;
+	else
+		slc_type = variant_code;
+	if (slc_type == 0) {
+		ecc_code = *(blk_3 + 2);
+		paging = (*(blk_3 + 1) & 0x0f);
+	}
+	fmdev->rds_data.extend_country_code = ecc_code;
+}
+
+/*
+ * Group types which contain this information: 0A 0B
+ * PS = Programme Service name
+ * block2 last 2bit stard for address, block4 16bits meaning ps.
+ */
+
+void rds_get_ps(unsigned char *buf)
+{
+	unsigned char *blk_2 = buf + rds_data_unit_size;
+	unsigned char *blk_4 = buf + 3 *  rds_data_unit_size;
+	unsigned char index = (unsigned char)((*(blk_2 + 2) & 0x03) * 2);
+
+	pr_info("PS start receive\n");
+	pr_info("blk2 =%d, blk4=%d\n", *blk_2, *blk_4);
+	if ((*blk_2) == 1) {
+		if ((flag_next == 0) && (index == 0)) {
+			memcpy(fmdev->rds_data.ps_data.PS[3],
+				fmdev->rds_data.ps_data.PS[2], 8);
+			pr_info("PS is %s\n", fmdev->rds_data.ps_data.PS[3]);
+			if (fmdev->rds_data.ps_data.PS[3] != NULL)
+				rds_event_set(&(fmdev->rds_data.event_status),
+					RDS_EVENT_PROGRAMNAME);
+			memset(fmdev->rds_data.ps_data.PS[2], 0x0, 8);
+		}
+		if (flag_next == 1)
+			flag_next = 0;
+
+		fmdev->rds_data.ps_data.addr_cnt = index;
+		fmdev->rds_data.ps_data.PS[2][index] = *(blk_4 + 1);
+		fmdev->rds_data.ps_data.PS[2][index + 1] = *(blk_4 + 2);
+	}
+	pr_info("the PS index is %x\n", index);
+	pr_info("The event is %x\n", fmdev->rds_data.event_status);
+	pr_info("The PS is %s\n", fmdev->rds_data.ps_data.PS[3]);
+	pr_info("blk4+1=0x%x\n", *(blk_4 + 1));
+	pr_info("blk4+2=0x%x\n", *(blk_4 + 2));
+
+}
+unsigned short rds_get_freq(void)
+{
+	return 0;
+}
+void rds_get_af_method(unsigned char AFH, unsigned char AFL)
+{
+	static signed short pre_af_num;
+	unsigned char  indx, indx2, num;
+
+	pr_info("af code is %d and %d\n", AFH, AFL);
+	if (AFH >= RDS_AF_NUM_1 && AFH <= RDS_AF_NUM_25) {
+		if (AFH == RDS_AF_NUM_1) {
+			fmdev->rds_data.af_data.ismethod_a = RDS_AF_M_A;
+			fmdev->rds_data.af_data.AF_NUM = 1;
+		}
+		/* have got af number */
+		fmdev->rds_data.af_data.isafnum_get = 0;
+		pre_af_num = AFH - 224;
+		if (pre_af_num != fmdev->rds_data.af_data.AF_NUM)
+			fmdev->rds_data.af_data.AF_NUM = pre_af_num;
+		else
+			fmdev->rds_data.af_data.isafnum_get = 1;
+		if ((AFL < 205) && (AFL > 0)) {
+			fmdev->rds_data.af_data.AF[0][0] = AFL + 875;
+			/* convert to 100KHz */
+#ifdef SPRD_FM_50KHZ_SUPPORT
+			fmdev->rds_data.af_data.AF[0][0] *= 10;
+#endif
+			if ((fmdev->rds_data.af_data.AF[0][0]) !=
+				(fmdev->rds_data.af_data.AF[1][0])) {
+				fmdev->rds_data.af_data.AF[1][0] =
+					fmdev->rds_data.af_data.AF[0][0];
+			} else {
+				if (fmdev->rds_data.af_data.AF[1][0] !=
+					rds_get_freq())
+					fmdev->rds_data.af_data.ismethod_a = 1;
+				else
+					fmdev->rds_data.af_data.ismethod_a = 0;
+			}
+
+			/* only one AF handle */
+			if ((fmdev->rds_data.af_data.isafnum_get) &&
+				(fmdev->rds_data.af_data.AF_NUM == 1)) {
+				fmdev->rds_data.af_data.addr_cnt = 0xFF;
+			}
+		}
+	} else if ((fmdev->rds_data.af_data.isafnum_get) &&
+		(fmdev->rds_data.af_data.addr_cnt != 0xFF)) {
+		/* AF Num correct */
+		num = fmdev->rds_data.af_data.AF_NUM;
+		num = num >> 1;
+		/*
+		 * Put AF freq fm_s32o buffer and check if AF
+		 * freq is repeat again
+		 */
+		for (indx = 1; indx < (num + 1); indx++) {
+			if ((AFH == (fmdev->rds_data.af_data.AF[0][2*num-1]))
+				&& (AFL ==
+				(fmdev->rds_data.af_data.AF[0][2*indx]))) {
+				pr_info("AF same as\n");
+				break;
+			} else if (!(fmdev->rds_data.af_data.AF[0][2 * indx-1])
+				) {
+				/* convert to 100KHz */
+				fmdev->rds_data.af_data.AF[0][2*indx-1] =
+					AFH + 875;
+				fmdev->rds_data.af_data.AF[0][2*indx] =
+					AFL + 875;
+#ifdef MTK_FM_50KHZ_SUPPORT
+				fmdev->rds_data.af_data.AF[0][2*indx-1] *= 10;
+				fmdev->rds_data.af_data.AF[0][2*indx] *= 10;
+#endif
+				break;
+			}
+		}
+		num = fmdev->rds_data.af_data.AF_NUM;
+		if (num <= 0)
+			return;
+		if ((fmdev->rds_data.af_data.AF[0][num-1]) == 0)
+			return;
+		num = num >> 1;
+		for (indx = 1; indx < num; indx++) {
+			for (indx2 = indx + 1; indx2 < (num + 1); indx2++) {
+				AFH = fmdev->rds_data.af_data.AF[0][2*indx-1];
+				AFL = fmdev->rds_data.af_data.AF[0][2*indx];
+				if (AFH > (fmdev->rds_data.af_data.AF[0][2*indx2
+					-1])) {
+					fmdev->rds_data.af_data.AF[0][2*indx-1]
+					= fmdev->rds_data.af_data.AF[0][2
+					*indx2-1];
+					fmdev->rds_data.af_data.AF[0][2*indx] =
+					fmdev->rds_data.af_data.AF[0][2*indx2];
+					fmdev->rds_data.af_data.AF[0][2*indx2-1]
+						= AFH;
+					fmdev->rds_data.af_data.AF[0][2*indx2]
+						= AFL;
+				} else if (AFH == (fmdev->rds_data.af_data
+					.AF[0][2*indx2-1])) {
+					if (AFL > (fmdev->rds_data.af_data.AF[0]
+						[2*indx2])) {
+						fmdev->rds_data.af_data.AF[0][2
+							*indx-1]
+						= fmdev->rds_data.af_data
+						.AF[0][2*indx2-1];
+						fmdev->rds_data.af_data.AF[0][2
+							*indx] = fmdev->rds_data
+							.af_data.AF[0][2*indx2];
+						fmdev->rds_data.af_data.AF[0][2*
+							indx2-1] = AFH;
+						fmdev->rds_data.af_data.AF[0][2
+							*indx2] = AFL;
+					}
+				}
+			}
+		}
+
+		/*
+		 * arrange frequency from low to high:end
+		 * compare AF buff0 and buff1 data:start
+		 */
+		num = fmdev->rds_data.af_data.AF_NUM;
+		indx2 = 0;
+		for (indx = 0; indx < num; indx++) {
+			if ((fmdev->rds_data.af_data.AF[1][indx]) ==
+				(fmdev->rds_data.af_data.AF[0][indx])) {
+				if (fmdev->rds_data.af_data.AF[1][indx] != 0)
+					indx2++;
+				} else {
+					fmdev->rds_data.af_data.AF[1][indx] =
+					fmdev->rds_data.af_data.AF[0][indx];
+				}
+			}
+
+		/* compare AF buff0 and buff1 data:end */
+		if (indx2 == num) {
+			fmdev->rds_data.af_data.addr_cnt = 0xFF;
+			for (indx = 0; indx < num; indx++) {
+				if ((fmdev->rds_data.af_data.AF[1][indx])
+					== 0)
+					fmdev->rds_data.af_data.addr_cnt = 0x0F;
+			}
+		} else
+			fmdev->rds_data.af_data.addr_cnt = 0x0F;
+	}
+}
+/*
+ * Group types which contain this information: 0A
+ * AF = Alternative Frequencies
+ * af information in block 3
+ */
+
+void rds_get_af(unsigned char *buf)
+{
+	unsigned char *blk_3 = buf + 2 * rds_data_unit_size;
+
+	if (*blk_3 != 1)
+		return;
+	rds_get_af_method(*(blk_3 + 1), *(blk_3 + 2));
+	fmdev->rds_data.af_data.AF[1][24] = 0;
+}
+
+/* Group types which contain this information: 0A 0B 15B */
+void rds_get_di_ms(unsigned char *buf)
+{
+}
+
+/*
+ * Group types which contain this information: TP_all(byte1 bit2);
+ * TA: 0A 0B 14B 15B(byte2 bit4)
+ * TP = Traffic Program identification; TA = Traffic Announcement
+ */
+
+void rds_get_tp_ta(unsigned char *buf, unsigned char grp_type)
+{
+	unsigned char *blk_2 = buf + rds_data_unit_size;
+	unsigned char byte1 = *(blk_2 + 1), byte2 = *(blk_2 + 2);
+	unsigned char ta_tp;
+	unsigned short *event = &(fmdev->rds_data.event_status);
+
+	if ((*blk_2) == 0)
+		return;
+	ta_tp = (unsigned char)((byte1 & (1<<2))>>2);
+	if (grp_type == 0x0a || grp_type == 0x0B || grp_type == 0xFB) {
+		ta_tp |= (byte2 & (1 << 4));
+		rds_event_set(event, RDS_EVENT_TAON_OFF);
+	}
+}
+
+/*
+ * Group types which contain this information: all
+ * block2:Programme Type code = 5 bits($)
+ * #### ##$$ $$$# ####
+ */
+
+void rds_get_pty(unsigned char *buf)
+{
+	unsigned char *blk_2 = buf + rds_data_unit_size;
+	unsigned char byte1 = *(blk_2 + 1), byte2 = *(blk_2 + 2);
+	unsigned char	pty = 0;
+
+	if ((*blk_2) == 1)
+		pty = ((byte2 >> 5) | ((byte1 & 0x3) << 3));
+	fmdev->rds_data.PTY = pty;
+}
+
+/*
+ * Group types which contain this information: all
+ * Read PI code from the group. grp_typeA: block 1 and block3,
+ * grp_type B: block3
+ */
+
+void rds_get_pi_code(unsigned char *buf, unsigned char version)
+{
+	unsigned char *blk_3 = buf + 2 * rds_data_unit_size;
+	/* pi_code for version A, pi_code_b for version B */
+	unsigned short pi_code = 0, pi_code_b = 0;
+	unsigned char crc_flag1 = *buf;
+	unsigned char crc_flag3 = *(buf + 2 * rds_data_unit_size);
+
+	if (version == invalid_grp_type)
+		return;
+
+	if (crc_flag1 == 1)
+		bytes_to_short(pi_code, buf+1);
+	else
+		return;
+
+	if (version == grp_ver_b) {
+		if (crc_flag3 == 1)
+			bytes_to_short(pi_code_b, blk_3 + 1);
+	}
+
+	if (pi_code == 0 && pi_code_b != 0)
+		pi_code = pi_code_b;
+/* send pi_code value to global and copy to user space in read rds interface */
+	fmdev->rds_data.PI = pi_code;
+}
+
+/*
+ * Block 1: PIcode(16bit)+CRC
+ * Block 2 : Group type code(4bit)
+ * B0 version(1bit 0:version A; 1:version B)
+ * TP(1bit)+ PTY(5 bits)
+ * @ buffer point to the start of Block 1
+ * Block3: 16bits + 10bits
+ * Block4: 16bits + 10bits
+ * rds_get_group_type from Block2
+ */
+unsigned char rds_get_group_type(unsigned char *buffer)
+{
+	unsigned char *crc_blk_2 = buffer + rds_data_unit_size;
+	unsigned char blk2_byte1 = *(crc_blk_2+1);
+	unsigned char group_type;
+	unsigned char crc_flag = *crc_blk_2;
+
+	if (crc_flag == 1)
+		group_type = (blk2_byte1 & grp_type_mask);
+	else
+		group_type = invalid_grp_type;
+	/* 0:version A, 1: version B */
+	if (blk2_byte1 & grp_ver_bit)
+		group_type |= grp_ver_b;
+	else
+		group_type |= grp_ver_a;
+
+	return group_type;
+}
+
+void dump_rx_data(unsigned char *buffer, unsigned int len)
+{
+	char i;
+
+	pr_info("\n fm rx data(%d): ", len);
+	for (i = 0; i < len; i++)
+		pr_info("0x%x__", *(buffer+i));
+	pr_info("\n");
+}
+
+/*
+ * rds_parser
+ * Block0: PI code(16bits)
+ * Block1: Group type(4bits), B0=version code(1bit),
+ * TP=traffic program code(1bit),
+ * PTY=program type code(5bits), other(5bits)
+ * @getfreq - function pointer, AF need get current freq
+ * Theoretically From FIFO :
+ * One Group = Block1(16 bits) + CRC(10 bits)
+ * Block2 +CRC(10 bits)
+ * Block3(16 bits) + CRC(10 bits)
+ * Block4(16 bits) + CRC(10 bits)
+ * From marlin2 chip, the data stream is like below:
+ * One Group = CRC_Flag(8bit)+Block1(16bits)
+ * CRC_Flag(8bit)+Block2(16bits)
+ * CRC_Flag(8bit)+Block3(16bits)
+ * CRC_Flag(8bit)+Block4(16bits)
+ */
+void rds_parser(unsigned char *buffer, unsigned char len, unsigned int fifo_id)
+{
+	unsigned char grp_type;
+
+	dump_rx_data(buffer, len);
+	grp_type = rds_get_group_type(buffer);
+	pr_info("group type is : 0x%x\n", grp_type);
+
+	rds_get_pi_code(buffer, grp_type & grp_ver_mask);
+	rds_get_pty(buffer);
+	rds_get_tp_ta(buffer, grp_type);
+
+	switch (grp_type) {
+	case invalid_grp_type:
+		pr_info("invalid group type\n");
+		break;
+	/* Processing group 0A */
+	case 0x0A:
+		rds_get_di_ms(buffer);
+		rds_get_af(buffer);
+		rds_get_ps(buffer);
+		break;
+	/* Processing group 0B */
+	case 0x0B:
+		rds_get_di_ms(buffer);
+		rds_get_ps(buffer);
+		break;
+	case 0x1A:
+		rds_get_slc(buffer);
+		rds_get_pin(buffer);
+		break;
+	case 0x1B:
+		rds_get_pin(buffer);
+		break;
+	case 0x2A:
+	case 0x2B:
+		rds_get_rt(buffer, grp_type);
+		break;
+	case 0x3A:
+		rds_get_oda_aid(buffer);
+		break;
+	case 0x4A:
+		rds_get_ct(buffer);
+		break;
+	case 0x5A:
+	case 0x5B:
+		rds_get_tdc(buffer, grp_type & grp_ver_mask);
+		break;
+	case 0x9a:
+		rds_get_ews(buffer);
+		break;
+	/* 10A group */
+	case 0xAA:
+		rds_get_ptyn(buffer);
+		break;
+	case 0xEA:
+		rds_get_eon(buffer);
+		break;
+	case 0xEB:
+		rds_get_eon_ta(buffer);
+		break;
+	case 0xFB:
+		rds_get_di_ms(buffer);
+		break;
+/* ODA (Open Data Applications) group availability signaled in type 3A groups */
+	case 0x3B:
+	case 0x4B:
+	case 0x6A:
+	case 0x6B:
+	case 0x7A:
+	case 0x7B:
+	case 0x8A:
+	case 0x8B:
+	case 0x9B:
+	case 0xAB:
+	case 0xBA:
+	case 0xBB:
+	case 0xCA:
+	case 0xCB:
+	case 0xDB:
+	case 0xDA:
+	case 0xFA:
+		rds_get_oda(buffer);
+		break;
+	default:
+		pr_info("rds group type[0x%x] not to be processed\n", grp_type);
+		break;
+	}
+	sdiom_pt_read_release(fifo_id);
+	pr_info("fmdrv release fifo_id is %d\n", fifo_id);
+}
+
diff --git a/drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.h b/drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.h
new file mode 100644
index 0000000..404dc28
--- /dev/null
+++ b/drivers/misc/sprd-wcn/radio/fmdrv_rds_parser.h
@@ -0,0 +1,103 @@
+/*
+ * SPREADTRUM SC2342 FM Radio driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _FMDRV_RDS_PARSER
+#define _FMDRV_RDS_PARSER
+
+/* Block1 */
+#define RDS_BLCKA		0x00
+/* Block2 */
+#define RDS_BLCKB		0x10
+/* Block3 */
+#define RDS_BLCKC		0x20
+/* Block4 */
+#define RDS_BLCKD		0x30
+/* BlockC hyphen */
+#define RDS_BLCKC_C		0x40
+/* BlockE in RBDS */
+#define RDS_BLCKE_B		0x50
+/* Block E  */
+#define RDS_BLCKE		0x60
+
+/* 3bytes = 8bit(CRC flag) + 16bits (1 block ) */
+#define rds_data_unit_size	3
+#define rds_data_group_size	(3*4)
+#define grp_type_mask		0xF0
+#define grp_ver_mask		0x0F
+/* 0:version A, 1: version B */
+#define grp_ver_bit		(0x01<<3)
+#define grp_ver_a		0x0A
+#define grp_ver_b		0x0B
+#define invalid_grp_type	0x00
+
+/* AF fill in code */
+#define RDS_AF_FILL		205
+/* AF invalid code low marker */
+#define RDS_AF_INVAL_L		205
+/* AF invalid code middle marker */
+#define RDS_AF_INVAL_M		223
+/* 0 AF follow */
+#define RDS_AF_NONE		224
+/* 1 AF follow */
+#define RDS_AF_NUM_1		225
+/* 25 AFs follow */
+#define RDS_AF_NUM_25		249
+/* LF/MF follow */
+#define RDS_LF_MF		250
+/* AF invalid code high marker */
+#define RDS_AF_INVAL_H		251
+/* AF invalid code top marker */
+#define RDS_AF_INVAL_T		255
+/* lowest MF frequency */
+#define RDS_MF_LOW		0x10
+
+/* FM base frequency */
+#define RDS_FM_BASE		875
+/* MF base frequency */
+#define RDS_MF_BASE		531
+/* LF base frequency */
+#define RDS_LF_BASE		153
+
+/* minimum day */
+#define RDS_MIN_DAY		1
+/* maximum day */
+#define RDS_MAX_DAY		31
+/* minimum hour */
+#define RDS_MIN_HUR		0
+/* maximum hour */
+#define RDS_MAX_HUR		23
+/* minimum minute */
+#define RDS_MIN_MUT		0
+/* maximum minute */
+#define RDS_MAX_MUT		59
+/* left over rds data length max in control block */
+#define BTA_RDS_LEFT_LEN         24
+/* Max radio text length */
+#define BTA_RDS_RT_LEN           64
+/* 8 character RDS feature length, i.e. PS, PTYN */
+#define BTA_RDS_LEN_8            8
+
+/* AF encoding method */
+enum {
+	/* unknown */
+	RDS_AF_M_U,
+	/* method - A */
+	RDS_AF_M_A,
+	/* method - B */
+	RDS_AF_M_B
+};
+
+/* change 8 bits to 16bits */
+#define bytes_to_short(dest, src)  (dest = (unsigned short)(((unsigned short)\
+	(*(src)) << 8) + (unsigned short)(*((src) + 1))))
+
+void dump_rx_data(unsigned char *buffer, unsigned int len);
+void rds_parser(unsigned char *buffer, unsigned char len,
+		unsigned int fifo_id);
+
+#endif /* _FMDRV_RDS_PARSER */
-- 
2.7.4
