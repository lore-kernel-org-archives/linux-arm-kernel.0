From: pgwipeout@gmail.com (Peter Geis)
Date: Fri, 29 Jun 2018 15:37:02 -0400
Subject: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
In-Reply-To: <20180619110027.16935-1-digetx@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com>
Message-ID: <d99935be-797d-4676-c186-a045a590f01b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good Afternoon,

I have tested these patches on the Ouya T3 device.
They work great to enable the L2 cache controller, however they do not 
respect explicitly disabling the L2 cache controller via the kernel 
config nor device tree.

With CONFIG_CACHE_L2X0 disabled, but CONFIG_TRUSTED_FOUNDATIONS enabled, 
the L2 cache controller is silently enabled and allows all four cores to 
boot.

One must also disable CONFIG_TRUSTED_FOUNDATIONS to stop the L2 cache 
controller from spinning up.

Tested-by: Peter Geis <pgwipeout@gmail.com>

On 06/19/2018 07:00 AM, Dmitry Osipenko wrote:
> Hello,
> 
> This series of patches brings initial support of Trusted Foundations to
> Tegra30, that is to the consumer-grade Tegra30 devices which do not allow
> to easily replace the proprietary bootloader. Support is initial because
> this series implements only a proper CPU boot-up (main + secondary cores)
> and a basic L2 cache maintenance that is done using the TF firmware.
> Suspend-resume support is missing yet as I couldn't get it to work
> (CPU hangs on resume from suspend after awhile and seems that is related
> to inappropriately done cache maintenance during of suspend-resume using
> the firmware), it is work-in-progress for now.
> 
> This patchset is partially based on the work done by Micha? Miros?aw [0].
> 
> [0] https://www.spinics.net/lists/linux-tegra/msg30368.html
> 
> Changelog:
> 
> v2:
> 	- The "Don't apply CPU erratas in insecure mode" patch got some
> 	  cleanup, in particular resolved the messiness in
> 	  __tegra_cpu_reset_handler_data.
> 
> 	- Added a comment to tf_cache_write_sec(), justifying the warning
> 	  message.
> 
> Dmitry Osipenko (5):
>    ARM: trusted_foundations: Implement L2 cache initialization callback
>    ARM: trusted_foundations: Provide information about whether firmware
>      is registered
>    ARM: tegra: Setup L2 cache using Trusted Foundations firmware
>    ARM: tegra: Don't apply CPU erratas in insecure mode
>    ARM: tegra: Always boot CPU in ARM-mode
> 
>   arch/arm/firmware/trusted_foundations.c    | 32 ++++++++++++++++++++++
>   arch/arm/include/asm/trusted_foundations.h |  7 +++++
>   arch/arm/mach-tegra/reset-handler.S        | 25 +++++++++--------
>   arch/arm/mach-tegra/reset.c                |  5 +++-
>   arch/arm/mach-tegra/reset.h                |  9 ++++--
>   arch/arm/mach-tegra/sleep-tegra20.S        |  4 +++
>   arch/arm/mach-tegra/tegra.c                | 15 ++++++++++
>   7 files changed, 82 insertions(+), 15 deletions(-)
> 
