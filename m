From: slash.tmp@free.fr (Mason)
Date: Mon, 17 Jul 2017 23:22:37 +0200
Subject: [RFC PATCH v3] irqchip: Add support for tango interrupt router
In-Reply-To: <9f384711-eef0-5117-b89c-9d2dc16e5ae5@free.fr>
References: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
 <20170606175219.34ef62b9@free-electrons.com>
 <d8a4d8ad-a9f3-07eb-9e2a-a4bbec01961e@free.fr>
 <dfb86360-2247-65bb-602b-5c21029709fd@free.fr>
 <c0bd235a-9035-2002-31eb-e68710b076fd@free.fr>
 <24f34220-a017-f4e0-b72e-d1fdb014c0e1@free.fr>
 <9f384711-eef0-5117-b89c-9d2dc16e5ae5@free.fr>
Message-ID: <afcc2b79-61ff-b54d-eac1-ea7f3ee6b6b2@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/2017 17:36, Mason wrote:

> This controller maps 128 input lines to 24 output lines.
> The output lines are routed to GIC SPI 0 to 23.
> This driver muxes LEVEL_HIGH IRQs onto output line 0,
> and gives every EDGE_RISING IRQ a dedicated output line.
> ---
> I think the driver is mostly finished. It works without
> errors for my basic use-cases.

I spotted a problem. Output lines are allocated
for edge interrupts in tango_set_type() but they
are never released. So if we insmod/rmmod modules
in a loop, we will run out of output lines.

It seems set_type() is not the right place for an
allocation. Perhaps that should be done in tango_map()?

I'll try to trace the code to figure out when the
unmap function is called, as well.

> There is one required feature missing:
> suspend/resume support.
> Should it be a separate patch, or just squashed
> into this patch?

That question still stands.

Regards.
