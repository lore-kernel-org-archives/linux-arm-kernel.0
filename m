From: xiechao.linux@gmail.com (chao xie)
Date: Tue, 19 Jun 2012 09:39:05 +0800
Subject: pm runtime and system suspend resume
Message-ID: <CAK9wHMQ7ZLtMTfBKWOb4A8wmjP9EQV8gA_moh5dXxvU0-b-vMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi
PM_RUNTIME provide a way for device driver do runtime PM. so for some
devices, they have some surrounded logic. For example, the device may
get clock from outside, or it need PHY support(USB is a example).
To get these dependency out of device driver, i define a struct
dev_pm_domain, and make dev.pm_domain point to it. So in the device
driver, when the hardware should be enabled, we can call
pm_runtime_get_sync while when the hardware is idle or does not work,
we can call pm_runtime_put_sync.
It seems work well, but i have question about the suspend/resume of
device. When the whole system will go to deep idle, and it will
suspend the devices. for the function do device suspend
__device_suspend, it will call pm_runtime_get_noresume(dev). As i
think it will make the device not do runtime suspend any more. Is that
correct?
There is the question, how device driver handle the logic surrounds
it? I want to add pm_runtime_put_sync in dev->driver->pm->suspend
function, and pm_runtime_get_sync in dev->driver->pm->resume. Because
__device_suspend increase the usage_count, pm_runtime_put_sync will
not do real work.
So is that right that i directly call pm_runtime_suspend in
dev->driver->pm->suspend and pm_runtime_resume in
dev->driver->pm->resume?
Thanks.
