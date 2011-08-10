From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 10 Aug 2011 16:18:42 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <20110810103052.GI1831@n2100.arm.linux.org.uk>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<CABb+yY0Qvuhrn+FUhWDHMwUjv=nR4MOfLeDfTzG17HXEuu2pmA@mail.gmail.com>
	<20110810103052.GI1831@n2100.arm.linux.org.uk>
Message-ID: <CABb+yY2T7qEZNLH1E8U+oiLUDQC+fGfrT82KExmOtV09UcqQeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 4:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 10, 2011 at 03:39:28PM +0530, Jassi Brar wrote:
>> On Wed, Aug 10, 2011 at 2:59 PM, viresh kumar <viresh.kumar@st.com> wrote:
>> > On 08/10/2011 02:30 PM, Russell King - ARM Linux wrote:
>> >>> > They must be allocated when they are required and must be freed after we are
>> >>> > done with transfers. So that they can be used by other users.
>> >> Which DMA engine driver requires this?
>> >>
>> >
>> > dw_dmac.c
>> >
>> >> Normally, when we have DMA engine drivers with multiple request signals,
>> >> the slave peripheral side publishes several virtual channels which are
>> >> claimed by the peripheral drivers. ?This (amongst other things) allows
>> >> the peripheral drivers to hold claim to one of the virtual channels
>> >> all the time that it's required.
>> >
>> > If users of DMA expect DMA engine drivers to work this way, then we should
>> > have this mentioned clearly in DMA slave documentation.
>>
>> The requirement stems from the fact that most DMACs(esp third party) could be
>> made to reroute req-signals by the platform, it has not much to do with the API.
>> IMO, all dmac drivers should be implemented that way to be on the safer side.
>
> No it isn't. ?It's to do with how the physical channels are used.
IMO, a dmac driver developer sees only two aspects - "virtual channel"
at frontend and
"ReqSig/PhyChan" management at the backend.  While ReqSig and Physical Channels
are different h/w entities, the driver developer usually works having
tied them together.

For ex, PL330 has 8 physical channels(ARM calls them threads) and 32
peripheral interfaces(ReqSig),
where as the dmac driver freely allocates 32 virtual channels and
keeps in mind that only 8 peripheral
interfaces can be active at any time.

So I am unable to see how I said something different that you do.
