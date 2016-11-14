From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 14 Nov 2016 12:48:57 +0300
Subject: [PATCH v2] staging: vc04_services: rework ioctl code path
In-Reply-To: <20161111061531.23507-1-mzoran@crowfest.net>
References: <20161111061531.23507-1-mzoran@crowfest.net>
Message-ID: <20161111134646.GI28701@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 10:15:31PM -0800, Michael Zoran wrote:
> +static void *
> +vchiq_ioctl_kmalloc(struct vchiq_ioctl_call_context *ctxt, size_t size)
> +{
> +	void *mem;
> +
> +	if (!ctxt->stackmem_used && size < sizeof(ctxt->stackmem)) {
> +		ctxt->stackmem_used = true;
> +		return ctxt->stackmem;
> +	}
> +
> +	mem = kmalloc(size + sizeof(void *), GFP_KERNEL);

This is a potential integer overflow leading to corruption.  I don't
understand why we need this complicated memory management anyway...

> +	if (!mem)
> +		return NULL;
> +
> +	*(void **)mem = ctxt->prev_kmalloc;
> +	ctxt->prev_kmalloc = mem;
> +
> +	return mem + sizeof(void *);
> +}

regards,
dan carpenter
