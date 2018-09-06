From: stefan@agner.ch (Stefan Agner)
Date: Thu, 06 Sep 2018 13:25:56 -0700
Subject: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
In-Reply-To: <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com>
References: <20180905052113.21262-1-stefan@agner.ch>
 <4035252.QuWadVx7pr@avalon> <1569297.pdEFdpi3HS@avalon>
 <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
 <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com>
Message-ID: <b1cb586397a4cd444c33dd83d72fa544@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.09.2018 04:07, Linus Walleij wrote:
> On Wed, Sep 5, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
>> On 05.09.2018 00:44, Laurent Pinchart wrote:
> 
>> Good point! I actually really don't like that we use the same flags here
>> but from a different perspective. Especially since the flags defines
>> document things differently:
>>
>> /* drive data on pos. edge */
>> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
>> /* drive data on neg. edge */
>> #define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)
> 
> Maybe a stupid comment from my side, but can't we just change the
> documentation to match the usecases?
> 
> /* Trigger pixel data latch on positive edge */
> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
> 
>> Using the opposite perspective would also need translation in crtc
>> drivers... So far no driver uses sampling_edge.
>>
>> I would prefer if we always use the meaning as documented by the flags.
>>
>> I guess we would need to convert DRM_BUS_FLAG_PIXDATA_POSEDGE ->
>> DRM_BUS_FLAG_PIXDATA_NEGEDGE.
>>
>> Linus Walleij, you added sampling edge, any thoughts?
> 
> I just thought it was generally useful to have triggering edge encoded
> into the bridge as it makes it clear that this edge is something
> that is a delayed version of the driving edge which is subject to
> clock skew caused by the speed of electrons in silicon and
> copper and slew rate caused by parasitic capacitance.

Ok, I read a bit up on the history of bridge timing, especially:
https://www.spinics.net/lists/dri-devel/msg155618.html

IMHO, this got overengineered. For displays we do not need all that
setup/sample delay timing information, and much longer cables are in
use. So why is all that needed for bridges?

For Linus case, the THS8134(A/B) data sheet I found (revised March 2010)
clearly states:
Clock input. A rising edge on CLK latches RPr0-7, GY0-7, BPb0-7.

So we need to drive on negative edge, hence DRM_BUS_FLAG_PIXDATA_NEGEDGE
should be used, which makes the pl111 driver setting TIM2_IPC: 
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0121d/index.html

> DRM_BUS_FLAG_PIXDATA_POSEDGE is the right value for my use cases, but it 
> doesn't match how the ADV7123 operates. Using DRM_BUS_FLAG_PIXDATA_NEGEDGE 
> would match the hardware, but would break display for some modes, depending on 
> the display clock frequency as the internal 8.5ns output delay applied to a 
> falling clock edge would fall right into the 1.7ns setup + hold time window of 
> the ADV7123 around the rising edge. I can't test this right now as I don't 
> have local access to boards using the ADV7123, but from a quick calculation 
> that ignores the PCB transmission delay modes with frequencies between 57MHz 
> and 71MHz could break if the data was output on the falling edge of the clock.

If clocks vs. data signal are really that much off on R-Car DU, then
parallel displays must have the very same issue...

Are you sure that only the clock signal has an output delay? And that
this output delay is a fixed value, clock independent?

Typically, delays apply to all signals equally, and often are clock
frequency dependent...

Without really looking at the signals, I would not jump to conclusions
here! I am pretty sure that driving on negative edge works just as well.

--
Stefan

> 
> Yours,
> Linus Walleij
