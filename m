From: jslaby@suse.cz (Jiri Slaby)
Date: Tue, 2 Feb 2016 18:19:44 +0100
Subject: [PATCH v6] kernel: add kcov code coverage
In-Reply-To: <1453726850-49137-1-git-send-email-dvyukov@google.com>
References: <1453726850-49137-1-git-send-email-dvyukov@google.com>
Message-ID: <56B0E530.8090908@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2016, 02:00 PM, Dmitry Vyukov wrote:
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -136,6 +136,12 @@ _c_flags += $(if $(patsubst n%,, \
>  		$(CFLAGS_UBSAN))
>  endif
>  
> +ifeq ($(CONFIG_KCOV),y)
> +_c_flags += $(if $(patsubst n%,, \
> +	$(KCOV_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)y), \
> +	$(CFLAGS_KCOV))

Now that KCOV does not inherit KASAN's "n"s, I see link errors in efi
lib with EFI_STUB:
drivers/firmware/efi/libstub/lib.a(efi-stub-helper.o): In function
`efi_printk':
efi-stub-helper.c:(.text+0x13): undefined reference to
`__sanitizer_cov_trace_pc'
efi-stub-helper.c:(.text+0x31): undefined reference to
`__sanitizer_cov_trace_pc'
...

I fixed it by adding "KCOV_INSTRUMENT := n" to
  drivers/firmware/efi/libstub/Makefile

thanks,
-- 
js
suse labs
