From: jakub.kicinski@netronome.com (Jakub Kicinski)
Date: Thu, 24 Nov 2016 01:30:03 -0800
Subject: [PATCH] ARM: fix kmemleak for XIP_KERNEL
In-Reply-To: <20161122142829.1776129-1-arnd@arndb.de>
References: <20161122142829.1776129-1-arnd@arndb.de>
Message-ID: <CAJpBn1zow6P5MUFP+jbOXafoH9dLV8Ng7cJqfRsE8FMEEe9J8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 6:28 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added check for RO_AFTER_INIT_DATA in kmemleak breaks ARM whenever
> XIP_KERNEL is enabled:
>
> mm/kmemleak.o: In function `kmemleak_scan':
> kmemleak.c:(.text.kmemleak_scan+0x2e4): undefined reference to `__end_data_ro_after_init'
> kmemleak.c:(.text.kmemleak_scan+0x2e8): undefined reference to `__start_data_ro_after_init'
>
> This adds the start/end symbols for the section even in the case of having
> no data in the section, to make the check work while keeping the architecture
> specific override in one place.
>
> Fixes: d7c19b066dcf ("mm: kmemleak: scan .data.ro_after_init")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The patch causing this was merged late into v4.9-rc, this one should
> probably go there as well.
>
> I assume the same problem exists on s390, but I have not checked that.

Hi Arnd!

Sorry for breaking things again :( The confusion must have been caused
by going via different trees.  Actually, Russell's commit is dated 6
days after mine so could as well be:

Fixes: 2a3811068fbc ("ARM: Fix XIP kernels")

Not that it matters.

About s390 - I thought I took care of it in d7c19b066dcf ("mm:
kmemleak: scan .data.ro_after_init"), do you see anything suspicious
in the way I did it?  I'll do some more s390 builds just to triple
check.

Sorry again,
Kuba
