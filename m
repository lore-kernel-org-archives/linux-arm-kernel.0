From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Thu, 16 Nov 2017 14:59:55 -0500
Subject: [linux-sunxi] Cedrus driver
In-Reply-To: <20171116110204.poakahqjz4sj7pmu@flea>
References: <1510059543-7064-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1b12fa21-bfe6-9ba7-ae1d-8131ac6f4668@micronovasrl.com>
 <6fcdc0d9-d0f8-785a-bb00-b1b41c684e59@imkreisrum.de>
 <693e8786-af83-9d77-0fd4-50fa1f6a135f@micronovasrl.com>
 <20171116110204.poakahqjz4sj7pmu@flea>
Message-ID: <1510862395.8053.39.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 16 novembre 2017 ? 12:02 +0100, Maxime Ripard a ?crit :
> Assuming that the request API is in, we'd need to:
>   - Finish the MPEG4 support
>   - Work on more useful codecs (H264 comes to my mind)

For which we will have to review the tables and make sure they match
the spec (the easy part). But as an example, that branch uses a table
that merge Mpeg4 VOP and VOP Short Header. We need to make sure it does
not pause problems or split it up. On top of that, ST and Rockchip
teams should give some help and sync with these tables on their side.
We also need to consider decoder like Tegra 2. In H264, they don't need
frame parsing, but just the PPS/SPS data (might just be parsed in the
driver, like CODA ?). There is other mode of operation, specially in
H264/HEVC low latency, where the decoder will be similar, but will
accept and process slices right away, without waiting for the full
frame.

We also need some doc, to be able to tell the GStreamer and FFMPEG team
how to detect and handle these decoder. I doubt the libv4l2 proposed
approach will be used for these two projects since they already have
their own parser and would like to not parse twice. As an example, we
need to document that V4L2_PIX_FMT_MPEG2_FRAME implies using the
Request API and specific CID. We should probably also ping the Chrome
Devs, which probably have couple of pending branches around this.

regards,
Nicolas


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171116/b9fdd8c2/attachment.sig>
