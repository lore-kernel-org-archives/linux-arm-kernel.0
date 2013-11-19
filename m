From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Nov 2013 14:58:05 -0700
Subject: [PATCH V4] kbuild: dtbs_install: new make target
In-Reply-To: <1384896475-8744-1-git-send-email-jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1384896475-8744-1-git-send-email-jason@lakedaemon.net>
Message-ID: <528BDEED.8080708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 02:27 PM, Jason Cooper wrote:
> Unlike other build products in the Linux kernel, there is no 'make
> *install' mechanism to put devicetree blobs in a standard place.
> 
> This patch is an attempt to fix this problem.  Akin to 'make install',
> this creates a new make target, dtbs_install.  The script that gets
> called defers to a distribution or user supplied installdtbs binary,
> if found in the system.  Otherwise, the default action is to install a
> given dtb into
> 
>   /lib/modules/${kernel_version}/devicetree/${dts_filename}.dtb

I still don't see why you wouldn't install the files in
/lib/devicetrees, but I suppose that location is fine.

> This is done to keep dtbs from different kernel versions separate until
> things have settled down.  Once the dtbs are stable, and not so strongly
> linked to the kernel version, the devicetree files will most likely move
> to their own repo.  Users will need to upgrade install scripts at that
> time.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
> Question: should I make a note about the filenames not being considered an ABI,
> or just let it be?

I still believe they're an ABI.

I guess Grant meant that they aren't an ABI to the kernel at run-time,
unlike the content which is an ABI. That's fine.

However, I believe the files certainly are an ABI to any script that
takes them from the "make dtbs_install" output directory.

Perhaps the best resolution is to just say nothing and let it be:-)

> diff --git a/arch/arm/Makefile b/arch/arm/Makefile

> +dtbs_install: dtbs
> +	$(CONFIG_SHELL) $(srctree)/scripts/installdtbs.sh $(KERNELRELEASE) \
> +	"$(MODLIB)/devicetree" "$(srctree)/$(boot)/dts"

I still think this rule should be in Makefile not arch/arm/Makefile.

Aside from those couple of issues, this version looks OK to me.
