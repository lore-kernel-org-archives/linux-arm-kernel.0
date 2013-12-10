From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Dec 2013 21:14:28 +0100
Subject: [linux-sunxi] Re: [PATCH 04/10] net: stmmac: sunxi platfrom
 extensions for GMAC in Allwinner A20 SoC's
In-Reply-To: <52A61435.6040803@redhat.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-5-git-send-email-wens@csie.org>
 <52A5A52C.50605@st.com> <52A5ECF4.6030301@redhat.com>
 <CAGb2v64LNxnz--vn0u9zwmt7MQJZ=uz2fs0H3zDSse_XDfdK4Q@mail.gmail.com>
 <52A61435.6040803@redhat.com>
Message-ID: <20131210201428.GF3651@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 08:04:21PM +0100, Hans de Goede wrote:
> >>Now reading this has also made me take a closer look at wens' patch
> >>for this. Wens, I see that you directly modify registers in the ccm
> >>that is a big no-no instead you should add a helper function to
> >>sunxi-clk.c and use that, see ie:
> >>https://bitbucket.org/emiliolopez/linux/commits/2b95847d9aa4aa13317dd7358ffcbd951dcb5eff?at=master
> >
> >Yes, this has been raised by Maxime. The odd "GMAC_IF_TYPE_RGMII" or
> >"gmac interface type bit" has been bugging me.
> >
> >Additionally, the TX clock has 2 inputs (not counting MII [1]).
> >The internal one is most likely controlled by the GMAC. The clock
> >rate is set internally to match the link speed. The external clock
> >source has controllable dividers to get the correct clock rate.
> >This shouldn't be hard to model with CCF though.
> >
> >In hardware, this is probably a mux between the GMAC clock generator
> >and the GMAC data transmit logic.
> >
> >My current plan is to choose MII when the clock is disabled,
> >and choose either of the inputs when it is enabled. I will
> >have to learn more about the CCF first.
> 
> OK, in this case I would be tempted to just go with a custom sunxi
> function in the sunx-clk mode like what we have for the mmc stuff,
> but if you think you can model this with the regular clock stuff,
> that is of course fine too :)

Note that it's also ok to implement the clock driver out of
drivers/clk if it makes more sense.

So, if it's more convenient for you to declare both drivers (clock and
gmac), say in the glue file, I'm totally fine whith that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/55df0249/attachment.sig>
