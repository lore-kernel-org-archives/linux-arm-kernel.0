From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 17 Nov 2015 09:15:49 +0300
Subject: [PATCHv2 2/3] staging: ion: Add files for parsing the devicetree
In-Reply-To: <1447721855-7574-3-git-send-email-laura@labbott.name>
References: <1447721855-7574-1-git-send-email-laura@labbott.name>
 <1447721855-7574-3-git-send-email-laura@labbott.name>
Message-ID: <20151117061549.GM18797@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 04:57:34PM -0800, Laura Abbott wrote:
> +	for_each_available_child_of_node(dt_node, node) {
> +		struct platform_device *heap_pdev;
> +
> +		ret = ion_parse_dt_heap_common(node, &heaps[i], compatible);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		heap_pdev = of_platform_device_create(node, heaps[i].name,
> +							&pdev->dev);

We should free these if something fails later in the function.

> +		if (!pdev)
> +			return ERR_PTR(-ENOMEM);
> +		heap_pdev->dev.platform_data = &heaps[i];
> +
> +		heaps[i].priv = &heap_pdev->dev;
> +
> +		ret = ion_setup_heap_common(pdev, node, &heaps[i]);
> +		if (ret)
> +			return ERR_PTR(ret);


regards,
dan carpenter
