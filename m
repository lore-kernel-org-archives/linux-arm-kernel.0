From: carlo@caione.org (Carlo Caione)
Date: Thu, 8 May 2014 08:14:45 +0200
Subject: [linux-sunxi] Re: [PATCH 0/2] ARM: sunxi: Enable syscon for the
 system controller
In-Reply-To: <20140508030425.GJ7047@lukather>
References: <1399212160-26934-1-git-send-email-carlo@caione.org>
 <20140505225517.GE9464@lukather>
 <CAGb2v66JBM_Rv8ie=7iuTPrXGPJECTeevnf9LLXNS=FSYs1+Tg@mail.gmail.com>
 <CAOQ7t2akOEr7o4Q5ze5QPr_RHj6MWmA-u5NTuq2q1epy2LBr8w@mail.gmail.com>
 <20140507032502.GM9464@lukather>
 <CAOQ7t2byRX3HmVjUKYZ-VEocR3S2ATLpSTPV8bdFD98_Q2sY9Q@mail.gmail.com>
 <20140508030425.GJ7047@lukather>
Message-ID: <CAOQ7t2b6hv_qUL2wRzo8=LMc99Gb7TsHA8-z4xBCkAZU6Z6o_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 5:04 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

<snip>

>> >> > I believe this will be used for toggling the SRAM mappings. (Am I right?)
>> >>
>> >> Definitely right.
>> >>
>> >> > The second register toggles mappings for MUSB FIFO, EMAC, and a few of
>> >> > the other IP blocks we currently don't support.
>> >>
>> >> Not yet :)
>> >
>> > I wonder how other SoCs are actually handling this mapping between CPU
>> > & DMA vs device of some SRAMs. Did you look at this?
>>
>> It seems quite a few grepping for syscon
>
> ??
>
> What do you mean?
>
> I wasn't really talking about syscon itself, just how other SoCs
> usually deals with this kind of remapping usually.

Ho, sorry. In general for what I have seen the drivers use syscon or
just map directly the register they need to use.
Probably there is something smarter that I'm not aware of.

>> >> >> Moreover, the A31 doesn't seem to have this system controller, or at
>> >> >> least this overlap.
>> >>
>> >> I admit that I didn't check the A31 manual but I trusted the wiki page
>> >> at http://linux-sunxi.org/SRAM_Controller and
>> >> http://linux-sunxi.org/A31/Memory_map
>> >>
>> >> > There should be something similar, as does the A23. There is no overlap AFAIK.
>> >>
>> >> I agree and will check also A23.
>> >>
>> >> >> And since on the A20, registers seem to have one usage only, so I
>> >> >> guess we can just split this IP into several nodes, just like we did
>> >> >> with the NMI.
>> >> >
>> >> > As stated above, the second register toggles SRAM mappings for at most
>> >> > 4 SRAM blocks (for EMAC, MUSB, ACE, ISP).
>> >> >
>> >> > syscon would be a good way to share this register among the various drivers.
>> >> > We do not toggle it in the current EMAC driver. The driver seems to assume
>> >> > it is setup by the bootloader, and on the A20, it seems to be mapped to
>> >> > EMAC by default.
>> >> >
>> >> > The MUSB glue layer driver must toggle this.
>> >>
>> >> This is exactly why I wrote these patches. I started hacking /
>> >> studying your MUSB driver and I think that using syscon is a better
>> >> way to manage these registers instead of mapping them in several
>> >> drivers also because most of the time a single register has to be used
>> >> by multiple drivers (i.e. SRAM_CTL1_CFG is used for USB,  EMAC,
>> >> etc...)
>> >>
>> >> > I think this approach is better than all the individual drivers mapping
>> >> > the registers and toggling a single bit. In fact I did something similar
>> >> > when working on preliminary musb support.
>> >
>> > I agree with that.
>>
>> So do you suggest to drop the syscon idea waiting for the new soc
>> framework?
>
> To be honest, I don't really know what to think of it. I'd need to see
> some code that uses this. Maybe we can just postpone the decision to
> whenever we will actually have some code submitted that make any use
> of this?
>
> If it's easier for you to keep the syscon at the moment for whateever
> driver you're working on before submitting it, I'm fine with it, but
> I'm not going to merge it right now either.

It's fine with me.
Thank you for your review,

-- 
Carlo Caione
