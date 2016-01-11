From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Jan 2016 12:35:28 -0200
Subject: [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain
In-Reply-To: <CAAObsKC1jTzLWmMtwGWVStuMtzZwvMuA_731dsn4YX7aKMtFKQ@mail.gmail.com>
References: <1445956731-6304-1-git-send-email-tomeu.vizoso@collabora.com>
 <1445956731-6304-3-git-send-email-tomeu.vizoso@collabora.com>
 <CAGS+omBMJXOgsd2x9agtt7yi-y+EPgHWSTr7B3JqbN9Hg_2W5A@mail.gmail.com>
 <CAAObsKC1jTzLWmMtwGWVStuMtzZwvMuA_731dsn4YX7aKMtFKQ@mail.gmail.com>
Message-ID: <CAOMZO5A7p6iZTdnZtnzMPED1e7rPp=1Q9UiZ_598QNTWSL5jMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 12:47 PM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 10 November 2015 at 10:33, Daniel Kurtz <djkurtz@chromium.org> wrote:
> [snip]
>>
>> The problem appears to be that:
>>   * On boot, platform_drv_probe() calls dev_pm_domain_attach() before
>> drv->probe(); thus, it calls dev_pm_domain_attach() while the device
>> is unbound.
>>
>>  * However, for a platform_device, the reboot path calls
>> device_shutdown(), but not __device_release_driver():
>> device_shutdown()
>>   dev->driver->shutdown => platform_drv_shutdown()
>>     dev_pm_domain_detach()
>>        dev->pm_domain->detach() => genpd_dev_pm_detach()
>>          pm_genpd_remove_device()
>>             dev_pm_domain_set(dev, NULL);
>>
>> So, for a platform_device in a genpd power domain with .shutdown
>> installed, platform_drv_shutdown() calls dev_pm_domain_detach() while
>> the device is still bound, which triggers the WARN().
>
> Hi Rafael, Alan and Ulf,
>
> do you have any suggestion about this? I don't really understand why
> the device is detached from the domain on shutdown.

I am running linux-next and this commit causes the same problem for me
on a mx6 after running a 'reboot' command:

Requesting system reboot
[   15.058782] ------------[ cut here ]------------
[   15.063459] WARNING: CPU: 3 PID: 1122 at
drivers/base/power/common.c:150 dev_pm_domain_set+0x4c/0x58()
[   15.072838] PM domains can only be changed for unbound devices
[   15.078735] Modules linked in:
[   15.081849] CPU: 3 PID: 1122 Comm: init Not tainted
4.4.0-rc8-next-20160111-dirty #207
[   15.089826] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   15.096375] Backtrace:
[   15.098941] [<c00136d8>] (dump_backtrace) from [<c0013874>]
(show_stack+0x18/0x1c)
[   15.106532]  r6:00000096 r5:00000000 r4:00000000 r3:00000000
[   15.112390] [<c001385c>] (show_stack) from [<c02de89c>]
(dump_stack+0x88/0xa4)
[   15.119708] [<c02de814>] (dump_stack) from [<c002bcac>]
(warn_slowpath_common+0x80/0xbc)
[   15.127860]  r5:c03da810 r4:ee63bd68
[   15.131533] [<c002bc2c>] (warn_slowpath_common) from [<c002bd8c>]
(warn_slowpath_fmt+0x38/0x40)
[   15.140292]  r8:eea01db0 r7:c0b0f87c r6:eea01d80 r5:00000000 r4:ef181410
[   15.147165] [<c002bd58>] (warn_slowpath_fmt) from [<c03da810>]
(dev_pm_domain_set+0x4c/0x58)
[   15.155661]  r3:c0b0f7f0 r2:c09e82dc
[   15.159373] [<c03da7c4>] (dev_pm_domain_set) from [<c03e4e5c>]
(genpd_free_dev_data+0x20/0x50)
[   15.168065]  r5:ef1814a0 r4:ef181410
[   15.171737] [<c03e4e3c>] (genpd_free_dev_data) from [<c03e5fe4>]
(pm_genpd_remove_device+0xb4/0xe0)
[   15.180842]  r6:ef181410 r5:eea01d80 r4:c0b0f7f0 r3:00000000
[   15.186644] [<c03e5f30>] (pm_genpd_remove_device) from [<c03e6040>]
(genpd_dev_pm_detach+0x30/0xac)
[   15.195743]  r8:c0b0f7f0 r7:c1379734 r6:00000001 r5:c0b209c4
r4:ef181410 r3:00000000
[   15.203694] [<c03e6010>] (genpd_dev_pm_detach) from [<c03da7c0>]
(dev_pm_domain_detach+0x28/0x2c)
[   15.212621]  r10:ef181444 r8:c0b6f560 r7:c1379734 r6:ef181410
r5:ef173c10 r4:ef181410
[   15.220683] [<c03da798>] (dev_pm_domain_detach) from [<c03d3ea0>]
(platform_drv_shutdown+0x34/0x38)
[   15.229817] [<c03d3e6c>] (platform_drv_shutdown) from [<c03d05b0>]
(device_shutdown+0x3c/0x194)
[   15.238579]  r4:ef18141c r3:c03d3e6c
[   15.242259] [<c03d0574>] (device_shutdown) from [<c004d51c>]
(kernel_restart_prepare+0x34/0x40)
[   15.251021]  r10:00000000 r8:c0010044 r7:00000000 r6:c0b120cc
r5:4321fedc r4:00000000
[   15.259065] [<c004d4e8>] (kernel_restart_prepare) from [<c004d724>]
(kernel_restart+0x14/0x58)
[   15.267760] [<c004d710>] (kernel_restart) from [<c004d948>]
(SyS_reboot+0x18c/0x1e4)
[   15.275526]  r4:01234567 r3:01234567
[   15.279242] [<c004d7bc>] (SyS_reboot) from [<c000fea0>]
(ret_fast_syscall+0x0/0x1c)
[   15.286920]  r7:00000058 r6:00000000 r5:00000000 r4:00000000
[   15.292754] ---[ end trace 3b419d3cbb367a11 ]---
