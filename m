From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Wed, 6 Dec 2017 00:55:46 +0000
Subject: [RFC PATCH 1/3] dt-bindings: pinctrl: sunxi: document new generic
 binding
In-Reply-To: <CACRpkdZ70a7Vk1QPFhkms6ucWmSH6rOUD9_J0h=NjhK+vfXNAA@mail.gmail.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <20171113012523.2328-2-andre.przywara@arm.com>
 <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
 <20171124105240.GB3792@ulmo> <20efcf8f-85a5-3cad-a84b-434ee5cad68e@arm.com>
 <20171124133123.GA15999@ulmo> <0c8051e6-5d8c-32d6-97e4-11c2283da5b4@arm.com>
 <CACRpkdZ70a7Vk1QPFhkms6ucWmSH6rOUD9_J0h=NjhK+vfXNAA@mail.gmail.com>
Message-ID: <be52417d-9509-f638-65b6-f455fade0c39@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

thanks for the reply!

On 01/12/17 09:56, Linus Walleij wrote:
> On Fri, Nov 24, 2017 at 6:19 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> Conceptually I consider the DT being
>> part of the firmware,
> 
> As it is a subset of open firmware it is obviously firmware.
> 
>> so one trust level above the kernel.
> 
> We are several kernel developers who don't trust firmware one
> bit. Several disasters in ACPI has made me ever more convinced
> that firmware should be trusted less than kernel code.

I know what you mean, check commit acd316248205 ;-)

But in the Allwinner case all the firmware is open source, and even
controlled by the community (ATF & U-Boot). This is even more true for
the DT. Allwinner came up with their own DT, but since it uses
completely non-standard bindings, we don't use it at all.

So I don't consider firmware this dark, evil and unhackable blob that
many people see in it. Instead it is a good opportunity to separate very
tedious machine-specific parts from the kernel (think of PSCI).

> But this is all very academic.

I agree!

>>> Also, device tree bindings are not documentation for how to write a
>>> driver. They are not a replacement for hardware documentation. Nobody
>>> should be expected to be able to write an OS driver solely based on a
>>> device tree binding. Device tree bindings are more of a configuration
>>> interface specification for OS drivers.
>>
>> Yes, but together with the hardware docs you should be able to write a
>> driver. And here you can't, because you are missing the strings. So a
>> BSD developer has to look at Linux code.
> 
> This is a fair point. It appears in several drivers.
> 
> BSD or even Windows (would they use DT) would have to sit in the
> back seat just like Linux has been doing for years when it comes
> to the hopeless Windowsisms in the x86 BIOSes. I suspect some
> Windows on ARM is already experiencing this, but in the ACPI world,
> where, incidentally, the servers were being deployed for Linux first
> and Windows had to follow their example. I bet they have been
> swearing a lot in Redmond about that.

On the other hand a lot of the ACPI tables have been either taken from
x86 or designed also with Windows in mind. And frankly, my sympathy for
MS is quite limited in this respect ;-)

> In general it's one of these areas where we can not be utopian about the
> hardware descriptions, just fail gracefully in different ways.
> 
> I usually try to keep the IETF motto "rough consensus and running
> code" in mind. I don't know if it helps in this discussion though.
> 
>>> So that's about 40% of the kernel image. Code really is no good without
>>> data to process.
>>
>> But how much of this is SoC specific configuration data? How much is it
>> in x86? Yes, historically we had and have a lot of configuration data in
>> ARM kernels. But that doesn't mean that we have to continue with this or
>> even increase the share.
> 
> What people have been doing is trying to have better Kconfig setups
> and compile it out by doing kernel modules. It is a bit hopeless with
> pin controllers: almost all of them have to be built in. And if they come
> with a lot of data, yeah there you have a real good point.
> 
> It would be sad if the ARMv7 multiboot or Aarch64 kernel just grows
> so that we can't use it but have to go back to shipping board-specific
> kernels with a huge bunch of stuff compiled out.
> 
> I was hoping Moore's law would save us here :/
> 
> An option that has been discussed is better used of  __initdata
> and similar tags, especially with built-in drivers. Sadly, this is
> hurt by another snag: the compiler or linker file or whatever it is,
> is preventing us from discarding any strings from the kernel.
> And pin controllers tend to stack up a lot of these.
> 
> This is really sucky and something we should solve in general.
> I'm not smart enough to tackle any of these problems myself, just
> to see them and "Oh that's bad. Very bad."

I am sure one can find clever hac^Wsolutions for this problem, but I was
wondering if a new approach - like putting the per machine data actually
in DT - isn't the smarter way.
Hence my suggestion with this driver: we *need* the DT anyway to assign
pins to devices, so why not just add the few bytes *there*, which allows
us to have a more or less "data-less" DT driver?

>From what I learned the pinctrl subsystem seems to predates the ARM DT
endeavor, so many design decisions probably didn't consider DT as a
possible solution in the first way. And this is fine, because this is
how it was back then. But it doesn't mean it has to stay this way. And I
carefully thought of solving this problem without alienating existing
users and developers - by keeping the driver and staying compatible with
the existing binding and the DTs.

>>> The majority of the improvements over the years have been achieved by
>>> moving drivers out of arch/arm and moving board files to DT. The goal
>>> was never to get rid of all data.
>>
>> Sure, not all data. But if we have the relatively easy opportunity to
>> avoid further addition of data, we should do it, I believe.
>> This significantly reduces the amount of kernel code we need to add to
>> support new SoCs.
> 
> This is the core of your argument as I perceive it: get rid of data
> from the kernel, because it is growing wild.

Yes, this, but also to avoid replicating data in other DT consumers. I
very much like the idea of the DT describing the hardware, but I am a
bit afraid we loose many good opportunities by treating the DT more like
a "Linux config file" or an external Linux board file.
So I wanted to propose a way where we simplify DT usage in other
systems, while still keeping the Linux driver intact.

> It is a valid cause. Just
> has to be weighed with other stuff, like maintainability, debuggability,
> maintainers viewpoint. ...

So to keep Maxime happy I actually designed this "driver" more like a
shim: to generate the table the current driver expects from the DT, and
actually not touching the existing driver at all.
So maintainability should actually be less of a concern: the driver will
just work with whatever one throws at it from the DT side, without
requiring frequent changes or additions.
In the moment we still need to write, review and merge *data* files for
each new SoC. And as I mentioned before, Allwinner decided to push for
new, slightly different chips every few months, so there will be more to
come. With at least the pinctrl driver out of the way we have one
problem less to worry about.

Cheers,
Andre.
