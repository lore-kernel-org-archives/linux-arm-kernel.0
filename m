From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 4 Jul 2017 14:51:18 +0300
Subject: [PATCH] thermal: imx: interpret fsl,tempmon-data through nvmem
In-Reply-To: <d1a8ec1ef73aefe6018f6a4923bd04b3ac34a5d4.1497879110.git.leonard.crestez@nxp.com>
References: <d1a8ec1ef73aefe6018f6a4923bd04b3ac34a5d4.1497879110.git.leonard.crestez@nxp.com>
Message-ID: <1499169078.16068.26.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-06-19 at 16:40 +0300, Leonard Crestez wrote:
> On imx6sx accessing the ocotp memory area directly is wrong because the
> ocotp clock needs to be enabled first. Fix this by reinterpreting the
> fsl,tempmon-data phandle as a reference to a nvmem_device and doing all
> the read through that.
> 
> This clock requirement does not apply to older imx6qdl chips because
> there the ocotp access clock (clk_ipg_s) is always enabled.
> 
> This is visible by comparing the "System Clocks, Gating, and Override"
> tables (OCOTP rows) in the 6DQ and 6SX manuals:
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6SXRM.pdf
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
> 
> This happens to work right now without this patch because the ocotp
> clock might be enabled for some other reason. In particular it might be
> enabled from the bootloader and it only gets disabled late during boot
> in clk_disable_unused, after imx-thermal has completed probing.
> 
> If imx-thermal is compiled as a module then the system can hang on
> probe.
> 
> This makes IMX_THERMAL depend on NVMEM_IMX_OCOTP but that driver seems
> be already available for all chips that contain tempmon so it's
> acceptable.
> 
> Reported-by: Lothar Wa?mann <LW@KARO-electronics.de>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
> 
> This was reported as a comment to a patch adding tempmon support for
> imx6ul (which is very similar to imx6sx). Since it already affects a
> supported chip this patch is sent as a separate bugfix.
> 
> Link: https://lkml.org/lkml/2017/6/9/578
> 
> There are various other ways to fix this problem. The main advantage of
> this solution is that it does not add a new binding but rather preserves
> compatibility with old DTBs. It also aligns with the idea that
> devicetree describes hardware relationships rather than a specific linux
> implementation.
> 
> An alternative would have been to add a nvmem-cells binding to imx-thermal and
> use that if available instead of fsl,tempmon-data. It might not be good to
> sidestep the official nvmem bindings, the devicetree people were added so that
> they have an opportunity to object.
> 
> In theory the "thermal grade" is a two-bit quantity and might be a
> candidate for using a cell with a "bits" binding. However this causes
> the nvmem core to issue reads of length and alignment less than 4 to the
> imx-ocotp driver so additional fixes might be required.
> 

It's been two weeks without a reply, any advice on how to proceed?
Since the original message is quite long I will summarize the main
question:

Is it OK to reinterpret the fsl,tempmon-data property as a nvmem
reference instead of a "raw" syscon regmap?

--
Regards,
Leonard
