From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 Nov 2013 14:38:07 +0000
Subject: [PATCH trivial] arm64: constify hwcap_str
In-Reply-To: <CAKv+Gu9zw-1p6q6vnQWi=ZU53V-oeN_-vDH5Jfo0XvnBjMqN2g@mail.gmail.com>
References: <1383755567-17244-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131107175010.GI13674@arm.com>
 <CAKv+Gu9zw-1p6q6vnQWi=ZU53V-oeN_-vDH5Jfo0XvnBjMqN2g@mail.gmail.com>
Message-ID: <20131108143807.GB17212@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 06:53:06PM +0000, Ard Biesheuvel wrote:
> On 7 November 2013 18:50, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, Nov 06, 2013 at 04:32:47PM +0000, Ard Biesheuvel wrote:
> >> Turn hwcap_str from a 'writable array of pointers to const char[]'
> >> to a multidimensional const char[][].
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>
> >> This is something I noticed when looking at Steve Capper's hwcaps patch: really
> >> no point in having a writable array of 8-byte pointers in .data keeping track of
> >> these hwcap strings.
> >
> > I don't see a problem (few bytes wasted). If you want to make it
> > read-only, this would do:
> >
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 9cf30f49610d..84a770fd7003 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -308,7 +308,7 @@ static int __init topology_init(void)
> >  }
> >  subsys_initcall(topology_init);
> >
> > -static const char *hwcap_str[] = {
> > +static const char *const hwcap_str[] = {
> >         "fp",
> >         "asimd",
> >         NULL
> 
> I agree that whether you want to put up with the additional layer of
> indirection, additional relocations etc is a matter of taste, but
> having writable pointers around that are easily dereferenced directly
> by unprivileged users is a bad idea in any case,

"unprivileged users"?!

> so if this is your preferred solution, it's fine by me.

My preferred solution is to leave it as it is ;).

-- 
Catalin
