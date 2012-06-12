From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 08:34:00 +0100
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
Message-ID: <4FD6F0E8.5040606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 21:37, Linus Walleij wrote:
> On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> As new users are
>> added, it is expected that they will be Device Tree compliant.
>> If this is the case, we will look up their initialisation values
>> by compatible entry, then apply them forthwith.
> (...)
>> +static struct nmk_i2c_controller u8500_i2c = {
>> +       /*
>> +        * slave data setup time, which is
>> +        * 250 ns,100ns,10ns which is 14,6,2
>> +        * respectively for a 48 Mhz
>> +        * i2c clock
>> +        */
>> +       .slsu           = 0xe,
>> +       /* Tx FIFO threshold */
>> +       .tft            = 1,
>> +       /* Rx FIFO threshold */
>> +       .rft            = 8,
>> +       /* std. mode operation */
>> +       .clk_freq       = 100000,
>> +       /* Slave response timeout(ms) */
>> +       .timeout        = 200,
>> +       .sm             = I2C_FREQ_MODE_FAST,
>> +};
>
> So why don't we create proper device tree bindings for the above platform
> data?
>
> For example several driver under
> Documentation/devicetree/bindings/i2c/*
> define the .clk_freq above as "clock-frequency"
>
> samsung-i2c even has this:
> samsung,i2c-sda-delay =<100>;
> samsung,i2c-max-bus-freq =<100000>;
>
> Where i2c-sda-delay corresponds to slsu above.
>
> I suspect .sm can be derived from the frequency so it
> is "FAST" whenever the frequency>  100000.
>
> This looks to me like a way to push the burden of doing the real
> device tree binding for the above to the next user.
> (Which will likely be me, so therefore I care a bit ...)

On the contrary. This will avoid any added Device Tree complexity and 
ensure that no extra vendor specific bindings are required. When a new 
user wishes to use the driver, all they (you) have to do is create a new 
struct with the platform specific information and add the entry to 
nmk_gpio_match[], simples.

I've even added the logic to extract any information you provide via 
nmk_gpio_match[] for use as platform data. This keeps it both out of 
platform code and the Device Tree binary. Everyone's a winner. :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
