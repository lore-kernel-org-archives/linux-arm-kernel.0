From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 17 Apr 2015 07:59:45 +0900
Subject: [query] how to use "ranges" in device tree
In-Reply-To: <20150416215938.347caa68@xhacker>
References: <20150416215938.347caa68@xhacker>
Message-ID: <55303EE1.1050108@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Well, I'm not sure..
But in my understanding..configuration range might be support both "ranges" and "config" of reg.

On 04/16/2015 10:59 PM, Jisheng Zhang wrote:
> Hi all,
> 
> I didn't fully understand the "ranges" usage, here is one situation which I dunno
> how to handle.
> 
> In arch/arm/boot/dts/berlin2q.dtsi, we describe the /soc ranges as
> 
> ranges = <0 0xf7000000 0x1000000>;
> 
> That's fine. Now there's a pci device based on pcie-designware.c which prefer
> put "config" space in reg. But the config space starts at 0xe0000000, due to
> the /soc ranges, the "config" space following pcie node is not correct in fact.
> 
> soc {
> 	ranges = <0 0xf7000000 0x1000000>;
> 	...
> 	pcie: pcie at e40000 {
> 		compatible = "...";
> 		reg = <0xe40000 0x10000>, <0xe0000000 0x8000000>;
> 		reg-names = "dbi", "pad", "config";
> 		...
> 	};
> 	...
> };

According to yours,

reg = <0xe40000 0x1000		/* dbi */
	0xe000000 0x800000	/* pad */
	0xf7000000 0x1000000>;	/* config ? */

If there is not "config" into reg-names, it should be tried to find it into "ranges".

If my understanding is wrong, let me know, plz.

In my case,

	reg = <0x156b0000 0x1000
		0x15680000 0x1000
		0x0c000000 0x1000>;
	reg-names = "elbi", "phy", "config";

	ranges = < ..... /* downstream I/O */
		  ...... /* non-prefetchable memory */


Best Regards,
Jaehoon Chung	

> 
> How to define the "config" space in this situation? Did we need to change
> the /soc ranges as the following?
> 
> soc {
> 	ranges;
> }
> 
> Thanks in advance,
> Jisheng
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
