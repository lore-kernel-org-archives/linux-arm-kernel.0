From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 May 2014 14:36:33 +0800
Subject: [linux-sunxi] Re: [PATCH 0/2] ARM: sunxi: Enable syscon for the
 system controller
In-Reply-To: <20140505225517.GE9464@lukather>
References: <1399212160-26934-1-git-send-email-carlo@caione.org>
 <20140505225517.GE9464@lukather>
Message-ID: <CAGb2v66JBM_Rv8ie=7iuTPrXGPJECTeevnf9LLXNS=FSYs1+Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 6, 2014 at 6:55 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sun, May 04, 2014 at 04:02:38PM +0200, Carlo Caione wrote:
>> The so called "system controller" in Allwinner A20 and A31 SoCs is
>> multi-purpose controller that tries to add misc functionality to one
>> memory region.
>> In these SoCs it controls the internal SRAM partitioning but it also
>> includes registers for chip versioning and NMI control.
>> This patch adds the proper nodes in the DTS files and enable the syscon
>> in the defconfig files.
>>
>> Even though the system controller includes also register for managing the
>> NMI controller, these register are not mapped in the syscon since they
>> are directly used and mapped by the NMI controller itself.
>
> Hmmm, what exactly do you want to achieve with this?
>
> The NMI controller won't be able to use it, since it's initialized
> much earlier than syscon and regmap.

I believe this will be used for toggling the SRAM mappings. (Am I right?)
The second register toggles mappings for MUSB FIFO, EMAC, and a few of
the other IP blocks we currently don't support.

> Moreover, the A31 doesn't seem to have this system controller, or at
> least this overlap.

There should be something similar, as does the A23. There is no overlap AFAIK.

> And since on the A20, registers seem to have one usage only, so I
> guess we can just split this IP into several nodes, just like we did
> with the NMI.

As stated above, the second register toggles SRAM mappings for at most
4 SRAM blocks (for EMAC, MUSB, ACE, ISP).

syscon would be a good way to share this register among the various drivers.
We do not toggle it in the current EMAC driver. The driver seems to assume
it is setup by the bootloader, and on the A20, it seems to be mapped to
EMAC by default.

The MUSB glue layer driver must toggle this.

I think this approach is better than all the individual drivers mapping
the registers and toggling a single bit. In fact I did something similar
when working on preliminary musb support.


Cheers
ChenYu
