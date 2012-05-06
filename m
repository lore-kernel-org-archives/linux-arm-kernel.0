From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 6 May 2012 14:21:42 +0300
Subject: [PATCH v2 3/3] omap: remoteproc: add support for a boot register
In-Reply-To: <1334360392-1494-4-git-send-email-jgutierrez@ti.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-4-git-send-email-jgutierrez@ti.com>
Message-ID: <CAK=Wgbb4bJ22BYh444Xndaody7Q7Eoox3K7zvGCFmf6ZMHAa0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juan,

Thanks for the patches ! it's exciting to see that support for OMAP's
DSP is (relatively) easily achieved now. I hope your work can be a
good basis for an OMAP3 port, too.

Overall the patches look good, I have only some minor comments inline.

And - sorry for the late response. I've just left for a (somewhat
long) business trip when you posted this.

On Sat, Apr 14, 2012 at 2:39 AM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> Some remote processors (like Omap4's DSP) need to explicitly
> configure a boot address in a special register or memory
> location

Let's just slightly rephrase this to prevent confusion: some remote
processors "need to have the boot address configured" in a special
register (as opposed to "need to configure").

> @@ -30,6 +30,7 @@ struct platform_device;
> ?* @ops: start/stop rproc handlers
> ?* @device_enable: omap-specific handler for enabling a device
> ?* @device_shutdown: omap-specific handler for shutting down a device
> + * @boot_reg: physical address of the control register for storing boot address
> ?*/
> ?struct omap_rproc_pdata {
> ? ? ? ?const char *name;
> @@ -40,6 +41,7 @@ struct omap_rproc_pdata {
> ? ? ? ?const struct rproc_ops *ops;
> ? ? ? ?int (*device_enable) (struct platform_device *pdev);
> ? ? ? ?int (*device_shutdown) (struct platform_device *pdev);
> + ? ? ? u32 boot_reg;

We might want to use an IORESOURCE_MEM resource instead, since we're
dealing with a platform device anyway.

The driver can then fetch the address using platform_get_resource.

> @@ -203,6 +215,9 @@ static int __devinit omap_rproc_probe(struct platform_device *pdev)
> ? ? ? ?return 0;
>
> ?free_rproc:
> + ? ? ? if (oproc->boot_reg)
> + ? ? ? ? ? ? ? iounmap(oproc->boot_reg);
> +err_ioremap:
> ? ? ? ?rproc_free(rproc);
> ? ? ? ?return ret;
> ?}

I tend to call those cleanup snippets with names that indicate what they do.

In this case I'd slightly prefer to keep calling the lower snippet
with "free_rproc" and just name the new snippet with something like
"unmap_bootreg". It's then a bit easier to read the code that calls
into those snippets (the reader easily know which cleanup snippet is
invoked by each 'goto').

Thanks,
Ohad.
