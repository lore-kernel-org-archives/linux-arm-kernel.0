From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 31 Mar 2016 15:20:03 +0200
Subject: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
In-Reply-To: <20160331123649.GE18910@arm.com>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <56FC9D1D.6090808@huawei.com>
 <CAJZ5v0gv-MJ+Ss8gtc80z2_sOq-3qfBYbspRU8MWRNvn+UVbUg@mail.gmail.com>
 <20160331123649.GE18910@arm.com>
Message-ID: <CAKv+Gu_i8q_xKQgJ1mJ5hE_gcdJgHkh_QZhUNwQchsyH9r-pJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 March 2016 at 14:36, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Mar 31, 2016 at 02:04:05PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Mar 31, 2016 at 5:44 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
>> > On 2016/3/31 1:58, Mark Brown wrote:
>> >> When ACPI was originally merged for arm64 it had only been tested on
>> >> emulators and not on real physical platforms and no platforms were
>> >> relying on it.  This meant that there were concerns that there might be
>> >> serious issues attempting to use it on practical systems so it had a
>> >> dependency on EXPERT added to warn people that it was in an early stage
>> >> of development with very little practical testing.  Since then things
>> >> have moved on a bit.  We have seen people testing on real hardware and
>> >> now have people starting to produce some platforms (the most prominent
>> >> being the 96boards Cello) which only have ACPI support and which build
>> >> and run to some useful extent with mainline.
>> >>
>> >> This is not to say that ACPI support or support for these systems is
>> >> completely done, there are still areas being worked on such as PCI, but
>> >> at this point it seems that we can be reasonably sure that ACPI will be
>> >> viable for use on ARM64 and that the already merged support works for
>> >> the cases it handles.  For the AMD Seattle based platforms support
>> >> outside of PCI has been fairly complete in mainline a few releases now.
>> >>
>> >> This is also not to say that we don't have vendors working with ACPI who
>> >> are trying do things that we would not consider optimal but it does not
>> >> appear that the EXPERT dependency is having a substantial impact on
>> >> these vendors.
>> >>
>> >> Given all this it seems that at this point the EXPERT dependency mainly
>> >> creates inconvenience for users with systems that are doing the right
>> >> thing and gets in the way of including the ACPI code in the testing that
>> >> people are doing on mainline.  Removing it should help our ongoing
>> >> testing cover those platforms with only ACPI support and help ensure
>> >> that when ACPI code is merged any problems it causes for other users are
>> >> more easily discovered.
>> >>
>> >> Signed-off-by: Mark Brown <broonie@kernel.org>
>> >
>> > Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
>> >
>> >> ---
>> >>  drivers/acpi/Kconfig | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> >> index 82b96ee8624c..bf5dc1ac3446 100644
>> >> --- a/drivers/acpi/Kconfig
>> >> +++ b/drivers/acpi/Kconfig
>> >> @@ -5,7 +5,7 @@
>> >>  menuconfig ACPI
>> >>       bool "ACPI (Advanced Configuration and Power Interface) Support"
>> >>       depends on !IA64_HP_SIM
>> >> -     depends on IA64 || X86 || (ARM64 && EXPERT)
>> >> +     depends on IA64 || X86 || ARM64
>> >>       depends on PCI
>> >>       select PNP
>> >>       default y
>>
>> OK
>>
>> What do the ARM64 maintainers think?
>
> I'm unsure about whether or not we want 'default y' here, but I'd like
> to wait for Catalin to come back from his 2-week holiday before going
> anywhere with this patch.

Ack to that, but ...

> It's only fair that his opinion should be
> taken into account, and there's not a huge rush for this. I do consider
> "ACPI-only platforms" as simply "platforms without a .dtb" (modulo
> any significant AML code) and therefore don't view this as a blocking
> issue.
>

... this patch will only affect those systems. DT-based systems, even
if they provide an ACPI description as well, will not invoke the ACPI
code unless you go out of your way to either boot without a DT or pass
'acpi=force' on the command line. On the other hand, it will make
generic kernels (defconfig, etc) bootable on ACPI only systems, which
currently require special kernel builds. Another important reason for
this change is to get more build testing coverage for the arm64 ACPI
code that we had so much fuss about, e.g, by the kbuild test robot.

> We should also take into account the large amount of ongoing ACPI work
> (e.g. the DSD and PRP0001 saga, PCI and IORT support, virtualisation work,
> etc), and decide whether or not that's currently in a state where we want
> to encourage people to start using this in their arm64 kernels.
>

The question is not about using it, the question is about
incorporating it into the default build. The runtime opt-in is not
going away with this patch.
