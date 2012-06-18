From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Jun 2012 08:18:05 +0100
Subject: Fwd: [PATCH 1/3] i2c: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <CACRpkdZ7ESKhokk8Z+6sC9Kq+jPztFNwzger0Db7nCD1fPnG1A@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD8BAD2.50703@linaro.org>
 <CACRpkdZFi34nChnMEo6yik67zk9owZLk-6zcdP7mmOXyLz8uqQ@mail.gmail.com>
 <4FDAFA17.6050502@linaro.org>
 <CAE2-_9rRYxjU9QQgtBv9ReMY5x+oRiJG1cDQahYHanjDrwVUYA@mail.gmail.com>
 <20120615115042.GA27480@bnru02> <4FDB2E57.4030904@linaro.org>
 <20120615130544.GA28537@bnru02> <4FDB3642.5030804@linaro.org>
 <CACRpkdZ7ESKhokk8Z+6sC9Kq+jPztFNwzger0Db7nCD1fPnG1A@mail.gmail.com>
Message-ID: <4FDED62D.6030008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/12 18:43, Linus Walleij wrote:
> Gah, what a thread...
>
> On Fri, Jun 15, 2012 at 3:18 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>> On 15/06/12 14:05, Srinidhi Kasagar wrote:
>>> On Fri, Jun 15, 2012 at 14:45:11 +0200, Lee Jones wrote:
>>>> On 15/06/12 12:50, Srinidhi Kasagar wrote:
>
>>>>>> +static struct nmk_i2c_controller u8500_i2c = {
>>>>>> +       /*
>>>>>> +        * Slave data setup time; 250ns, 100ns, and 10ns, which
>>>>>> +        * is 14, 6 and 2 respectively for a 48Mhz i2c clock.
>>>>>> +        */
>>>>>> +       .slsu           = 0xe,
>>>>>> +       .tft            = 1,      /* Tx FIFO threshold */
>>>>>> +       .rft            = 8,      /* Rx FIFO threshold */
>>>>>> +       .clk_freq       = 100000, /* std. mode operation */
>>>>>> +       .timeout        = 200,    /* Slave response timeout(ms) */
>>>>>> +       .sm             = I2C_FREQ_MODE_FAST,
>>>>>
>>>>> How is this possible? you are setting clk_freq as 100kb/s and mode
>>>>> as fast mode which is supposed to be 400kb/s.
>>>>
>>>> That's not how I read it:
>>>
>>> But it is not readable. It confuses people.
>>
>> I understood it. :)
>>
>> If you think it's unclear speak to the author, Linus. He's CC'ed.
>
> Author of what? The i2c driver was written by Srinidhi. (The
> MODULE_AUTHOR() clause should be a good hint...)

Actually, we appear to have our wires crossed. You wrote the board data 
stuff below, which changes the mode from STANDARD to FAST, no doubt 
using Srinidhi's struct explanation comments found in 
arch/arm/plat-nomadik/include/plat/i2c.h.

 > I'll cook a separate patch for this or something.

Cool, thanks Linus.

But you're correct in what you say Linus. Srinidhi, the comments which 
are you say are confusing are the bits you are the author of: 
e208c447bd728920e4f3d438a706344ea31249b9?

> But it's true that board data for the ux500 kernel use
> 100000 Hz and I2C_FREQ_MODE_FAST, in the board-mop500.c
> file, like this:
>
> U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(2, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(3, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
 >
> This is indeed a bit odd. But obviously it works... But reading some
> fixes in another tree it seems it should look like this:
>
> /*
>   * The board uses 4 i2c controllers, initialize all of
>   * them with slave data setup time of 250 ns,
>   * Tx&  Rx FIFO threshold values as 1 and standard
>   * mode of operation
>   */
> U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(2, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(3, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
>
> Which makes *much* more sense.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
