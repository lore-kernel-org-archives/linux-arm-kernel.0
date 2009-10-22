From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 22 Oct 2009 18:22:32 -0500
Subject: [PATCH 05/10] omap1: Fix DSP public peripherals support for
	ams-delta
In-Reply-To: <20091022221216.27408.39863.stgit@localhost>
References: <20091022221013.27408.443.stgit@localhost>
	<20091022221216.27408.39863.stgit@localhost>
Message-ID: <4AE0E938.7080305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Tony Lindgren wrote:
> From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
> DSP public peripherals used to work on OMAP1510 based (or all OMAP1 class?)
> machines as long as old dspgateway code were present in the l-o tree. For
> several months it is no longer included, breaking support for McBSP1 based
> audio on Amstrad Delta, for example.
> 
> This patch, derived from the old dspgateway code, corrects the problem for the
> board by simply taking the DSP out of reset state, I guess. That way, things
> should not break when a new dsp code is added to the tree, and the change can
> be reverted then.

A minor comment/correction here. Although this bit is called "DSP_RST" 
this does not actually release the DSP from reset. This bit actually 
releases the reset for the "priority registers (TIPB module), EMIF 
configuration registers, and the MPUI control logic (partially) in the 
DSP", thus allowing you to access the DSP peripherals via the MPUI. Bit 
1 of the same register, called "DSP_EN", actually releases the DSP reset.

> If there are any reports on McBSP1 or other DSP public peripherals not working
> for other OMAP1 machines (I've not heard of any for now), I can prepare a more
> general patch providing an extra include file with a helper function defined.

This would be necessary for all OMAP15xx based devices that use McBSP1 
(or McBSP3 for that matter). However, I am not sure if it is common for 
other boards to use McBSP1 for audio.

Jon
