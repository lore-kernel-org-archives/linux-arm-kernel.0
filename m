From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 12 May 2015 22:24:49 +0200
Subject: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
In-Reply-To: <87lhgumi4b.fsf@belgarion.home> (Robert Jarzmik's message of
 "Tue, 12 May 2015 08:20:52 +0200")
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
 <1431384089-28367-2-git-send-email-robh@kernel.org>
 <20150511224934.GL2067@n2100.arm.linux.org.uk>
 <CAL_Jsq+tNStipTDRH05XRHVDz30B8w92YTD1ZKUTrCp-Lj7=1w@mail.gmail.com>
 <87lhgumi4b.fsf@belgarion.home>
Message-ID: <878uctmtm6.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Rob Herring <robh@kernel.org> writes:
>
>>> This really isn't a good idea - what do you think happens when
>>> the same struct resource gets passed into insert_resource()
>>> twice?
>>
>> Bad things. If you recall, we discussed this on v1[1]. See the commit
>> msg of patch 2 for the summary. There is not currently a problem
>> because the rtc-pxa driver does not request the resource.
>
> I think you're talking about resource claiming, while Russell is talking about
> resource declaration.
>
> The point Russell is raising is if you do a platform_add_device() twice with the
> same resource (which is done in pxa, once for sa1100-rtc, once for pxa-rtc), you
> call insert_resource() twice with the same resource structure.
>
> I had not thought of that before (that's in my reply noted "nasty consequences"
> in [1]), and I'll do my homework this week, and try this only patch, but if I
> follow Russell's thinking, then sa1100-rtc and pxa-rtc cannot be declared
> together anymore.

I made the try, and Russell was right, this breaks the pxa architecture. The
relevant extract of kernel message is in [1].

The consequences with your patches :
 - pxa27x_init()
   - platform_add_devices()
     - the pxa_device_rtc fails (as resource is duplicated)
     - all the devices are unregistered (rollback)
And pxa27x fails.

Now I'm pondering about the right approach :
 - either remove sa1100_device_rtc from pxas
 - or remove pxa_device_rtc
 - or both
 - or something else

Let me think a bit about it.

-- 
Robert

[1]
2015/05/12  22:12:57  ------------[ cut here ]------------
2015/05/12  22:12:57  WARNING: CPU: 0 PID: 1 at kernel/resource.c:755 __insert_resource+0x74/0x134()
2015/05/12  22:12:57  Modules linked in:
2015/05/12  22:12:57  CPU: 0 PID: 1 Comm: swapper Tainted: G        W       4.0.0-00004-g7fa5ed0 #528
2015/05/12  22:12:57  Hardware name: Intel HCDDBBVA0 Development Platform (aka Mainstone)
2015/05/12  22:12:57  [<c000e170>] (unwind_backtrace) from [<c000c064>] (show_stack+0x10/0x14)
2015/05/12  22:12:57  [<c000c064>] (show_stack) from [<c00176b0>] (warn_slowpath_common+0x7c/0xb4)
2015/05/12  22:12:57  [<c00176b0>] (warn_slowpath_common) from [<c0017784>] (warn_slowpath_null+0x1c/0x24)
2015/05/12  22:12:57  [<c0017784>] (warn_slowpath_null) from [<c001ada4>] (__insert_resource+0x74/0x134)
2015/05/12  22:12:57  [<c001ada4>] (__insert_resource) from [<c001bfd4>] (insert_resource_conflict+0x20/0x60)
2015/05/12  22:12:57  [<c001bfd4>] (insert_resource_conflict) from [<c001c01c>] (insert_resource+0x8/0x18)
2015/05/12  22:12:57  [<c001c01c>] (insert_resource) from [<c0207a7c>] (platform_device_add+0x88/0x254)
2015/05/12  22:12:57  [<c0207a7c>] (platform_device_add) from [<c02082c4>] (platform_add_devices+0x34/0x70)
2015/05/12  22:12:57  [<c02082c4>] (platform_add_devices) from [<c00088e0>] (do_one_initcall+0xa8/0x204)
2015/05/12  22:12:58  [<c00088e0>] (do_one_initcall) from [<c050dd6c>] (kernel_init_freeable+0xf4/0x1b4)
2015/05/12  22:12:58  [<c050dd6c>] (kernel_init_freeable) from [<c03b5a9c>] (kernel_init+0x8/0xec)
2015/05/12  22:12:58  [<c03b5a9c>] (kernel_init) from [<c0009698>] (ret_from_fork+0x14/0x3c)
2015/05/12  22:12:58  ---[ end trace cb88537fdc8fa201 ]---
2015/05/12  22:12:58  platform pxa-rtc: failed to claim resource 0
