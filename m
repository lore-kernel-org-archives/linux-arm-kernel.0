From: albeu@free.fr (Alban)
Date: Tue, 21 Aug 2018 13:39:16 +0200
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
In-Reply-To: <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl>
 <20180817182720.6a6e5e8e@bbrezillon> <20180819133106.0420df5f@tock>
 <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
 <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
Message-ID: <20180821133916.3a1c51b1@eos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Aug 2018 10:50:07 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> Just curious...Is there a reason why we can't do it like this?:
> Is this because of issue of #address-cells and #size-cells Or mtd 
> bindings always prefer subnodes?
> 
> 	mtdnode {
> 		reg = <0x0123000 0x40000>;
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		cell at 0 {
> 			compatible = "nvmem-cell";
> 			reg = <0x0 0x14>;
> 		};
> 
> 		partitions {
> 			compatible = "fixed-partitions";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 
> 			partition at 0 {
> 				reg = <0x0 0x20000>;
> 				cell at 0 {
> 					compatible = "nvmem-cell";
> 					reg = <0x0 0x10>;
> 				};
> 			};
> 		};
> 	};

That would work, the MTD partitions parser ignore child nodes with a
compatible string when looking for "old style" partitions, see [1].
However we still have the a potential address space clash between the
nvmem cells and the main device binding.

Alban

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/mtd/ofpart.c#L28
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180821/1832621d/attachment.sig>
