From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sun, 18 Jan 2015 22:17:28 +0100
Subject: [PATCHv4 3/6] USB: host: ohci-at91: Stop/start USB PLL for all
 sleep modes
In-Reply-To: <1421609766-11204-4-git-send-email-sylvain.rochet@finsecur.com>
References: <Pine.LNX.4.44L0.1501181220040.1499-100000@netrider.rowland.org>
 <1421609766-11204-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421609766-11204-4-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150118211728.GA21128@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Jan 18, 2015 at 08:36:03PM +0100, Sylvain Rochet wrote:
> Disable/unprepare clocks without testing the sleep target_state, removed
> the at91_suspend_entering_slow_clock() call (which is only a
> target_state == PM_SUSPEND_MEM).
> 
> Other kind of suspend now benefit from the power save induced by this
> PLL deactivation. The resume penalty is about 500 us, which is not
> negligible but acceptable considering the amount of power we are saving.

Well, this patch actually lights up a previous issue on wake up support.

This device needs to be continuously clocked to provide wake up support, 
previously, if STANDBY target were chosen the device were 
enable_irq_wake-prepared and clock still active and if MEM target were 
chosen the device were also enable_irq_wake-prepared but not clocked 
anymore, which is wrong, but not so wrong.

This patch actually breaks wake up support for STANDBY sleep target. I 
am going to propose a v5 which reinitiate at91_suspend_entering_slow_clock()
and fix wake up support on this driver.

Sylvain
