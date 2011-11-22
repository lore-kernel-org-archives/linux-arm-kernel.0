From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Nov 2011 09:31:48 +0800
Subject: [RFC PATCH] arm/imx6: convert clock to device tree
In-Reply-To: <4ECA8E37.8010307@gmail.com>
References: <1321895502-32341-1-git-send-email-shawn.guo@linaro.org>
 <4ECA8E37.8010307@gmail.com>
Message-ID: <20111122013147.GD16417@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 11:45:27AM -0600, Rob Herring wrote:
> On 11/21/2011 11:11 AM, Shawn Guo wrote:
> > It converts imx6 clock code to common clock frame and device tree.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > As I promised to Arnd, I will convert imx6 clock code to common clock
> > frame and in turn device tree.  Here it is.
> > 
> > It's based on Mike's common-clk pre-v3 and Grant's clock device tree
> > binding series.
> > 
> > Along with the conversion to device tree, I feel it's a great idea to
> > introduce '#clock-cells'.  With adopting it, I'm using 70 nodes to
> > describe 110 clocks (~35% nodes reduced).  However, the current design
> > of '#clock-cells' makes the user a little difficult.  For example, when
> > a consumer node references to provider node which is a blob of 4 clocks,
> > it has to fill 4 parameters into the phandle.
> > 
> > usdhc at 02198000 { /* uSDHC3 */
> > 	compatible = "fsl,imx6q-usdhc";
> > 	reg = <0x02198000 0x4000>;
> > 	interrupts = <0 24 0x04>;
> > 	clock-input = <&usdhc_clk 2 0 0 0>; <--
> > 	clock-input-name = "usdhc3";
> > };
> > 
> > But we actually need to pass only one parameter to point out the index
> > of the clock in the blob.  It's a little silly to put a number of
> > meaningless 0 there to fill the length of the phandle parameters.  Can
> > we rework the dt core code to make the following one work?
> > 
> > usdhc at 02198000 { /* uSDHC3 */
> > 	compatible = "fsl,imx6q-usdhc";
> > 	reg = <0x02198000 0x4000>;
> > 	interrupts = <0 24 0x04>;
> > 	clock-input = <&usdhc_clk 2>; <--
> > 	clock-input-name = "usdhc3";
> > };
> 
> What you want is how it is supposed to work. Why do you think it is not
> this way?
> 
Looking at of_parse_phandle_with_args(), if we do not fill up these
zeros, it will bail out as following.

		/*
		 * Make sure that the arguments actually fit in the
		 * remaining property data length
		 */
		if (list + count > list_end) {
			pr_debug("%s: insufficient arguments length\n",
				 np->full_name);
			goto err1;
		}

BTW, it seems the patch is too big to reach the mailing list.  I will
split it and repost.

-- 
Regards,
Shawn
