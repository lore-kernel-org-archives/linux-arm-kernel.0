From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Feb 2016 17:29:40 +0100
Subject: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host
 controller ECAM compliant
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECACF44@lhreml503-mbs>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <3532826.pJr5R5Xa4c@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECACF44@lhreml503-mbs>
Message-ID: <2599997.xBRrI3qHak@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 15:55:35 Gabriele Paoloni wrote:
> > Doesn't this break backwards compatibility?
> 
> Well Hip05/Hip06 SoCs are used into evaluation boards
> For the Estuary project.
> 
> https://github.com/hisilicon/estuary
> 
> As this new driver gets upstream we'll merge this new driver into estuary
> and release a new version of the firmware to support it.

So what happens to folks running the old firmware then?

> > I think you need to use a new compatible string in the firmware
> > if you change the register layout, and then change the driver
> > to support both the old and the new layout.
> 
> You are right, for some reason in this patchset I missed the Documentation
> update that I posted in the previous one, i.e.:
> 
> --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -23,8 +23,8 @@ Optional properties:
>  Hip05 Example (note that Hip06 is the same except compatible):
>         pcie at 0xb0080000 {
>                 compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
> -               reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
> -               reg-names = "rc_dbi", "config";
> +               reg = <0 0xb0080000 0 0x10000>, <0x220 0x00100000 0 0x0f00000>;
> +               reg-names = "rc_dbi", "ecam-cfg";
> 

That is not the compatible string, it's an undocumented register set.
You can either define the a new compatible string that gives the "config"
registers a new meaning, or you change the binding to allow two either
a "config" or an "ecam-cfg" register set, and let the driver handle both.

	Arnd
