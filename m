From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 23:23:54 +0800
Subject: [PATCH 1/5] Input: ambakmi - Convert to use devm_*()
In-Reply-To: <20170326145023.GO7909@n2100.armlinux.org.uk>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
 <20170326145023.GO7909@n2100.armlinux.org.uk>
Message-ID: <20170326152354.GA11555@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 26, 2017 at 03:50:24PM +0100, Russell King - ARM Linux wrote:
> On Sun, Mar 26, 2017 at 10:41:50PM +0800, Leo Yan wrote:
> > Convert driver to use devm_*() APIs so rely on driver model core layer
> > to manage resources. This eliminates error path boilerplate and makes
> > code neat.
> > 
> > This patch also fixes the memory leakage for 'kmi->io' when remove
> > module.
> 
> No, it is not leaked, in fact, your patch introduces a use-after-free
> bug.
> 
> kmi->io is of type "struct serio", and this structure has an embedded
> "struct device".  The lifetime of any structure containing a "struct
> device" is controlled by the lifetime of the struct device.
> 
> Once serio_register_port() has been called on it, it is up to the
> serio layer to free this structure.
> 
> Therefore, your patch creates a bug, and so it gets a NAK.  There is no
> resource leakage here.

Thanks for reviewing. Now I understood and please ignore this patch
and patch 0005.

Thanks,
Leo Yan
