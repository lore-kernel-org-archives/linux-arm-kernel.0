From: ldv@altlinux.org (Dmitry V. Levin)
Date: Thu, 2 Mar 2017 18:48:45 +0300
Subject: [PATCH] uapi: fix asm/signal.h userspace compilation errors
In-Reply-To: <CAE2sS1h9QNV+31GMSv8aahJYOb9hFtFp5Aj-yVOfg7cjBHr_kg@mail.gmail.com>
References: <20170226010156.GA28831@altlinux.org>
 <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
 <CAE2sS1h9QNV+31GMSv8aahJYOb9hFtFp5Aj-yVOfg7cjBHr_kg@mail.gmail.com>
Message-ID: <20170302154845.GB3503@altlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 10:22:18AM -0500, Carlos O'Donell wrote:
> On Wed, Mar 1, 2017 at 11:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sun, Feb 26, 2017 at 2:01 AM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> >> Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix asm/signal.h
> >> userspace compilation errors like this:
> >>
> >> /usr/include/asm/signal.h:126:2: error: unknown type name 'size_t'
> >>   size_t ss_size;
> >>
> >> As no uapi header provides a definition of size_t, inclusion
> >> of <stddef.h> seems to be the most conservative fix available.
[...]
> > I'm not sure if this is the best fix. We generally should not include one
> > standard header from another standard header. Would it be possible
> > to use __kernel_size_t instead of size_t?
> 
> In glibc we handle this with special use of __need_size_t with GCC's
> provided stddef.h.
> 
> For example glibc's signal.h does this:
> 
> # define __need_size_t
> # include <stddef.h>

Just to make it clear, do you suggest this approach for asm/signal.h as well?

[...]
> Changing the fundamental type causes the issues you see in patch v2
> where sizeof(size_t) < sizeof(__kernel_size_t).
> 
> It will only lead to problem substituting the wrong type.

I don't see any appetite for creating more ABIs like x32 with
sizeof(size_t) < sizeof(__kernel_size_t), so v2 approach
is not going to be any different from v1 in maintenance.


-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/f75b9e11/attachment.sig>
