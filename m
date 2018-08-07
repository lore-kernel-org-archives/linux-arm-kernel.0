From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 7 Aug 2018 19:14:20 +0200
Subject: [RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays
 with direct mapping
In-Reply-To: <20180806222918.12644-10-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-10-jmkrzyszt@gmail.com>
Message-ID: <20180807191420.04431e8e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 Aug 2018 00:29:15 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Certain GPIO array lookup results may map directly to GPIO pins of a
> single GPIO chip in hardware order.  If that condition is recognized
> and handled efficiently, significant performance gain of get/set array
> functions may be possible.
> 
> While processing a request for an array of GPIO descriptors, verify if
> the descriptors just collected represent consecutive pins of a single
> GPIO chip.  Pass that information with the array to the caller so it
> can benefit from enhanced performance as soon as bitmap based get/set
> array functions which can make efficient use of that are available.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  Documentation/driver-api/gpio/consumer.rst |  4 +++-
>  drivers/gpio/gpiolib.c                     | 14 ++++++++++++++
>  include/linux/gpio/consumer.h              |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
> index aa03f389d41d..38a990b5f3b6 100644
> --- a/Documentation/driver-api/gpio/consumer.rst
> +++ b/Documentation/driver-api/gpio/consumer.rst
> @@ -109,11 +109,13 @@ For a function using multiple GPIOs all of those can be obtained with one call::
>  					   enum gpiod_flags flags)
>  
>  This function returns a struct gpio_descs which contains an array of
> -descriptors::
> +descriptors.  It may also contain a valid descriptor of a single GPIO chip in
> +case the array strictly matches pin hardware layout of the chip::
>  
>  	struct gpio_descs {
>  		unsigned int ndescs;
>  		struct gpio_desc *desc[];
> +		struct gpio_chip *chip;

chip is placed at the beginning of the struct in the real code, which
is expected since putting it at the end won't work because of the
desc[] declaration.

...

> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 21ddbe440030..862ee027a02f 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -22,6 +22,7 @@ struct gpio_desc;
>   * gpiod_get_array().
>   */
>  struct gpio_descs {
> +	struct gpio_chip *chip;
>  	unsigned int ndescs;
>  	struct gpio_desc *desc[];
>  };
