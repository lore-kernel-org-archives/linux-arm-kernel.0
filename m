From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 10 Feb 2012 07:35:26 +0100
Subject: [PATCH] pinctrl: changes hog mechanism to be self-referential
In-Reply-To: <1328834868-25030-1-git-send-email-linus.walleij@linaro.org>
References: <1328834868-25030-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20276.47790.447816.701234@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij writes:
> Instead of a specific boolean field to indicate if a map entry shall
> be hogged, treat self-reference as an indication of desired hogging.
> This drops one field off the map struct and has a nice Douglas R.
> Hofstadter-feel to it.
> 
> Suggested-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/pinctrl.txt       |    8 ++++----
>  drivers/pinctrl/core.c          |    6 ++----
>  include/linux/pinctrl/machine.h |   18 ++++++------------
>  3 files changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
> index 2e71323..acb9078 100644
> --- a/Documentation/pinctrl.txt
> +++ b/Documentation/pinctrl.txt
> @@ -989,21 +989,21 @@ is registered. This means that the core will attempt to call pinctrl_get() and
>  pinctrl_enable() on it immediately after the pin control device has been
>  registered.
>  
> -This is enabled by simply setting the .hog_on_boot field in the map to true,
> -like this:
> +This is enabled by simply setting the .dev_name field in the map to the name
> +of the pin controller itself, like this:
>  
>  {
>  	.name = "POWERMAP"
>  	.ctrl_dev_name = "pinctrl-foo",
>  	.function = "power_func",
> -	.hog_on_boot = true,
> +	.dev_name = "pinctrl-foo",
>  },
>  
>  Since it may be common to request the core to hog a few always-applicable
>  mux settings on the primary pin controller, there is a convenience macro for
>  this:
>  
> -PIN_MAP_PRIMARY_SYS_HOG("POWERMAP", "power_func")
> +PIN_MAP_PRIMARY_SYS_HOG("POWERMAP", "pinctrl-foo". "power_func")
                                                    ^
Shouldn't this be a comma rather than a period?

Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
