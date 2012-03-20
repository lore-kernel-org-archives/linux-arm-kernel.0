From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Mar 2012 15:20:20 +0800
Subject: [PATCH 2/2] clk: Move init fields from clk to clk_hw
In-Reply-To: <1332214706-675-2-git-send-email-skannan@codeaurora.org>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
 <1332214706-675-2-git-send-email-skannan@codeaurora.org>
Message-ID: <20120320072018.GC32469@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 08:38:26PM -0700, Saravana Kannan wrote:
> This has a couple of advantages:
> * Completely hides struct clk from many clock platform drivers and static
>   clock initialization code.
> * Simplifies the generic clk_register() function and allows adding optional
>   fields in the future without modifying the function signature.
> * Allows for simpler static initialization of clocks on all platforms by
>   removing the need for forward delcarations.
> * Halves the number of symbols added for each static clock initialization.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>

I agree this is a reasonable move.  But while you simplify the interface
of clk_register(), why not making a further step to simplify the
following interfaces simple too?

struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
                const char *parent_name, unsigned long flags,
                unsigned long fixed_rate);
struct clk *clk_register_gate(struct device *dev, const char *name,
                const char *parent_name, unsigned long flags,
                void __iomem *reg, u8 bit_idx,
                u8 clk_gate_flags, spinlock_t *lock);
struct clk *clk_register_divider(struct device *dev, const char *name,
                const char *parent_name, unsigned long flags,
                void __iomem *reg, u8 shift, u8 width,
                u8 clk_divider_flags, spinlock_t *lock);
struct clk *clk_register_mux(struct device *dev, const char *name,
                char **parent_names, u8 num_parents, unsigned long flags,
                void __iomem *reg, u8 shift, u8 width,
                u8 clk_mux_flags, spinlock_t *lock);

Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
