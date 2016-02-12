From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Feb 2016 15:26:41 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
 <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
 <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
Message-ID: <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 04:17:09PM +0100, Ard Biesheuvel wrote:
> On 12 February 2016 at 16:10, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Feb 12, 2016 at 04:02:58PM +0100, Ard Biesheuvel wrote:
> >> On 12 February 2016 at 15:58, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> > On Mon, Feb 01, 2016 at 11:54:52AM +0100, Ard Biesheuvel wrote:
> >> >> This moves the module area to right before the vmalloc area, and
> >> >> moves the kernel image to the base of the vmalloc area. This is
> >> >> an intermediate step towards implementing KASLR, which allows the
> >> >> kernel image to be located anywhere in the vmalloc area.
> >> >>
> >> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> >
> >> > This patch is causing lots of KASAN warnings on Juno (interestingly, it
> >> > doesn't seem to trigger on Seattle, though we only tried for-next/core).
> >> > I pushed the branch that I'm currently using here:
> >> >
> >> > git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/kernmap
> >> >
> >> >
> >> > A typical error (though its place varies based on the config options,
> >> > kernel layout):
> >> >
> >> > BUG: KASAN: stack-out-of-bounds in clockevents_program_event+0x28/0x1b0 at addr ffffffc936257cc8
> >>
> >> Can you confirm that these are stack accesses? I was having similar
> >> errors before, and I ended up creating the kasan zero page patch
> >> because it turned out the kasan shadow page in question was aliased
> >> and the stack writes were occurring elsewhere.
> >
> > It's possible, we are looking into this. Is there any other patch I miss on
> > the above branch?
> 
> I don't think so but I will check

Commit 7b1af9795773 ("arm64: kasan: ensure that the KASAN zero page is
mapped read-only") was merged in -rc2 while the branch above is based on
-rc1. Anyway, I merged it into -rc2 and the errors are similar.

-- 
Catalin
