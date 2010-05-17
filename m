From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 17 May 2010 08:23:31 +0300
Subject: [alsa-devel] [patch 5/6] orion/kirkwood: Add i2s support
In-Reply-To: <20100515153130.937921459@mandriva.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153130.937921459@mandriva.com>
Message-ID: <AANLkTim31zMgvsSdcidDvmD-Q3124w48PVxMnT3nL5O6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + ? ? ? /* First disable and clear windows */
> + ? ? ? for (win_num = 0; win_num < ORION_MAX_AUDIO_WIN; win_num++) {
> + ? ? ? ? ? ? ? writel(0, base + ORION_AUDIO_WIN_CTRL_REG(win_num));
> + ? ? ? ? ? ? ? writel(0, base + ORION_AUDIO_WIN_BASE_REG(win_num));
> + ? ? ? }
> +
> + ? ? ? /* Setup windows for DDR */
> + ? ? ? for (win_num = 0; win_num < ORION_MAX_AUDIO_WIN; win_num++) {
> + ? ? ? ? ? ? ? /* We will set the Window to DRAM_CS1 in default */
> + ? ? ? ? ? ? ? struct mbus_dram_window *cs = &dram->cs[1];
> + ? ? ? ? ? ? ? writel(cs->base & 0xffff0000,
> + ? ? ? ? ? ? ? ? ? ? ?base + ORION_AUDIO_WIN_BASE_REG(win_num));
> + ? ? ? ? ? ? ? writel(((cs->size - 1) & 0xffff0000) |
> + ? ? ? ? ? ? ? ? ? ? ?(cs->mbus_attr << 8) |
> + ? ? ? ? ? ? ? ? ? ? ?(dram->mbus_dram_target_id << 4) | 1,
> + ? ? ? ? ? ? ? ? ? ? ? base + ORION_AUDIO_WIN_CTRL_REG(win_num));
> + ? ? ? }
> +}
The i2s controller has one window for playback, so that window must be
set according to the current dma address, i.e, if the dma address
falls into csX then the window should be configured to csX. same for
record.
sorry for the late comment.
saeed
