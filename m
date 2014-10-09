From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Oct 2014 23:32:44 +0100
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <54370A1E.6070707@gmail.com>
References: <54345FA7.9030606@gmail.com>
 <20141007221515.GY5182@n2100.arm.linux.org.uk> <5434F387.804@gmail.com>
 <20141008083509.GD5182@n2100.arm.linux.org.uk>
 <CAKv+Gu_qNggWRTg+-Y1xQ81qjYUexKXyAY3nU04dxy3HVoRDKg@mail.gmail.com>
 <54370A1E.6070707@gmail.com>
Message-ID: <20141009223244.GJ5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 07:20:14PM -0300, Lanchon wrote:
>
> On 10/08/2014 05:53 AM, Ard Biesheuvel wrote:
>> On 8 October 2014 10:35, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Wed, Oct 08, 2014 at 05:19:19AM -0300, Lanchon wrote:
>>>> for instance, you say that if an ISR uses the FPU it would corrupt user
>>>> FP state. fine, but it is not that simple. what if the FPU was disabled
>>>> at the time of interrupt? (ie: lazy restore did not yet happen in this
>>>> time-slice.)
>>> At that point, it depends on which kernel version you are using.  Yes,
>>> older kernels will just restore the state.  Newer kernels will trap this
>>> and complain.
>>>
>> Indeed. As part of the kernel mode NEON support (which landed in 3.12
>> I think?), the VFP trap handling now checks whether it occurred in
>> kernel mode or user mode.
>> Check arch/arm/vfp/vfphw.S:84 in your kernel tree for
>>
>> """
>> ldr r3, [sp, #S_PSR] @ Neither lazy restore nor FP exceptions
>> and r3, r3, #MODE_MASK @ are supported in kernel mode
>> teq r3, #USR_MODE
>> bne vfp_kmode_exception @ Returns through lr
>> """
>>
>> Without these lines, the lazy restore machinery may kick in during the
>> execution of an ISR that uses NEON registers inadvertently, and
>> overwrite your VFP state with that of the process that happens to be
>> active when the interrupt is taken.
>
> thank you for this! just one question. i suppose the 'kernel mode' test  
> used here will be positive if the trap happens while executing a kernel  
> thread. it should also be positive if the trap happens while executing  
> an ISR that interrupted a kernel thread.  but what if the trap happens  
> while executing an ISR that interrupted userland? would this 'kernel  
> mode' test also be positive?

Yes.

> there is a new piece of information:
> the FP corruption seems to only happen in these android devices if the  
> display is off. the charger may be connected or not, but if the display  
> is on, the corruption won't happen.
>
> i wonder if the kernel could be turning off the FPU and then back on  
> without saving the FPU state. i would think corruption would be seen  
> more often then.

No.  We don't "turn off" the VFP.  We disable and enable access to VFP
via the coprocessor access register.  If the VFP access is disabled and
then re-enabled, all state is preserved.

The only time which state would be lost is if (eg) we hot-unplug the
entire CPU, but that first requires a context switch which implies that
the state will already be saved.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
