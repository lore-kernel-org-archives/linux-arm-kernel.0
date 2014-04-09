From: bp@alien8.de (Borislav Petkov)
Date: Wed, 9 Apr 2014 17:19:32 +0200
Subject: [RFC PATCH] edac: add support for ARM PL310 L2 cache parity
In-Reply-To: <CAL_Jsq+gszc+R_BrLtHKEBGYd=3T+sE1d+-HoF9aYZt6C2k5-g@mail.gmail.com>
References: <1393770760-32550-1-git-send-email-punnaia@xilinx.com>
 <a1a9e47a-069c-4285-9899-d5a58cf532c2@CO9EHSMHS003.ehs.local>
 <20140409113246.GA8778@pd.tnic>
 <CAL_Jsq+gszc+R_BrLtHKEBGYd=3T+sE1d+-HoF9aYZt6C2k5-g@mail.gmail.com>
Message-ID: <20140409151932.GK6529@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 08:18:28AM -0500, Rob Herring wrote:
> I don't think so, the PL310 is present on lots of ARM chips besides
> Xilinx. I don't know how many support parity as that is optional. In
> fact the highbank_l2_edac.c is for the PL310 as well, but the
> registers it uses is all custom logic added for ECC and there is no
> part of the PL310 h/w used by the driver.

Oh ok, so highbank_l2 and PL310 could theoretically be merged together
in one compilation unit, even if they don't really share code at all...

> If there is lots duplication, then that's a sign the framework needs
> to handle more of the boilerplate pieces. There could be a "simple"
> driver/library for devices which are no more than some registers, an
> interrupt handler and static information about the type of EDAC
> device.

Yeah, it's not that - I'm just getting worried that I'm receiving an
EDAC driver for each piece of silicon out there and would like to still
keep drivers/edac/ sane and be able to control that wild growth.

I'm just thinking out loud here, bear with me pls:

Frankly, having a single compilation unit contain similar silicon
functionality could be a good way to put a hold on the growth but the
disadvantage of this is fatter drivers. Which wouldn't matter all too
much but after a certain level of fat, they might need splitting.

And the highbank version is nothing but the big probe routine and a
small irq handler.

And the PL310 is similar but also with a poller.

I guess, if they don't share functionality at all, putting them together
might not be worth it. Hohummm.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
