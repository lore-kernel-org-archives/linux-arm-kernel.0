From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 Jun 2016 22:59:43 -0700
Subject: [PATCH v2] arm64: Kconfig: select PM{,_GENERIC_DOMAINS} for
 ARCH_VEXPRESS
In-Reply-To: <1466434569-26449-1-git-send-email-sudeep.holla@arm.com>
References: <1466434569-26449-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160621055943.GD24293@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 03:56:09PM +0100, Sudeep Holla wrote:
> The Linux AMBA bus framework probes the peripheral IDs when adding the
> AMBA devices very early on the boot. Generally they are on APB bus and
> just require APB clocks to be on even when most of the core logic of the
> IP is powered down.
> 
> However on Juno, the entire debugsys domain needs to be ON to access
> even the coresight components' CID/PID registers and hence broken by
> design. Accessing those while debugsys power domain is off will lead to
> the bridge stalling the transactions instead of returning the slave error.
> 
> Further, the AMBA framework can't deal with !CONFIG_PM_GENERIC_DOMAINS
> case: it ignores the error and proceeds to access the device region.
> It was suggested to always enable CONFIG_PM{,_GENERIC_DOMAINS} in order
> to handle above explained scenario.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/Kconfig.platforms | 2 ++
>  1 file changed, 2 insertions(+)
> 
> (Resending as I missed ALKML before)
> Hi ARM-SoC team,
> 
> The discussion on this happened on linux-pm list[1]. This is need on
> Juno once we introduce coresight components in the DT. With
> !PM_GENERIC_DOMAINS, the board stalls on boot and hence this patch is
> needed. This shouldn't change any thing in the defconfig as couple of
> other platforms already do the same. It's needed in case all other
> ARCH_* configs are disabled.
> 
> Without this, we need a dirty trick in the DT[2] to handle
> !PM_GENERIC_DOMAINS
> 
> Can you please pick this for v4.8 directly ?

Applied to next/arm64.


-Olof
