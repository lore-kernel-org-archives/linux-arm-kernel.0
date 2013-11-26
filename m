From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 26 Nov 2013 18:48:14 +0200
Subject: [PATCH] clk: tegra: add TEGRA_DIVIDER_ROUND_UP for periph clks
Message-ID: <1385484495-9835-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perform upwards rounding when calculating dividers for periph clks on Tegra30
and Tegra114.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c |   53 ++++++++++++++++++++-----------------
 drivers/clk/tegra/clk-tegra30.c  |   19 +++++++------
 2 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 7661128..e390492 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -791,50 +791,53 @@ static unsigned long tegra114_input_freq[] = {
 #define TEGRA_INIT_DATA_MUX(_name, _con_id, _dev_id, _parents, _offset,	\
 			    _clk_num, _regs, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset,\
-			30, MASK(2), 0, 0, 8, 1, 0, _regs, _clk_num,	\
-			periph_clk_enb_refcnt, _gate_flags, _clk_id,	\
-			_parents##_idx, 0)
+			30, MASK(2), 0, 0, 8, 1, TEGRA_DIVIDER_ROUND_UP, \
+			_regs, _clk_num, periph_clk_enb_refcnt, _gate_flags,\
+			_clk_id, _parents##_idx, 0)
 
 #define TEGRA_INIT_DATA_MUX_FLAGS(_name, _con_id, _dev_id, _parents, _offset,\
 			    _clk_num, _regs, _gate_flags, _clk_id, flags)\
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset,\
-			30, MASK(2), 0, 0, 8, 1, 0, _regs, _clk_num,	\
-			periph_clk_enb_refcnt, _gate_flags, _clk_id,	\
-			_parents##_idx, flags)
+			30, MASK(2), 0, 0, 8, 1, TEGRA_DIVIDER_ROUND_UP,\
+			_regs, _clk_num, periph_clk_enb_refcnt, _gate_flags,\
+			_clk_id, _parents##_idx, flags)
 
 #define TEGRA_INIT_DATA_MUX8(_name, _con_id, _dev_id, _parents, _offset, \
 			     _clk_num, _regs, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset,\
-			29, MASK(3), 0, 0, 8, 1, 0, _regs, _clk_num,	\
-			periph_clk_enb_refcnt, _gate_flags, _clk_id,	\
-			_parents##_idx, 0)
+			29, MASK(3), 0, 0, 8, 1, TEGRA_DIVIDER_ROUND_UP,\
+			_regs, _clk_num, periph_clk_enb_refcnt, _gate_flags,\
+			_clk_id, _parents##_idx, 0)
 
 #define TEGRA_INIT_DATA_INT_FLAGS(_name, _con_id, _dev_id, _parents, _offset,\
 			    _clk_num, _regs, _gate_flags, _clk_id, flags)\
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset,\
-			30, MASK(2), 0, 0, 8, 1, TEGRA_DIVIDER_INT, _regs,\
-			_clk_num, periph_clk_enb_refcnt, _gate_flags,	\
-			_clk_id, _parents##_idx, flags)
+			30, MASK(2), 0, 0, 8, 1, TEGRA_DIVIDER_INT |	\
+			TEGRA_DIVIDER_ROUND_UP, _regs, _clk_num,	\
+			periph_clk_enb_refcnt, _gate_flags, _clk_id,	\
+			_parents##_idx, flags)
 
 #define TEGRA_INIT_DATA_INT8(_name, _con_id, _dev_id, _parents, _offset,\
 			    _clk_num, _regs, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset,\
-			29, MASK(3), 0, 0, 8, 1, TEGRA_DIVIDER_INT, _regs,\
-			_clk_num, periph_clk_enb_refcnt, _gate_flags,	\
-			_clk_id, _parents##_idx, 0)
+			29, MASK(3), 0, 0, 8, 1, TEGRA_DIVIDER_INT |	\
+			TEGRA_DIVIDER_ROUND_UP, _regs, _clk_num,	\
+			periph_clk_enb_refcnt, _gate_flags, _clk_id,	\
+			_parents##_idx, 0)
 
 #define TEGRA_INIT_DATA_UART(_name, _con_id, _dev_id, _parents, _offset,\
 			     _clk_num, _regs, _clk_id)			\
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset,\
-			30, MASK(2), 0, 0, 16, 1, TEGRA_DIVIDER_UART, _regs,\
-			_clk_num, periph_clk_enb_refcnt, 0, _clk_id,	\
-			_parents##_idx, 0)
+			30, MASK(2), 0, 0, 16, 1, TEGRA_DIVIDER_UART |	\
+			TEGRA_DIVIDER_ROUND_UP, _regs, _clk_num,	\
+			periph_clk_enb_refcnt, 0, _clk_id, _parents##_idx, 0)
 
 #define TEGRA_INIT_DATA_I2C(_name, _con_id, _dev_id, _parents, _offset,\
 			     _clk_num, _regs, _clk_id)			\
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset,\
-			30, MASK(2), 0, 0, 16, 0, 0, _regs, _clk_num,	\
-			periph_clk_enb_refcnt, 0, _clk_id, _parents##_idx, 0)
+			30, MASK(2), 0, 0, 16, 0, TEGRA_DIVIDER_ROUND_UP,\
+			_regs, _clk_num, periph_clk_enb_refcnt, 0, _clk_id,\
+			_parents##_idx, 0)
 
 #define TEGRA_INIT_DATA_NODIV(_name, _con_id, _dev_id, _parents, _offset, \
 			      _mux_shift, _mux_mask, _clk_num, _regs,	\
