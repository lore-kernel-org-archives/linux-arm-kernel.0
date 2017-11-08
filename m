From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  8 Nov 2017 16:47:07 +0100
Subject: [PATCH 0/3] ASoC: sun8i-codec: A33 codec fixes
Message-ID: <20171108154710.16407-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The commit 043b8daa578f ("ASoC: sun4i-i2s: Update global enable with
bitmask") has broken the A33 codec since it's been merged as part as
4.14-rc1.

The reason has been that while that commit was obviously right, one of
its side effect was to clear the bit that would set the I2S controller
in slave mode, effectively forcing it to act as master.

This was actually working by accident since the codec also had its
condition on whether to act as a master or a slave backward, meaning
that even though we were setting the i2s controller as slave and the
codec as master, we were ending up with the exact opposite.

The commit mentionned above (rightfully) broke that combination, and
we ended up with the two devices in slave mode, which obviously didn't
work.

The way to fix that is in two parts. The first one is obviously to
make the codec act as its proper role. However, that's not sufficient
because some logic was missing in the initial driver that was merged
to act as such. Indeed the BCLK divider was never programmed, meaning
that we would generate a BCLK running at the PLL rate, which is way
too fast. The second patch addresses that.

The final fix is here to address an issue that has been there for
quite some time too and would invert the two channels. It appears that
the codec and I2S drivers don't share the same polarity for the LRCK
signal. The fix is quite obvious and is to invert whatever value has
been programmed in ALSA.

All these commits should go as fix in 4.14 if possible, as without
them the audio is completely broken.

Let me know what you think,
Maxime

Maxime Ripard (3):
  ASoC: sun8i-codec: Invert Master / Slave condition
  ASoC: sun8i-codec: Set the BCLK divider
  ASoC: sun8i-codec: Fix left and right channels inversion

 sound/soc/sunxi/sun8i-codec.c | 63 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

-- 
2.14.3
