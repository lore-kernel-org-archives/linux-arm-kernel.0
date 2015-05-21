From: slash.tmp@free.fr (Mason)
Date: Thu, 21 May 2015 11:56:20 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <20150520231443.GB2067@n2100.arm.linux.org.uk>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <20150520201438.GW2067@n2100.arm.linux.org.uk> <555CF17D.4060500@free.fr>
 <76003699.Oyq777txnm@wuerfel> <555D030F.8030100@free.fr>
 <20150520231443.GB2067@n2100.arm.linux.org.uk>
Message-ID: <555DABC4.2000407@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/2015 01:14, Russell King - ARM Linux wrote:

Do you ever sleep? :-)

> On Wed, May 20, 2015 at 11:56:31PM +0200, Mason wrote:
>
>> Russell, when you added the FEAT_C3STOP flag unconditionally in
>> commit 5388a6b266, didn't that potentially break platforms that
>> didn't expect the flag to be set?
> 
> Why would it break any platforms at the time it was merged?
> 
> You're only having problems because you don't provide a global timer
> to the kernel, which the C3STOP feature does require - and that's
> because your platform appears to be very limited in what it can
> provide.

For the record, I don't think it is the platform that is limited;
it is my understanding of Linux internals and interrupt management
that is insufficient. (I'm working on it.)

AFAICT, most of the Linux know-how is not explicitly spelled out in
Documentation, it's often bits-and-pieces hidden in long ML threads.
(Sites like LWN are a blessing for grunts like me. I await eagerly
the release of LDD4.)

> All other platforms at the time provided a global timer, so the
> scenario you're facing never existed.

Sorry, my limitations are showing... Take mach-ux500 for example.
Did it provide a global timer at the time?

$ git checkout 5388a6b266
$ git grep clock.*event arch/arm/mach-ux500
arch/arm/mach-ux500/localtimer.c: * Setup the local clock events for a CPU.
arch/arm/mach-ux500/localtimer.c:void __cpuinit local_timer_setup(struct clock_event_device *evt)

> Maybe you also should read the discussion around this which is over 5
> years old.  You can find some initial discussion via these message IDs:
> 
> alpine.LFD.2.00.1004171152080.3625 at localhost.localdomain
> And the thread "SMP Local timer and power management" from May 2010.

I downloaded gmane's NNTP archive for linux-arm-kernel (415000 message),
going back to 2002.

$ grep alpine.LFD.2.00.1004171152080.3625@ gmane.linux.ports.arm.kernel.msf
$ grep -i "SMP Local timer and power management" gmane.linux.ports.arm.kernel.msf

No hits using gmane's search interface either.

> Yes, making it conditional depending on the platform was mooted, but
> it seemed unnecessary.  The fact that no one until now has had a
> problem with it is testament to the approach being correct for the
> hardware that was in use over the last five years.  No bug reports
> means no problem.

I agree with this pragmatic stance.

Regards.
