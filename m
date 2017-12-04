From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 4 Dec 2017 08:43:33 +0800
Subject: [PATCH 1/9] ASoC: sun4i-i2s: Add quirk to handle fixed WSS
In-Reply-To: <20171203204157.20829-2-anarsoul@gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-2-anarsoul@gmail.com>
Message-ID: <CAGb2v64BpqPzj0WOeiY0mQkX9QXqKctUJyfD9DOVfaE_K6k39g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 4, 2017 at 4:41 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> I2S for audio codec on sun50i-A64 always uses fixed word select size value,
> no matter what is sample width. Add quirk to support that.

Please clarify on this. Does this mean the WSS bitfield is useless and it
always sends out the same sample sizes regardless of the setting? Or it's
the codec that can only use a fixed sample width?

As far as I can tell, the code you added in this patch points to the latter.
In that case. this is the wrong way to go about it. The limitation is a
property of the codec, not the I2S controller. If the codec assumes 32 bits
per sample, then that is what you should setup in the code driver. See
sun8i_codec_dai in sound/soc/sunxi/sun8i-codec.c where you can set the
format. You'll likely need to make a copy of the data structure for A64,
and tie it to the compatible.

ChenYu
