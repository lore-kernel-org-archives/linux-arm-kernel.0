From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jan 2015 18:14:53 +0000
Subject: [PATCHv7 2/2] arm64: add better page protections to arm64
In-Reply-To: <54B9AC53.8020903@codeaurora.org>
References: <1421276394-20402-1-git-send-email-lauraa@codeaurora.org>
 <1421276394-20402-3-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu8iGAPpR49EQKwmOZp2cHGdg8QJyoh2x1BB9uW6-S5L4g@mail.gmail.com>
 <54B9AC53.8020903@codeaurora.org>
Message-ID: <20150120181453.GI25575@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 12:26:59AM +0000, Laura Abbott wrote:
> On 1/15/2015 1:44 AM, Ard Biesheuvel wrote:
> > On 14 January 2015 at 22:59, Laura Abbott <lauraa@codeaurora.org> wrote:
> >> Add page protections for arm64 similar to those in arm.
> >> This is for security reasons to prevent certain classes
> >> of exploits. The current method:
> >>
> >> - Map all memory as either RWX or RW. We round to the nearest
> >>    section to avoid creating page tables before everything is mapped
> >> - Once everything is mapped, if either end of the RWX section should
> >>    not be X, we split the PMD and remap as necessary
> >> - When initmem is to be freed, we change the permissions back to
> >>    RW (using stop machine if necessary to flush the TLB)
> >> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
> >>    read only.
> >>
> >> Tested-by: Kees Cook <keescook@chromium.org>
> >> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> >> ---
> >> v7: Rebased on Ard's patch series. Addressed minor comments from
> >> Catalin.
> >> ---
> >
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > With setting DEBUG_RODATA, I lose the ability to write to variables in
> > the rodata section. I have not tested executing from !X sections
> > though.
> >
> > My single objection to this patch would be that it is presented as a
> > debug option, which I think is a mistake. Especially now, we are in a
> > time window with lots of momentum in the arm64 kernel developer
> > community and little hardware in the field yet, so we have a huge
> > opportunity to make features such as this one opt-out rather than
> > opt-in, without having to worry about backward compatibility. This
> > applies equally to STRICT_DEVMEM, for instance, which is something
> > that is on our radar at Linaro, and will be addressed in the 3.21
> > timeframe.

I agree with STRICT_DEVMEM.

> I agree. I fully support making this default on if possible. My goal
> for the first pass was to get the infrastructure in and then figure
> out how to make this default later.

I don't mind dropping the "debug" naming part from this feature but I
wouldn't go as far as making it the default. Do we have any information
on what the performance impact is? We lose some big block mappings
(could even be 1GB with the right RAM alignment) once we want finer
grained permissions.

-- 
Catalin
