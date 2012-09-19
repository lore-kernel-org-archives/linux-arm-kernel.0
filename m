From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 19 Sep 2012 15:15:11 -0700
Subject: [PATCHv4 8/8] ARM: OMAP3: do not delete per_clkdm autodeps during
 idle
In-Reply-To: <alpine.DEB.2.00.1209182241400.4747@utopia.booyaka.com> (Paul
 Walmsley's message of "Tue, 18 Sep 2012 22:43:52 +0000 (UTC)")
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-9-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1209182156330.4747@utopia.booyaka.com>
 <alpine.DEB.2.00.1209182241400.4747@utopia.booyaka.com>
Message-ID: <87k3vpek28.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 18 Sep 2012, Paul Walmsley wrote:
>
>> What do you think about the following patch to handle part of the i582 
>> workaround?
>
> That patch was an older version; here's one that builds and boots - sorry 
> about that.  It passed the basic PM tests here on 3730ES1.0 Beagle XM and 
> 3730ES1.2 EVM.
>
> Kevin, care to ack it if you're happy with it?  We still need to get the 
> other parts of the i582 workaround into place, of course...
>
>
> - Paul
>
> From: Paul Walmsley <paul@pwsan.com>
> Date: Tue, 18 Sep 2012 16:02:38 -0600
> Subject: [PATCH] ARM: OMAP36xx: PM: apply part of the erratum i582 workaround
>
> On OMAP36xx chips with ES < 1.2, if the PER powerdomain goes to OSWR
> or OFF while CORE stays at CSWR or ON, or if, upon chip wakeup from
> OSWR or OFF, the CORE powerdomain goes ON before PER, the UART3/4
> FIFOs and McBSP2/3 SIDETONE memories will be unusable.  This is
> erratum i582 in the OMAP36xx Silicon Errata document.
>
> This patch implements one of several parts of the workaround: the
> addition of the wakeup dependency between the PER and WKUP
> clockdomains, such that PER will wake up at the same time CORE_L3
> does.
>
> This is not a complete workaround.  For it to be complete:
>
> 1. the PER powerdomain's next power state must not be set to OSWR or
>    OFF if the CORE powerdomain's next power state is set to CSWR or
>    ON;
>
> 2. the UART3/4 FIFO and McBSP2/3 SIDETONE loopback tests should be run
>    if the LASTPOWERSTATEENTERED bits for PER and CORE indicate that
>    PER went OFF while CORE stayed on.  If loopback tests fail, then
>    those devices will be unusable until PER and CORE can undergo a
>    transition from ON to OSWR/OFF and back ON.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
