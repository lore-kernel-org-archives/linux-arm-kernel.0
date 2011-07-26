From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 27 Jul 2011 01:24:19 +0530
Subject: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <20110726181441.GE1655@n2100.arm.linux.org.uk>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
	<CABb+yY0nWLpdVGqTJPO2YwkGWiDw5tRjC2xn7Le0bO0ZNFHC_g@mail.gmail.com>
	<20110726080233.GN9653@n2100.arm.linux.org.uk>
	<CABb+yY2rQXxHGJuvhtJGgrCsoFZgsACHWUEV0L-kpqaDaCFAQA@mail.gmail.com>
	<20110726181441.GE1655@n2100.arm.linux.org.uk>
Message-ID: <CABb+yY1ONj2YTyFi7281vCnCq_9B7DtXbE7-YnWUUPy6O0T54A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 11:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>
> 1. Arrange for individual DMA engine drivers to provide a filter
> ? function - eg, pl08x_filter_id() for pl08x channels.
>
> 2. Have the filter function check chan->device->dev->driver == its
> ? own struct driver as the very first thing, and reject on failure.
>
> 3. Have its own matching algorithm using whatever data is appropriate
> ? for the DMA engine driver.
IMHO it should be possible to have client drivers not use platform specific
details while choosing a channel. Otherwise, they are not really 'generic'
'platform-independent' client drivers.


>> I hope we agree, clients (esp 'generic' ones of the future)
>> should not ask for channels from a particular dmac.
>> They should simply tell DMA API, what capabilities they expect
>> from the allocated channel - of whatever index on whichever dmac.
>> And the platform should have specified capabilities of a channel
>> while introducing it to the DMA API. ? Yes, imho, DMA API should
>> only work with a pool of channels and not dmacs - it shouldn't
>> matter from which dmac a channel comes.
>
> You're quite clearly confused. ?"DMA API" has not very much to do with
> the subject we're discussing. ?The "DMA API" is the API for mapping and
> unmapping buffers for DMA. ?It has not much to do with the DMA engine
> API. ?So I'm not going to bother trying to decode what you said above
> until you start using the right terminology. ?I'm a stickler for that,
> get used to it.
>
> No point talking about how round bananas are when you're actually
> discussing orange fruit.
Sorry, my carelessness.
I should have written DMAENGINE API, instead of DMA API.

If you want I can repost with s/DMA API/DMAENGINE API/

>
>> So when a client asks for a channel, the dmaengine would return
>> the first free channel that has just as much the requested capability.
>
> No. ?For slave DMA, peripheral drivers normally need a specific
> channel on the DMA controller.
Of course they do.
And It is the responsibility of platform to encode such information as a
'capability' of the channel.  Capability to reach a particular peripheral, say.

> ?Peripheral drivers normally do not
> know which channel they need, or even which DMA controller they
> require. ?That information is specific to the platform and SoC.
For that very reason I proposed, say, if MMC client driver is probed
for 2nd instance
of MMC controller, it should ask for the following capabilities
    (MMC << TYPE_SHFT) | (2 << INST_SHFT)    //I don't show other
fields for simplicity

It is the job of _platform_ to set TYPE and INSTANCE fields to
'MMC' and 2 resp _only_ for the channel(s) that can reach its MMC_2 controller.

That way, when the client 'generically' asks for DMA_MMC_2, it will be given
only one of those channels that can talk to second instance of MMC controller.


>> That is, the generic filter function would look equivalent of :-
>>
>> ? ? ? return is_free(chan) && (cap_requested == cap_of(chan) & cap_requested)
>>
>>
>> Now it all boils down to defining the set of _practically_ possible capabilities
>> and a method to exchange them between the API, Client and DMAC drivers.
>
> What are these capabilities?
I had mentioned the list below under 'Assuming'.  We may add more.

>
>> The above is the overall approach.
>>
>> The following is my idea of implementing it as of now, I am open to suggestions.
>>
>> Assuming :-
>> ***********
>> There are no more than 256 types of DMA'able devices
>> ?(MMC, USB, SPI etc) -- ?[8bits]
>>
>> A type of device never has more than 16 instances in a platform
>> ?(MMC-0, MMC-1, MMC-2 etc) -- ?[4bits]
>>
>> Mem->Mem, Mem->Dev, Dev->Mem, Dev->Dev capability in [4bits]
>
> No. ?You're being far too specific to your own DMA controller. ?Many
> DMA controllers (eg, PL08x) have a number of physical channels, all of
> which can be programmed for M2M, M2P, P2M and P2P. ?There is nothing
> in the design which restricts what a channel can do.
I am not being specific, at least not on this point. Btw, I have worked on pl080
as well and I have tried to be not specific to not only pl330 but also pl080.

If you notice I have assigned 4bits to the field. Each of the 4 bits can be set
independently.
So, a capable pl08x channel can set all 4 bits to indicate that it can
do all 4 types
 - M2M, M2P, P2M and P2P.


>> Max_Burst_Len for any channel is less than 64KB, in power of two [4bits]
>> Support programmable Max_Burst_Len(tunable in geometric steps of 2) ?[1bit]
>>
>> Max_RW_width/fifo_width is less than 128, in power of two -- [3bits]
>> Support programmable Max_RW_Width(tunable in geometric steps of 2) ?[1bit]
>>
>> Finally, No platform has more than 128 channels with identicial
>> capabilities [7bits]
>
> There is absolutely no way that this will work in reality - are you on
> a different planet? ?As has already been described to you, MMCI can
> use one DMA channel, and programs it according to the DMA direction,
> and has in the past adjusted the burst size according to what's going
> on with the driver.
>
> With your model, it would have to claim N channels from the DMA
> engine for all possible different configurations.
I don't think so.
What I proposed is only a list of capabilities and method to _select_ a suitable
channel in a platform independent way.

For example, if MMCI driver wants to be able to change directions, it should
specify Mem->Dev and Dev->Mem capability while requesting a channel.
And use slave_config call to switch directions. (and yes we have to modify
slave_config call and maybe some other parts too)

For being able to change burst size, it could set some 'ignore' bit +
default value
to the 'fifo_width' field so that DMAENGINE ignores checking the fifo_width
capability and upon slave_config either set requested burst_size if supported
or return error if the requested burst size is not supported.
That is implementation detail.

Sincerely, I would to know other capabilities that are more flexible than I have
assumed here or missed altogether.

I have not yet written any code. I just wanted to share my belief that
it is possible
to have client drivers truly independent of the platform they run on.
And by not using platform_data of DMA channels.

Probably you don't, but if you do want, I can send rudimentary implementation
of what I propose, in a few days.

Thanks
