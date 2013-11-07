From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Nov 2013 10:41:02 +0100
Subject: PINCTRL:We May need mutex protect in pinctrl API
In-Reply-To: <201311071253281097419@gmail.com>
References: <1383732348-18576-1-git-send-email-lee.jones@linaro.org>
 <1383732348-18576-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdZekui-CoPdwtyATQyAv07CZp3B9L=qU6xAk8J43=Bb6w@mail.gmail.com>
 <201311071253281097419@gmail.com>
Message-ID: <CACRpkdYUKKLvMWcSxb24ZvYUq1QMzs9cw-h5CpZ1Q5S2s3RVBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 7, 2013 at 5:53 AM, xulinuxkernel at gmail.com
<xulinuxkernel@gmail.com> wrote:

> Recently, our company use kernel 3.10 instead of 3.8.When we test the kernel
> we found there would be hang up in pinctrl subsystem,the reason may be as
> following,
> In out system,nand and spi pins are some of the same,so we need frequently
> get pinctrl and put pinctrl. and sd card also frequently get and put
> pinctrl.
> when the nand and sd card both come in
> pinctrl_lookup_state

If you're repeatedly doing pinctrl_lookup_state() in your driver,
then *this* is the problem, not that the pinctrl_lookup_state()
is not mutexed.

You should lookup your states at probe() and at runtime
only use pinctrl_select_state() to move between different
states.

Can you please refer me to the code in the upstream kernel
that is causing this.

If your code is not upstream and you're abusing the interface
as described above, the actual problem you have is that
you need to get your code upstream and properly reviewed
by the community.

Yours,
Linus Walleij
