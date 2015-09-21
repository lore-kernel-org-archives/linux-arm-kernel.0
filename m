From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Sep 2015 16:28:48 -0700
Subject: [PATCH v2 2/3] gpiolib: gpiod_hog remove separate name argument
In-Reply-To: <1440920686-6892-3-git-send-email-mpa@pengutronix.de>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-3-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdZrXEXtkPpgtrcjqP5jD+M0UOj5Wj69o4zYJQKihsY6Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 30, 2015 at 12:44 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> The gpio name is now stored in the gpio descriptor, so we can simply use
> that instead of an argument to the function.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Several problems with this patch:

- Does not apply to v4.3-rc1
- Fixed that but noted that it just alters the call to gpiod_hog()
  in of_gpiochip_scan_hogs(), there is a local const char *name that
  should be removed too.
- Looking at of_get_gpio_hog() it is unclear to me that .name
  is set in the gpio_desc as desired. Please check this.

  Crucial code looks like this:

    if (name && of_property_read_string(np, "line-name", name))
        *name = np->name;

  i.e. is the line-name really propagated to gpiod->name?
  Are you sure you have tested this with a DTS using line-name
  and verified that it propagates properly?

Yours,
Linus Walleij
