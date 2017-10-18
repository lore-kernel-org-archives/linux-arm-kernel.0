From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Oct 2017 12:24:19 +0100
Subject: [PATCH/RFC 4/5] regulator: bd9571mwv: Add support for backup mode
In-Reply-To: <CAMuHMdU2PpiSftwnqHjb8uFpu5Huw7hpedk4cSzDY-eeKio_Dw@mail.gmail.com>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-5-git-send-email-geert+renesas@glider.be>
 <20171018110238.hjv7huiievhr5obs@sirena.co.uk>
 <CAMuHMdU2PpiSftwnqHjb8uFpu5Huw7hpedk4cSzDY-eeKio_Dw@mail.gmail.com>
Message-ID: <20171018112419.3eqz34epcshxas3f@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 01:19:08PM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 18, 2017 at 1:02 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Oct 10, 2017 at 05:26:17PM +0200, Geert Uytterhoeven wrote:

> >> Backup mode is not enabled automatically, as e.g. on Renesas
> >> Salvator-X(S) boards enabling backup mode changes the role of the ACC
> >> switch from a power switch to a wake-up switch.  Hence enabling it
> >> prevents the board from being powered off using the ACC switch, which
> >> may confuse the user.

> > This sounds an awful lot like the standard power/wakeup, though the
> > power change is a bit unexpected there.  I'm also wondering if it makes
> > sense to just only enable the wakeup mode when suspending which
> > preserves the power off functionality while also keeping the wakeup
> > support.

> The ACC switch is not a momentary switch (push button), but a toggle
> switch with two positions.
> Hence you cannot enable wakeup mode while suspending, as the proper
> system suspend/resume procedure is:
>   1. Enable backup mode in the PMIC,
>   2. Switch ACC off (no-op as backup mode has been enabled),
>   3. Suspend to RAM (PSCI suspend) => system suspends,
>   4. Switch ACC on => system wakes up.
> If you would combine steps 1 and 3, you can no longer do step 2 in between.

> Yes, it's complicated :-(

I'm confused, I thought this was a physical switch but that's talking
about this as something software controlled (at least in step 2)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/118e68a0/attachment-0001.sig>
