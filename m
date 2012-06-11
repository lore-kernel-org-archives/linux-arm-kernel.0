From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 22:37:14 +0200
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones <lee.jones@linaro.org> wrote:

> As new users are
> added, it is expected that they will be Device Tree compliant.
> If this is the case, we will look up their initialisation values
> by compatible entry, then apply them forthwith.
(...)
> +static struct nmk_i2c_controller u8500_i2c = {
> + ? ? ? /*
> + ? ? ? ?* slave data setup time, which is
> + ? ? ? ?* 250 ns,100ns,10ns which is 14,6,2
> + ? ? ? ?* respectively for a 48 Mhz
> + ? ? ? ?* i2c clock
> + ? ? ? ?*/
> + ? ? ? .slsu ? ? ? ? ? = 0xe,
> + ? ? ? /* Tx FIFO threshold */
> + ? ? ? .tft ? ? ? ? ? ?= 1,
> + ? ? ? /* Rx FIFO threshold */
> + ? ? ? .rft ? ? ? ? ? ?= 8,
> + ? ? ? /* std. mode operation */
> + ? ? ? .clk_freq ? ? ? = 100000,
> + ? ? ? /* Slave response timeout(ms) */
> + ? ? ? .timeout ? ? ? ?= 200,
> + ? ? ? .sm ? ? ? ? ? ? = I2C_FREQ_MODE_FAST,
> +};

So why don't we create proper device tree bindings for the above platform
data?

For example several driver under
Documentation/devicetree/bindings/i2c/*
define the .clk_freq above as "clock-frequency"

samsung-i2c even has this:
samsung,i2c-sda-delay = <100>;
samsung,i2c-max-bus-freq = <100000>;

Where i2c-sda-delay corresponds to slsu above.

I suspect .sm can be derived from the frequency so it
is "FAST" whenever the frequency > 100000.

This looks to me like a way to push the burden of doing the real
device tree binding for the above to the next user.
(Which will likely be me, so therefore I care a bit ...)

Yours,
Linus Walleij
