From: rabin@rab.in (Rabin Vincent)
Date: Mon, 14 Apr 2014 23:08:07 +0200
Subject: [PATCH 2/2] ARM: mm: make text and rodata read-only
In-Reply-To: <CAGXu5jLkc2oFouYq3ZT1sUvgjjJY32_uEcuLLE4wHX-N0cFiFw@mail.gmail.com>
References: <1396577719-14786-1-git-send-email-keescook@chromium.org>
 <1396577719-14786-3-git-send-email-keescook@chromium.org>
 <20140404195818.GA21028@debian>
 <CAGXu5jKPX2igsb2rQzdCZQZ8X3h4YZihCV9D+cDW3F+qii8H2A@mail.gmail.com>
 <1396960898.3567.55.camel@linaro1.home>
 <CAGXu5jJq24k4uQbBJmihJ4RScJ40o41oKFtm13hBO_YZOvHpkA@mail.gmail.com>
 <1396973561.14809.26.camel@linaro1.home>
 <CAGXu5jJewy0Xy-qUEF2K6bAcEC8ZdKy0Ad2nLPjGRsq20fSQXQ@mail.gmail.com>
 <20140408194815.GA6188@debian>
 <CAGXu5jLkc2oFouYq3ZT1sUvgjjJY32_uEcuLLE4wHX-N0cFiFw@mail.gmail.com>
Message-ID: <20140414210807.GA25564@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 01:19:01PM -0700, Kees Cook wrote:
> > To prevent any stale entries being used indefinitely, perhaps the all
> > CPU TLB flush can be inserted into
> > ftrace_arch_code_modify_post_process(), which is called after the
> > stop_machine() and which is where x86 for example makes the entries
> > read-only again.
> 
> Do you mean something like this?

Yes, something like that should probably be sufficient.

> 
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index ea446ae09c89..b8c75e45a950 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -90,6 +90,8 @@ int ftrace_arch_code_modify_prepare(void)
>  int ftrace_arch_code_modify_post_process(void)
>  {
>         set_all_modules_text_ro();
> +       /* Make sure any TLB misses during machine stop are cleared. */
> +       flush_tlb_all();
>         return 0;
>  }
