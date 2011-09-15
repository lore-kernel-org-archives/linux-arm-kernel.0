From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Thu, 15 Sep 2011 13:29:32 +0000
Subject: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
In-Reply-To: <CAMQu2gy0VX5wQVJRjpjMwtNqM5h2Te4FtoFnyZfphFyP+uSXmQ@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
	<20110913203616.GG24252@atomide.com>
	<CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
	<20110914152116.GM24252@atomide.com> <4E70DB33.5070501@ti.com>
	<20110914170803.GN24252@atomide.com> <4E70E0CC.80300@ti.com>
	<20110914171800.GO24252@atomide.com> <4E70E2DE.2030006@ti.com>
	<4E71C702.40206@ti.com>
	<CAMQu2gy0VX5wQVJRjpjMwtNqM5h2Te4FtoFnyZfphFyP+uSXmQ@mail.gmail.com>
Message-ID: <EF62F09C0797D947AD4180A1043C0DF7E7E202@DFLE31.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Shilimkar, Santosh
> Sent: Thursday, September 15, 2011 7:02 AM

> >> You missed my point in the description. Clockdomain inactive
> >> doesn't depend on idle or WFI execution. Under HW supervison
> >> CPU clock domain can get into inactive when CPU is stalled and
> >> waiting for a read response from slow interconnect.

My understanding is MPSS global clock domain can not gate unless each cpu is in wfi and other conditions are met.  Other conditions are a wugen ack that there are no irqs and ocp-bridge logic giving its ok.

What kind of local clock gating is there per cpu or sub-clock domains is not as clear.  The mpu's pivot on individual wfi while other blocks in mpuss have other considerations.

The spec is very clear about coherent programmation of wugen and gic.  Like being discussed.

Its examples are about how wugen used I've heard about are around transition in and out of standbys at wfi.  Wugen will process all irqs before giving ack to sleep, it also has ability to fail sleep if new irqs come in before final idle.

* It may be possible depending on clarifications to handle near wfi, but you might have to do it for -every- cpu's wfi unless you can coordinate who the last one is.  Doing it as you go with gic would avoid redoing work over and over at the many wfi calls.  This extra work costs in latency and power.

Doing housekeeping along with gic seems better from a run time perspective.

Regards,
Richard W.
