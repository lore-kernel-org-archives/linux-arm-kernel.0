From: daniel@iogearbox.net (Daniel Borkmann)
Date: Fri, 17 Aug 2018 14:40:19 +0200
Subject: [offlist] Re: Crash in netlink/sk_filter_trim_cap on ARMv7 on
 4.18rc1
In-Reply-To: <CALeDE9Pm7nsqDFL0m0ZsNdnEti6YAbEPhtfbNMPe=UZCUyyHMA@mail.gmail.com>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
 <ad98d60c-bd60-b495-c4bd-507fc29c8bcd@iogearbox.net>
 <CALeDE9PBZWJBp8KB0mB4zoNXqscmzxWzz+LnuqRA-z4t1e9T8g@mail.gmail.com>
 <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
 <20180816203515.GA7688@torres.zugschlus.de>
 <20180816225844.GW30658@n2100.armlinux.org.uk>
 <CALeDE9Pm7nsqDFL0m0ZsNdnEti6YAbEPhtfbNMPe=UZCUyyHMA@mail.gmail.com>
Message-ID: <1c2218cb-63bf-1528-6156-8ce93f46169c@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2018 02:25 PM, Peter Robinson wrote:
> On Thu, Aug 16, 2018 at 11:58 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Thu, Aug 16, 2018 at 10:35:16PM +0200, Marc Haber wrote:
>>> On Mon, Jun 25, 2018 at 05:41:27PM +0100, Peter Robinson wrote:
>>>> So with that and the other fix there was no improvement, with those
>>>> and the BPF JIT disabled it works, I'm not sure if the two patches
>>>> have any effect with the JIT disabled though.
>>>
>>> I can confirm the crash with the released 4.18.1 on Banana Pi, and I can
>>> also confirm that disabling BPF JIT makes the Banana Pi work again.,
>>
>> I'm afraid that the information in the crash dumps is insufficient
>> to be able to work very much out about these crashes.
>>
>> We need a recipe (kernel configuration and what userspace is doing)
>> so that it's possible to recreate the crash, or we need responses
>> to requests for information - I requested the disassembly of
>> sk_filter_trim_cap and the BPF code dump via setting a sysctl back
>> in early July.  Without this, as I say, I don't see how this problem
>> can be progressed.
> 
> I can provide a kernel config [1] but I've not had enough time to sit
> down and get the rest of the stuff and debug it due to a combination
> of travel and other priorities.

Did you get a chance to try latest kernel from Linus' tree [1] from last
few days to see whether the issue is still persistent? There have been
a number of improvements, bit strange why e.g. Russell didn't run into
it while others have, hmm. Perhaps due to EABI vs non EABI.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

>> If the problem is at boot, one way to set the sysctl would be to
>> hack the kernel and explicitly initialise the sysctl to '2', or
>> boot with init=/bin/sh, then manually mount /proc, set the sysctl,
>> and then "exec /sbin/init" from that shell.  (Remember there's no
>> job control in that shell, so ^z, ^c, etc do not work.)
> 
> It starts to happen in the early kernel boot long before we get to any
> userspace across a number of ARMv7 devices (RPi2/3, BeagleBone and
> AllWinner H3 based devices at least).
> 
> [1] https://pbrobinson.fedorapeople.org/kernel-armv7hl.config

I'd have one potential bug suspicion, for the 4.18 one you were trying,
could you run with the below patch to see whether it would help?

Thanks,
Daniel

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f6a62ae..c864f6b 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -238,7 +238,7 @@ static void jit_fill_hole(void *area, unsigned int size)
 #define STACK_SIZE	ALIGN(_STACK_SIZE, STACK_ALIGNMENT)

 /* Get the offset of eBPF REGISTERs stored on scratch space. */
-#define STACK_VAR(off) (STACK_SIZE - off)
+#define STACK_VAR(off) (STACK_SIZE - off - 4)

 #if __LINUX_ARM_ARCH__ < 7
