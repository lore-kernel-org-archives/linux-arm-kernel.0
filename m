From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 26 Mar 2017 15:50:24 +0100
Subject: [PATCH 1/5] Input: ambakmi - Convert to use devm_*()
In-Reply-To: <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20170326145023.GO7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 26, 2017 at 10:41:50PM +0800, Leo Yan wrote:
> Convert driver to use devm_*() APIs so rely on driver model core layer
> to manage resources. This eliminates error path boilerplate and makes
> code neat.
> 
> This patch also fixes the memory leakage for 'kmi->io' when remove
> module.

No, it is not leaked, in fact, your patch introduces a use-after-free
bug.

kmi->io is of type "struct serio", and this structure has an embedded
"struct device".  The lifetime of any structure containing a "struct
device" is controlled by the lifetime of the struct device.

Once serio_register_port() has been called on it, it is up to the
serio layer to free this structure.

Therefore, your patch creates a bug, and so it gets a NAK.  There is no
resource leakage here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
