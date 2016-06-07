From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 7 Jun 2016 15:11:14 +0100
Subject: HDLCD crashes with 6d910bfa809e
In-Reply-To: <20160607133535.GA1165@e106497-lin.cambridge.arm.com>
References: <5756B8A8.8000902@arm.com>
 <20160607133535.GA1165@e106497-lin.cambridge.arm.com>
Message-ID: <5756D602.4090305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On 07/06/16 14:35, liviu.dudau at arm.com wrote:
> On Tue, Jun 07, 2016 at 01:06:00PM +0100, Robin Murphy wrote:
>> Having just inadvertently merged -next into my working branch, I find
>> dev6d910bfa809e ("drm/hlcd: Use lockless gem BO free callback") adversely
>> affecting my board's ability to boot ;)
>>
>> Since I (intentionally) don't have sufficient CMA to create a framebuffer,
>> drm_gem_cma_create() fails, unconditionally calls the now-NULL
>> drm->driver->gem_free_object() in its cleanup path, and fiery death
>> ensues...
>
> Thanks for reporting this. What other changes other than reducing the CMA
> allocation size do you have that I might need in order to reproduce this?

I've just confirmed a plain checkout of next-20160602, using arm64 
defconfig + DRM + HDLCD + TDA998X and CMA_SIZE_MBYTES=1, booted on a 
Juno, does the job:

[    3.032402] hdlcd 7ff60000.hdlcd: bound 0-0070 (ops tda998x_ops)
[    3.038388] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.044970] [drm] No driver support for vblank timestamp query.
[    3.076973] hdlcd 7ff60000.hdlcd: failed to allocate buffer with size 
7680000
[    3.084081] Bad mode in Synchronous Abort handler detected, code 
0x86000004 -- IABT (current EL)
[    3.092815] CPU: 3 PID: 6 Comm: kworker/u12:0 Not tainted 
4.7.0-rc1-next-20160602 #686
[    3.100682] Hardware name: ARM Juno development board (r1) (DT)
[    3.106567] Workqueue: deferwq deferred_probe_work_func
[    3.111761] task: ffff8009768a3e80 ti: ffff8009768e8000 task.ti: 
ffff8009768e8000
[    3.119198] PC is at 0x0
[    3.121720] LR is at drm_gem_cma_create+0x128/0x130
...and so on.

Today's -next, on the other hand, dodges the bullet entirely:

[    2.903645] [drm] found ARM HDLCD version r0p0
[    2.908122] hdlcd 7ff60000.hdlcd: master bind failed: -22
[    2.913505] tda998x: probe of 0-0070 failed with error -22
[    2.919141] [drm] found ARM HDLCD version r0p0
[    2.923609] hdlcd 7ff50000.hdlcd: master bind failed: -22
[    2.928991] tda998x: probe of 0-0071 failed with error -22

Oh well...

Robin.
