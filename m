From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 6 Mar 2013 16:15:23 +0900
Subject: [PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
In-Reply-To: <201302261612.25444.arnd@arndb.de>
References: <20130218134648.17303.97576.sendpatchset@w520>
 <201302261018.28463.arnd@arndb.de>
 <CANqRtoS9uK-xmAvvP=ujVDqDBqe7+c_p5G4QOK6o=FNQEmvT5A@mail.gmail.com>
 <201302261612.25444.arnd@arndb.de>
Message-ID: <CANqRtoTYTCK9e0OAN_xEwUs+9tYAwoMebUSJiP8+FOJKrWw8cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Feb 27, 2013 at 1:12 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 26 February 2013, Magnus Damm wrote:
>> On Tue, Feb 26, 2013 at 7:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Monday 25 February 2013, Magnus Damm wrote:
>> > You are right that ioremap cannot be used from ->smp_init_cpus() and any
>> > code called from there needs to use a static mapping for accessing
>> > MMIO registers. There is nothing wrong with that. There are in fact
>> > three distinct reasons why people use static MMIO mappings with
>> > iotable_init():
>> >
>> > 1. For MMIO registers that need to be accessed before ioremap works.
>> >    This usually means the SMP startup and the early printk (which I
>> >    believe shmobile is not using).
>>
>> Thanks for describing these.
>>
>> Is there any particular reason why SMP startup needs to happen earlier
>> than ioremap() is available?
>
> I think it's mostly traditional reason I think.

I think so too.

>> From a hardware point of view on Cortex-A9 the SCU needs to be enabled
>> and the number of available cores need to be determined. The SCU
>> enabling can probably happen later and the number of cores are already
>> limited to the kernel configuration maximum number of cores setting,
>> so it should be possible to use that to size any early per-cpu
>> variables if needed. So I wonder why we're not enabling SMP later than
>> we actually do? Using maxcpus=1 and late CPU hotplug from user space
>> is certainly working fine.
>
> AFAIK, on Cortex-A15 we already rely on getting the number of cores from
> the device tree, which is also available at the right time, without
> the need for an early mapping. It would not be hard to do the same
> on Cortex-A9. Then again, the static mapping there does not do harm
> as I said.

I understand that you feel that static mapping in the case of SMP is acceptable.

>> Regarding early printk, you are correct that we're not using that ARM
>> specific debug output. Instead we are relying on earlyprintk via early
>> platform devices. This way we are not only multi-soc and multi-subarch
>> already, we are also multi-arch. For really early console output we
>> rely on the clocks and pin function being initialized by the boot
>> loader and we also require 1:1 entity mappings so we can use printouts
>> before ioremap() is functional. So yes, we like using 1:1 virt-phys
>> memory maps for early printouts.
>
> Ok.
>
>> We do not use early printk with DT at this point. If we would be able
>> to move the SMP init later then perhaps we could debug SMP issues with
>> serial ports described by DT in the future?
>>
>> > 3. For hardcoding the virtual address to a location that is passed
>> >    to device drivers as compile-time constants.
>> >
>> > The first two are absolutely fine, there are no objections to those.
>>
>> Ok. As you probably can tell by now - I would like to get rid of the
>> SMP case if possible.
>
> I would certainly welcome a patch that moves the SMP initialization
> to a later point. I'm not sure if it requires changes to architecture
> independent code, but it does sound like a good idea.

Good to hear that that this may be a move in the right direction!

>> > The third one is tradtitionally used on a lot of the older platforms,
>> > but with the multiplatform work, we are moving away from it, towards
>> > passing resources in the platform device (ideally from DT, but that
>> > is an orthogonal question here). AFAICT, shmobile is the only "modern"
>> > platform that still relies on fixed virtual addresses, and it is the
>> > only one I know that uses a mapping where the virtual address equals
>> > the physical address.
>>
>> The 1:1 mapping is deliberately chosen to be simple. So in the case
>> when people do register I/O without ioremap() then at least we can
>> look up the address in the data sheet. I've seen too many examples of
>> people not using ioremap and instead inventing their own magic mapping
>> table with undocumented hard coded address that map to something even
>> more unknown. Of course we should be aiming at using ioremap(). If we
>> for some reason can't then we should use 1:1 mappings.
>
> Well, I would argue that when someone doesn't understand the basic
> interfaces we expose to device drivers, they probably shouldn't
> be writing kernel code. ;)

