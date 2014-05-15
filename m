From: robherring2@gmail.com (Rob Herring)
Date: Thu, 15 May 2014 09:44:11 -0500
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency in
 non-SMP platforms
In-Reply-To: <20140515120152.7b0beb37@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_JsqJy=dYpVFbgjGVRHrgwfaB7dkJVGazpfjf9qf7Z9poJuw@mail.gmail.com>
 <20140515120152.7b0beb37@free-electrons.com>
Message-ID: <CAL_JsqKO5j-rTQVwo9AJA=WYF_oSfdvbM-LjF7QNox3SPGuAkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 5:01 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Rob Herring,
>
> On Wed, 14 May 2014 12:07:28 -0500, Rob Herring wrote:
>
>> > This hardware I/O coherency mechanism needs a set of ARM core
>> > requirements to operate properly:
>> >
>> >  * On Armada 370 (a single core processor)
>> >
>> >    - The cache policy of pages must be set to "write allocate".
>>
>> Why do we want !SMP to be no write allocate in the first place? Seems
>> like we should always enable write-allocate at least for v7.
>
> Ok, seems like it matches the suggestion from Catalin. I've sent a
> quick patch in my reply to Catalin, if you could have a look and tell
> if it's OK, I can use that in my next version.

Looks fine to me.

>> >  * On Armada XP (which has dual core and quad core variants)
>> >
>> >    - The cache policy of pages must be set to "write allocate".
>> >    - The SMP bit in the Auxiliary Functional Modes Control Register 0
>> >      must be set (remember the CPU core is PJ4B)
>>
>> I know you don't like my answer of this should be done in the bootloader.
>
> See my answer to Catalin about this.

I'll reply in the other thread.

>> >    - The pages must be set as shareable.
>>
>> What is the impact of setting shareable bit for !SMP? I would think it
>> would be a don't care for true UP systems. Does the 370 actually not
>> work with shareable pages? AMP systems could have an issue though.
>
> No, the Armada 370 doesn't work with shareable pages. See my cover
> letter that details the requirements for the different SoCs, and I've
> only mentioned shareable pages as part of the requirements for Armada
> XP, Armada 375 and Armada 38x.

I asked because you only mentioned platforms requiring shared pages.
That didn't tell me whether some platforms can work either way. It
would take some hacks to test that out including dealing the initial
mappings.

>> >  * On Armada 375/38x (which have single core and dual core variants)
>> >
>> >    - The cache policy of pages must be set to "write allocate".
>> >    - The SMP and TLB broadcast bits must be set in the Auxiliary
>> >      Control Register (the core is a Cortex-A9)
>>
>> bootloader :)
>
> No. It's done by the kernel for the SMP case, there's no reason it
> should be done in the bootloader for the !SMP I/O coherent case. Or, we
> remove the SMP and TLB broadcast bit fiddling in the kernel
> *completely* and make it part of the ARM boot protocol that the
> bootloader is required to do that.

No, it depends on the A9 configuration. The TLB broadcast is not
modifiable in non-secure mode. You can control non-secure access to
the SMP bit, but it can work with it enabled by secure world. This is
what highbank does.

> I really don't see any justification for why it some situations the
> bootloader would be responsible for it, and why in some other
> situations the kernel would be responsible for it.

Like many other cases, we did not enforce what the bootloader must do
in the past. The mixture of platforms running in secure and non-secure
mode has led to some of it.

>> >    - The pages must be set as shareable.
>> >    - The SCU must be enabled
>>
>> This is also needed on A9s using ACP port. (Could be in the bootloader as well.)
>>
>> While I understand the we can't update the bootloader/firmware
>> arguments, we also would reasonably expect ACPI based server systems
>> from the same vendor. Those systems are going to have to get things
>> right in the firmware and thus will require firmware updates in the
>> early stages before production systems and OS's are ready. I don't
>> know that the vendor mindset will ever be changed other than by
>> refusing to accept changes upstream which should be fixed in firmware
>> (and distros also refusing to carry them).
>
> See above. It's not only about having issues to get the vendor to fix
> the firmware. It's also about:
>
>  * Having a consistent strategy with regard to what the kernel does and
>    what the bootloader does. Why would the kernel set the SMP and TLB
>    broadcast bit when CONFIG_SMP is set and the processor is SMP, but
>    not when CONFIG_SMP is disabled and the system is I/O coherent?

