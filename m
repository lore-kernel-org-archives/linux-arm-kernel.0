From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 28 Feb 2018 16:56:56 +0100
Subject: [PATCH 2/2] drm/sun4i: Handle DRM_MODE_FLAG_**SYNC_POSITIVE
 correctly
In-Reply-To: <20180216155049.r2mc724nfluwrrbe@flea.lan>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1516474221-114596-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180122085112.7xo2t3x5ag4k2kpl@flea.lan>
 <aa724bd5-cfb1-128c-af32-db29253f32aa@micronovasrl.com>
 <59f7b542-3b1d-ff62-e290-37c47f4075ff@micronovasrl.com>
 <9929d894-53c3-a7e9-a328-a00cfc1ef546@micronovasrl.com>
 <20180207103905.mtyzgu73mmifyvvj@flea>
 <653f0438-c55a-02a5-dffb-2ee8e6d9ef4a@micronovasrl.com>
 <20180208204043.mqryuqhx7a6z4v3b@flea>
 <e5d49c13-9b8f-d597-508c-10fed5300769@micronovasrl.com>
 <20180216155049.r2mc724nfluwrrbe@flea.lan>
Message-ID: <b4b4795c-6380-48fd-344f-3fb22968b1c2@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 16/02/2018 16:50, Maxime Ripard ha scritto:
> On Thu, Feb 15, 2018 at 07:05:56PM +0100, Giulio Benetti wrote:
>>> If so, and if remember the captures properly, the sampling would occur
>>> right before the rise, and not really around the fall.
>>>
>>> Would 2/3 be better here?
>>
>> Yes, you're right, 2/3 phase is better:
>>
>> 1/3 phase: https://pasteboard.co/H4VehON.png
>> 2/3 phase: https://pasteboard.co/H4Veq8a.png
>>
>> Take a look at the bit in middle(yellow) sampled by clock(blue).
>>
>> Rising edge is almost in the middle of D0 bit.
>>
>>>
>>>> According to scope captures above on both A20 and A33.
>>>> Unfortunately I don't have other boards for the other SoCs to take captures.
>>>>
>>>> What do you think?
>>>
>>> I guess we can make that part applicable to all SoCs, we haven't seen
>>> any significant differences on those part.
>>
>> So let's keep:
>> - As normal(rising edge) => IO_POL_REG "0x2 => 2/3 phase"
>> - As inverted(falling edge) => IO_POL_REG "0x0 => normal phase"
> 
> I was actually thinking 1/3 for rising, 2/3 for falling.

1/3 is almost the same waveform as D0,
having rising an falling edges almost in sync with D0.
It's not so clear because DCLK has a bad figure,
but it is that way.

2/3 instead is almost in the middle of D0 as rising.

Summarizing:
- use 0/3 as falling, then DRM_BUS_FLAG_PIXDATA_NEGEDGE
- use 2/3 as rising, then DRM_BUS_FLAG_PIXDATA_POSEDGE

I follow with a new patch using clk_set_phase function.

> 
> Maxime
> 


-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
