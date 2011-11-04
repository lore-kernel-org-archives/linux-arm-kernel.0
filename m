From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Nov 2011 11:44:32 -0700
Subject: [PATCH 2/2] USB: ehci-tegra: add probing through device tree
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173F9A4CBC@HQMAIL01.nvidia.com>
References: <1320377174-28047-1-git-send-email-olof@lixom.net>
	<1320377174-28047-2-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A4CBC@HQMAIL01.nvidia.com>
Message-ID: <CAOesGMhXE+-u_PgG3UqccVESrr9_UU3ggPzEhFkFLv2adNzOug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2011 at 8:37 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Thursday, November 03, 2011 9:26 PM:
>> Rely on platform_data being passed through auxdata for now; more elaborate
>> bindings for phy config and tunings to be added.
> ...
>> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
> ...
>> ?static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
>> ? ? ? /* name ? ? ? ? parent ? ? ? ? ?rate ? ? ? ? ? ?enabled */
>> ? ? ? { "uartd", ? ? ?"pll_p", ? ? ? ?216000000, ? ? ?true },
>> + ? ? { "usbd", ? ? ? "clk_m", ? ? ? ?12000000, ? ? ? false },
>> + ? ? { "usb3", ? ? ? "clk_m", ? ? ? ?12000000, ? ? ? false },
>> ? ? ? { NULL, ? ? ? ? NULL, ? ? ? ? ? 0, ? ? ? ? ? ? ?0},
>> ?};
>
> As woglinde mentioned on IRC, I think you do want to add "usb2" to the
> table here; it's in board-paz00.c at least. It shouldn't hurt other boards.

Yeah, I didn't catch it before posting this.

It might make sense to just move them to common.c then, especially
since the clocks aren't enabled in the table. But I'll add usb2 for
now, and we can move them later if it makes sense.

>
>> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> ...
>> @@ -590,6 +617,13 @@ static int tegra_ehci_probe(struct platform_device *pdev)
>> ? ? ? ? ? ? ? return -EINVAL;
>> ? ? ? }
>>
>> + ? ? if (!pdev->dev.dma_mask)
>> + ? ? ? ? ? ? pdev->dev.dma_mask = &tegra_ehci_dma_mask;
>
> Should this come from DT, or is it some more system-level/internal thing
> that doesn't make sense to represent there?

Ideally it should come from the device tree based on dma window
information, but there's currently no way to encode in there what the
dma address limitations of a device is, or at least nothing that is
used generically -- IBM has some custom extensions to encode what part
of the dma address space is mapped for a specific device through the
iommu.

The auxdata function has a comment saying that it is intentionally not
setting up the dma mapping functions and that it should be handled
through a system notifier instead (but it does set the
coherent_dma_mask). As a stepping stone on getting that all sorted out
I just did the simple solution above. I'll add a comment saying it
should go away.

>> +
>> + ? ? vbus_gpio = of_get_named_gpio(pdev->dev.of_node, "nvidia,vbus-gpio", 0);
>
> of_get_named_gpio() does check for NULL node pointer in practice, but is
> it defined to? I wonder if this needs to be conditional of of_node!=NULL
> or not?

Sure, I can wrap it with a test of of_node.

>> + ? ? if (vbus_gpio > 0)
>
> Should that use gpio_is_valid()?

Yep, fixing.



-Olof
