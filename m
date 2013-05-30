From: hector.palacios@digi.com (Hector Palacios)
Date: Thu, 30 May 2013 18:17:47 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <20130529075044.GC3293@lukather>
References: <51A5A808.2070803@digi.com>
 <F281D0F91ED19E4D8E63A7504E8A649803E8A3F3@039-SN2MPN1-021.039d.mgd.msft.net>
 <20130529075044.GC3293@lukather>
Message-ID: <51A77BAB.4060101@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime,

On 05/29/2013 09:50 AM, maxime.ripard at free-electrons.com wrote:
> Hi,
>
> On Wed, May 29, 2013 at 07:11:30AM +0000, Chen Peter-B29397 wrote:
>>
>>> Hello,
>>>
>>> Am I right in assuming that the MXS USB on-the-go port does not currently
>>> support the
>>> device (gadget) functionality?
>>> Anybody out there working on that?
>>>
>>
>> As far as I know, Maxime Ripard may already let the chipidea durl-role function
>> work ok at mx28. It may need my chipidea otg patch
>>
>> https://github.com/hzpeterchen/linux-usb.git
>
> Indeed, I've been using the patchset "Add tested id switch and vbus
> connect detect support for Chipidea" from Peter for quite some time on
> top of 3.9 and it works like a charm for the gadget mode on an MX28
> platform.
>
> BTW, Peter, I've seen that these patches are still not merged in 3.10,
> is there a reason for that? do you plan on sending a version rebased on
> top of 3.10 some time in the future? I tried to do the rebasing myself,
> but the chipidea driver seems to have changed quite heavily, which makes
> the process quite difficult when you don't know what you're doing :)

I guess you didn't get rid of the 'possible circular locking dependency' you talked 
about at [1], right? I experimented the same and also a BUG [2] after cable reconnection.
Despite those, I ran a simple test of serial, ethernet, and mass_storage gadgets and 
they worked fine.

I didn't use the new properties (phy_type, dr_mode...) in the DT of my mx28 platform, 
did you?

[1] https://lkml.org/lkml/2013/3/6/200

[2]
[ 1949.074726] BUG: spinlock lockup suspected on CPU#0, swapper/0
[ 1949.080623]  lock: 0xcf41f014, .magic: dead4ead, .owner: swapper/0, .owner_cpu: 0
[ 1949.088184] [<c001510c>] (unwind_backtrace+0x0/0xf4) from [<c0273754>] 
(do_raw_spin_lock+0x104/0x14c)
[ 1949.097463] [<c0273754>] (do_raw_spin_lock+0x104/0x14c) from [<c045893c>] 
(_raw_spin_lock_irqsave+0x50/0x5c)
[ 1949.107340] [<c045893c>] (_raw_spin_lock_irqsave+0x50/0x5c) from [<c03467f8>] 
(ep_disable+0x30/0xfc)
[ 1949.116541] [<c03467f8>] (ep_disable+0x30/0xfc) from [<bf00a19c>] 
(gserial_disconnect+0x9c/0x174 [g_serial])
[ 1949.126447] [<bf00a19c>] (gserial_disconnect+0x9c/0x174 [g_serial]) from 
[<bf00a288>] (acm_disable+0xc/0x2c [g_serial])
[ 1949.137325] [<bf00a288>] (acm_disable+0xc/0x2c [g_serial]) from [<bf000930>] 
(reset_config+0x34/0x5c [libcomposite])
[ 1949.147931] [<bf000930>] (reset_config+0x34/0x5c [libcomposite]) from [<bf000fd0>] 
(composite_disconnect+0x34/0x5c [libcomposite])
[ 1949.159737] [<bf000fd0>] (composite_disconnect+0x34/0x5c [libcomposite]) from 
[<c0347b14>] (udc_irq+0x1d8/0xbe4)
[ 1949.169951] [<c0347b14>] (udc_irq+0x1d8/0xbe4) from [<c0345830>] (ci_irq+0x9c/0x104)
[ 1949.177751] [<c0345830>] (ci_irq+0x9c/0x104) from [<c006cb50>] 
(handle_irq_event_percpu+0x5c/0x26c)
[ 1949.186847] [<c006cb50>] (handle_irq_event_percpu+0x5c/0x26c) from [<c006cd9c>] 
(handle_irq_event+0x3c/0x5c)
[ 1949.196716] [<c006cd9c>] (handle_irq_event+0x3c/0x5c) from [<c006f3c8>] 
(handle_level_irq+0x8c/0x118)
[ 1949.205976] [<c006f3c8>] (handle_level_irq+0x8c/0x118) from [<c006cae4>] 
(generic_handle_irq+0x28/0x30)
[ 1949.215421] [<c006cae4>] (generic_handle_irq+0x28/0x30) from [<c001009c>] 
(handle_IRQ+0x30/0x84)
[ 1949.224246] [<c001009c>] (handle_IRQ+0x30/0x84) from [<c00086ec>] 
(icoll_handle_irq+0x30/0x44)
[ 1949.232897] [<c00086ec>] (icoll_handle_irq+0x30/0x44) from [<c000ee24>] 
(__irq_svc+0x44/0x54)
[ 1949.241438] Exception stack(0xc0627f68 to 0xc0627fb0)
[ 1949.246520] 7f60:                   c0010278 0005317f 0005217f 60000013 c0626000 
c0667c88
[ 1949.254729] 7f80: c0631980 7fffffff 40004000 41069265 4061c574 00000000 600000d3 
c0627fb0
[ 1949.262926] 7fa0: c0010278 c0010284 60000013 ffffffff
[ 1949.268023] [<c000ee24>] (__irq_svc+0x44/0x54) from [<c0010284>] 
(default_idle+0x40/0x48)
[ 1949.276244] [<c0010284>] (default_idle+0x40/0x48) from [<c00105b8>] 
(cpu_idle+0x68/0xd0)
[ 1949.284380] [<c00105b8>] (cpu_idle+0x68/0xd0) from [<c0600810>] 
(start_kernel+0x258/0x298)
[ 1953.034550]  gadget: high-speed config #2: CDC ACM config

Regards,
--
H?ctor Palacios
