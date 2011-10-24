From: sebras@gmail.com (Sebastian Rasmussen)
Date: Mon, 24 Oct 2011 11:11:28 +0200
Subject: [PATCH] mmc: mmci: Improve runtime PM support
In-Reply-To: <4EA51C4A.7040802@stericsson.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<4EA51C4A.7040802@stericsson.com>
Message-ID: <CAAgDR1MxvhXKwDoBMZF44gJXTigWNDQCkZXsueAqUxw4Rf5fkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> If the ARM PL180 TRM prevent us from from doing this kind of operations in
> runtime_suspend, we must think of an alternative solution which just apply
> for ST-Ericssons derivative of PL180. THIS IS VERY IMPORTANT to be able to
> implement a proper power management solution.

I believe that what it boils down to is how the power regulators are controlled.

In ST-Ericssons PL180 derivative there must be two independent regulators,
controlled by something outside the PL180 itself, one for the controller and
one for the external card. So if you know what you are doing you can power
down the controller while still keeping the card powered.

In the case of ARM PL180 it seems to me as if there is one power regulator,
controlled by something outside the PL180, that supplies power to the
controller, and one power regulator, controlled by the PL180, that supplies
power to the card. Therefore it is simply not possible to clear the ARM
PL180s MCIPower register (because that means that the card will loose
power since the control signals to the card's power regulator are now asking
it to cut power to the card). In addition I believe that it may not be
possible to
power the controller down...

 / Sebastian
