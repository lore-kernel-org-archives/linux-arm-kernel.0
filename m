From: highguy@gmail.com (Stijn Devriendt)
Date: Mon, 25 Apr 2011 19:21:14 +0200
Subject: [PATCH 1/2] gpio: add a custom configuration mechanism to gpiolib
In-Reply-To: <1303315216-14852-1-git-send-email-linus.walleij@stericsson.com>
References: <1303315216-14852-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <BANLkTi=o-2ML0MxNXa0SsFm8JQ1D+_4Zxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 6:00 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> index 32720ba..fa92e50 100644
> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -3,6 +3,60 @@
>
> ?/* see Documentation/gpio.txt */
>
> +/*
> + * Bias modes for GPIOs - if you have more biases, add them here or provide
> + * custom enumerators for your driver if you find they are not generally
> + * useful.
> + *
> + * GPIO_CONFIG_BIAS_UNKNOWN: this bias mode is not known to us
> + * GPIO_CONFIG_BIAS_FLOAT: no specific bias, the GPIO will float or state
> + * ? ? is not controlled by software
> + * GPIO_CONFIG_BIAS_PULL_UP: the GPIO will be pulled up (usually with high
> + * ? ? impedance to VDD)
> + * GPIO_CONFIG_BIAS_PULL_DOWN: the GPIO will be pulled down (usually with high
> + * ? ? impedance to GROUND)
> + * GPIO_BIAS_HIGH: the GPIO will be wired high, connected to VDD
> + * GPIO_BIAS_GROUND: the GPIO will be grounded, connected to GROUND
> + */
> +#define GPIO_CONFIG_BIAS_UNKNOWN ? ? ? 0x1000
> +#define GPIO_CONFIG_BIAS_FLOAT ? ? ? ? 0x1001
> +#define GPIO_CONFIG_BIAS_PULL_UP ? ? ? 0x1002
> +#define GPIO_CONFIG_BIAS_PULL_DOWN ? ? 0x1003
> +#define GPIO_CONFIG_BIAS_HIGH ? ? ? ? ?0x1004
> +#define GPIO_CONFIG_BIAS_GROUND ? ? ? ? ? ? ? ?0x1005
> +
Why contain all values in the config rather than
// Actual config
#define GPIO_CONFIG_BIAS 0x1

#define GPIO_BIAS_UNKNOWN 0x0
#define GPIO_BIAS_FLOAT 0x1
#define GPIO_BIAS_PULL_UP       0x2
#define GPIO_BIAS_PULL_DOWN     0x3
#define GPIO_BIAS_HIGH          0x4
#define GPIO_BIAS_GROUND                0x5
#define GPIO_BIAS_ARCH_SPECIFIC 0x100

#define GPIO_CONFIG_DRIVE 0x2
/// omitted rest

#define GPIO_CONFIG_COMPLEX_SAMPLE 0x3
struct gpio_complex_sample_config
{
  // whatever here
};

// code:
gpio_config(10, GPIO_CONFIG_BIAS, GPIO_BIAS_FLOAT);
struct gpio_complex_sample_config config = { ... };
gpio_config(10, GPIO_CONFIG_COMPLEX_SAMPLE, &config);

Other than that I definitely like the heading of this.

I think a nice end-goal would be to allow a driver/board code to do
something like
  pin = of_gpio_request_setup(device_node, index);
  pin = gpio_request(gpio_platform_data);
  gpio_request(10, list_of_config_options);
to obtain a fully setup gpio pin where configuration is passed
transparently through platform-data, device-tree or built up by
the driver/board-code.

Device-tree support can be added on top by having (reusable) generic
and custom xlate functions (perhaps referring to the generic ones).
Something similar could probably also be implemented for platform-data.

Regards,
Stijn
