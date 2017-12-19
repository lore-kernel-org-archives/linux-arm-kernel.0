From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Dec 2017 11:42:59 +0000
Subject: [PATCH] drm/rockchip: analogix_dp: Ensure that the bridge is
 powered before poking it
In-Reply-To: <5842af4d-8dc0-d7bf-8eef-991656b71f49@samsung.com>
References: <20171218112831.7990-1-marc.zyngier@arm.com>
 <CGME20171219075600eucas1p1b740ca3c833ee90a2680d4b03891f6f2@eucas1p1.samsung.com>
 <5842af4d-8dc0-d7bf-8eef-991656b71f49@samsung.com>
Message-ID: <17fd8819-2771-7dd2-03c1-ba23326961d8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/12/17 07:55, Andrzej Hajda wrote:
> On 18.12.2017 12:28, Marc Zyngier wrote:
>> Stopping the X display manager on a kevin platform results in the
>> following crash:
>>
>> [  674.833536] Synchronous External Abort: synchronous external abort (0x96000010) at 0xffff00000c970640
>> [  674.843886] Internal error: : 96000010 [#1] PREEMPT SMP
>> [  674.849744] Modules linked in:
>> [  674.849755] CPU: 1 PID: 86 Comm: kworker/1:1 Not tainted 4.15.0-rc3-00057-gff24f8cf492d-dirty #3
>> [  674.849760] detected fb_set_par error, error code: -16
>> [  674.849761] Hardware name: Google Kevin (DT)
>> [  674.849773] Workqueue: events analogix_dp_psr_work
>> [  674.849778] pstate: 60000005 (nZCv daif -PAN -UAO)
>> [  674.849784] pc : analogix_dp_send_psr_spd+0x8/0x168
>> [  674.849788] lr : analogix_dp_enable_psr+0x54/0x60
>> [  674.849789] sp : ffff000009b2bd60
>> [  674.849790] x29: ffff000009b2bd60 x28: 0000000000000000
>> [  674.849794] x27: ffff000009913d20 x26: ffff00000900fbf0
>> [  674.849797] x25: ffff8000f1b30000 x24: ffff8000f0c21d98
>> [  674.849800] x23: 0000000000000000 x22: ffff8000f7d3aa00
>> [  674.849803] x21: ffff8000f7d36980 x20: ffff8000f0c21c18
>> [  674.849806] x19: ffff8000f0c21db8 x18: 0000000000000001
>> [  674.849809] x17: 0000ffff89f2ed58 x16: ffff000008222908
>> [  674.849812] x15: 0000000000000000 x14: 0000000000000400
>> [  674.849815] x13: 0000000000000400 x12: 0000000000000000
>> [  674.849817] x11: 0000000000001414 x10: 0000000000000a00
>> [  674.849820] x9 : ffff000009b2bbb0 x8 : ffff8000f1b30a60
>> [  674.849823] x7 : 0000000000080000 x6 : 0000000000000001
>> [  674.849826] x5 : 0000000000000010 x4 : 0000000000000007
>> [  674.849829] x3 : 0000000000000002 x2 : ffff00000c970640
>> [  674.849832] x1 : ffff000009b2bd78 x0 : ffff8000f1624018
>> [  674.849836] Process kworker/1:1 (pid: 86, stack limit = 0x0000000083e5f7c3)
>> [  674.849838] Call trace:
>> [  674.849842]  analogix_dp_send_psr_spd+0x8/0x168
>> [  674.849844]  analogix_dp_psr_work+0x9c/0xa0
>> [  674.849849]  process_one_work+0x1cc/0x328
>> [  674.849852]  worker_thread+0x50/0x450
>> [  674.849856]  kthread+0xf8/0x128
>> [  674.849860]  ret_from_fork+0x10/0x18
>> [  674.849864] Code: b9000001 d65f03c0 f9445802 91190042 (b9400042)
>>
>> Further investigation show that this happens because the the workqueue
>> races with the analogix_dp_bridge_disable() call from the core DRM code,
>> and end up trying to write to the DP bridge that has already been powered
>> down. This result is a very black screen, and a hard reset.
>>
>> Instead of counting on luck to keep the bridge alive, let's use the
>> pm_runtime framework and take a reference on the device when we're about
>> to poke it. That is a fairly big hammer, but one that allows the system
>> to stay alive across dozens of X start/stop sequences.
> 
> Wouldn't be better to cancel the work in analogix_dp_bridge_disable, it
> looks safer.

Not sure. That would only cancel a single work that would be in flight
right when we hit disable, but won't prevent the work from being queued
right after the cancel.

In summary, I think you're trading a race between pm_runtime_put_sync
and analogix_dp_send_psr_spd for another between cancel_work_sync and
analogix_dp_send_psr_spd. Also, I seem to remember that the disable can
occur in its own work queue:

commit_tail -> drm_atomic_helper_commit_modeset_disables ->
disable_outputs -> drm_bridge_disable -> analogix_dp_bridge_disable

making it racy by nature. But I'm no DRM expert (as you can probably tell).

My approach is to guarantee that analogix_dp_send_psr_spd cannot fault
due to the IP being powered off, which feels a bit more bullet proof.

Please shoot me down if I got it wrong!

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
