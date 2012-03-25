From: dirk.behme@googlemail.com (Dirk Behme)
Date: Sun, 25 Mar 2012 08:21:17 +0200
Subject: uImage with integrated dtb file
In-Reply-To: <4F6E5D5B.8050306@antcom.de>
References: <4F6E5D5B.8050306@antcom.de>
Message-ID: <4F6EB95D.7040601@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.03.2012 00:48, Roland Stigge wrote:
> Hi,
>
> since I will need to maintain some machines with DT enabled kernels but
> containing a U-Boot without DT support, I sometimes need to integrate a
> dtb file into uImage.
>
> I'm sure others have got the same issue. But searching for a while I
> only got older/meanwhile neglected approaches like:
>
> git://kernel.ubuntu.com/jk/dt/linux-2.6.git - branch: dtbimage

Would have been nice if you would have provided a http link ;)

> I'm currently using a simple hack like attached below.
>
> Wondering what others are doing.

In the past I saw people using something like

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-September/064353.html

I'm not sure if the is the most recent version, though.

Best regards

Dirk

> Sorry if this topic has already been discussed.
>
> Roland
>
>
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -70,9 +70,11 @@ $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
>   clean-files := *.dtb
>
>   quiet_cmd_uimage = UIMAGE  $@
> -      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
> +      cmd_uimage = cat $<  arch/arm/boot/*.dtb>  $<.tmp ; \
> +                  $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
>                     -C none -a $(LOADADDR) -e $(STARTADDR) \
> -                  -n 'Linux-$(KERNELRELEASE)' -d $<  $@
> +                  -n 'Linux-$(KERNELRELEASE)' -d $<.tmp $@ ; \
> +                  rm -f $<.tmp
>
>   ifeq ($(CONFIG_ZBOOT_ROM),y)
>   $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
