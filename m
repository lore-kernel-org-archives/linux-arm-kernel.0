From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 19 Aug 2013 16:30:36 -0700
Subject: Enable arm_global_timer for Zynq brakes boot
In-Reply-To: <5212A394.5020109@codeaurora.org>
References: <5204FA5D.3060908@linaro.org>
 <20130809172757.GD14845@codeaurora.org>
 <c1e112a3-cfed-4e53-951e-b1a9208d7dc8@TX2EHSMHS038.ehs.local>
 <52090B43.9090000@codeaurora.org>
 <d36fc2db-1189-4c6a-9bc4-0ac2e29eaa1b@AM1EHSMHS009.ehs.local>
 <5209120D.1010701@linaro.org>
 <9b07d8a3-b650-4147-b952-9bcfc1172c51@VA3EHSMHS025.ehs.local>
 <5209152F.5020307@linaro.org>
 <86b18b0d-08e1-4899-86ea-ed22d3d36dee@DB8EHSMHS028.ehs.local>
 <5212A394.5020109@codeaurora.org>
Message-ID: <140fc91a-cc81-418e-8a5e-413bbf47834e@CO1EHSMHS025.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Aug 19, 2013 at 04:00:36PM -0700, Stephen Boyd wrote:
> On 08/16/13 10:28, S?ren Brinkmann wrote:
> > On Mon, Aug 12, 2013 at 07:02:39PM +0200, Daniel Lezcano wrote:
> >> On 08/12/2013 06:53 PM, S?ren Brinkmann wrote:
> >>> It's actually present. I have a clean 3.11-rc3 and the only changes are
> >>> my patch to enable the GT and Stephen's fix.
> >>> The cpuidle stats show both idle states being used.
> >> Ah, right. The tick_broadcast_mask is not set because the arm global
> >> timer has not the CLOCK_EVT_FEAT_C3STOP feature flag set.
> > Just to check in. Do you want any additional testing done? Or can I
> > expect Stephens fix to get merged, so Zynq can use the GT?
> >
> 
> I was curious, can you use just the first hunk of the patch that applied
> to tick-broadcast.c to fix the problem? I think the answer is yes.

Yes, that seems to be enough.

# cat /proc/interrupts 
           CPU0       CPU1       
 27:         14          1       GIC  27  gt
 29:        664        759       GIC  29  twd
 43:        725          0       GIC  43  ttc_clockevent
 82:        214          0       GIC  82  xuartps
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0         58  Timer broadcast interrupts
IPI2:       1224       1120  Rescheduling interrupts
IPI3:          0          0  Function call interrupts
IPI4:         44         50  Single function call interrupts
IPI5:          0          0  CPU stop interrupts
Err:          0

Timer list:
Tick Device: mode:     1
Broadcast device
Clock Event Device: ttc_clockevent
 max_delta_ns:   1207932479
 min_delta_ns:   18432
 mult:           233015
 shift:          32
 mode:           3
 next_event:     60080000000 nsecs
 set_next_event: ttc_set_next_event
 set_mode:       ttc_set_mode
 event_handler:  tick_handle_oneshot_broadcast
 retries:        0

tick_broadcast_mask: 00000003
tick_broadcast_oneshot_mask: 00000000

Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: local_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           3
 next_event:     59075238755 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0

Tick Device: mode:     1
Per CPU device: 1
Clock Event Device: local_timer
 max_delta_ns:   12884902005
 min_delta_ns:   1000
 mult:           715827876
 shift:          31
 mode:           3
 next_event:     59080000000 nsecs
 set_next_event: twd_set_next_event
 set_mode:       twd_set_mode
 event_handler:  hrtimer_interrupt
 retries:        0


	S?ren
