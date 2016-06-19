From: olof@lixom.net (Olof Johansson)
Date: Sat, 18 Jun 2016 22:21:13 -0700
Subject: [PATCH v4.7-rc] ARM: dts: STi: stih407-family: Disable
 reserved-memory co-processor nodes
In-Reply-To: <1466163858-13819-1-git-send-email-maxime.coquelin@st.com>
References: <1466163858-13819-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <20160619052113.GB11958@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 01:44:18PM +0200, Maxime Coquelin wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> This patch fixes a non-booting issue in Mainline.
> 
> When booting with a compressed kernel, we need to be careful how we
> populate memory close to DDR start.  AUTO_ZRELADDR is enabled by default
> in multi-arch enabled configurations, which place some restrictions on
> where the kernel is placed and where it will be uncompressed to on boot.
> 
> AUTO_ZRELADDR takes the decompressor code's start address and masks out
> the bottom 28 bits to obtain an address to uncompress the kernel to
> (thus a load address of 0x42000000 means that the kernel will be
> uncompressed to 0x40000000 i.e. DDR START on this platform).
> 
> Even changing the load address to after the co-processor's shared memory
> won't render a booting platform, since the AUTO_ZRELADDR algorithm still
> ensures the kernel is uncompressed into memory shared with the first
> co-processor (0x40000000).
> 
> Another option would be to move loading to 0x4A000000, since this will
> mean the decompressor will decompress the kernel to 0x48000000. However,
> this would mean a large chunk (0x44000000 => 0x48000000 (64MB)) of
> memory would essentially be wasted for no good reason.
> 
> Until we can work with ST to find a suitable memory location to
> relocate co-processor shared memory, let's disable the shared memory
> nodes.  This will ensure a working platform in the mean time.
> 
> NB: The more observant of you will notice that we're leaving the DMU
> shared memory node enabled; this is because a) it is the only one in
> active use at the time of this writing and b) it is not affected by
> the current default behaviour which is causing issues.
> 
> Fixes: fe135c6 (ARM: dts: STiH407: Move over to using the 'reserved-memory' API for obtaining DMA memory)
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>

Applied, thanks.

-Olof
