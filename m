From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 25 Sep 2016 18:07:30 +0200
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
References: <20160905105803.13ed27ff@canb.auug.org.au>
 <20160905182603.GS1041@n2100.armlinux.org.uk>
Message-ID: <871t08c69p.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Mon, Sep 05, 2016 at 10:58:03AM +1000, Stephen Rothwell wrote:
>> I fixed it up (I deleted the file) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.

...zip...
> Since the patch in my tree is fixing a regression caused by the broken
> conversions, I'm not mindful to drop it from the merge window - I
> actually want to push it into -rc kernels.  We _do_ need to fix the
> DT regressions, and quickly though, and push those with this patch.
>
> Since I don't use the SMC91x with DT, that's outside of what I can
> test, so consider this a call for help on that subject.
Then consider you have one more tester, for a 16-bits access.

My lubbock is now DT aware, with a smc91x ethernet card actually working,
provided the small patch in [2].

Cheers.

-- 
Robert

[1] DT extract
	ethernet at extbus {
		compatible = "smsc,lan91c94";
		reg = <0x0c000c00 0x100000 0x0e00000 0x100000>;
		reg-names = "smc91x-regs", "smc91x-attrib";
		interrupts-extended = <&pxa_cplds_irqs 3 IRQ_TYPE_EDGE_RISING>;
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_eth_default>;
		reg-io-width = <2>;
		reg-io-shift = <2>;
	};


[2] Patch for lubbock
---8>---
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 726b80f45906..6d4fdac6c0e0 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2316,6 +2316,9 @@ static int smc_drv_probe(struct platform_device *pdev)
 		} else {
 			lp->cfg.flags |= SMC91X_USE_16BIT;
 		}
+		if (!device_property_read_u32(&pdev->dev, "reg-io-shift",
+					      &val))
+			lp->io_shift = val;
 	}
 #endif
 
