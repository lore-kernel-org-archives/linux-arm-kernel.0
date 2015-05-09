From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 10:26:26 +0100
Subject: Bulid regression with VDSO enabled
In-Reply-To: <554D276D.9040205@mentor.com>
References: <391d6fc127b78ef4cbc5443557f0665a@agner.ch>
 <554CD5F8.10901@mentor.com>
 <983cc33a8e5704f4281a7d30bbc9d1d2@agner.ch>
 <554D276D.9040205@mentor.com>
Message-ID: <20150509092626.GM2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 04:15:25PM -0500, Nathan Lynch wrote:
> I suppose it's possible to make arch/arm/vdso/Makefile honor LD, but it
> would basically entail a rewrite.  In the meantime, using -fuse-ld=bfd
> may suffice:
> 
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index 8aa791051029..da0ce897edde 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -43,6 +43,7 @@ quiet_cmd_vdsold = VDSO    $@
>        cmd_vdsold = $(CC) $(c_flags) -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) \
>                     $(call cc-ldoption, -Wl$(comma)--build-id) \
>                     -Wl,-Bsymbolic -Wl,-z,max-page-size=4096 \
> +                   $(call cc-option, -fuse-ld=bfd) \
>                     -Wl,-z,common-page-size=4096 -o $@

Would it make more sense to have something like:

VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,-z,max-page-size=4096 \
		-Wl,-z,common-page-size=4096 \
		$(call cc-ldoption, -Wl$(comma)--build-id) \
		$(call cc-option, -fuse-ld=bfd)

and then have:

	 cmd_vdsold = $(CC) $(c_flags) $(VDSO_LDFLAGS) \
		      -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@

Also, do we want to use cc-option or cc-ldoption (this question becomes
obvious when you arrange the Makefile as I have above...)?  cc-option
doesn't result in the linker actually being run, where as cc-ldoption
does.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
