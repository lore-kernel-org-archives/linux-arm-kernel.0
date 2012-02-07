From: rabin@rab.in (Rabin Vincent)
Date: Tue, 7 Feb 2012 21:48:24 +0530
Subject: [PATCHv2 5/6] jump label: detect %c support for ARM
In-Reply-To: <1327757725-10114-6-git-send-email-rabin@rab.in>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-6-git-send-email-rabin@rab.in>
Message-ID: <CAH+eYFDzsWjrxOFiYcYO6sgPDusxcHOTQcjvN8hDaEPG+=LgAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Sat, Jan 28, 2012 at 19:05, Rabin Vincent <rabin@rab.in> wrote:
> Some versions of ARM GCC which do support asm goto, have problems
> handling the the %c specifier. ?Since we need the %c to support jump
> labels on ARM, detect that too in the asm goto detection script to avoid
> build errors with these versions.
>
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
>
> Cc: Jason Baron <jbaron@redhat.com>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Could you please ack this patch if it's OK for you?  Then I could try to
send it via rmk's ARM patch system along with the rest of the series.

Thanks.

> ---
> ?scripts/gcc-goto.sh | ? 18 +++++++++++++++++-
> ?1 files changed, 17 insertions(+), 1 deletions(-)
>
> diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
> index 98cffcb..9b744de 100644
> --- a/scripts/gcc-goto.sh
> +++ b/scripts/gcc-goto.sh
> @@ -2,4 +2,20 @@
> ?# Test for gcc 'asm goto' support
> ?# Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
>
> -echo "int main(void) { entry: asm goto (\"\"::::entry); return 0; }" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
> +cat << "END" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
> +int main(void)
> +{
> +#ifdef __arm__
> + ? ? ? /*
> + ? ? ? ?* Not related to asm goto, but used by jump label
> + ? ? ? ?* and broken on some ARM GCC versions (see GCC Bug 48637).
> + ? ? ? ?*/
> + ? ? ? static struct { int dummy; int state; } tp;
> + ? ? ? asm ("@ %c0" :: "i" (&tp.state));
> +#endif
> +
> +entry:
> + ? ? ? asm goto ("" :::: entry);
> + ? ? ? return 0;
> +}
> +END
> --
> 1.7.8.3
>