It is not that simple. The SMP bit has different meanings depending on
the core, but is more related to cache usage than running multi-core
or not. On the A15 for example, IIRC, the SMP bit basically means
disable cache lookups while the C bit only means disable cache
allocations (i.e. cache hits can occur with the "cache disabled").

>  * User support issues. Having gazillions of bootloader updates every
>    time a piece of configuration settings is rejected by the kernel
>    maintainers is going to be a nightmare for users.

It's an artifact of trying to upstream the kernel after shipping
rather than before. If these issues were fixed in the bootloader at
the same time as someone decided to just hack up the vendor kernel,
then probably none of us would even know about the issue.

> I certainly do understand the wish to put pressure on vendors to do
> their firmware correctly, and I'm continuously pushing Marvell to be
> more open, and I'm hoping to get them to do progress in the bootloader
> area in the future.
>
> However, by forcing users to do gazillions of bootloader upgrades, you
> also make the mainline kernel very difficult to use for them. The
> result is that those users will prefer to use the vendor BSP kernels
> which can carry all the crazy fixes, and therefore the mainline kernel
> is completely untested, unused, and basically just a sort of repository
> of code that helps vendor reduce the overhead of bumping from one
> kernel version to the other for their own vendor BSP. Is this really
> what you want? Clearly not me.

As long as upstream is not a requirement, you are not in a position
you can win. You can never keep up with someone that has the freedom
to just go and change whatever they want without having to deal with
those annoying kernel maintainers. You fix these issues, there will
just be other reasons why mainline is not usable (Do they still have
the random one line deletion of a goto statement in the scheduler).

Speaking from experience rebasing i.MX vendor kernels, nothing
upstream is easier to update than partially upstream if you try to
build upon what is upstream. Generally speaking, vendors don't care
what their delta against upstream is any more than they care about
upstream being production quality.

Obviously, Marvell does care about mainline to some extent or I
wouldn't be talking to you. But how do we get them to care enough to
make mainline production quality? Part of the problem is we have
distro's willing to take your money and vendor kernel (they are also
willing to take your money and upstream kernel as well).

>> > All of these requirements are met when the kernel is configured with
>> > CONFIG_SMP *and* when the processor is actually a multiple core
>> > processors (otherwise, due to the CONFIG_SMP_ON_UP logic, is_smp()
>> > returns false, and most of the requirements above are not met).
>>
>> I think there are some other problems here with is_smp(). For example,
>> there are several cases where it is used for determining to read the
>> MPIDR register. For things such as matching MPIDR to DT cpu nodes, we
>> need that to work for !SMP kernels.
>
> Could you point more specifically where this is happening?

Just grep for is_smp. IIRC, the DT cpu parsing code spews a warning
when running a !SMP kernel on an MP system. It may only be when the
MPIDR is not 0 like highbank which has 0x900.

> In fact, another possible solution would be to make is_smp() returns
> "true" when the system is !SMP but has I/O coherency enabled. However,
> I have the issue that Armada 370 does *not* want shareable pages, while
> Armada XP/375/38x *require* that.

We'd need to look more closely at how is_smp is used to redefine it's
meaning. We probably need to be able to describe "I have MP
extensions", "I'm MP on SMP kernel" and "I'm UP running an SMP
kernel".

>> > Basically, the patch series goes like this:
>> >
>> >  * PATCH 1 adds a 'flags' field to 'struct machine_desc' so that each
>> >    platform can tell the ARM kernel core some of its requirements. We
>> >    maybe could have used the Device Tree as well, but accessing the
>> >    Device Tree as early as in paging_init() is a bit problematic as
>> >    far as I understand.
>> >
>> >    Two flags are defined: MACHINE_NEEDS_CPOLICY_WRITEALLOC and
>> >    MACHINE_NEEDS_SHAREABLE_PAGES. We need separate flags because
>> >    Armada 370 cannot have the shareable attribute on page tables.
>>
>> I think these are too specific. We used to have arch_is_coherent()
>> which somewhat does what you need, but it was not multi-platform
>> friendly. I think you need something like "is_io_coherent" and/or
>> "is_mp".
>
> I agree the flags are very specific, but unfortunately I haven't found
> a better way of describing things. The main problem here is that the
> different platforms have different requirements: Armada XP/375/38x
> require shareable pages, but Armada 370 does not want them. So a single
> "is_io_coherent" flag was not sufficient, because each platform has its
> own requirements. I'm really open to suggestions on this, but a single
> is_io_coherent flag doesn't work, unfortunately.

With the write-allocate change, you only have a single flag so it is
really just a question of name and how to control the flag.

Rob
