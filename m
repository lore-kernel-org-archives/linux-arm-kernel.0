From: stigge@antcom.de (Roland Stigge)
Date: Wed, 16 May 2012 15:06:25 +0200
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <4FB3A5E7.7060505@antcom.de>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <4FB39C62.3030305@antcom.de> <20120516125253.GD9571@n2100.arm.linux.org.uk>
 <4FB3A5E7.7060505@antcom.de>
Message-ID: <4FB3A651.2080601@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2012 03:04 PM, Roland Stigge wrote:
> On 05/16/2012 02:52 PM, Russell King - ARM Linux wrote:
>>> * SLC driver says:
>>>
>>> lpc32xx-nand 20020000.flash: FIFO not empty!
>>> lpc32xx-nand 20020000.flash: FIFO held data too long
>>> lpc32xx-nand 20020000.flash: DMA FIFO failure
>>>
>>> Any hints, before I find the time to sort out all the details with
>>> amba-pl08x?
>>
>> Nothing jumps out; it would be useful if you could bisect the small
>> series - I did the conversion in small steps so it should be easy to
>> track down.  And it shouldn't take too long to rebuild between each
>> iteration.  Whatever it is, it's probably going to be a stupid mistake
>> somewhere.
> 
> The problem first appears with patch #4.

FYI: My pl08x is configured via platform data like this:

static struct pl08x_channel_data pl08x_slave_channels[] = {
        {
                .bus_id = "nand-slc",
                .min_signal = 1, /* SLC NAND Flash */
                .max_signal = 1,
                .periph_buses = PL08X_AHB1,
        },
        {

                .bus_id = "nand-mlc",
                .min_signal = 12, /* MLC NAND Flash */
                .max_signal = 12,
                .periph_buses = PL08X_AHB1,
        },
};

static int pl08x_get_signal(struct pl08x_dma_chan *ch) {
        return ch->cd->min_signal;
}

static void pl08x_put_signal(struct pl08x_dma_chan *ch) {
}

static struct pl08x_platform_data pl08x_pd = {
        .slave_channels = &pl08x_slave_channels[0],
        .num_slave_channels = 2,
        .get_signal = &pl08x_get_signal,
        .put_signal = &pl08x_put_signal,
        .lli_buses = PL08X_AHB1,
        .mem_buses = PL08X_AHB1,
};
