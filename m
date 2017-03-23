From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 23 Mar 2017 20:51:43 +0200
Subject: [PATCH v3 1/2] pinctrl: samsung: Register pinctrl before GPIO
In-Reply-To: <1490202935-4708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490202935-4708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Message-ID: <20170323185143.7nfgddujuie6ccws@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 05:15:34PM +0000, Charles Keepax wrote:
> If we request a GPIO hog, then gpiochip_add_data will attempt
> to request some of its own GPIOs. The driver also uses
> gpiochip_generic_request which means that for any GPIO request to
> succeed the pinctrl needs to be registered. Currently however the
> driver registers the GPIO and then the pinctrl meaning all GPIO hog
> requests will fail, which then in turn causes the whole driver to fail
> probe.
> 
> Fix this up by ensuring we register the pinctrl first. This
> does require us to manually set the GPIO base for the
> pinctrl. Fortunately the driver already assigns a fixed GPIO base, in
> samsung_gpiolib_register, and uses the same calculation it does for
> the pin_base. Meaning the two will always be the same and allowing us
> to reuse the pinbase and avoid the issue.
> 
> Although currently there are no users of GPIO hogs in mainline
> there are plenty of Samsung based boards that are widely used for
> development purposes of other hardware. Indeed we hit this issue
> whilst attaching some additional hardware to an Arndale system.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
> 
> Changes since v2:
>  - Squash in fix to set the GPIO base on the pin_bank.
> 
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 36 +++++++++++++++----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
