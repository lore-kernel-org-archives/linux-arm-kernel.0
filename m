From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 16 Dec 2011 15:34:14 -0800
Subject: [RFC V2 6/8] ARM i.MX: prepare common clk support
In-Reply-To: <1323854638-3455-7-git-send-email-richard.zhao@linaro.org>
References: <1323854638-3455-1-git-send-email-richard.zhao@linaro.org>
 <1323854638-3455-7-git-send-email-richard.zhao@linaro.org>
Message-ID: <CAPtuhTim42ZjqPA5i+O0eHqEmfmO2Z5nJnBAA+TWS753gH8m5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 1:23 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>
> Add static clock help macros, clock register spinlock.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
> ?arch/arm/plat-mxc/clock.c ? ? ? ? ? ? ?| ? ?8 ++++++
> ?arch/arm/plat-mxc/include/mach/clock.h | ? 42 +++++++++++++++++++++++++++++--
> ?2 files changed, 47 insertions(+), 3 deletions(-)
>
...
>
> +extern spinlock_t imx_ccm_lock;
> +
> +#define DEFINE_CLK_GATE2B(_name, _parent, _reg, _shift) \
> + ? ? ? struct clk_gate2b _name = { \
> + ? ? ? ? ? ? ? .clk = { \
> + ? ? ? ? ? ? ? ? ? ? ? .name = #_name, \
> + ? ? ? ? ? ? ? ? ? ? ? .ops = &clk_gate2b_ops, \
> + ? ? ? ? ? ? ? ? ? ? ? .parent = _parent, \
> + ? ? ? ? ? ? ? }, \
> + ? ? ? ? ? ? ? .reg = (_reg), \
> + ? ? ? ? ? ? ? .shift = (_shift) * 2, \
> + ? ? ? ? ? ? ? .val_en = 0x3, \
> + ? ? ? ? ? ? ? .val_dis = 0x0, \
> + ? ? ? ? ? ? ? .lock = &imx_ccm_lock, \
> + ? ? ? }
> +
> +#define IMX_DEFINE_CLK_DIVIDER(_name, _parent, _flags, _reg, _shift, _width) \
> + ? ? ? DEFINE_CLK_DIVIDER(_name, _parent, _flags, _reg, _shift, _width, \
> + ? ? ? ? ? ? ? ? ? ? ? &imx_ccm_lock)
> +
> +#define IMX_DEFINE_CLK_MUX(_name, _reg, _shift, _width, _clks) \
> + ? ? ? DEFINE_CLK_MUX(_name, _reg, _shift, _width, _clks, &imx_ccm_lock)

gate2b, basic div and basic mux clks all use the imx_ccm_lock.  How
many registers are we talking about here?  If the number is very high
then maybe per-register locking makes sense for you?

Also, do you need locking added to the basic gated clk type, or any of
the others?  I'll probably add it anyways but just curious...

Regards,
Mike
