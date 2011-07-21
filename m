From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 21 Jul 2011 19:58:03 +0530
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <CACRpkdaP5D=URqAXAytm9s2e9HRVMB-MzsKZeLJ9v6ktkJUCRA@mail.gmail.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
	<20110721081138.GL26574@n2100.arm.linux.org.uk>
	<CABb+yY2obv5JMBiRSXS-4tSCYX+7nVVaA0Q7gurA+NndrGVuvA@mail.gmail.com>
	<CACRpkdaP5D=URqAXAytm9s2e9HRVMB-MzsKZeLJ9v6ktkJUCRA@mail.gmail.com>
Message-ID: <CABb+yY2wTj5i-koQhD+dqNWaL4TvUYk1XP3YT0jE3oDZT57U4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 3:53 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jul 21, 2011 at 11:14 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> On Thu, Jul 21, 2011 at 1:41 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Thu, Jul 21, 2011 at 12:47:49AM +0530, Jassi Brar wrote:
>>>> PL330 has fixed channels to peripherals.
>>>> So FIFO addresses(burst_sz too?) should already be set via platform data.
>>>> Client drivers shouldn't bother.
>>>
>>> That's utter crap, and isn't what the DMA engine API is about.
>>>
>>> The above looks correctly implemented. ?Slave DMA engine users are
>>> supposed to supply the device DMA register address via this
>>> DMA_SLAVE_CONFIG call. ?Doing this via platform data for the DMA
>>> device is braindead.
>>
>> Rather than have 32 client drivers expect fifo_address from the
>> platform and then
>> provide to the DMAC, IMHO it is better for a single driver(DMAC) to
>> get 32 addresses
>> from the platform.
>
> My idea (when I implemented it) is that the device driver knows the
> physical and virtual base and thus the address where DMA data is
> destined. It knows all other registers, it remaps them, noone else should
> be bothered with containing the knowledge of adress ranges for the
> specific hardware block.
>
> Passing this through platform data requires the machine to keep track
> not only of the base adress of the peripheral (as is generally contained
> in the machine or device tree) but also the offset of specific registers
> in that memory region, which is too much.
>
> Usually this means the offsets are defined in files like <mach/perfoo.h>
> which means they can't be pushed down into drivers/foo/foo.c and
> creates unnecessary bindings and de-encapsulation of the driver.
> We want to get rid of such stuff. (I think?)
>
> Therefore I introduced this to confine the different registers into
> the driver itself and ask the DMA engine to transfer to a specific
> address.
While that does make sense, it makes mandatory the ritual of calling
DMA_SLAVE_CONFIG mandatory for most of the cases.
And I think the effort to set fifo_addr for peripherals is overrated.

>
>> Esp when the DMAC driver already expect similar h/w
>> parameter -- *direction*.
>>
>> I don't understand why is 'fifo_address' a property much different
>> than 'direction' of the
>> channel ?
>
> struct dma_slave_config {
> ? ? ? ?enum dma_data_direction direction;
> ? ? ? ?dma_addr_t src_addr;
> ? ? ? ?dma_addr_t dst_addr;
> ? ? ? ?enum dma_slave_buswidth src_addr_width;
> ? ? ? ?enum dma_slave_buswidth dst_addr_width;
> ? ? ? ?u32 src_maxburst;
> ? ? ? ?u32 dst_maxburst;
> };
>
> We do support changing direction as well as src and dst address
> (i.e. FIFO endpoint) at runtime.
>
> Check drivers/mmc/host/mmci.c for an example of how we switch
> a single channel from TX to RX in runtime using this one property.
>
> However it has been noted by Russell that the direction member
> is unnecessary since the device_prep_slave_sg() function in the
> dmaengine vtable already takes a direction argument like this:
>
> ? ? ? ?struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
> ? ? ? ? ? ? ? ?struct dma_chan *chan, struct scatterlist *sgl,
> ? ? ? ? ? ? ? ?unsigned int sg_len, enum dma_data_direction direction,
> ? ? ? ? ? ? ? ?unsigned long flags);
>
> Therefore the direction setting needs to go from either the config
> struct or the device_prep_slave_sg() call, as right now the channel
> is being told about the direction twice which is not elegant and
> confusing.
>
> So you even have two ways of changing direction at runtime...
Of course there are ways to set the direction... but whatever we do
it can't really be changed from what h/w can only do.
And that is my point.  Let clients not bother trying to 'configure' what is
the only supported option by h/w.

And I don't suggest dropping the DMA_SLAVE_CONFIG callback - just
keep it for rarer situations when we have configurable channels.

And I assumed that was your original idea too.
-----------------------
* @DMA_SLAVE_CONFIG: this command is only implemented by DMA controllers
 * that need to runtime reconfigure the slave channels (as opposed to passing
 * configuration data in statically from the platform). An additional
 * argument of struct dma_slave_config must be passed in with this
 * command.
-----------------------

Regards,
-j

>
> Yours,
> Linus Walleij
>
