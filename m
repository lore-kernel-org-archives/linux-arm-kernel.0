From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Mar 2015 17:04:05 +0000
Subject: [PATCH] ARM: advertise availability of v8 Crypto instructions
In-Reply-To: <CAKv+Gu-pSOMFhSs=AeAERU1=XKU3xsBJCBOedVnZYBg6frWN9A@mail.gmail.com>
References: <1425054991-29951-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_dSgtsUp8aeMwz9a6stEC3DCg8GMU5QWWTPy_oOyHCSw@mail.gmail.com>
 <20150304162049.GX28951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-pSOMFhSs=AeAERU1=XKU3xsBJCBOedVnZYBg6frWN9A@mail.gmail.com>
Message-ID: <20150304170404.GZ28951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 05:31:00PM +0100, Ard Biesheuvel wrote:
> On 4 March 2015 at 17:20, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Mar 03, 2015 at 02:43:01PM +0100, Ard Biesheuvel wrote:
> >> On 27 February 2015 at 17:36, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> > When running the 32-bit ARM kernel on ARMv8 capable bare metal (e.g.,
> >> > 32-bit Android userland and kernel on a Cortex-A53), or as a KVM guest
> >> > on a 64-bit host, we should advertise the availability of the Crypto
> >> > instructions, so that userland libraries such as OpenSSL may use them.
> >> > (Support for the v8 Crypto instructions in the 32-bit build was added
> >> > to OpenSSL more than six months ago)
> >> >
> >> > This adds the ID feature bit detection, and sets elf_hwcap2 accordingly.
> >> >
> >> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> > ---
> >> >  arch/arm/kernel/setup.c | 16 ++++++++++++++++
> >> >  1 file changed, 16 insertions(+)
> >> >
> >> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> >> > index e55408e96559..8d4cb1c1c9ac 100644
> >> > --- a/arch/arm/kernel/setup.c
> >> > +++ b/arch/arm/kernel/setup.c
> >> > @@ -393,6 +393,22 @@ static void __init cpuid_init_hwcaps(void)
> >> >         vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
> >> >         if (vmsa >= 5)
> >> >                 elf_hwcap |= HWCAP_LPAE;
> >> > +
> >> > +       /* check for supported v8 Crypto instructions on non v7-M CPUs */
> >>
> >> Perhaps this should be 'on v7+ (non v7-M) CPUs'
> >>
> >> > +       if (cpu_architecture() == CPU_ARCH_ARMv7) {
> >>
> >> @Russell: any thoughts on this?
> >>
> >> Currently, v8 CPUs are identified as CPU_ARCH_ARMv7, and there is no
> >> point in performing this test on other architectures (including v7-M)
> >
> > With the new CPUID scheme introduced around v6/v7, the OS is no longer
> > meant to read much into the architecture version. Even the current
> > __get_cpu_architecture() function that we have returns the VMSA version
> > and not the actual CPU architecture version (for example, ARM11MPCore is
> > reported as ARMv7 by Linux when it's clearly an ARMv6). With ARMv8, the
> > ID_MMFR0 would still report VMSAv7 with LPAE (0b0101) like on a
> > Cortex-A15. You may be able to guess it's an ARMv8 from other fields
> > like ID_ISAR2[3:0] (acquire/release semantics for load/store) but that's
> > not how CPUID registers are meant to be used.
> 
> It doesn't really matter which architecture it is. I just want to be
> reasonably sure that reading ID_ISAR5 isn't going to explode. If there
> are other/better ways to guarantee that, I am happy to use those as
> well. (I noticed that there is a v7-M specific definition of ID_ISAR5
> in the source which I couldn't find any reference to in any of the
> Cortex-M TRMs on the infocenter web site.)

The ARMv7-M reference manual only defines to ID_ISAR4. Maybe it will get
a fifth register at some point but for now I don't think we should read
it (I guess it was just copy/paste from the A profile).

> > If we are bothered by the ARMv7 name, we could redefine some of these
> > macros to make it clear that the arch version is no longer relevant,
> > something like below (covering the profile names as well):
> >
> >         CPU_ARCH_CPUID_A
> >         CPU_ARCH_CPUID_R
> >         CPU_ARCH_CPUID_M
> >
> > Once you find such cpu arch number, you know you have access to the
> > architected CPUID registers.
> 
> Let's just rename 7 to 7up  and be done with it :-)

Looks good ;)

-- 
Catalin
