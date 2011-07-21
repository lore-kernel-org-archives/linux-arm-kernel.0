From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 21 Jul 2011 10:30:11 +0530
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <000101cc475c$9b5bcdb0$d2136910$%kim@samsung.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
	<000101cc475c$9b5bcdb0$d2136910$%kim@samsung.com>
Message-ID: <CABb+yY05U0Q58F93TEZ8xt727e6YAxwxZT2HbeTTV6nVcg5DQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 9:43 AM, Boojin Kim <boojin.kim@samsung.com> wrote:

>> > - ? ? ? pl330_tasklet((unsigned long) pch);
>> > + ? ? ? ? ? ? ? list_splice_tail_init(&list, &pdmac->desc_pool);
>> > + ? ? ? ? ? ? ? spin_unlock_irqrestore(&pch->lock, flags);
>> > + ? ? ? ? ? ? ? break;
>> > + ? ? ? case DMA_SLAVE_CONFIG:
>> Please protect this section too using spin_lock.
> Why is spin_lock need here?
> This code just sets configuration data into own channel structure.
It does seem unncessary, but the configuration that is set here is read
in other parts of the driver. However unlikely but there is theoretical
possibility of race here - one shouldn't count upon goodness of client drivers.

>>
>> > + ? ? ? ? ? ? ? if (slave_config->direction == DMA_TO_DEVICE) {
>> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->dst_addr)
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->fifo_addr = slave_config->dst_addr;
>> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->dst_addr_width)
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->burst_sz = __ffs(slave_config-
>> >dst_addr_width);
>> > + ? ? ? ? ? ? ? } else if (slave_config->direction == DMA_FROM_DEVICE) {
>> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->src_addr)
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->fifo_addr = slave_config->src_addr;
>> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->src_addr_width)
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->burst_sz = __ffs(slave_config-
>> >src_addr_width);
>> > + ? ? ? ? ? ? ? }
>> PL330 has fixed channels to peripherals.
>> So FIFO addresses(burst_sz too?) should already be set via platform data.
>> Client drivers shouldn't bother.
>
> First, DMA machine code should know the FIFO address of all client drivers to
> set via platform data.
> In this case, Problem is that the definition of FIFO address is almost
> declared to the header file of client driver.
> For example, sound\soc\samsung\regs-i2s-v2.h only has the definition of fifo
> address as following.
>
> #define S3C2412_IISTXD ? ? ? ? ? ? ? ? ?(0x10)
> #define S3C2412_IISRXD ? ? ? ? ? ? ? ? ?(0x14)
>
> These definitions should be referred to DMA machine code to set fifo address
> through platform data.
> I think it's not good method.
Crap!
Client drivers don't conjure up the fifo address - if not hardcoded they
are gotten via platform_data already.


> And, SLAVE_CONFIG command exist to pass slave configuration data from client
> driver to DMA driver.
> So, I think that it's proper to pass fifo address through SLAVE_CONFIG
> command.
If it's still not clear, read the para above definition of 'struct
dma_slave_config'
in include/linux/dmaengine.h

>
> Second, 'burst_sz' isn't fixed value. Namely, Client driver changes 'burst_sz'
> according to its usecase.
> For example, I2S driver sets 'burst_sz' to 4 in case of stereo
> playback/recording. But in case of mono playback/recording, It changes
> 'burst_sz' to 2.
> So, Client driver should use SLAVE_CONFIG command to set 'burst_sz' because
> it's not fixed value.
>
Yeah yeah, ok, that's why I put that with a ? in bracket.
I just don't remember testing with fixed burst_sz with pl330.
