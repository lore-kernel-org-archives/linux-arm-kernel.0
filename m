From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Sep 2017 00:38:03 +0200
Subject: HAVE_EFFICIENT_UNALIGNED_ACCESS on ARM32 (was: Alignment issues
 in zImage with Linux 4.12, LZ4 and GCC5.3)
In-Reply-To: <CAKv+Gu_6kxidH-4YwuCorJx25WSZDsOdtbZ6MZCv+R4ufzUjrw@mail.gmail.com>
References: <CAGkQfmOKqFWisiRjkCHBHDwgY5A0HA_+hcLYSeDYaoGQ6CVu6Q@mail.gmail.com>
 <CAK8P3a3AQ43t2q1MVN9PoqQXZiuXQo1uDcGnRAPCiT66_oDyLg@mail.gmail.com>
 <CAKv+Gu_6kxidH-4YwuCorJx25WSZDsOdtbZ6MZCv+R4ufzUjrw@mail.gmail.com>
Message-ID: <CAK8P3a1xX5RfM1kao7WZBmS=0J=MgNZTH2_c-nSOY+GNmjNsUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 7, 2017 at 12:23 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 6 September 2017 at 21:57, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Sep 4, 2017 at 6:19 PM, Romain Izard <romain.izard.pro@gmail.com> wrote:
>
> HAVE_EFFICIENT_UNALIGNED_ACCESS only affects explicit unaligned
> accesses, and selects between fixups in hardware or in software.
> AFAICT the issue here is implicit unaligned accesses, where char
> pointers are passed as u32 * arguments.

The problem with include/linux/unaligned/access_ok.h is that it
converts pointers
that are known by the caller to be potentially unaligned and accesses them as if
they were aligned. This means we require a software fixup through the
trap handler
on ARM in cases that the compiler already knows how to handle correctly when
using linux/unaligned/le_struct.h. On ARMv7 this means it ends up using normal
load/store instructures but not the ldm/stm or ldrd/stdr instructions
that are not
allowed on unaligned pointers.

Doing that solves the problem that Romain ran into and also makes other
code much more efficient on ARMv7.

       Arnd
