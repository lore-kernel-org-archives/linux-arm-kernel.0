From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 5 Jul 2018 08:58:09 -0700
Subject: [PATCHv5 2/4] x86: Add build salt to the vDSO
In-Reply-To: <20180703233430.14416-3-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-3-labbott@redhat.com>
Message-ID: <CALCETrVZi2WYbBSifaNV4wajj52PyG-w7z9DekfJvSuZAKi1nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2018 at 4:34 PM, Laura Abbott <labbott@redhat.com> wrote:
>
> The vDSO needs to have a unique build id in a similar manner
> to the kernel and modules. Use the build salt macro.
>

Looks good to me.  I have no idea whose tree these would go through.

> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: Switched to using the single line BUILD_SALT macro
> ---
>  arch/x86/entry/vdso/vdso-note.S   | 3 +++
>  arch/x86/entry/vdso/vdso32/note.S | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
> index 79a071e4357e..79423170118f 100644
> --- a/arch/x86/entry/vdso/vdso-note.S
> +++ b/arch/x86/entry/vdso/vdso-note.S
> @@ -3,6 +3,7 @@
>   * Here we can supply some information useful to userland.
>   */
>
> +#include <linux/build-salt.h>
>  #include <linux/uts.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
> @@ -10,3 +11,5 @@
>  ELFNOTE_START(Linux, 0, "a")
>         .long LINUX_VERSION_CODE
>  ELFNOTE_END
> +
> +BUILD_SALT
> diff --git a/arch/x86/entry/vdso/vdso32/note.S b/arch/x86/entry/vdso/vdso32/note.S
> index 9fd51f206314..e78047d119f6 100644
> --- a/arch/x86/entry/vdso/vdso32/note.S
> +++ b/arch/x86/entry/vdso/vdso32/note.S
> @@ -4,6 +4,7 @@
>   * Here we can supply some information useful to userland.
>   */
>
> +#include <linux/build-salt.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
>
> @@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
>         .long LINUX_VERSION_CODE
>  ELFNOTE_END
>
> +BUILD_SALT
> +
>  #ifdef CONFIG_XEN
>  /*
>   * Add a special note telling glibc's dynamic linker a fake hardware
> --
> 2.17.1
>
