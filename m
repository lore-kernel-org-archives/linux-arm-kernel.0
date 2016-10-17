From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Oct 2016 15:48:59 +0100
Subject: [PATCH] arm64: kaslr: fix breakage with CONFIG_MODVERSIONS=y
In-Reply-To: <CAKv+Gu9X3-mMk7_2R=LZ6V38f-dPYrcZkROrkQBde5H-kFcYbw@mail.gmail.com>
References: <1476376929-29688-1-git-send-email-ard.biesheuvel@linaro.org>
 <57FFE78E.4040002@codeaurora.org>
 <CAKv+Gu-sdgkoQvbpgHXZmDyxg6NTGJpC+hsqzdbwTkny+TeqfA@mail.gmail.com>
 <20161014182637.GF6534@arm.com>
 <CAKv+Gu9X3-mMk7_2R=LZ6V38f-dPYrcZkROrkQBde5H-kFcYbw@mail.gmail.com>
Message-ID: <20161017144859.GA5601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 08:53:02PM +0100, Ard Biesheuvel wrote:
> On 14 October 2016 at 19:26, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Oct 14, 2016 at 07:23:15PM +0100, Ard Biesheuvel wrote:
> >> On 13 October 2016 at 20:59, Timur Tabi <timur@codeaurora.org> wrote:
> >> > Ard Biesheuvel wrote:
> >> >>
> >> >> As it turns out, the KASLR code breaks CONFIG_MODVERSIONS, since the
> >> >> kcrctab has an absolute address field that is relocated at runtime
> >> >> when the kernel offset is randomized.
> >> >>
> >> >> This has been fixed already for PowerPC in the past, so simply wire up
> >> >> the existing code dealing with this issue.
> >> >>
> >> >> Signed-off-by: Ard Biesheuvel<ard.biesheuvel@linaro.org>
> >> >
> >> >
> >> > Tested-by: Timur Tabi <timur@codeaurora.org>
> >> >
> >>
> >> Thanks. I will resend this with a fixes: tag and a better description
> >
> > Feel free, but I already queued it locally and added the Fixes tag myself.
> > I'm just waiting for Lorenzo to post a fix to the ACPI NUMA stuff, then
> > I'll send these two up together next week.
> 
> It's no big deal. The description is not entirely accurate in the
> sense that the kcrctab does not contain an absolute address field, but
> it masquerades as an absolute address so that the build system can
> populate the kcrctab entries using a linker script include containing
> name=value pairs. This does not only result in 4 wasted bytes per CRC,
> but on PPC64 and arm64 with CONFIG_RELOCATABLE=y, it also results in
> the breakage this patch addresses, and more importantly, results in a
> 24 byte RELA entry per CRC in the __init section. So I intend to
> propose a patch to change this in the generic code, after which this
> patch could be reverted.
> 
> BTW, I spotted another KASLR issue, with ftrace this time, where it
> attempts to poke relative branches into modules targeting the core
> kernel, which is likely to fail when
> CONFIG_RANDOMIZE_MODULE_REGION_FULL=y. Should we address this at the
> Kconfig level? Or should we try to fix ftrace to support long
> branches?

I guess we could fix it at the kconfig level in the short term, then it
makes it clear that some ftrace work needs doing to fix it properly.

Will
