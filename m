From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 31 Mar 2015 22:00:14 +0200
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>	<1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>	<CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>	<551976F1.1000605@collabora.co.uk>
 <CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>
Message-ID: <551AFCCE.4050404@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhilash,

On 03/31/2015 04:38 PM, Abhilash Kesavan wrote:
> javier.martinez at collabora.co.uk> wrote:
>> On 03/30/2015 06:07 PM, Tomasz Figa wrote:
>> >
>> > If look-up speed is important here, maybe all the relevant clocks
>> > could be looked up once at initialization time and just prepared and
>> > enabled here?
>> >
>>
>> Yes, I'll do that indeed.
>>
>> In fact, I was wondering if we should let this clock be disabled at
>> all. I noticed that the rockchip clk drivers do something similar
>> and prepare / enable a list of clocks at init time [0,1].
>>
>> Unfortunately I don't fully understand why this clock needs to be
>> enabled. It would be good if someone at Samsung can explain in
>> more detail what the real problem really is.
>>
> 
> I had a look at this some more today. The problem actually occurs when the
> mdma0 clock's parent - aclk266_g2d gets disabled. The run-time pm support
> in the dma driver disables mdma0 and in turn aclk266_g2d which causes the
> issue.
> From the User Manual, it appears that aclk266_g2d should be gated only when
> certain bits in the clock gating status register are 0. I cannot say for
> certain, but our gating the aclk266_g2d clock without the CG_STATUS bits
> being 0 could be a cause of the suspend failure.
> 

Thanks a lot for the explanation. I see the NOTE at the bottom of section
7.9.1.159 CLK_GATE_BUS_TOP that mentions that. I'll add this information
to the commit message when posting as a proper patch instead of a RFC.

I confirmed that changing the patch to prevent "aclk266_g2d" to be gated
instead of "mdm0" also makes the system to resume correctly from suspend
so I'll change that on the patch as well.

I see that many of the Exynos5420 clocks (including "aclk266_g2d") use the
CLK_IGNORE_UNUSED flag but AFAIU it only prevents the common clock framework
to disable the clocks on init but doesn't prevent the clocks to be disabled
if all the clock childs are gated so the parent is gated as well.

> As the CG_STATUS bits are not being checked anywhere in the kernel I think
> aclk266_g2d (and others in GATE_BUS_TOP) should not be gated. I am OK with

For now I'll just add "aclk266_g2d" but later if needed all the GATE_BUS_TOP
clocks (and others) that should only be gated when CG_STATUS is 0 can be
added. My patch iterates over a list of clocks to be kept during suspend even
when there is only one for now so adding more later if needed will be trivial.

Or do you think that I should add all the GATE_BUS_TOP clocks now?

> the suspend specific approach you have posted.
>

Great, I'll wait a couple of days to see if others have more comments about
the last RFC I shared [0] and I'll post it as a proper patch.

> Regards,
> Abhilash
> 

Thanks a lot for all your help and best regards,
Javier

[0]: https://lkml.org/lkml/2015/3/31/152
