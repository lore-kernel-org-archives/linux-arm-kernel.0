From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 6 Mar 2012 19:36:29 +0100
Subject: [PATCH] OMAP3+: PM: VP: fix integer truncation error
In-Reply-To: <1331058767-28933-1-git-send-email-nm@ti.com>
References: <1331058767-28933-1-git-send-email-nm@ti.com>
Message-ID: <CAMQu2gw5bZg1kw2-jrtAs4MTkaPPfDsimhwCWmZUCCe3rOu8rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 7:32 PM, Nishanth Menon <nm@ti.com> wrote:
> From: Yuan Jiangli <jlyuan@motorola.com>
>
> commit 2f34ce81b8c05c900e45bd88595cc154f7bb5957
> (OMAP3: PM: Adding voltage driver support.)
> introduced runtime computation of waittime to handle all potential
> sys clocks available.
>
> In the voltage processor, the SPMSUpdateWait is calculated based on
> the slew rate and the voltage step (SMPSUpdateWait = slew rate *
> Voltage Step). After the voltage processor receives the SMPS_Ack
> signal, the Voltage Controller will wait for SMPSUpdateWait clock
> cycles for the voltage to settle to the new value. For all
> practical purposes, the waittime parameter is the OMAP hardware
> translation of what the slew rate on the PMIC is.
>
> As an example, with TPS62361 on OMAP4460,
> step_size = 10000
> slew_rate = 32000
> sys_clk_rate = 38400
>
> Our current computation results in the following:
> ?= ((step_size / slew_rate) * sys_clk_rate) / 1000
> ?= ((10000 / 32000) * 38400 / 1000
> ?= 0
>
> Fix the same using DIV_ROUND_UP as an extra wait clock cycle
> is better than lesser clock cycle. For the above example, this
> translates to:
> ?= (10000 * 38400) / (1000 * 32000)
> ?= 12
>
> Change-Id: I0ee22e60555e1cfd6cc3dea7ee44d0584ce182b6
You don't need above gerrit change id in commit message.

Regardas
Santosh
