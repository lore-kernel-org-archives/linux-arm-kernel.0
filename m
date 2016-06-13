From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2016 22:25:16 +0100
Subject: [PATCH] ARM: mm: fix location of _etext
In-Reply-To: <CAGXu5jJwtDqLALk+3QETK7Wia56yxFp30nO7vwwbNX49s5KVmg@mail.gmail.com>
References: <20160608231158.GA12159@www.outflux.net>
 <CAGXu5jJwtDqLALk+3QETK7Wia56yxFp30nO7vwwbNX49s5KVmg@mail.gmail.com>
Message-ID: <20160613212515.GA1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 01:23:29PM -0700, Kees Cook wrote:
> On Wed, Jun 8, 2016 at 4:11 PM, Kees Cook <keescook@chromium.org> wrote:
> > The _etext position is defined to be the end of the kernel text code,
> > and should not include any part of the data segments. This interferes
> > with things that might check memory ranges and expect executable code
> > up to _etext.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Can someone give this an Ack? I'd like to land it as it is a
> prerequisite to some usercopy hardening work I'm doing.

We use _etext to place the end of the "kernel code" resource in
/proc/iomem, and init_mm.end_code.  I don't think anything makes
use of init_mm.end_code, but I'm more worried about the resource.

Currently, because of where _etext is placed, "kernel code" covers
the read-only data and other read-only sections as well - I don't
know whether we need to preserve that, but this change has a side
effect of changing that.

Maybe we also need a "kernel rodata" resource?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
