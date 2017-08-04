From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Fri, 4 Aug 2017 22:31:26 +0900
Subject: [PATCH] arm64:kexec: have own crash_smp_send_stop() for crash
 dump for nonpanic cores
In-Reply-To: <59844E98.3020507@arm.com>
References: <1501830173-15989-1-git-send-email-hoeun.ryu@gmail.com>
 <59844E98.3020507@arm.com>
Message-ID: <31F08185-69F6-4EB9-92B0-A8C6DD6B7532@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 4 Aug 2017, at 7:38 PM, James Morse <james.morse@arm.com> wrote:
> 
> Hi Hoeun,
> 
>> On 04/08/17 08:02, Hoeun Ryu wrote:
>> Commit 0ee5941 : (x86/panic: replace smp_send_stop() with kdump friendly
>> version in panic path) introduced crash_smp_send_stop() which is a weak
>> function and can be overriden by architecture codes to fix the side effect
>> caused by commit f06e515 : (kernel/panic.c: add "crash_kexec_post_
>> notifiers" option).
> 
> If I've understood correctly: if we boot with this option core code doesn't use
> our machine_crash_shutdown(), and instead calls crash_smp_send_stop(), which we
> don't have, so it uses the default smp_send_stop(), which doesn't save the regs.
> 
> Thanks for catching this!
> 
> 
> Could we rename smp_send_crash_stop() crash_smp_send_stop() and add the
> called-twice logic there? They are similar enough that I'm getting them muddled
> already!

I think it is possible, I will reflect it in v2.
Thank you for the review.

> 
> Thanks,
> 
> James
> 
> 
>> ARM64 architecture uses the weak version function and the problem is that
>> the weak function simply calls smp_send_stop() which makes other CPUs
>> offline and takes away the chance to save crash information for nonpanic
>> CPUs in machine_crash_shutdown() when crash_kexec_post_notifiers kernel
>> option is enabled.
>> 
>> Calling smp_send_crash_stop() in the function is useless because all
>> nonpanic CPUs are already offline by smp_send_stop() in this case and
>> smp_send_crash_stop() only works against online CPUs.
>> 
>> The result is that /proc/vmcore is not available with the error messages;
>> "Warning: Zero PT_NOTE entries found", "Kdump: vmcore not initialized".
>> 
>> crash_smp_send_stop() is implemented for ARM64 architecture to fix this
>> problem and the function (strong symbol version) saves crash information
>> for nonpanic CPUs using smp_send_crash_stop() and machine_crash_shutdown()
>> tries to save crash information for nonpanic CPUs only when
>> crash_kexec_post_notifiers kernel option is disabled.
> 
> 
