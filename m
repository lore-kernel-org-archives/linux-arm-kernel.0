From: lost.distance@yahoo.com (Paul Parsons)
Date: Sun, 15 May 2011 00:20:17 +0100 (BST)
Subject: [PATCH] pxa/hx4700: Avoid unbalanced irq wakeup enables/disables
In-Reply-To: <20110514211305.GB16305@rainbow>
Message-ID: <55815.35947.qm@web29005.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

> Well, you right here - GPIO94 and GPIO99 can't be enabled
> as wake-up
> sources in PWER on PXA270. But they can be enabled in PKWR,
> according to
> section 3.8.1.15 of PXA27x Developer's Manual. And there's
> a proof: WinCE
> happily wakes on MAIL/CONTACTS presses. Though probably
> these pins will
> need some configuration in MFP table to work as wake-up
> sources...

Ah, another wake-up enable register; I missed that! Yes, that should work via tweaks to the MFP table.

> Anyway, I have no strong opinion about whether to disable
> just ASIC3
> buttons, or to leave only POWER as wakeup source. So I
> think your patch is
> fine as the solution to unbalanced irq wakeup problem and
> may go in, unless
> Philipp or Eric have objections.

My feeling is that it should be all or nothing; we either get all other 5 buttons working as wake-ups or we disable them. Perhaps Russell's comments are the clincher.

While on the subject, it turns out that the reset button (= GPIO reset) also acts as a wake-up on my unit. But the PXA27x manual says this:

"In standby, sleep, and deep-sleep modes, GPIO reset is first treated as a wake-up event."

Does this mean that both the SMR and GPR bits the RCSR register are set? And if so, does the bootloader then decide whether to wake-up the unit or whether to reset it?

Regards,
Paul
