From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 12 Sep 2014 18:20:57 +0200
Subject: [PATCH v2 1/2] ARM: tegra: apalis/colibri t30: integrate audio
 support
In-Reply-To: <5410C222.2020602@wwwdotorg.org>
References: <cover.1410362950.git.marcel@ziswiler.com>
 <00f249b3d648d3a8d550c5db0737f3aa6d93f07e.1410362950.git.marcel@ziswiler.com>
 <5410C222.2020602@wwwdotorg.org>
Message-ID: <1410538857.15150.22.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-09-10 at 15:26 -0600, Stephen Warren wrote:
> No, definitely not; this patch has significant semantic changes since I 
> reviewed it.

OK, sorry. Admittedly this was probably a little bit too quick a shot.
The solution looked so clean and on first sight worked just fine.

> I'm not sure how this can work. Certainly all 3 clocks that are required 
> for audio are mentioned here. However, the PLL_A clock (which then 
> trickles down to the other 2) needs to have its rate changed based on 
> whether the sample rate is 44.1KHz- or 48KHz-based. Semantically, this 
> can't be something that "simple-audio-card" can imply, since 
> "simple-audio-card" is something agnostic to any HW, whereas this 
> clocking requirement is something specific to Tegra HW.

Yes, now as you mention it I forgot about the whole
tegra_asoc_utils_set_rate() stuff!

> To see the problem, try encoding some audio stream as both 44.1KHz and 
> 48KHz, then play a few seconds of each and keep switching back and 
> forth. You'll likely find either the playback pitch is wrong, or you get 
> drop-outs or stuttering.

Yeah, right. Clocks seem to be stuck at the 44.1 kHz setting.

> I also wonder how "simple-audio-card" can know what rate the EXTERN1 
> clock to the CODEC should be set to; each CODEC has a different 
> requirement for the minimum clock input and the Fs multiple usually 
> varies for different sample rates. See for example 
> sound/soc/tegra/tegra_wm8903.c:tegra_wm8903_hw_params(). This could be a 
> solved problem though: Perhaps some API has been added to CODECs to 
> report this information (or perhaps CODEC drivers now clk_set_rate() on 
> their input clocks themselves) since I last looked.

If there are no objections I will just revive version 1 again and send
it around as a new version 3 just to prevent any further confusion.
