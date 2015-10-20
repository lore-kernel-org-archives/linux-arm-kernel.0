From: dianders@chromium.org (Doug Anderson)
Date: Tue, 20 Oct 2015 08:52:35 -0700
Subject: [PATCH 2/4] thermal: rockchip: ensure the otp state before
 resetting the controller
In-Reply-To: <1445332264-6054-3-git-send-email-wxt@rock-chips.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
 <1445332264-6054-3-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=WHvwNGdRZ4Yjwk0zB00o2gFHXLfbAYHai1kM_oBAR4_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Tue, Oct 20, 2015 at 2:11 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> We need the OTP pin is gpio state before resetting the TSADC controller,
> since the tshut polarity will generate a high signal.
>
> Says:
> The TSHUT temperature is setting more than 80 degree, the default tshut
> polarity is high.
>
> If T > 80C, the OTP output the High Signal.
> If T < 80C, the OTP output the Low Signal.
>
> On the moment, the TSADC controller is reset, the tshut polarity will be
> low in a short period of time.
> So:
>
> If T < 80C, the OTP output the High Signal.
> If T > 80C, the OTP output the Low Signal.
>
> In some cases, the OTP pin is connected to the PMIC, maybe the PMIC can
> accept the reset response time to avoid this issue.
> In other words, the system will be always reboot if we make the OTP pin
> is connected the others IC to control the power.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
>  drivers/thermal/rockchip_thermal.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

I think you could do this with no code changes to the thermal driver
if we simply convince Linus W. to apply a change that I posted up just
about a year ago.  See:

https://patchwork.kernel.org/patch/5055741/

In v1 of that patch at <https://patchwork.kernel.org/patch/5049041/>
Linus said he liked it "A lot" and was willing to merge it with Greg
KH's Ack and with a small comment fix.  I obtained the Ack and fixed
the comment, but then the patch didn't end up being needed for me and
so I never bumped it and it got lost...

Maybe you could re-test that patch?  It looks like it has a merge
conflict with current linuxnext but it looks trivial to resolve.  You
could re-post my patch or I could repost it and you could add your
Tested-by.

You'd still want to have a bindings change to describe "init", but at
least you shouldn't need any code changes.


-Doug
