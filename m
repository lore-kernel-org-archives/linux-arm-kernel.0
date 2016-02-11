From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Feb 2016 18:00:32 +0000
Subject: [PATCH v2] ARM: mm: mark section-aligned portion of rodata NX
In-Reply-To: <CAGXu5jLDK8eVO2kUD1cB3TArL8k8pF=igc3O04Fa40QgQ2pwNw@mail.gmail.com>
References: <20151207223534.GA13722@www.outflux.net>
 <CAKv+Gu9EeKQk7GOAPV2cvff10=kD49u+oP-yEiOrJBPOF=QNtw@mail.gmail.com>
 <CAGXu5j+Pc7ucC4tmxHyDW7aW88pwQvMejuR2Ehdxp=vY+pv-5w@mail.gmail.com>
 <CAGXu5jLDK8eVO2kUD1cB3TArL8k8pF=igc3O04Fa40QgQ2pwNw@mail.gmail.com>
Message-ID: <20160211180032.GY10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 01:19:03PM -0800, Kees Cook wrote:
> On Tue, Dec 8, 2015 at 10:38 AM, Kees Cook <keescook@chromium.org> wrote:
> > On Mon, Dec 7, 2015 at 11:47 PM, Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> >> On 7 December 2015 at 23:35, Kees Cook <keescook@chromium.org> wrote:
> >>>  /*
> >>> + * Without CONFIG_DEBUG_ALIGN_RODATA, __start_rodata_section_aligned will
> >>> + * be the first section-aligned location after __start_rodata. Otherwise,
> >>> + * it will be equal to __start_rodata.
> >>> + */
> >>> +__start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
...

I'm afraid this causes build errors on two configurations:

./arch/arm/kernel/vmlinux.lds:701: undefined symbol `SECTION_SHIFT' referenced in expression

which I think is down to the new __start_rodata_section_aligned line.

Olof's builder errored out with this for both allnoconfig and
lpc18xx_defconfig builds.  Both probably due to CONFIG_MMU being
unset, and hence no definition for SECTION_SHIFT.

I think you need to make this conditional on CONFIG_MMU.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
