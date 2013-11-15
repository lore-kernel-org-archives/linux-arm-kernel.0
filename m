From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:12 -0700
Subject: [PATCH 17/31] ASoC: tegra: call pm_runtime APIs around register
 accesses
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-18-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Call pm_runtime_get_sync() before all register accesses; the HW requires
clocks to be running when accessing registers.

This hasn't been needed to date, since all register IO was performed
while playback was active, and hence the ASoC core had already called
pm_runtime_get(). However, an imminent future commit will allocate and
set up the FIFOs and routing during probe(), when that "protection"
won't be in place.

Cc: treding at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 sound/soc/tegra/tegra30_ahub.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 5ce00dc48c44..2f1a566dd9cc 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -115,6 +115,8 @@ int tegra30_ahub_allocate_rx_fifo(enum tegra30_ahub_rxcif *rxcif,
 		   (channel * TEGRA30_AHUB_CHANNEL_RXFIFO_STRIDE);
 	*reqsel = ahub->dma_sel + channel;
 
+	pm_runtime_get_sync(ahub->dev);
+
 	reg = TEGRA30_AHUB_CHANNEL_CTRL +
 	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
 	val = tegra30_apbif_read(reg);
@@ -141,6 +143,8 @@ int tegra30_ahub_allocate_rx_fifo(enum tegra30_ahub_rxcif *rxcif,
 	      (channel * TEGRA30_AHUB_CIF_RX_CTRL_STRIDE);
 	ahub->soc_data->set_audio_cif(ahub->regmap_apbif, reg, &cif_conf);
 
+	pm_runtime_put(ahub->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_allocate_rx_fifo);
@@ -150,12 +154,16 @@ int tegra30_ahub_enable_rx_fifo(enum tegra30_ahub_rxcif rxcif)
 	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
 	int reg, val;
 
+	pm_runtime_get_sync(ahub->dev);
+
 	reg = TEGRA30_AHUB_CHANNEL_CTRL +
 	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
 	val = tegra30_apbif_read(reg);
 	val |= TEGRA30_AHUB_CHANNEL_CTRL_RX_EN;
 	tegra30_apbif_write(reg, val);
 
+	pm_runtime_put(ahub->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_enable_rx_fifo);
@@ -165,12 +173,16 @@ int tegra30_ahub_disable_rx_fifo(enum tegra30_ahub_rxcif rxcif)
 	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
 	int reg, val;
 
+	pm_runtime_get_sync(ahub->dev);
+
 	reg = TEGRA30_AHUB_CHANNEL_CTRL +
 	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
 	val = tegra30_apbif_read(reg);
 	val &= ~TEGRA30_AHUB_CHANNEL_CTRL_RX_EN;
 	tegra30_apbif_write(reg, val);
 
+	pm_runtime_put(ahub->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_disable_rx_fifo);
@@ -205,6 +217,8 @@ int tegra30_ahub_allocate_tx_fifo(enum tegra30_ahub_txcif *txcif,
 		   (channel * TEGRA30_AHUB_CHANNEL_TXFIFO_STRIDE);
 	*reqsel = ahub->dma_sel + channel;
 
+	pm_runtime_get_sync(ahub->dev);
+
 	reg = TEGRA30_AHUB_CHANNEL_CTRL +
 	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
 	val = tegra30_apbif_read(reg);
@@ -231,6 +245,8 @@ int tegra30_ahub_allocate_tx_fifo(enum tegra30_ahub_txcif *txcif,
 	      (channel * TEGRA30_AHUB_CIF_TX_CTRL_STRIDE);
 	ahub->soc_data->set_audio_cif(ahub->regmap_apbif, reg, &cif_conf);
 
+	pm_runtime_put(ahub->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_allocate_tx_fifo);
@@ -240,12 +256,16 @@ int tegra30_ahub_enable_tx_fifo(enum tegra30_ahub_txcif txcif)
 	int channel = txcif - TEGRA30_AHUB_TXCIF_APBIF_TX0;
 	int reg, val;
 
+	pm_runtime_get_sync(ahub->dev);
+
 	reg = TEGRA30_AHUB_CHANNEL_CTRL +
 	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
 	val = tegra30_apbif_read(reg);
 	val |= TEGRA30_AHUB_CHANNEL_CTRL_TX_EN;
 	tegra30_apbif_write(reg, val);
 
+	pm_runtime_put(ahub->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_enable_tx_fifo);
@@ -255,12 +275,16 @@ int tegra30_ahub_disable_tx_fifo(enum tegra30_ahub_txcif txcif)
 	int channel = txcif - TEGRA30_AHUB_TXCIF_APBIF_TX0;
 	int reg, val;
 
+	pm_runtime_get_sync(ahub->dev);
+
 	reg = TEGRA30_AHUB_CHANNEL_CTRL +
 	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
 	val = tegra30_apbif_read(reg);
 	val &= ~TEGRA30_AHUB_CHANNEL_CTRL_TX_EN;
 	tegra30_apbif_write(reg, val);
 
+	pm_runtime_put(ahub->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_disable_tx_fifo);
@@ -281,10 +305,14 @@ int tegra30_ahub_set_rx_cif_source(enum tegra30_ahub_rxcif rxcif,
 	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
 	int reg;
 
+	pm_runtime_get_sync(ahub->dev);
+
 	reg = TEGRA30_AHUB_AUDIO_RX +
 	      (channel * TEGRA30_AHUB_AUDIO_RX_STRIDE);
 	tegra30_audio_write(reg, 1 << txcif);
 
+	pm_runtime_put(ahub->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_set_rx_cif_source);
@@ -294,10 +322,14 @@ int tegra30_ahub_unset_rx_cif_source(enum tegra30_ahub_rxcif rxcif)
 	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
 	int reg;
 
+	pm_runtime_get_sync(ahub->dev);
+
 	reg = TEGRA30_AHUB_AUDIO_RX +
 	      (channel * TEGRA30_AHUB_AUDIO_RX_STRIDE);
 	tegra30_audio_write(reg, 0);
 
+	pm_runtime_put(ahub->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_unset_rx_cif_source);
-- 
1.8.1.5
