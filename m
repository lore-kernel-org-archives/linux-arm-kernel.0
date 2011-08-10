From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 10 Aug 2011 16:01:13 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
Message-ID: <CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 3:31 PM, Koul, Vinod <vinod.koul@intel.com> wrote:
> On Wed, 2011-08-10 at 14:59 +0530, viresh kumar wrote:
>> On 08/10/2011 02:30 PM, Russell King - ARM Linux wrote:
>> >> > They must be allocated when they are required and must be freed after we are
>> >> > done with transfers. So that they can be used by other users.
>> > Which DMA engine driver requires this?
>> >
>>
>> dw_dmac.c
>>
>> > Normally, when we have DMA engine drivers with multiple request signals,
>> > the slave peripheral side publishes several virtual channels which are
>> > claimed by the peripheral drivers. ?This (amongst other things) allows
>> > the peripheral drivers to hold claim to one of the virtual channels
>> > all the time that it's required.
>>
>> If users of DMA expect DMA engine drivers to work this way, then we should
>> have this mentioned clearly in DMA slave documentation.
>>
>> @Dan/Vinod: What do you say?
> I would agree on both counts :)
>
> In some cases it does make sense to hold the channel for the lifetime
> like uart or where the channel has been tied to an interface by SoC
> designer.
> But in some cases like dw_dmac it seems you can assign channels
> dynamically to each usage, and runtime allocation ensures we have best
> utilization.
> So i would argue that there is no "one size fits all" here, if you can
> manage channels dynamically and utilize more efficiently then go ahead,
> but if you cant (h/w and usage constraint) then you should not be forced
> to do so.

The idea is to have channel allocation as purely a s/w thing - no
actual commitment
of h/w resources. So we can afford to have channel allocated for the
whole lifetime
of a client.

Some dmac drivers are written 'improperly', keeping in mind the
platforms that have fixed
ReqSig->Peri map and no more clients than actual req-sigs are active
simultaneously.
But such dmac drivers will fail if a new platform decides to hijack req-signals.

So, imho, it is absolutely a good thing for every dmac driver to be
designed for re-routable
ReqSig->Peri map... which would force their design to allocate
virtual/software channels to clients
without commit much(any?) h/w resources.
