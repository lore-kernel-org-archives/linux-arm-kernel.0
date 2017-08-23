From: keescook@chromium.org (Kees Cook)
Date: Wed, 23 Aug 2017 11:48:13 -0700
Subject: [PATCH] Arm: mm: ftrace: Only set text back to ro after kernel
 has been marked ro
In-Reply-To: <20170823135836.52fb44fc@gandalf.local.home>
References: <20170823135836.52fb44fc@gandalf.local.home>
Message-ID: <CAGXu5jLaQozk-TuZd8o=CK2kBcj3EFqD+VQtGX-DehU=c_TAkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 10:58 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> ftrace needs to modify the kernel text in order to enable function tracing.
> For security reasons, the kernel text is marked to read-only (ro) at the end
> of system bootup. When enabling function tracing after that, ftrace calls
> arch specific code that needs to enable the modification of kernel text
> while ftrace does the update, and reset it back again when finished.
>
> The issue arises when function tracing is enabled during system bootup. The
> text hasn't been marked as read-only yet, but the same code to modify the
> kernel is executed, and when it is finished, it will cause the kernel to
> become read-only. This causes issues for other init code that requires
> modification of kernel text during system bootup. This appears to cause
> issue with Raspberry Pi 2.
>
> By implementing the feature that is used in x86 to deal with this issue, it
> fixes the problem. The solution is simple. Have a variable
> (kernel_set_to_readonly) get set when the system finished boot and marks the
> kernel to readonly. If that variable is not set, both
> kernel_set_to_readonly() and kernel_set_to_rw() return without doing any
> modifications. Those functions are used by ftrace to change the permissions
> of the kernel text. By not doing anything, ftrace will not mess with the
> permissions when it is enabled at system bootup.
>
> Link: http://lkml.kernel.org/r/20170821153402.7so2u364htvt6tnf at camel2.lan
> Link: https://github.com/raspberrypi/linux/issues/2166#issuecomment-323355145
> Reported-by: Matthias Reichl <hias@horus.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Phil Elwell <phil@raspberrypi.org>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: stable at vger.kernel.org
> Fixes: 80d6b0c2ee ("ARM: mm: allow text and rodata sections to be read-only")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/arm/mm/init.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index ad80548..fd75f38 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -745,19 +745,29 @@ static int __mark_rodata_ro(void *unused)
>         return 0;
>  }
>
> +static int kernel_set_to_readonly;

Adding a comment here might be a good idea, something like:

/* Has system boot-up reached mark_rodata_ro() yet? */

Otherwise:

Acked-by: Kees Cook <keescook@chromium.org>

> +
>  void mark_rodata_ro(void)
>  {
> +       kernel_set_to_readonly = 1;
> +
>         stop_machine(__mark_rodata_ro, NULL, NULL);
>  }
>
>  void set_kernel_text_rw(void)
>  {
> +       if (!kernel_set_to_readonly)
> +               return;
> +
>         set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), false,
>                                 current->active_mm);
>  }
>
>  void set_kernel_text_ro(void)
>  {
> +       if (!kernel_set_to_readonly)
> +               return;
> +
>         set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), true,
>                                 current->active_mm);
>  }

Does arm64 suffer from a similar condition? (It looks like no, as text
patching is done with a fixmap poke.)

-Kees

-- 
Kees Cook
Pixel Security
