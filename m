From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 4 Jul 2018 12:55:35 +0900
Subject: [PATCHv5 4/4] arm64: Add build salt to the vDSO
In-Reply-To: <20180703233430.14416-5-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-5-labbott@redhat.com>
Message-ID: <CAK7LNARxwNkzkUif9dj1oVFGYP4J41C+t=W4YFVxM+J94siGvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

2018-07-04 8:34 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> The vDSO needs to have a unique build id in a similar manner
> to the kernel and modules. Use the build salt macro.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: I was previously focused on x86 only but since powerpc gave a patch,
> I figured I would do arm64 since the changes were also fairly simple.
> ---
>  arch/arm64/kernel/vdso/note.S | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
> index b82c85e5d972..2c429dfd3f45 100644
> --- a/arch/arm64/kernel/vdso/note.S
> +++ b/arch/arm64/kernel/vdso/note.S
> @@ -22,7 +22,10 @@
>  #include <linux/uts.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
> +#include <linux/build-salt.h>
>
>  ELFNOTE_START(Linux, 0, "a")
>         .long LINUX_VERSION_CODE
>  ELFNOTE_END
> +
> +BUILD_SALT;



I think this works, but
I prefer no-semicolon in assembly files.

For coding consistency,
I want ';' as statement delimiter in .c files.
But, only new line after each statement in .S files.

For example, in arch/x86/xen/xen-head.S
I see no semicolon after ELFNOTE().

I found this:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0473k/dom1359731141352.html
It says ';' starts a comment line
although it is not the case of GAS.


Same for 3/4.



-- 
Best Regards
Masahiro Yamada