I am not sure how this is related to device drivers actually. The
example I was thinking about was snapshot-style development on some
ancient kernel version. In that case the developers simply seemed to
follow the at-that-point common coding style in the ARM architecture.
I am happy to see that the ARM architecture code is getting cleaner
bit by bit.

>> While I agree to move more towards using ioremap(), I can't really see
>> how this affects our multiplatform situation. Our device drivers have
>> always been using the driver model and we do never export any virtual
>> addresses in any header files. If you have any particular area that
>> you think needs work related to ioremap() then perhaps we can get
>> together on next conference and talk it through?
>
> It may not be as bad as I thought. I know that at least the intc
> controller is fundamentally built around this assumption (I tried changing
> it, and that didn't end well), but that may be the only one, following
> the recent cleanup of the pfc driver.

Uhm, I am not sure where you got that idea about the INTC driver.
Allow me to clarify.

Regarding the shared INTC code base I recall implementing ioremap()
support there 2010, feel free to search the archives for "[PATCH] sh:
INTC ioremap support V2".

As for actual SoC support, this varies with interrupt controller and
SoC. It is basically a matter of if I/O memory windows are passed to
the INTC driver or not.

A typical example would be sh7372 that has two interrupt controllers:
INTCA and INTCS. In intc-sh7372.c you have the following:

INTCA (no resources - using the 0xe6xxxxxx 1:1 mapping):

static DECLARE_INTC_DESC(intca_desc, "sh7372-intca",
			 intca_vectors, intca_groups,
			 intca_mask_registers, intca_prio_registers,
			 NULL);

INTCS (resources - relies on ioremap()):

static struct resource intcs_resources[] __initdata = {
	[0] = {
		.start	= 0xffd20000,
		.end	= 0xffd201ff,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= 0xffd50000,
		.end	= 0xffd501ff,
		.flags	= IORESOURCE_MEM,
	}
};

static struct intc_desc intcs_desc __initdata = {
	.name = "sh7372-intcs",
	.force_enable = ENABLED_INTCS,
	.skip_syscore_suspend = true,
	.resource = intcs_resources,
	.num_resources = ARRAY_SIZE(intcs_resources),
	.hw = INTC_HW_DESC(intcs_vectors, intcs_groups, intcs_mask_registers,
			   intcs_prio_registers, NULL, NULL),
};

Adding I/O memory resources to the already existing INTC controllers
is not a particularly difficult task. Would you like us to perform
such a change?

> The main worry is probably that people will take the platform code
> as example when writing device drivers, and that uses hardcoded
> IOMEM() macros.  There are probably a couple of instances where that
> is the best solution, but for those, I would suggest using offsets
> from a base register that gets passed into iotable_init() rather
> than literal numbers.

If you look at all our regular device drivers we use a base register +
offset. In such cases that kind of design makes a lot of sense.

In the case of INTC and PFC we do not follow this style. This since
each version of the hardware block varies quite a bit and there often
are a couple of I/O memory windows associated with each hardware block
instance. So the design has been to use the same physical addresses as
are described in the data sheet, and for bit fields and register width
follow the same type of representation as the data sheet to allow easy
development and validation.

Keep in mind that in arch/sh and arch/arm we have over 30 different
variants of INTC hardware blocks.

So to summarize, INTC, PFC and CPG (clocks) have ioremap support
included in the actual driver code. If the SoC makes use of it or not
is a different question. =)

>> As I mentioned before, from my point of view the main limiting factor
>> for mach-shmobile multiplatform at this point is the clock framework.
>> The SH clock framework does already support ioremap() though, so it is
>> just a matter of making the clock code actually use it. And while
>> we're doing that we may as well solve the multiplatform issue to and
>> move towards common clocks.
>
> Ok, good to hear.

So how would you like to proceed with this matter?

Thanks,

/ magnus
