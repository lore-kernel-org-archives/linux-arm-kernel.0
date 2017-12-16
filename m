From: briannorris@chromium.org (Brian Norris)
Date: Fri, 15 Dec 2017 19:25:54 -0800
Subject: [PATCH] ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink
In-Reply-To: <20171121082517.17233-1-jeffy.chen@rock-chips.com>
References: <20171121082517.17233-1-jeffy.chen@rock-chips.com>
Message-ID: <20171216032552.GA220745@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 21, 2017 at 04:25:17PM +0800, Jeffy Chen wrote:
> The rt5514 dsp captures pcm data through spi directly, so we should not
> use rockchip-i2s as it's cpu dai like other codecs.
> 
> Use dummy_dai for rt5514 dsp dailink to make voice wakeup work again.
> 
> Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
> Fixes: (72cfb0f20c75 ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp)
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

I didn't review this closely (and I don't know ASoC that well), but this
does fix regressions I've seen on 4.15 RCs, where

(a) the rt5514 DAI link doesn't get set up
(b) the rt5514 *always* causes my device to wake up, because we arm the
    wakeup IRQ even though we never actually configured the DSP
(c) there are system crashes on resume because the rt5514-spi driver
    assumes that the DAI link was correctly configured (that's the
    subject of another patch I sent [1]

I believe this was working fine on 4.14? At least, I know (b) didn't
happen, and I'm not sure about (a). (c) is a new issue in 4.15-rc1.

Anyway, that's all to say:

Tested-by: Brian Norris <briannorris@chromium.org>

on the "kevin" Chromebook (Samsung Chromebook Plus).

I also suspect this might be regression-fixing material, for 4.15. Or if
not, at least something like patch [1] should be.

Thanks,
Brian

[1] https://patchwork.kernel.org/patch/10116761/
    [PATCH for-4.15] ASoC: rt5514: don't assume rt5514 component was "attached"
