From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 16 Aug 2011 20:21:34 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <1313495727.1603.83.camel@vkoul-udesk3>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
	<CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
	<20110810104025.GK1831@n2100.arm.linux.org.uk>
	<CABb+yY3=q5Nq1wtM6Av2DrgUfjZR_Ao40QhBhv_ik9naAd5wRg@mail.gmail.com>
	<CACRpkdaCyUJ3A9VWfsVuwJj3DGVkvjc2_ZOD4yM4YX3NPxAAYQ@mail.gmail.com>
	<CABb+yY2Usd5=RW6BV69UW=Tq0zQW6LCtT2GhfdHGA61ZU3aNcQ@mail.gmail.com>
	<1313009883.1603.25.camel@vkoul-udesk3>
	<CABb+yY0Hy9DcHf+D0OrrGjxkR=V8sa4Q-Kvd1iH01oChnoEE6w@mail.gmail.com>
	<1313495727.1603.83.camel@vkoul-udesk3>
Message-ID: <CABb+yY3gdkDZf7vZGV1Bcdyo0VphnA2odk8nRy3aCcv9kxjGXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 5:25 PM, Koul, Vinod <vinod.koul@intel.com> wrote:
>> >> > The lookup of a device DMA channel should follow the
>> >> > design pattern set by regulators and clocks.
>> >> Nopes. It depends upon the subsystem.
>> >> We should strive towards making this scheme as 'standalone' as
>> >> possible.
>> >> Client having to specify the device it wants a channel for, is a
>> >> waste - otherwise we don't fully get rid of platform assistance for
>> >> channel selection!
>> > On one of the platforms I work on we have 3 DMACs, peripheral 1, 2 and 3
>> > can only use channels from controller 1, and the peripherals 4, 5 from
>> > controller 2 and so on. They _absolutely_ need channel from specific
>> > controller, so above suits it :).
>> > Btw all three controllers _have_exactly_same_caps_ so dma engine will
>> > not see any difference in channels. They don't know which peripherals
>> > are connected to them, that's platform information which this scheme
>> > seems to be suited to...
>> > Can you tell me how your scheme will work in this case?
>> Actually the setup is quite simple.
>> Say, the Peri-4 is the UART which could only be reached from DMAC-2.
>>
>> DMAENGINE should simply manage a pool of total channels in the platform,
>> disregarding the dmacs they come from.
>>
>> Each channel in the common pool will have a 'capability-tag' of u32 type - which
>> specifies various capabilities of the channel expressed in bit-fields.
>> It is the job of
>> platform (via dmac driver) to set 'tag' of each channel appropriately.
>> Among others, a channel's reach to a particular device is a
>> 'capability' (expressed
>> in 7-bits DEV_TYPE field-mask of the 'tag')
>>
>> In your case, while setting up channels before adding them to the common pool,
>> the platform (via dmac driver) will ensure exactly the channel which
>> can reach UART
>> has set DEV_UART value in the DEV_TYPE field of its capability-tag.
>>
>> After all the dmac instances have been probed, _exactly_ one channel in the pool
>> will have the 'UART' capability mentioned in the DEV_TYPE field.
>>
>> The serial driver(client), will simply specify 'Ability to reach UART'
>> as one of its
>> requirements to the core - by setting the DEV_TYPE field with DEV_UART value
>> of the 'request-tag' (a u32 number, say).
>>
>> While searching for appropriate channel for the serial client, the core will
>> iterate over the pool and, of course, only one channel will have DEV_TYPE
>> field set to DEV_UART - the one which platform decided!
>>
>> Please have a look at the end of ?https://lkml.org/lkml/2011/7/29/211
>> (esp the helpers) to get an idea of data structures involved.
>>
>>
>> *******************************
>> UART(client) driver snippet :-
>> *******************************
>> struct dma_chan *chan_rx;
>> u32 req_cap;
>>
>> /* Reset the requirement list */
>> DCH_RESET_CAP(req_cap);
>>
>> /* Specify ability to reach UART as a requirement */
>> DCH_REQCAP_DEV(req_cap, DCHAN_TODEV_UART);
>>
>> /* Specify we require to Read from UART */
>> DCH_REQCAP_P2M(req_cap);
>>
>> /* ...... specify other requirements */
>>
>> /* Ask for the channel */
>> chan_rx = dma_request_channel(req_cap);
>>
>>
>>
>> ***************
>> dmaengine.c
>> ***************
>> struct dma_chan *dma_request_channel(u32 req_cap) ?// typedef u32 to
>> look nice ;)
>> {
>> ?struct dma_chan *ch;
>>
>> ? ? ? ? ? ?/* !!! Not final implementation !!! */
>> ?list_for_each_entry(ch, &channel_pool, chan_node) {
>> ? ? ? if (GET_DEVTYPE(req_cap) != GET_DEVTYPE(ch->tag))
>> ? ? ? ? ? continue;
>>
>> ? ? ? if ((IS_DCH_M2M(req_cap) && !IS_DCH_M2M(ch->tag))
>> ? ? ? ? ?continue;
>>
>> ? ? ? if ((IS_DCH_M2P(req_cap) && !IS_DCH_M2P(ch->tag))
>> ? ? ? ? ?continue;
>>
>> ? ? ? if ((IS_DCH_P2M(req_cap) && !IS_DCH_P2M(ch->tag))
>> ? ? ? ? ?continue;
>>
>> ? ? ? if ((IS_DCH_P2P(req_cap) && !IS_DCH_P2P(ch->tag))
>> ? ? ? ? ?continue;
>>
>> ? ? ? /* weed out channels that don't have further capabilities required */
>>
>> ? ? ? /* At the end of checks this channel meets every requirement */
>> ? ? ? return ch;
>> ? }
>> ? /* Will never reach here in a bug-free platform */
>> ? return NULL;
>> }
>>
>>
>> **************************************
>> DMAC <- PLATFORM <- BOARD
>> ***************************************
>> Well, that is between dmac and platform and out of scope of DMAENGINE API.
>> They can decide upon any data structure to pass the info needed.
>>
>> But at some point someone must set :-
>> ? _Only_ for the channel of DMAC-2 that could talk to the UART.
> That is why I am skeptical about this implementation approach. Here
> CHAN_TODEV_UART is how peripheral is connected to DMAC which is a
> platform capability which magically needs to be published by generic
> DMAC driver and requested by UART driver...
Not really. Set by generic dmac driver in conjunction with platform (or maybe
also board).... which would look at the type of controller it has and
the CHAN_TODEV_
its client driver requests.
S3C DMA API has been doing similar, albeit for fixed ReqSig->Peri map,
for quite some time now.

> Sorry I still don't get this schema and how it can be scaled and be
> generic enough to let it carry with various implementations.
>
> Can you publish your complete idea rather than bits and pieces...
I already explained the complete idea. I don't have any implementation yet.
Clients and dmaengine.c is easier to manage.
But changes to >20 dmac drivers is the biggest effort - though they anyway
need such modifications if we are to have the DMAENGINE utopia someday.
In free time, I will modify a dmac driver or two, but it might take
prohibitively
long if I am expected to update possibly all the 20 dmac drivers and the backend
platforms by
  a) Making dmac drivers platform agnostic and for re-routable ReqSig-Peri map.
       That implies dmac drivers managing 'virtual-channel' front end
and physical
       channel and ReqSig->Peri link management in the backend with
help from platform.
  b) Modifying platforms/boards to pass channel map and link re-routing callback
      pointers to generic dmac drivers.
