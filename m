From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 7 Jul 2016 09:15:12 +0200
Subject: sama5d4, configure pck1 with dt?
In-Reply-To: <alpine.DEB.2.02.1607062239210.12243@pmeerw.net>
References: <alpine.DEB.2.02.1607062239210.12243@pmeerw.net>
Message-ID: <20160707091512.387ea113@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Wed, 6 Jul 2016 23:17:07 +0200 (CEST)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> Hello,
> 
> how do I configure pck1 using devicetree to be used as the master 
> clock for an audio codec?
> 
> in particular how do I choose the clock source and frequency for pck1?
> is there a way to do this using devicetree?
> 
> or is the code in at91sam9g20ek_audio_probe() the way to go?
> i.e mclk=clk_get(0, "pck1"); pllb=clk_get(0, "pllb"); clk_set_parent(mclk, 
> pllb); clk_set_rate(mclk, 12000000);

It's as simple as that:

mclk = clk_get(<your-device>, "<audio-clk-name>");
clk_set_rate(mclk, <rate>);

<your-device> should not be NULL, <audio-clk-name> should not be pck1
(see the DT binding doc), and you should not manually re-parent the mclk
clk (the driver select the best parent when clk_set_rate() is
called).

Regards,

Boris
