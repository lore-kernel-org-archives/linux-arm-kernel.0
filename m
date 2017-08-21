From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 09:47:50 +0200
Subject: [PATCH v3 3/6] pwm: mediatek: fix clock control issue
In-Reply-To: <1498802721-32455-4-git-send-email-zhi.mao@mediatek.com>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-4-git-send-email-zhi.mao@mediatek.com>
Message-ID: <20170821074750.GM18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 02:05:18PM +0800, Zhi Mao wrote:
> 1. prepare top/main clk in mtk_pwm_probe() function,
>    it will increase power consumption
>    and in original code these clocks is only prepeare but never enabled.
> 2. pwm clock should be enabled before setting pwm registers
>    in function: mtk_pwm_config().
> 3. delete "pwm_disable" in function:mtk_pwm_remove(),
>    as framework should disable all the pwms, before remove them.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c |   69 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 22 deletions(-)

I think the commit description could be better. Try to avoid enumerating
changes like you did. Not only is it tedious to read, but this kind of
enumeration is often a sign that you can split the commit up into
multiple logical changes.

Especially the change described in 3) is not related to the clock. It's
also not a quite correct description, because there is no code in the
framework that disables PWMs on chip removal. Users should've disabled
the PWMs that they were using.

The framework could probably warn about misuse, though.

That said, I've left the change as-is, and changed the commit message to
this:

--- >8 ---
pwm: mediatek: Fix clock control issue

In order to save some power, do not prepare the top and main clocks
during mtk_pwm_probe(). Instead, prepare the clocks only when necessary
and also make sure to enable the clocks to match the semantics of the
common clock framework.

While at it, don't explicitly disable all PWM channels in ->remove()
because all users should have done that already.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
Acked-by: John Crispin <john@phrozen.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
--- 8< ---

Try to keep this in mind for future patch submissions.

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/1a5ffacc/attachment.sig>
