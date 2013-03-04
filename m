From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Mar 2013 04:19:27 +0000
Subject: [PATCH RFC] arm: l2x0: Leverage power saving features
In-Reply-To: <da92149b-159b-40e3-87b4-a0a448d1da8b@CO1EHSMHS031.ehs.local>
References: <da92149b-159b-40e3-87b4-a0a448d1da8b@CO1EHSMHS031.ehs.local>
Message-ID: <20130304041927.GA14686@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Soren,

On Fri, Mar 01, 2013 at 06:51:26PM +0000, Soren Brinkmann wrote:
> Enable the 'dynamic clock stop' and 'standby mode' features in the
> l2x0 disable path.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> Hi,
> 
> we are currently implementing a suspend to RAM like low power mode for
> Zynq.
> The code for entering suspend looks like this:
> 	outer_disable();                                                 
>         cpu_suspend(0, zynq_pm_suspend);                                 
>         outer_resume();
> 
> In our low power guidelines we mention the pl310's standby and clock stop
> feature and that they should be enabled for low power modes. The question
> arising here now is: Does the outer_disable() make these features redundant,
> or does it make sense to add it like shown in this patch?

The settings in the power control register are unrelated to CPU suspend
afaict. Instead, they are for semi-autonomous entry to non-destructive
low-power states (e.g. when the L2 is idle for n cycles, or all of the L1
masters have asserted WFI).

This raises the question of whether or not we should poke this register at
all (other than saving/restoring it across suspend, which *is* destructive).
I personally think that this stuff is better off being dealt with in
firmware and initialised there, which follows what we do for other registers
like this.

Will
