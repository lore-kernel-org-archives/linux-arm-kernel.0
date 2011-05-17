From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 17 May 2011 20:02:55 +0530
Subject: [RFC PATCH v2 00/12] Consolidating GIC per-cpu interrupts
In-Reply-To: <1305642091.30788.47.camel@e102391-lin.cambridge.arm.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>	
	<4DCD64FC.4090703@ti.com>
	<1305642091.30788.47.camel@e102391-lin.cambridge.arm.com>
Message-ID: <4DD28717.1090804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/17/2011 7:51 PM, Marc Zyngier wrote:
> Hi Santosh,
>
> On Fri, 2011-05-13 at 22:36 +0530, Santosh Shilimkar wrote:
>> Marc,
>>
>> On 5/6/2011 4:03 PM, Marc Zyngier wrote:
>>> The current GIC per-cpu interrupt (aka PPIs) suffers from a number of
>>> problems:
>>>
>>> - It uses a completely separate scheme to handle the interrupts,
>>>     mostly because the PPI concept doesn't really match the kernel view
>>>     of an interrupt.
>>> - Some low-level code gets duplicated, as usual...
>>> - At least one platform (msm) has started implementing its own
>>>     alternative scheme.
>>>
>>> The proposed solution is to let the GIC code expose the PPIs as
>>> something that the kernel can manage. Instead of having a single
>>> interrupt number shared on all cores, make the interrupt number be
>>> different on each CPU.
>>>
>>> This enables the use of the normal kernel API (request_irq() and
>>> friends) and the elimination of some low level code.
>>>
>>> This patch set is based on 2.6.39-rc6, and depends on Will Deacon's
>>> GIC fasteoi patches. Tested on VExpress, PB-11MP, Pandaboard and
>>> SMDK-S5PV310.
>>>
>>
>> Looks like, this series breaks system wide supsend. Please
>> check.
>
> Are you sure you're testing with v2? v1 is known to be broken with
> CPU_HOTPLUG, but v2 should deal with it. Here is a suspend/resume cycle
> on my Panda:
>
May be I tried V1 then. Will try your v2 tomorrow and let you know
