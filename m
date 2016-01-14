From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 14 Jan 2016 22:24:41 +0100
Subject: [PATCH V2 1/4] clk: bcm2835: avoid the use of BCM2835_CLOCK_COUNT
 in clk-bcm2835
In-Reply-To: <20160114202330.1942.96295@quark.deferred.io>
References: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
 <1452542157-2387-2-git-send-email-kernel@martin.sperl.org>
 <20160113200012.1168.74515@quark.deferred.io>
 <20160114001358.1168.5768@quark.deferred.io>
 <56979056.6010407@martin.sperl.org>
 <20160114202330.1942.96295@quark.deferred.io>
Message-ID: <B33A54DE-453D-4F3E-BE0F-A8A9E3796D55@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On 14.01.2016, at 21:23, Michael Turquette <mturquette@baylibre.com> wrote:
>> static int bcm2835_clk_probe(struct platform_device *pdev)
>> {
>>        const size_t asize = ARRAY_SIZE(clk_desc_array);
>>        ...
>>        for (i = 0; i < asize; i++) {
>>                desc = &clk_desc_array[i];
>>                if (desc)
>>                        clks[i] = desc->clk_register(cprman,
>>                                                     desc->data);
> 
> Interesting. I have been playing with the idea of putting a .register()
> callback into struct clk_init_data. Then it would be called by a new
> clk_register_desc() top-level registration function.
> 
> You've done that here, but you've put the registration function in your
> machine-specific struct. Nothing wrong with that.
> 
> Do you actually need a machine-specific registration function? Many clk
> drivers only use their machine-specific registration functions to
> allocate a stuct clk_hw and populate the contents of struct
> clk_init_data, which can be done by the framework and reduce duplicate
> code in drivers.
> 
> (they do this because the basic clk types like clk-divider, clk-gate,
> etc do it, and everyone loves to copy/paste that code)
> 
> bcm2835 seems to register two clks in the PLL registration function (one
> of which is a fixed factor divider), but you could just add those
> post-PLL dividers to your array of clk data?
> 

My goal was to limit the changes of the patch as much as possible.

Also that way I know it will continue to work as there real
registration code has not changed - it was just wrapped (and I
have to admit: I did not want to go into the details of understanding
the existing registration code.

If there is ever a change in the framework, then we may make use of it.

>> 
>> If we need to order the initialization then we can add some
>> priority field to clk_desc_array and iterate over all the priority
>> values.
> 
> I guess that you can order them in your array? Just start with the root
> clocks at the beginning of the array (regardless of "clk type") and walk
> through the array registering them.
That was what my earlier patch was doing, but right now we have a sparse
array wo we do not have to check for duplicates.

Anyway: my interpretation is that the clocks only become really
available to the device-tree with of_clk_add_provider
so that means there should not be any race? (but this may not be
the absolute truth?

So I hope this is acceptable (besides the bug I have mentioned
earlier for which I will send a version 4)
