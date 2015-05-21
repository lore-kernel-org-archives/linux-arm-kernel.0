From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 May 2015 11:20:12 +0100
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <555DABC4.2000407@free.fr>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <20150520201438.GW2067@n2100.arm.linux.org.uk>
 <555CF17D.4060500@free.fr> <76003699.Oyq777txnm@wuerfel>
 <555D030F.8030100@free.fr>
 <20150520231443.GB2067@n2100.arm.linux.org.uk>
 <555DABC4.2000407@free.fr>
Message-ID: <20150521102011.GD2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 11:56:20AM +0200, Mason wrote:
> On 21/05/2015 01:14, Russell King - ARM Linux wrote:
> 
> Do you ever sleep? :-)

Yes, normally between about midnight-1am until 9am London time.  All
other hours are normally spent trying to keep up with the email deluge
(which gives me no satisfication what so ever, it feels like I haven't
achieved anything) or trying to get some real practical work done.

> Sorry, my limitations are showing... Take mach-ux500 for example.
> Did it provide a global timer at the time?

Yes.

> $ git checkout 5388a6b266
> $ git grep clock.*event arch/arm/mach-ux500
> arch/arm/mach-ux500/localtimer.c: * Setup the local clock events for a CPU.
> arch/arm/mach-ux500/localtimer.c:void __cpuinit local_timer_setup(struct clock_event_device *evt)

I have to wonder wtf you are trying to prove me wrong... in any case,
your "example" is too short-sighted to be meaningful.  If you want to
try and find an example, you have to read the code, and follow the code
paths.  Let's take your example of ux500.

$ git diff -u 5388a6b266.. -- arch/arm/mach-ux500 arch/arm/plat-nomadik

and search the output of that.  What you'll find is that ux500 has:

-MACHINE_START(U8500, "ST-Ericsson U5500 Platform")
-       .timer          = &ux500_timer,

-struct sys_timer ux500_timer = {
-       .init   = ux500_timer_init,
-};

and tracing this code...

-static void __init ux500_timer_init(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
-       /* Setup the local timer base */
-       twd_base = __io_address(UX500_TWD_BASE);
-#endif
-       /* Setup the MTU base */
-       if (cpu_is_u8500ed())
-               mtu_base = __io_address(U8500_MTU0_BASE_ED);
-       else
-               mtu_base = __io_address(UX500_MTU0_BASE);
-
-       nmdk_timer_init();
 }

Now, nmdk_timer_init() is in arch/arm/plat-nomadik/timer.c, and that
sets up the clocksouce for timekeeping, and the global clock event.
I'll let you read that code.

> I downloaded gmane's NNTP archive for linux-arm-kernel (415000 message),
> going back to 2002.
> 
> $ grep alpine.LFD.2.00.1004171152080.3625@ gmane.linux.ports.arm.kernel.msf
> $ grep -i "SMP Local timer and power management" gmane.linux.ports.arm.kernel.msf
> 
> No hits using gmane's search interface either.

Yea, sorry, those messages weren't on a mailing list, but were a private
discussion between Thomas, Catalin, Santosh and others.  As it's private,
it can't be published without the consent of everyone involved.  As people
would have been talking on behalf of their companies, and they have moved
on, it's highly unlikely that the people could give consent now.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
