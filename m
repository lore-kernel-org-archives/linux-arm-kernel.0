From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 04 Mar 2014 12:13:42 +0100
Subject: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
In-Reply-To: <20140304110706.GA12727@katana>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <2207635.bd10VfTU6U@avalon> <20140304110706.GA12727@katana>
Message-ID: <3106573.JU29eCDXeo@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tuesday 04 March 2014 12:07:06 Wolfram Sang wrote:
> > > > While the parent is indeed selected at boot time only, and only one
> > > > parent is thus needed, parent selection could be performed by a DIP
> > > > switch connected to MD_CLK on the board for instance. In that case
> > > > both parents should be available in DT, as selection will be done by
> > > > the kernel at boot time, not at DT compile time.
> > > 
> > > OK, I understand the case. I still wonder about specifying two parents,
> > > though. If a board uses USB_X1, it then has to spefify a dummy EXTAL
> > > clock (or an empty one), just because USB_X1 is enumerated as second
> > > entry?
> > 
> > That's a good question. Mike, would it be possible to support "holes" in
> > the DT clocks lists, like the GPIO DT bindings do ?
> 
> I am currently playing with the status property for clocks, so we can
> "disable" clocks. Opinions?

Could you please provide an example of how you would like to use that ?

> From: Wolfram Sang <wsa@sang-engineering.com>
> Subject: [PATCH] clk: allow clocks to use the 'status' property
> 
> Similar to platform devices, this allows us to set up the clock
> hierarchy in dtsi files and enable the used clocks in the board file
> later.
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>  drivers/clk/clk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 5517944..0045f55 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2542,6 +2542,9 @@ void __init of_clk_init(const struct of_device_id
> *matches) matches = &__clk_of_table;
> 
>  	for_each_matching_node_and_match(np, matches, &match) {
> +		if (!of_device_is_available(np))
> +			continue;
> +
>  		of_clk_init_cb_t clk_init_cb = match->data;
>  		clk_init_cb(np);
>  	}

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140304/2e1916f0/attachment.sig>
