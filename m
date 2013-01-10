From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Jan 2013 09:44:44 +0000
Subject: [PATCHv2 0/4] clockevents: decouple broadcast mechanism from
 drivers
In-Reply-To: <50EDD71A.5030406@codeaurora.org>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
 <50EDD71A.5030406@codeaurora.org>
Message-ID: <20130110094435.GA17741@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 08:46:18PM +0000, Stephen Boyd wrote:
> On 01/09/13 06:46, Mark Rutland wrote:
> > This is an updated version of the series I posted back in December:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137929.html
> >
> > Changes since v1:
> > * Drop removal of guards in smp.c
> > * Removed useless evt->evt_handler check in tick_receive_broadcast
> > * Fix up tick_receive_broadcast when !GENERIC_CLOCKEVENTS_BROADCAST
> > * Fix checkpatch issues (multi-line strings)
> >
> > Thanks go to Stephen Boyd and Santosh Shilimkar for their commments.
> >
> > In some SMP systems, cpu-local timers may stop delivering interrupts
> > when in low power states, or not all CPUs may have local timers. To
> > support these systems we have a mechanism for broadcasting timer ticks
> > to other CPUs. This mechanism relies on the struct
> > clock_event_device::broadcast function pointer, which is a
> > driver-specific mechanism for broadcasting ticks to other CPUs.
> >
> > As the broadcast mechanism is architecture-specific, placing the
> > broadcast function on struct clock_event_device ties each driver to a
> > single architecture. Additionally the driver or architecture backend
> > must handle the routing of broadcast ticks to the correct
> > clock_event_device, leading to duplication of the list of active
> > clock_event_devices.
> >
> > These patches introduce a generic mechanism for handling the receipt of
> > timer broadcasts, and an optional architecture-specific broadcast
> > function which allows drivers to be decoupled from a particular
> > architecture will retaining support for timer tick broadcasts. These
> > mechanisms are wired up for the arm port, and have been boot-tested on a
> > pandaboard.
> >
> 
> For the series:
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks!

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> 
> 

Mark.
