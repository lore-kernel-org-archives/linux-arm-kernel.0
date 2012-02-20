From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2012 17:21:58 +0000
Subject: [PATCHv2 5/6] jump label: detect %c support for ARM
In-Reply-To: <1327757725-10114-6-git-send-email-rabin@rab.in>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-6-git-send-email-rabin@rab.in>
Message-ID: <20120220172158.GI26840@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2012 at 07:05:24PM +0530, Rabin Vincent wrote:
> Some versions of ARM GCC which do support asm goto, have problems
> handling the the %c specifier.  Since we need the %c to support jump
> labels on ARM, detect that too in the asm goto detection script to avoid
> build errors with these versions.

I'm not sure how this detects properly working %c support.  %c support
has been rather flakey on ARM for some time, I'm not sure which version
of gcc was fixed for it.

> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
> 
> Cc: Jason Baron <jbaron@redhat.com>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  scripts/gcc-goto.sh |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
> index 98cffcb..9b744de 100644
> --- a/scripts/gcc-goto.sh
> +++ b/scripts/gcc-goto.sh
> @@ -2,4 +2,20 @@
>  # Test for gcc 'asm goto' support
>  # Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
>  
> -echo "int main(void) { entry: asm goto (\"\"::::entry); return 0; }" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
> +cat << "END" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
> +int main(void)
> +{
> +#ifdef __arm__
> +	/*
> +	 * Not related to asm goto, but used by jump label
> +	 * and broken on some ARM GCC versions (see GCC Bug 48637).
> +	 */
> +	static struct { int dummy; int state; } tp;
> +	asm ("@ %c0" :: "i" (&tp.state));

While this detects the presence of the ICE, previous compilers included
the '#' before the constant, which leads to problems.  I think a better
check would be:
	asm(".long %c0" :: "i" (&tp.state));

to make sure that it spits out something purely numeric, rather than
something prefixed with a '#'.
