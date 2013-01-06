From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 06 Jan 2013 15:07:37 +0100
Subject: [PATCH] ARM: PXA27x: fix workaround for AC97 reset
In-Reply-To: <1357470761-14363-1-git-send-email-grinberg@compulab.co.il> (Igor
 Grinberg's message of "Sun, 6 Jan 2013 13:12:41 +0200")
References: <1357470761-14363-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <87fw2ebe1i.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg <grinberg@compulab.co.il> writes:

> Fix the workaround to a hardware bug in the AC97 controller of PXA27x.
> A bug in the controller's warm reset functionality requires that the MFP
> used by the controller as the AC97_RESET_n line be temporarily
> reconfigured as a GPIO (AF0) and manually held high for the duration of
> the warm reset cycle.
>
> The workaround was broken long ago by commit fb1bf8cd
> ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset()).
> The commit above changed the original workaround code in a way that
> changed the MFP to AF0 (GPIO), but forgot to drive the GPIO high output.
> This way, the GPIO state was left input (and undriven) and only worked
> for boards with external pullup on the line.
>
> Fix the above breakage by actually configurring the GPIO for output high
> in case of reset assert and returning it to default state
> (AF2 and GPDR - input) in case of reset deassert.

NAK.
If you return GPIO95 to AF-input, the GPIO95 will be "KP_DKIN<2>", ie. you'll
map a keyboard input to a AC97 reset.
As I said in a mail before, don't put a AC97 reset line as an input pin, this is
not a sensible patch.

Cheers.

--
Robert
