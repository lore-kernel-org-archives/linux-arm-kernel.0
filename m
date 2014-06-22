From: maz@misterjones.org (Marc Zyngier)
Date: Sun, 22 Jun 2014 12:25:02 +0100
Subject: [RFC PATCH 2/6] arm/arm64: KVM: Rename =?UTF-8?Q?irq=5Factive?=
 =?UTF-8?Q?=20to=20irq=5Fqueued?=
In-Reply-To: <1402779067-34478-3-git-send-email-christoffer.dall@linaro.org>
References: <1402779067-34478-1-git-send-email-christoffer.dall@linaro.org>
 <1402779067-34478-3-git-send-email-christoffer.dall@linaro.org>
Message-ID: <40b2b2cd240d39950a3aa98c53c36fad@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-06-14 21:51, Christoffer Dall wrote:
> We have a special bitmap on the distributor struct to keep track of 
> when
> level-triggered interrupts are queued on the list registers.  This 
> was
> named irq_active, which is confusing, because the active state of an
> interrupt as per the GIC spec is a different thing, not specifically
> related to edge-triggered/level-triggered configurations but rather
> indicates an interrupt which has been ack'ed but not yet eoi'ed.
>
> Rename the bitmap and the corresponding accessor functions to 
> irq_queued
> to clarify what this is actually used for.

While I agree that irq_active is confusing, I would tend to object to 
irq_queued for similar reasons. Edge interrupts get queued as well.

What this bit does is to allow or forbid resampling of a level 
interrupt.

How about irq_resample instead? That would mandate a small refactor of 
the code (a bit set to one would allow resampling, which is the opposite 
of the current logic), but would look better, I believe.

What do you think?

         M.
-- 
Who you jivin' with that Cosmik Debris?
