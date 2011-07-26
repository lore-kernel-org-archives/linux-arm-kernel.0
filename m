From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 26 Jul 2011 23:13:35 +0530
Subject: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <20110726080233.GN9653@n2100.arm.linux.org.uk>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
	<CABb+yY0nWLpdVGqTJPO2YwkGWiDw5tRjC2xn7Le0bO0ZNFHC_g@mail.gmail.com>
	<20110726080233.GN9653@n2100.arm.linux.org.uk>
Message-ID: <CABb+yY2rQXxHGJuvhtJGgrCsoFZgsACHWUEV0L-kpqaDaCFAQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 1:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 25, 2011 at 05:21:44PM +0530, Jassi Brar wrote:
>> On Mon, Jul 25, 2011 at 6:58 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
>>
>> > +
>> > +static bool pl330_filter(struct dma_chan *chan, void *param)
>> > +{
>> > + ? ? ? struct dma_pl330_peri *peri = (struct dma_pl330_peri *)chan->private;
>> > + ? ? ? unsigned dma_ch = (unsigned)param;
>> > +
>> > + ? ? ? if (peri->peri_id != dma_ch)
>> > + ? ? ? ? ? ? ? return false;
>> > +
>> > + ? ? ? return true;
>> > +}
>> This is what I meant... if we keep chan_id for paltform assigned IDs,
>> these filter functions could simply become
>>
>> static bool pl330_filter(struct dma_chan *chan, void *param)
>> {
>> ? ? ? ? return chan->chan_id == param
>> }
>>
>> And ideally in the long run, we could just drop the filter callback
>> and add expected channel ID to the request_channel call.
>
> So what if you have a PL080 and PL330 drivers registered with the DMA
> engine code, and you need to match a specific PL330 channel?
>

Before we start, let me be clear that I don't say it's all possible
today as such.
We will need changes to the API and modifications to the damc/client
drivers (which are already misusing the API as it turns out).

I hope we agree, clients (esp 'generic' ones of the future)
should not ask for channels from a particular dmac.
They should simply tell DMA API, what capabilities they expect
from the allocated channel - of whatever index on whichever dmac.
And the platform should have specified capabilities of a channel
while introducing it to the DMA API.   Yes, imho, DMA API should
only work with a pool of channels and not dmacs - it shouldn't
matter from which dmac a channel comes.

So when a client asks for a channel, the dmaengine would return
the first free channel that has just as much the requested capability.

That is, the generic filter function would look equivalent of :-

      return is_free(chan) && (cap_requested == cap_of(chan) & cap_requested)


Now it all boils down to defining the set of _practically_ possible capabilities
and a method to exchange them between the API, Client and DMAC drivers.

The above is the overall approach.

The following is my idea of implementing it as of now, I am open to suggestions.

Assuming :-
***********
There are no more than 256 types of DMA'able devices
 (MMC, USB, SPI etc) --  [8bits]

A type of device never has more than 16 instances in a platform
 (MMC-0, MMC-1, MMC-2 etc) --  [4bits]

Mem->Mem, Mem->Dev, Dev->Mem, Dev->Dev capability in [4bits]

Max_Burst_Len for any channel is less than 64KB, in power of two [4bits]
Support programmable Max_Burst_Len(tunable in geometric steps of 2)  [1bit]

Max_RW_width/fifo_width is less than 128, in power of two -- [3bits]
Support programmable Max_RW_Width(tunable in geometric steps of 2)  [1bit]

Finally, No platform has more than 128 channels with identicial
capabilities [7bits]


For a channel, when specific values of these fields are appended together,
we get a unqiue 32-bits value called 'chan_id'

Though we can use 64-bits to store the capabilities if we think number
or size of these fields need to be increased.

Thanks,
Jassi
