From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 8 Apr 2014 21:46:05 -0700
Subject: Big endian working?
In-Reply-To: <alpine.LFD.2.11.1404082339291.1571@knanqh.ubzr>
References: <20140408095446.0520dd28@skate> <5343BDEE.4010005@linaro.org>
 <12950765.TpxjkTx5NP@wuerfel>
 <alpine.LFD.2.11.1404082339291.1571@knanqh.ubzr>
Message-ID: <CAA3XUr3gR-R1X6+CxP-Z0fv7kiSzENtm0NsYd539BNVWKCgdNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2014 20:44, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 8 Apr 2014, Arnd Bergmann wrote:
>
>> On Tuesday 08 April 2014 12:14:22 Taras Kondratiuk wrote:
>> > On 04/08/2014 10:54 AM, Thomas Petazzoni wrote:
>> > > Hello Taras,
>> > >
>> > > I'm currently trying to get ARM BE to work on Armada XP. I'm pretty
>> > > sure it used to work on 3.13, but now I'm testing 3.13 and 3.14 and it
>> > > doesn't boot here (it hangs even before "Uncompressing kernel...",
>> > > apparently while relocating the kernel image before decompression).
>> > >
>> > > Ben Dooks told me that the ARM BE kernel works for you. Can you confirm
>> > > which kernel version you're using, and if you've applied any patch?
>> > > Also, can you confirm which toolchain and toolchain version you're
>> > > using?
>> >
>> > Hi Tom
>> >
>> > To boot BE kernel from LE u-boot I'm using a few patches on top of
>> > upstream kernel.
>> >
>> > git://git.linaro.org/people/taras.kondratiuk/linux.git arm-be-boot-le
>> >
>> > ----------------------------------------------------------------
>> > Ben Dooks (1):
>> >        ARM: add CPU_BE8_BOOT_LE configuration
>> >
>> > Nico Pitre (1):
>> >        ARM: ensure loader information in LE format for BE kernels
>>
>> Sorry for lacking the history on this patch set, but why would
>> you ever want to have this as a compile-time conditional?
>>
>> Did anyone really put a u-boot on shipping hardware that expects
>> the headers in big-endian format?
>
> If I remember correctly, those are for booting a BE kernel on hardware
> that initializes in LE mode and expects a LE kernel.  Since the zImage
> header values are defined to be words, those must be swapped so they
> read as LE even if the kernel is BE.  Of course the kernel is then
> responsible for switching the endian mode when entered.

My understanding is that CPU_BE8_BOOT_LE was needed only for
atags boot case. Since now practically nobody uses atags, but rather
fdt those patches were not pushed into main stream.

Please look at
git://git.baserock.org/delta/linux baserock/311-rc7/be/atags-v2

Thomas, does your Armada XP uboot still uses atags? I would think
not.

I can confirm that in main line TC2 works in BE mode without any
changes. In linaro kernel tree we have Arandle and Pandaboard with
additional, drivers only changes, and they work OK. However I don't
think we are testing zImage, in all cases I use it, it is uImage.

Maybe Nico's zImage change was under atags umbrella by mistake and
it really addresses general zImage issue. In this case we need to add
this commit to main line. However, I don't think we need to carry
CPU_BE8_BOOT_LE option forward, why we just use
CONFIG_CPU_BIG_ENDIAN instead. Note in all cases when BE
image used loader is always in LE mode. Never seen case
otherwise.

As toolchain concerned any recent 4.7 and 4.8 should work. Note
toolchain should may not be configured as BE by default. LE toolchain
should compile BE kernel just fine.

Thanks,
Victor

>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
