From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Wed, 6 Oct 2010 18:45:43 +0200
Subject: Kirkwood DMA engine transfer to PCI memory space?
In-Reply-To: <AANLkTi=P6d_Acg49+dMubCvarHednH-so7b1Msapec5m@mail.gmail.com>
References: <20101006093134.GA32436@debian-wegner1.datadisplay.de>
	<AANLkTi=P6d_Acg49+dMubCvarHednH-so7b1Msapec5m@mail.gmail.com>
Message-ID: <20101006164543.GA11519@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saeed,

On Wed, Oct 06, 2010 at 06:27:14PM +0200, saeed bishara wrote:
> The XOR DMA engine has "address decoding windows"  that determines
> where to route transactions issued by the xor. the kernel configs only
> dram windows, you need to open windows for PCI. this ad-hoc code (not
> tested) my help:
> 
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1274,6 +1274,15 @@ mv_xor_conf_mbus_windows(struct
> mv_xor_shared_private *msp,
>                 win_enable |= (1 << i);
>                 win_enable |= 3 << (16 + (2 * i));
>         }
> +       /* set window 4 for pcie 0 */
> +       i = 4;
> +        writel((KIRKWOOD_PCIE_MEM_PHYS_BASE & 0xffff0000) |
> +              (ATTR_PCIE_MEM << 8) |
> +               TARGET_PCIE, base + WINDOW_BASE(i));
> +        writel((KIRKWOOD_PCIE_MEM_SIZE - 1) & 0xffff0000, base +
> WINDOW_SIZE(i));
> +
> +       win_enable |= (1 << i);
> +        win_enable |= 3 << (16 + (2 * i));

thank you for this code!
It looks more sane than my dirty hack, so when we have our FPGA
burst problems solved, this could be the solution.

Somehow I did not see the window setting@first glance, and
the address error was silently ignored in the code, so it took
me some printk's to figure out what was going wrong.

Now I have to figure out how to make use of DMA to speed up
our framebuffer...

Best regards,
Wolfgang
