From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jan 2014 10:07:23 +0000
Subject: [PATCH] ARM64: perf: support dwarf unwinding in compat mode
In-Reply-To: <CAFrcx1=QWPFeuNDc0JatiykGnRuvPyOgwwCxnW7pSAiNa9RsxA@mail.gmail.com>
References: <1389869123-5884-1-git-send-email-jean.pihet@linaro.org>
 <20140116115634.GE30257@mudshark.cambridge.arm.com>
 <CAFrcx1=eAHsGZDsedGvvNai7Vrnf5p8RKLGFPS+cn5yGp7UQJw@mail.gmail.com>
 <20140116125727.GI30257@mudshark.cambridge.arm.com>
 <CAFrcx1npWFs3=rooqiGKSv-p7ivcG1J7SCvcmsz-hd3waXBfdA@mail.gmail.com>
 <CAFrcx1=QWPFeuNDc0JatiykGnRuvPyOgwwCxnW7pSAiNa9RsxA@mail.gmail.com>
Message-ID: <20140117100723.GB16003@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 09:00:09AM +0000, Jean Pihet wrote:
> On 16 January 2014 14:47, Jean Pihet <jean.pihet@linaro.org> wrote:
> >> So the simplest thing would be to make compat_user_stack_pointer expand to
> >> user_stack_pointer(current_pt_regs()) on arm64 and merge that in with your
> >> original patch fixing user_stack_pointer.
> 
> I see 2 issues in your proposal:
> 
> 1) user_stack_pointer(regs) calls compat_user_stack_pointer if
> compat_user_mode(regs)) and compat_user_stack_pointer expands to
> user_stack_pointer. I see a circular dependency in the macros.

Not today it doesn't, so you just need to avoid writing the circular
dependency and instead make user_stack_pointer access (regs)->compat_sp
instead.

> 2) current_pt_regs() returns the current task regs although perf
> passes a regs struct that had been recorded previously.

Yes, but compat_user_stack_pointer doesn't take a regs paramater anyway, so
there's no change in behaviour here.

Will
