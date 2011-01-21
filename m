From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 21 Jan 2011 09:09:51 +0900
Subject: Locking in the clk API
In-Reply-To: <20110120190822.GK6335@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<201101111744.59712.jeremy.kerr@canonical.com>
	<20110111103929.GN24920@pengutronix.de>
	<AANLkTinHL9X_bqMPR=W8Va01O4xngUnpGCkCiE3xEdiQ@mail.gmail.com>
	<4D386ABF.9060908@fluff.org>
	<20110120190822.GK6335@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim5N_sCCoOR40y7sTvdDoFkUJd4tUSSbrCccGjy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 4:08 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 20, 2011 at 05:02:55PM +0000, Ben Dooks wrote:
>> If you want to make it so that each low-power mode has to work
>> out what PLLs need to be disabled and then re-enabled makes me
>> want to be sick. Hiding this stuff behind specific implementations
>> is a recipe for disaster.
>
> Why should systems which don't suffer from such problems be prevented
> from gaining power saving from turning off their clocks when devices
> are not being used (eg, the console serial port.)
>
> One solution to your root PLL issue would be to have a separate set of
> enable/disable API calls which get called at setup/release time (or
> whatever you'd like to call it) which can only be called from non-atomic
> context. ?Maybe clk_prepare() and clk_unprepare(). ?These functions
> should perform whatever is necessary to ensure that the clock source
> is available for use atomically when clk_enable() is called.
>
> So, in your case, clk_prepare() ensures that the root PLL is enabled,
> clk_unprepare() allows it to be turned off.
>
> In the case of a console driver, clk_prepare() can be called when we
> know the port will be used as a console. ?clk_enable() is then called
> before writing out the string, and clk_disable() after we've completely
> sent the last character.
>
> This allows the best of both worlds. ?We now have a clk_enable() which
> can be used to turn the clocks off through the clock tree up to the first
> non-atomic clock, and we also have a way to deal with those which need
> to sleep. ?So not only do "sleeping clock" implementations become possible
> but these "sleeping clock" implementations also get the opportunity to
> shutdown some of their clock tree with minimal latency for doing so.

This is exactly what I suggested in my last post, except the console example.
Only to be a part of common clock api because it's not very safe to assume
future SoCs will have the same simple clock topologies that they have today.

Not to mean to teach, but I hope you realize with more and more
device controller being crammed into ever shrinking SoCs,
clock would eventually have to be flexible in functionality
and complicated in hierarchy. Ben already gave examples
of Audio, MFC and Video controllers of latest Samsung SoCs.
