From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 May 2014 17:51:05 +0100
Subject: [PATCH 1/3] driver core/platform: don't leak memory allocated
 for dma_mask
In-Reply-To: <1401122483-31603-1-git-send-email-emilgoode@gmail.com>
References: <1401122483-31603-1-git-send-email-emilgoode@gmail.com>
Message-ID: <20140526165105.GD3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 06:41:21PM +0200, Emil Goode wrote:
> @@ -211,6 +215,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
>  		strcpy(pa->name, name);
>  		pa->pdev.name = pa->name;
>  		pa->pdev.id = id;
> +		pa->pdev.dev.dma_mask = &pa->dma_mask;

There is code in the kernel which, rightly or wrongly, checks whether
dev->dma_mask is NULL to determine whether the device can do any kind
of DMA.  The above results in devices allocated via this interface
always having this member set, which is a change of core kernel behaviour.

How sure are you that this will not break anything?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
