From: dianders@chromium.org (Doug Anderson)
Date: Fri, 4 Sep 2015 13:00:11 -0700
Subject: [PATCH 8/9] drm: bridge/dw_hdmi: replace CTS calculation for the
 ACR
In-Reply-To: <E1ZO6hm-0003Ni-E0@rmk-PC.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hm-0003Ni-E0@rmk-PC.arm.linux.org.uk>
Message-ID: <CAD=FV=X6Qhuw6DF7HFqQ-uMMC1TRRNYoPZs=aUhqs9q--gEO3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Aug 8, 2015 at 9:10 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Given the TDMS clock, audio sample rate, and the N parameter, we can
> calculate the CTS value for the audio clock regenerator (ACR) using the
> following calculation given in the HDMI specification:
>
>         CTS = ftdms * N / (128 * fs)
>
> The specification says that the CTS value is an average value, which is
> true if the source hardware measures it.  Where source hardware needs it
> to be programmed, it is particularly difficult to alternate it between
> two values correctly to ensure that we achieve a correct "average"
> fractional value at the sink.
>
> Also, there's the problem that our "ftdms" is not a fully accurate
> value; it is rounded to a kHz value.  This introduces an unnecessary
> (and harmless) fractional value into the above equation for combinations
> like 148.5MHz/1.001 for 44100Hz - we still calculate the correct CTS
> value.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/bridge/dw_hdmi.c | 92 +++++++---------------------------------
>  1 file changed, 16 insertions(+), 76 deletions(-)

If you take my feedback about your "drm: bridge/dw_hdmi: adjust pixel
clock values in N calculation" patch [1], all this math just works out
to "cts = pixel_clk / 1000".  ...but doing the math does future proof
us a bit, so it seems like a good idea.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>


[1] https://patchwork.kernel.org/patch/6975221/
