From: dianders@chromium.org (Doug Anderson)
Date: Thu, 18 Dec 2014 09:46:00 -0800
Subject: [PATCH] i2c: rk3x: Account for repeated start time requirement
In-Reply-To: <1418325511-16648-1-git-send-email-dianders@chromium.org>
References: <1418325511-16648-1-git-send-email-dianders@chromium.org>
Message-ID: <CAD=FV=Vt3q_7g=SmnV5ZCd-Evr_17BTMR9LWsFax8qOwtkSw6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 11, 2014 at 11:18 AM, Doug Anderson <dianders@chromium.org> wrote:
> On Rockchip I2C the controller drops SDA low in the repeated start
> condition at half the SCL high time.
>
> If we want to meet timing requirements, that means we need to hold SCL
> high for (4.7us * 2) when we're sending a repeated start (.6us * 2 for
> Fast-mode).  That lets us achieve minimum tSU;STA.  However, we don't
> want to always hold SCL high for that long because we'd never be able
> to make 100kHz or 400kHz speeds.
>
> Let's fix this by doing our clock calculations twice: once taking the
> above into account and once running at normal speeds.  We'll use the
> slower speed when sending the start bit and the normal speed
> otherwise.
>
> Note: we really only need the conservative timing when sending
> _repeated_ starts, not when sending the first start.  We don't account
> for this so technically the first start bit will be longer too.
> ...well, except in the case when we use the combined write/read
> optimization which doesn't use the same code.
>
> As part of this change we needed to account for the SDA falling time.
> The specification indicates that this should be the same, but we'll
> follow Designware and add a binding.  Note that we deviate from
> Designware and assign the default SDA falling time to be the same as
> the SCL falling time, which is incredibly likely.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Note: This is based on Addy's patch (i2c: rk3x: fix bug that cause
> measured high_ns doesn't meet I2C specification) that can be found at
> <https://patchwork.kernel.org/patch/5475331/>.
>
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  7 +-
>  drivers/i2c/busses/i2c-rk3x.c                      | 90 +++++++++++++++++-----
>  2 files changed, 74 insertions(+), 23 deletions(-)

So apparently the person who tested this for me got mixed up and told
me it was good, but it wasn't.  :(

I've sent up a new version.  I've tested it myself this time but
certainly would appreciate any extra testing folks can do on it...
See <https://patchwork.kernel.org/patch/5515551/>

-Doug
