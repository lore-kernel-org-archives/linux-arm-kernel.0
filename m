From: tj@kernel.org (Tejun Heo)
Date: Sun, 19 Jan 2014 06:14:12 -0500
Subject: [RFC v3 03/13] ahci-platform: Fix clk enable/disable unbalance
 on suspend/resume
In-Reply-To: <1390088935-7193-4-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20140119111412.GA11123@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 12:48:45AM +0100, Hans de Goede wrote:
> For devices where ahci_platform_data provides suspend() there is an unbalance
> in clk enable/disable calls. The suspend path does not disable the clk, but
> the resume path enables it. This commit fixes it by always disabling the clk
> in the suspend path independent of there being an ahci_platform_data suspend
> method.
> 
> On all drivers currently using a suspend method, the suspend method always
> succeeds, so change its return type to void, to avoid having the introduce
> somewhat complex error handling paths.
> 
> The disabling of the clock on suspend is a functional change, to ensure this
> is ok I've audited all drivers using ahci_platform_data:
> 
> arch/arm/mach-davinci/devices-da8xx.c: Does not use a suspend method
> arch/arm/mach-spear/spear1340.c: Does not use the clock framework
> drivers/ata/ahci_imx.c: Does have suspend and resume pdata methods, these
> disable / enable another clock, so likely it is ok to disable / enable the
> clock at of-node index 0 as well, I've ordered a wandboard to be able to
> test these changes.

This isn't your fault but similarly to the previous patch, I'd much
prefer if drivers which need custom ops just override the whole
operation and are allowed to use the default platform from their
custom implementations as they see fit.  Allowing partial overrides
seems like an efficient thing to do at the beginning but if you
continue to stack them, you eventually end up with giant pile of
methods where figuring out which code paths are actually executed
takes quite a bit of effort.  I'd really like to avoid that.

Thanks.

-- 
tejun
