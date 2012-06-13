From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Jun 2012 07:40:19 +0200
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <4FD6F0E8.5040606@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD6F0E8.5040606@linaro.org>
Message-ID: <CACRpkdYxiT-0x4aetMxB2x8SkB+Mmy8rk8uSzgU_anemSayhMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 9:34 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On 11/06/12 21:37, Linus Walleij wrote:
>>
>> So why don't we create proper device tree bindings for the above platform
>> data?
>>(...)
>> This looks to me like a way to push the burden of doing the real
>> device tree binding for the above to the next user.
>> (Which will likely be me, so therefore I care a bit ...)
>
>
> On the contrary. This will avoid any added Device Tree complexity and ensure
> that no extra vendor specific bindings are required. When a new user wishes
> to use the driver, all they (you) have to do is create a new struct with the
> platform specific information and add the entry to nmk_gpio_match[],
> simples.
>
> I've even added the logic to extract any information you provide via
> nmk_gpio_match[] for use as platform data. This keeps it both out of
> platform code and the Device Tree binary. Everyone's a winner. :)

No. You assume that the platform data is a chip-specific property,
and that it will be the same for all busses on the chip. But it
isn't.

The above platform data is *board specific*, it depends on
what devices have been connected to each bus.

For example the max frequency: this depends on the maximum
frequency any of the devices connected to one very bus
can support.

The other platforms have put this frequency into their device
trees for a reason, and this is it.

So for the four different i2c busses there may need to be
four different platform data sets. How are you going to
distinguish between the four buses?

This is thus broken and needs to have proper bindings.

Yours,
Linus Walleij
