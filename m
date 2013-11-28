From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Nov 2013 17:37:32 +0100
Subject: [PATCH v6] gpio: Add MOXA ART GPIO driver
In-Reply-To: <1385651945-22355-1-git-send-email-jonas.jensen@gmail.com>
References: <1381503190-5733-1-git-send-email-jonas.jensen@gmail.com>
 <1385651945-22355-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201311281737.32696.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 November 2013, Jonas Jensen wrote:
> +static void __iomem *moxart_gpio_base;

Just one comment: the usual way to do such a driver is to have
a derived data structure like

struct moxart_gpio_chip {
	struct gpio_chip chip;
	void __iomem *moxart_gpio_base;
};

and dynamically allocate that from probe(), using container_of() to
get from the gpio_chip pointer to your own structure.

You obviously rely on the fact that there is only one gpio_chip
in a moxart soc, which is a safe assumption, the only real disadvantage
of your approach is that it makes your driver less suitable as an
example for others to look at when they are not dealing with
just a single instance, so decide for yourself whether you want
to change it or not.

	Arnd
