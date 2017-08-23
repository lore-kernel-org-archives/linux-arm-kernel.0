From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 23 Aug 2017 15:03:51 -0400
Subject: [PATCH] Arm: mm: ftrace: Only set text back to ro after kernel
 has been marked ro
In-Reply-To: <CAGXu5jLaQozk-TuZd8o=CK2kBcj3EFqD+VQtGX-DehU=c_TAkg@mail.gmail.com>
References: <20170823135836.52fb44fc@gandalf.local.home>
 <CAGXu5jLaQozk-TuZd8o=CK2kBcj3EFqD+VQtGX-DehU=c_TAkg@mail.gmail.com>
Message-ID: <20170823150351.606ba09f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Aug 2017 11:48:13 -0700
Kees Cook <keescook@chromium.org> wrote:

> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index ad80548..fd75f38 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -745,19 +745,29 @@ static int __mark_rodata_ro(void *unused)
> >         return 0;
> >  }
> >
> > +static int kernel_set_to_readonly;  
> 
> Adding a comment here might be a good idea, something like:
> 
> /* Has system boot-up reached mark_rodata_ro() yet? */

I don't mind adding a comment, but the above is rather self explanatory
(one can easily see that it is set in mark_rodata_ro() with a simple
search).

If a comment is to be added, something a bit more descriptive of the
functionality of the variable would be appropriate:

/*
 * Ignore modifying kernel text permissions until the kernel core calls
 * make_rodata_ro() at system start up.
 */

I can resend with the comment, or whoever takes this could add it
themselves.

-- Steve


> 
> Otherwise:
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> > +
> >  void mark_rodata_ro(void)
> >  {
> > +       kernel_set_to_readonly = 1;
> > +
> >         stop_machine(__mark_rodata_ro, NULL, NULL);
> >  }
> >
> >  void set_kernel_text_rw(void)
> >  {
> > +       if (!kernel_set_to_readonly)
> > +               return;
> > +
> >         set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), false,
> >                                 current->active_mm);
> >  }
> >
> >  void set_kernel_text_ro(void)
> >  {
> > +       if (!kernel_set_to_readonly)
> > +               return;
> > +
> >         set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), true,
> >                                 current->active_mm);
> >  }  
> 
> Does arm64 suffer from a similar condition? (It looks like no, as text
> patching is done with a fixmap poke.)
> 
> -Kees
> 
