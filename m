From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 18 Jun 2014 10:55:01 -0700
Subject: [PATCH] ARM: zImage: ensure header in LE format for BE8 kernels
In-Reply-To: <1397147232-28516-1-git-send-email-taras.kondratiuk@linaro.org>
References: <1397147232-28516-1-git-send-email-taras.kondratiuk@linaro.org>
Message-ID: <CAGa+x85P-M3qUD6L=kezkiQ1NJymEZ9P=u2ANUZJu2b3F+o5LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 9:27 AM, Taras Kondratiuk
<taras.kondratiuk@linaro.org> wrote:
> From: Nico Pitre <nico@fluxnic.net>
>
> All known BE8-capable systems have LE bootloaders, so we need to ensure
> that the magic number and image start/end values are in little endian
> format.
>
> [ben.dooks at codethink.co.uk: from nico's original email on this subject]
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [taras.kondratiuk at linaro.org: removed lds.S->lds rule, added target to extra-y]
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>

This patch has now hit -next (as of next-20140618) and I noticed all
my big-endian boot tests failed[1].  Turns out they failed because I'm
deciding whether to pass a big-endian or little-endian initramfs based
on the magic number of the zImage.  Since it's now always little
endian, even the big-endian kernels were boot tested with a little
endian initramfs.  And guess what.... they failed.

I like this patch for several reasons, including the fact that
u-boot's bootz support checks the magic number and failed before this
patch.

All of that to say, with this patch applied, I need a new (and
reliable) way to determine the endianness of a kernel just by looking
at the zImage.  Recommendations welcome.

Thanks,

Kevin

[1] http://lists.linaro.org/pipermail/kernel-build-reports/2014-June/004059.html
