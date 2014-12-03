From: dianders@chromium.org (Doug Anderson)
Date: Tue, 2 Dec 2014 21:13:55 -0800
Subject: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C spec
In-Reply-To: <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=VupzfrWWkRMmQz_c57Gq59gmM4Oq=iYrYfHuTeR8giKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Tue, Dec 2, 2014 at 6:37 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> high_ns calculated from the low division of CLKDIV register is the sum
> of actual measured high_ns and rise_ns. The rise time which related to
> external pull-up resistor can be up to the maximum rise time in I2C spec.
>
> In my test, if external pull-up resistor is 4.7K, rise_ns is about
> 700ns. So the actual measured high_ns is about 3900ns, which is less
> than 4000ns(the minimum high_ns in I2C spec).
>
> To fix this bug, min_low_ns should include fall time and min_high_ns
> should include rise time too.
>
> This patch merged the patch that Doug submitted to chromium, which
> can get the rise and fall times for signals from the device tree.
> This allows us to more accurately calculate timings. see:
> https://chromium-review.googlesource.com/#/c/232774/
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
> Changes in v2:
> - merged the patch that Doug submitted to chromium
>
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 10 ++++
>  drivers/i2c/busses/i2c-rk3x.c                      | 55 +++++++++++++++-------
>  2 files changed, 47 insertions(+), 18 deletions(-)

This looks good to me.  Thank you for spinning.

Reviewed-by: Doug Anderson <dianders@chromium.org>
