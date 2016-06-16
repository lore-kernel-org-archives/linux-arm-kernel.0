From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 16 Jun 2016 15:42:27 +0100
Subject: [PATCH 2/3] arm64: dts: juno: add arm, primecell-periphid override
In-Reply-To: <1465228765-14038-3-git-send-email-sudeep.holla@arm.com>
References: <1465228765-14038-1-git-send-email-sudeep.holla@arm.com>
 <1465228765-14038-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <5762BAD3.6050405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/06/16 16:59, Sudeep Holla wrote:
> The Linux AMBA framework probes the peripheral ids when adding the amba
> devices very early on the boot. Generally they are on APB bus and just
> require APB clocks to be on even when most of the core logic of the IP
> is powered down.
>
> However on Juno, the entire debugsys domain needs to be ON to access
> those CID/PID registers and hence broken by design. Accessing those
> while debugsys power domain is off will lead to the bridge stalling the
> transactions instead of returning the slave error.
>
> Since keeping the power domain on by default affects the core power(by
> preventing cores entering deeper idle states), it's not feasible
> solution. Instead we can provide arm,primecell-periphid override in the
> device tree that prevents accessing the device early in the boot.
>

OK, I recently found out that AMBA bus/infrastructure can deal with 
powered off domains even while adding the devices. That makes this patch 
redundant. I had missed it initially as I tested with !CONFIG_PM
option.

So I raised the issue with !CONFIG_PM option[1] and it was suggested to 
make platform select the same[2] as there's no simple way to deal with
that.

Hence I will drop this patch but will post patch to select PM from
ARCH_VEXPRESS to ensure we always have it enabled to deal with this
platform issue.

-- 
Regards,
Sudeep


[1] http://marc.info/?l=linux-pm&m=146607608629880&w=2
[2] http://marc.info/?l=linux-pm&m=146608125731479&w=2
