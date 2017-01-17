From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 17 Jan 2017 08:58:58 +0100
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 (Jan Kiszka's message of "Mon, 16 Jan 2017 19:44:55 +0100")
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
Message-ID: <87vatedsn1.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> When using the a device with edge-triggered interrupts, such as MSIs,
> the interrupt handler has to ensure that there is a point in time during
> its execution where all interrupts sources are silent so that a new
> event can trigger a new interrupt again.
>
> This is achieved here by looping over SSSR evaluation. We need to take
> into account that SSCR1 may be changed by the transfer handler, thus we
> need to redo the mask calculation, at least regarding the volatile
> interrupt enable bit (TIE).

I'd like moreover to add a question here.

In pxa architecture, SPI interrupts are already edge-triggered, and it's working
well. The interrupt source disabling is not disabled, but the interrupt
controller doesn't trigger an interrupt anymore (as it is masked), yet it marks
it as pending if an interrupt arrives while the interrupt handler is running.

All of this is handled by the interrupt core. My question is why for Intel MSI's
is it necessary to make a change in the driver instead or relying on the
interrupt core as for the pxa ?

Cheers.

--
Robert
