From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 1 Aug 2017 10:17:46 +0800
Subject: [linux-sunxi] Re: [PATCH 0/4] clk: sunxi-ng: Fix issues with
 fractional mode
In-Reply-To: <4026156.d8uMWWFJnt@jernej-laptop>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
 <CAGb2v65pH-Me6JjMYzp41NwS478azMTLBPrkJwZcho9Ay2JX1Q@mail.gmail.com>
 <4026156.d8uMWWFJnt@jernej-laptop>
Message-ID: <CAGb2v66W+kEZAPOj6qLnBc15ocrYT9pv3oofgBr9TsNmzBGuhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 12:50 AM, Jernej ?krabec <jernej.skrabec@siol.net> wrote:
> Hi Chen-Yu,
>
> Dne ponedeljek, 31. julij 2017 ob 07:13:34 CEST je Chen-Yu Tsai napisal(a):
>> Hi Jernej,
>>
>> On Mon, Jul 31, 2017 at 12:41 AM, Jernej Skrabec
>>
>> <jernej.skrabec@siol.net> wrote:
>> > During development of H3 HDMI driver, I found some issues with
>> > setting video clock rate. It turned out that clock driver decided
>> > to use fractional mode and selected right frequency, but it didn't
>> > enable it. Additionally, fractional helpers don't wait on lock.
>>
>> What kind of resolution were you testing to actually hit this?
>
> 1920x1080p @ 60Hz
>
>>
>> AFAIK the fractional mode is either 297 or 270 MHz. Even Full HD
>> 1080p60 dot clocks aren't that high. And the clk drivers should
>> try to request a matching parent clk rate. So the PLL wouldn't
>> go that high. Are you testing 4k @ 30fps?
>
> No, it is a bit more complicated than that. H3's HDMI PHY is proprietary and
> register meanings are not known well. Because of that, I'm using values found
> in BSP driver. Those values include pixel clock divider. BSP driver always use
> 297 MHz as a base and uses dividers in PHY to prepare right pixel clock. So
> the case for 1080p is 297 MHz / 2 = 148.5 MHz.

I see. So for the current in kernel users, none would be able to
hit the fractional mode clock rates. HDMI on sun5i is limited to
1080p60, and we don't support pixel doubling. LCD dotclocks have
a minimal /6 divider, though it doesn't seem likely they will hit
this either, or we would have seen someone complain. And these
drivers were introduced well before 4.13-rc1. The clk maintainers
really like to have just critical fixes, and fixes for stuff
added in the current release. So I'm re-queuing these 4 patches
for 4.14.

Thanks
ChenYu

>
>>
>> As it stands, I don't think any of the existing display support
>> can go that high, so I think we're safe as far as old kernels
>> go, i.e. we don't need to Cc stable for these.
>
> Ok.
>
> Regards,
> Jernej
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
