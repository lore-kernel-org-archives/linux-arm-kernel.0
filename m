From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Jul 2018 17:52:52 +0100
Subject: [PATCH] arm64: cpuinfo: Include cleartext implementer and part
 strings
In-Reply-To: <CAOesGMjq=d3ZPLTq5qudx+EE+XC2-zSsA1ViheTwM7fnTtJh2Q@mail.gmail.com>
References: <20180715035342.11371-1-olof@lixom.net>
 <f619f0e9-b8b4-29fb-5ad6-7f5ebc3a4da8@arm.com>
 <CAOesGMjq=d3ZPLTq5qudx+EE+XC2-zSsA1ViheTwM7fnTtJh2Q@mail.gmail.com>
Message-ID: <20180716165251.6ka5wvvmebxphpme@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, Jul 16, 2018 at 07:34:05AM -0700, Olof Johansson wrote:
> On Mon, Jul 16, 2018 at 2:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On 15/07/18 04:53, Olof Johansson wrote:
> >> There's some use in printing out what the implementer and part numbers
> >> decode to for cases where they're known.
> >>
> >> I filled in the table based on public information; mostly from ARM TRMs
> >> and other tools (and some of the SSBD tables in the kernel, etc).
> >>
> >> Apple IDs came from
> >> https://github.com/apple/darwin-xnu/blob/master/osfmk/arm/cpuid.h

I appreciate that the format of /proc/cpuinfo isn't as nice as one might
like as a human reader.

For better or worse, the vast majority of readers of /proc/cpuinfo are
applications (be they scripts or binaries), and we must treat the format
and contents of /proc/cpuinfo as ABI. We've been burned by /proc/cpuinfo
format changes in the past, so we want to minimize the potential for ABI
issues.

This change is only useful to human readers of /proc/cpuinfo, mandates
perpetual maintenance work, and comes with a very strong risk of subtle
ABI breakage (both for this patch and future patches it implies will be
necessary).

So sorry, but I must NAK this patch, as with prior patches changing the
format of /proc/cpuinfo.

> > The same thing pops up every so often. And the answer is the same each time:
> 
> Ever thought about why it pops up?

In some cases because the person in question isn't sure what hardware
they're on. In most cases because people are used to x86, and haven't
considered what exactly they're trying to achieve.

We've repeatedly been asked for strings *by application developers*,
despite the MIDR being sufficient and already available. Generally,
developers are happy to use MIDRs once they realise this.

Having the string leads people to try to parse it, even though it cannot
be reliable.

> > - it breaks an existing userspace ABI by changing the format of cpuinfo
> 
> Most tools likely rely on a per-line format, and in this case they're
> likely interpreting the contents after the ':' as an integer. Adding
> something to the line might or might not break them, agreed.
> 
> How about introducing a "CPU model" line similar to x86's cleartext one?
> 
> > - it is unmaintainable in the long run
> 
> False. Chances are you already need details more fine-grained than
> this for errata and quirks, we already do for SSBD.

For SSBD, we don't look at the MIDR, and rely solely on the FW to
identify the presence of a workaround. Going forwards, we'll do likewise
as this is the only way to be future-proof and generic.

> And if it lacks an entry it's not the end of the world.

I don't think we can be that relaxed about this; it's quite easy to see
that people *will* write software that relies on the string (or
properties thereof) in ways that we cannot manage.

People will do silly things like try to read the string into a
fixed-size buffer. That works when the string is "Unknown", but falls
apart on the next kernel release when it's "awesome super CPU
2000xx-super-mega-long-name-edition". We don't discover this problem for
months, whereupon other applications are reliant upon the new string,
and now we're stuck with a horrible ABI bug that we can't fix.

> > - userspace already has this information by simply running "lscpu"
> >
> > What has changed?
> 
> What has changed is that ARM(64) is moving from a
> custom-kernel-custom-userspace world to one where you might be
> upreving kernels and userspace separately, and you might be using an
> older userspace with a newer machine and a newer kernel.

Sure, and this is exactly why we're trying to ensure that the behaviour
is *guaranteed* to be consistent across kernels -- so whichever kernel
is used, userspace should behave the same.

If userspace *needs* to know about a CPU, it can identify the CPU based
on the MIDR (and REVIDR), and this will work regardless of kernel
version. GCC does this today.

If userspace *wants* to know about a CPU (e.g. to expose a
human-friendly name), then a userspace database is fine. In the majority
of cases it's *vastly* easier to update a userspace application than it
is to update the kernel, and it's always possible to build the latest
binary yourself.

There are a number of cases where using strings is going to be
problematic in practice, e.g.

* Every out-of-tree SoC port is going to invent values that may not
  match the values mainline settles on. Then people will complain that
  their software only works on one or the other, because it makes some
  decision base on the model name.

* Every distro is going to differ in the set of IDs they backport, if
  any.  If your software relies on the MIDR, it will work everywhere. If
  it tries to parse the string, it will behave erratically across
  distros.

* We may get the matching logic for wrong, and be overly permissive when
  matching MIDR -> string. e.g. we ignore the low 4 bits for some range
  of MIDRs, but the vendor only uses 0x0-0xc, and assigns 0xd-0xf a
  different name.

* Parts (and vendors) don't always have a fix name. What happens when a
  vendor renames their product (or themselves)? Remember Cortex-A12?

> There's also a growing expectation of the system to behave more like
> x86, especially when it comes to trivial ways of detecting what kind
> of machine you are running on. On x86 it's been trivial to look at
> /proc/cpuinfo since it is provided by the platform there.

It's trivial because *the CPU provides this*, via CPUID. See
get_model_name() in arch/x86/kernel/cpu/common.c. That is how x86 can
expose a model name in a future-proof manner, and without a maintenance
nightmare.

On arm, we have the MIDR_EL1 and REVIDR_EL1. We simply do not have the
same information, and trying to guess at it is a losing game.

> Nobody wants to change their implementation from having to read a file
> to exec a program, dealing with errors, and parsing its output (sure,
> easier from scripts, but more awkward from real source).

Unfortunately, this ship has long sailed. The format of /proc/cpuinfo
differs across architectures, and it is not something that can be relied
upon by portable applications.

> Having the information exported from the kernel is a reasonable way to
> do it.

While I can appreciate this may seem simple, it comes with far more
problems than it solves.

> The other extreme is that the kernel should just ever have exported
> the raw MIDR value.

We expose the raw MIDR and REVIDR values under sysfs. We expose the
decomposed value (in the format defined by the architecture) because we
have to for compatibility with existing software.

To be honest, my personal preference would be to delete /proc/cpuinfo if
we could.

Thanks,
Mark.
