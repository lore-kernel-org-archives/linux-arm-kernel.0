From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Oct 2011 15:42:36 -0700
Subject: [PATCH v2] arm/tegra: pinmux: ioremap registers
In-Reply-To: <1318434867-19120-1-git-send-email-swarren@nvidia.com>
References: <1318434867-19120-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111012224236.GE25128@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 09:54:27AM -0600, Stephen Warren wrote:
> Use ioremap to obtain access to registers instead of using static
> mappings. This reduces the number of users of the static mappings, which
> will eventually allow them to be removed.
> 
> Note that on Tegra30, the number of register "banks" will decrease to 2,
> and the packing of specific bits into registers will change significantly.
> That's why this change adds the "*_bank" fields to the pingroup tables,
> rather than implementing some more hard-coded scheme.
> 
> Also, completely remove the implementation of suspend/resume; Tegra doesn't
> yet support suspend/resume, and the implementation is complex for the
> general pinmux driver:
> 
> * Not all registers are used within each bank, so we probably shouldn't
>   just iterate over every register in the bank, and save/restore it,
>   since that would mean touching undefined registers.
> 
> * Registers are shared between pingroups, so we can't simply iterate over
>   each pingroup, and save/restore the registers it uses.
> 
> It'd probably be best have probe() calculate a bitmask of actually-used
> registers for each bank, and have suspend/resume iterate over those
> bitmaps.
> 
> Oh, and Real Soon Now, I should be looking into converting this driver to
> the new pinmux/pinctrl subsystem, so I didn't want to put too much work
> into the current incarnation.
> 
> v2: s/space/bank/ to match comments on reg_* fields in pinmux.h.
>     Re-order bank/reg parameters to pg_readl/pg_writel.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.2/features.


-Olof