@@ -847,14 +850,16 @@ static unsigned long tegra114_input_freq[] = {
 #define TEGRA_INIT_DATA_XUSB(_name, _con_id, _dev_id, _parents, _offset, \
 			     _clk_num, _regs, _gate_flags, _clk_id)	 \
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, _parents, _offset, \
-			29, MASK(3), 0, 0, 8, 1, TEGRA_DIVIDER_INT, _regs, \
-			_clk_num, periph_clk_enb_refcnt, _gate_flags,	 \
-			_clk_id, _parents##_idx, 0)
+			29, MASK(3), 0, 0, 8, 1, TEGRA_DIVIDER_INT |	\
+			TEGRA_DIVIDER_ROUND_UP, _regs, _clk_num,	\
+			periph_clk_enb_refcnt, _gate_flags, _clk_id,	\
+			_parents##_idx, 0)
 
 #define TEGRA_INIT_DATA_AUDIO(_name, _con_id, _dev_id, _offset,  _clk_num,\
 				 _regs, _gate_flags, _clk_id)		\
 	TEGRA_INIT_DATA_TABLE(_name, _con_id, _dev_id, mux_d_audio_clk,	\
-			_offset, 16, 0xE01F, 0, 0, 8, 1, 0, _regs, _clk_num, \
+			_offset, 16, 0xE01F, 0, 0, 8, 1,		\
+			TEGRA_DIVIDER_ROUND_UP, _regs, _clk_num,	\
 			periph_clk_enb_refcnt, _gate_flags , _clk_id,	\
 			mux_d_audio_clk_idx, 0)
 
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index dbe7c80..147f5b9 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -282,8 +282,8 @@ static DEFINE_SPINLOCK(sysrate_lock);
 #define TEGRA_INIT_DATA_MUX(_name, _con_id, _dev_id, _parents, _offset,	\
 			    _clk_num, _regs, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA(_name, _con_id, _dev_id, _parents, _offset,	\
-			30, 2, 0, 0, 8, 1, 0, _regs, _clk_num,		\
-			periph_clk_enb_refcnt, _gate_flags, _clk_id)
+			30, 2, 0, 0, 8, 1, TEGRA_DIVIDER_ROUND_UP, _regs, \
+			_clk_num, periph_clk_enb_refcnt, _gate_flags, _clk_id)
 
 #define TEGRA_INIT_DATA_DIV16(_name, _con_id, _dev_id, _parents, _offset, \
 			    _clk_num, _regs, _gate_flags, _clk_id)	\
@@ -295,21 +295,22 @@ static DEFINE_SPINLOCK(sysrate_lock);
 #define TEGRA_INIT_DATA_MUX8(_name, _con_id, _dev_id, _parents, _offset, \
 			     _clk_num, _regs, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA(_name, _con_id, _dev_id, _parents, _offset,	\
-			29, 3, 0, 0, 8, 1, 0, _regs, _clk_num,		\
-			periph_clk_enb_refcnt, _gate_flags, _clk_id)
+			29, 3, 0, 0, 8, 1, TEGRA_DIVIDER_ROUND_UP, _regs,\
+			_clk_num, periph_clk_enb_refcnt, _gate_flags, _clk_id)
 
 #define TEGRA_INIT_DATA_INT(_name, _con_id, _dev_id, _parents, _offset,	\
 			    _clk_num, _regs, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA(_name, _con_id, _dev_id, _parents, _offset,	\
-			30, 2, 0, 0, 8, 1, TEGRA_DIVIDER_INT, _regs,	\
-			_clk_num, periph_clk_enb_refcnt, _gate_flags,	\
-			_clk_id)
+			30, 2, 0, 0, 8, 1, TEGRA_DIVIDER_INT |		\
+			TEGRA_DIVIDER_ROUND_UP, _regs, _clk_num,	\
+			periph_clk_enb_refcnt, _gate_flags, _clk_id)
 
 #define TEGRA_INIT_DATA_UART(_name, _con_id, _dev_id, _parents, _offset,\
 			     _clk_num, _regs, _clk_id)			\
 	TEGRA_INIT_DATA(_name, _con_id, _dev_id, _parents, _offset,	\
-			30, 2, 0, 0, 16, 1, TEGRA_DIVIDER_UART, _regs,	\
-			_clk_num, periph_clk_enb_refcnt, 0, _clk_id)
+			30, 2, 0, 0, 16, 1, TEGRA_DIVIDER_UART |	\
+			TEGRA_DIVIDER_ROUND_UP, _regs, _clk_num,	\
+			periph_clk_enb_refcnt, 0, _clk_id)
 
 #define TEGRA_INIT_DATA_NODIV(_name, _con_id, _dev_id, _parents, _offset, \
 			      _mux_shift, _mux_width, _clk_num, _regs,	\
-- 
1.7.7.rc0.72.g4b5ea.dirty
