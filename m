From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Sep 2016 10:24:50 +0100
Subject: [PATCH] ARM: fix linker call for ARM_MODULE_PLTS
In-Reply-To: <HE1PR07MB14835C6A5F6AA3A905E40018FAE50@HE1PR07MB1483.eurprd07.prod.outlook.com>
References: <HE1PR07MB14835C6A5F6AA3A905E40018FAE50@HE1PR07MB1483.eurprd07.prod.outlook.com>
Message-ID: <20160902092450.GB1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 09:17:58AM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
> module.lds script doesn't get called when
> CONFIG_ARM_MODULE_PLTS is enabled.
> Use KBUILD_LDFLAGS_MODULE to fix it.

For those of us who haven't encountered this problem, could you include
some commentry in the commit message describing the failure mechanism
and why you think this is the correct solution?

The final link for modules is:

quiet_cmd_ld_ko_o = LD [M]  $@
      cmd_ld_ko_o = $(LD) -r $(LDFLAGS)                                 \
                             $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE) \
                             -o $@ $(filter-out FORCE,$^)

which seems to always include both flags.  Why is it ignored when it's
in LDFLAGS_MODULE?  What about the other flags we pass in LDFLAGS_MODULE?

Thanks.

> 
> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 61f6ccc..01c6025 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -20,7 +20,7 @@ LDFLAGS_MODULE	+= --be8
>  endif
>  
>  ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
> -LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
> +KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
>  endif
>  
>  OBJCOPYFLAGS	:=-O binary -R .comment -S
> -- 
> 1.7.12.4

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
