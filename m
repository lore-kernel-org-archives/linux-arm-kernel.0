From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Jan 2017 17:29:00 +0000
Subject: [PATCH v3 4/5] Xen: Select correct dom0 console
In-Reply-To: <20161215122718.21422-5-andre.przywara@arm.com>
References: <20161215122718.21422-1-andre.przywara@arm.com>
 <20161215122718.21422-5-andre.przywara@arm.com>
Message-ID: <20170103172859.GC14183@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 12:27:17PM +0000, Andre Przywara wrote:
> From: Ian Campbell <ian.campbell@citrix.com>
> 
> If Xen is enabled, tell Dom0 to use the 'hvc0' console, and fall back to
> the usual ttyAMA0 otherwise.
> 
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Julien Grall <julien.grall@arm.com>
> Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  configure.ac | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index ea02dca..d23cced 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -105,7 +105,8 @@ AC_ARG_WITH([initrd],
>  AC_SUBST([FILESYSTEM], [$USE_INITRD])
>  AM_CONDITIONAL([INITRD], [test "x$USE_INITRD" != "x"])
>  
> -C_CMDLINE="console=ttyAMA0 earlyprintk=pl011,0x1c090000"
> +AS_IF([test "x$X_IMAGE" = "x"],[C_CONSOLE="ttyAMA0"],[C_CONSOLE="hvc0"])
> +C_CMDLINE="console=$C_CONSOLE earlyprintk=pl011,0x1c090000"

Just to check: what happesns if Dom0 tries to write to 0x1c090000?

Shouldn't we override/delete earlyprintk/earlycon here too?

I've applied this as-is, so if we do need to, I'll need a fixup patch.

Thanks,
Mark.
