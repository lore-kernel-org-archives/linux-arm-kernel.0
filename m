From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 19 Oct 2016 10:26:12 +0200
Subject: [PATCH 2/4] base: soc: Introduce soc_device_match() interface
In-Reply-To: <1475572167-29581-3-git-send-email-geert+renesas@glider.be>
References: <1475572167-29581-1-git-send-email-geert+renesas@glider.be>
 <1475572167-29581-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20161019082612.GA6199@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 11:09:25AM +0200, Geert Uytterhoeven wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> We keep running into cases where device drivers want to know the exact
> version of the a SoC they are currently running on. In the past, this has
> usually been done through a vendor specific API that can be called by a
> driver, or by directly accessing some kind of version register that is
> not part of the device itself but that belongs to a global register area
> of the chip.
> 
> Common reasons for doing this include:
> 
> - A machine is not using devicetree or similar for passing data about
>   on-chip devices, but just announces their presence using boot-time
>   platform devices, and the machine code itself does not care about the
>   revision.
> 
> - There is existing firmware or boot loaders with existing DT binaries
>   with generic compatible strings that do not identify the particular
>   revision of each device, but the driver knows which SoC revisions
>   include which part.
> 
> - A prerelease version of a chip has some quirks and we are using the same
>   version of the bootloader and the DT blob on both the prerelease and the
>   final version. An update of the DT binding seems inappropriate because
>   that would involve maintaining multiple copies of the dts and/or
>   bootloader.
> 
> This patch introduces the soc_device_match() interface that is meant to
> work like of_match_node() but instead of identifying the version of a
> device, it identifies the SoC itself using a vendor-agnostic interface.
> 
> Unlike of_match_node(), we do not do an exact string compare but instead
> use glob_match() to allow wildcards in strings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/Kconfig    |  1 +
>  drivers/base/soc.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sys_soc.h |  3 +++
>  3 files changed, 70 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
