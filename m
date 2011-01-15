From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 15 Jan 2011 06:20:06 -0600
Subject: [GIT PULL v3] pxa: patches for v2.6.38-rc
In-Reply-To: <20110114214900.GP15996@n2100.arm.linux.org.uk>
References: <AANLkTi=B3sfBXS3vN1+nnRa5m64jiaqmzRFfi6w07dJB@mail.gmail.com>
	<20110114173147.GK15996@n2100.arm.linux.org.uk>
	<20110114214900.GP15996@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=AtkMc90K8C9qrKaVqdLyuHE9SXyugkkX8HEeS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 3:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 14, 2011 at 05:31:47PM +0000, Russell King - ARM Linux wrote:
>> On Fri, Jan 14, 2011 at 11:08:59AM -0600, Eric Miao wrote:
>> > Hi Russell,
>> >
>> > I rebased the branch on top of devel-stable. The conflict in irq.c is
>> > fixed. And there is a one-liner patch fixing a building issue in spitz.c
>> > missing of physmap.h. Please re-pull and let know any other issue.
>>
>> Pulled cleanly, thanks.
>
> Building my PXA config:
>
> arch/arm/mach-pxa/irq.c:124: warning: initialization from incompatible pointer type
> arch/arm/mach-pxa/irq.c:125: warning: initialization from incompatible pointer type
> arch/arm/mach-pxa/irq.c:126: warning: initialization from incompatible pointer type
> arch/arm/mach-pxa/irq.c:127: warning: initialization from incompatible pointer type
>
> Seems the initializers want to be .irq_ack rather than .ack etc.
>

Fixed.

> I also need to remove asm/pgtable.h from arch/arm/mach-pxa/generic.c:
> ?CC ? ? ?arch/arm/mach-pxa/generic.o
> In file included from arch/arm/include/asm/pgtable.h:461,
> ? ? ? ? ? ? ? ? from arch/arm/mach-pxa/generic.c:26:
> include/asm-generic/pgtable.h: In function ?ptep_test_and_clear_young?:
> include/asm-generic/pgtable.h:29: error: dereferencing pointer to incomplete type
>

This didn't happen on my side. Maybe it's due to some change
not yet merged into devel-stable?

> and I also got:
> arch/arm/mach-pxa/tosa-bt.c: In function ?tosa_bt_probe?:
> arch/arm/mach-pxa/tosa-bt.c:84: error: implicit declaration of function ?rfkill_set_led_trigger_name?
>

This is going to be tricky now. The rfkill_set_led_trigger_name() has been
removed somehow as dead code along with several others in commit 2e48928,
apparently the patch author didn't notice it's existing usage, not only in
tosa-bt.c but arch/arm/mach-s3c2410/h1940-bluetooth.c.

There are two options:

1) remove the invocation completely, and rfkill_register() will just use
the dev_name(), which is of form 'rfkill%u', as the name for the led trigger.
But this is going to change the name of user space as well, which is what
we want to avoid.

2) or revert that 'removing dead code' commit. The function is simple
enough though, but since 'struct rfkill' is declared somehow within the
net/rfkill/core.c file, there has to be some function to initialize that.

Now, my personal preference would be to postpone the proper fix for this
issue into -rc?.

> which looks like a missing dependency.
>
> Do you want to fix these and send an updated pull?
>

With the first issue solved, I've pushed the change to my tree. Please
try re-pull. Will have to be on the flight hours later, and I might be
not responsive until a bit later. Sorry for this.
