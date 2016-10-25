From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 25 Oct 2016 16:13:46 +0530
Subject: [PATCH/RFT v2 12/17] USB: ochi-da8xx: Use a regulator for
 vbus/overcurrent
In-Reply-To: <20161024164634.4330-13-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-13-ahaslam@baylibre.com>
Message-ID: <d7e2b356-4874-fdc1-c505-70e57e3908de@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Currently, the da8xx ohci driver uses a set of gpios and callbacks in
> board files to handle vbus and overcurrent irqs form the power supply.
> However, this does not play nice when moving to a DT based boot were
> we wont have board files.
> 
> Instead of requesting and handling the gpio, use the regulator framework
> to take care of enabling and disabling vbus power. This has the benefit
> that we dont need to pass any more platform data to the driver:
> 
> These will be handled by the regulator framework:
> set_power   ->  regulator_enable/regulator_disable
> get_power   ->  regulator_is_enabled
> get_oci     ->  regulator_get_mode
> ocic_notify ->  regulator notification
> 
> We can keep the default potpgt and use the regulator start delay instead:
> potpgt      -> regulator startup delay time
> 
> The hawk board does not have a GPIO/OVERCURRENT gpio to control vbus,
> (they should not have been decleared/reserved) so, just remove those
> definitions from the hwk board file.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-da830-evm.c     |  97 ++++++++----------------
>  arch/arm/mach-davinci/board-omapl138-hawk.c |  96 +-----------------------
>  arch/arm/mach-davinci/include/mach/da8xx.h  |   2 +-
>  arch/arm/mach-davinci/usb-da8xx.c           |   3 +-
>  drivers/usb/host/ohci-da8xx.c               | 111 ++++++++++++++++++----------
>  include/linux/platform_data/usb-davinci.h   |  19 -----
>  6 files changed, 105 insertions(+), 223 deletions(-)

Can you separate out the driver enhancement from the platform
(mach-davinci) changes? They need to go through different trees.

Thanks,
Sekhar
