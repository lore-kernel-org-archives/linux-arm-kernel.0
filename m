From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Aug 2011 11:26:27 +0100
Subject: [PATCH V2 08/20] dmaengine/amba-pl08x: support runtime PM
In-Reply-To: <bc59bbd3709a7af1723d37ab846bf44c6867c00e.1312190881.git.viresh.kumar@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
	<bc59bbd3709a7af1723d37ab846bf44c6867c00e.1312190881.git.viresh.kumar@st.com>
Message-ID: <20110801102627.GF15578@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 03:07:18PM +0530, Viresh Kumar wrote:
> @@ -1993,6 +2002,8 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>  	dev_info(&pl08x->adev->dev, "DMA: PL%03x rev%u at 0x%08llx irq %d\n",
>  		 amba_part(adev), amba_rev(adev),
>  		 (unsigned long long)adev->res.start, adev->irq[0]);
> +
> +	pm_runtime_suspend(&adev->dev);

Having read the runtime pm documentation, devices are assumed to be
suspended at probe time, and there should be a call to pm_runtime_enable()
in here.  See Documentation/power/runtime_pm.txt chapter 5.

However, this is complicated by the core managing the peripheral clock,
which starts off in the enabled state.  So there's only one sane solution,
which is to tell the runtime PM that the device is already active.  So
I think a primecell's probe function should look like this:

primecell_probe()
{
	ret = amba_request_regions(adev, NULL);
	if (ret)
		return ret;

	... allocate stuff, don't access primecell though ...

	pm_runtime_set_active(&adev->dev);
	pm_runtime_enable(&adev->dev);

	... get clocks and enable them, do rest of init ...

	pm_runtime_put_sync(&adev->dev);
	return 0;
}
