From: pmeerw@pmeerw.net (Peter Meerwald-Stadler)
Date: Wed, 13 Jul 2016 11:02:28 +0200 (CEST)
Subject: sama5d4, configure pck1 with dt?
In-Reply-To: <20160707091512.387ea113@bbrezillon>
References: <alpine.DEB.2.02.1607062239210.12243@pmeerw.net>
 <20160707091512.387ea113@bbrezillon>
Message-ID: <alpine.DEB.2.02.1607131054080.10743@pmeerw.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Boris,

> > how do I configure pck1 using devicetree to be used as the master 
> > clock for an audio codec?
> > 
> > in particular how do I choose the clock source and frequency for pck1?
> > is there a way to do this using devicetree?
> > 
> > or is the code in at91sam9g20ek_audio_probe() the way to go?
> > i.e mclk=clk_get(0, "pck1"); pllb=clk_get(0, "pllb"); clk_set_parent(mclk, 
> > pllb); clk_set_rate(mclk, 12000000);
> 
> It's as simple as that:
> mclk = clk_get(<your-device>, "<audio-clk-name>");
> clk_set_rate(mclk, <rate>);

thank you for your advise; it almost works :)
my issue is/was that CLK_SET_PARENT_GATE is set, so the clock cannot
reparent when prepared

the audio codec driver I am trying to use (da7213) enables the mclk in 
BIAS_STANDBY pretty much before doing anything else (without knowing the 
actual clock rate), later-on setting the actual rate fails...

the issue is within ALSA and/or the codec driver, not the SAMA5D4 clock 
implementation

> <your-device> should not be NULL, <audio-clk-name> should not be pck1
> (see the DT binding doc), and you should not manually re-parent the mclk
> clk (the driver select the best parent when clk_set_rate() is
> called).

yep, understood, doing so now

thanks, regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
