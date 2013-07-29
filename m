From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 30 Jul 2013 02:46:23 +0400
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7778: add HPB-DMAC support
In-Reply-To: <87a9lacd6o.wl%kuninori.morimoto.gx@renesas.com>
References: <201307230218.01495.sergei.shtylyov@cogentembedded.com>
 <201307230222.04763.sergei.shtylyov@cogentembedded.com>
 <20130726001052.GA28912@verge.net.au>
 <87a9lacd6o.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <51F6F0BF.2030004@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/26/2013 05:39 AM, Kuninori Morimoto wrote:

>>> +static const struct hpb_dmae_slave_config hpb_dmae_slaves[] = {
>>> +	{
>>> +		.id	= HPBDMA_SLAVE_SDHI0_TX,
>>> +		.addr	= 0xffe4c000 + 0x30,
>>> +		.dcr	= DCR_SPDS_16BIT | DCR_DMDL | DCR_DPDS_16BIT,
>>> +		.rstr	= ASYNCRSTR_ASRST21 | ASYNCRSTR_ASRST22 |
>>> +			  ASYNCRSTR_ASRST23,
>>> +		.mdr	= ASYNCMDR_ASMD21_SINGLE,
>>> +		.mdm	= ASYNCMDR_ASMD21_MASK,
>>> +		.port	= 0x0D0C,
>>> +		.flags	= HPB_DMAE_SET_ASYNC_RESET | HPB_DMAE_SET_ASYNC_MODE,
>>> +		.dma_ch	= 21,
>>> +	}, {
>>> +		.id	= HPBDMA_SLAVE_SDHI0_RX,
>>> +		.addr	= 0xffe4c000 + 0x30,
>>> +		.dcr	= DCR_SMDL | DCR_SPDS_16BIT | DCR_DPDS_16BIT,
>>> +		.rstr	= ASYNCRSTR_ASRST21 | ASYNCRSTR_ASRST22 |
>>> +			  ASYNCRSTR_ASRST23,
>>> +		.mdr	= ASYNCMDR_ASMD22_SINGLE,
>>> +		.mdm	= ASYNCMDR_ASMD22_MASK,
>>> +		.port	= 0x0D0C,
>>> +		.flags	= HPB_DMAE_SET_ASYNC_RESET | HPB_DMAE_SET_ASYNC_MODE,
>>> +		.dma_ch	= 22,
>>> +	},

> I'm not sure detail of SDHI, but TX and RX are using same .port = 0x0D0C.

    It's not one port, it's a pair of ports, source and destination.

> Is this correct ?
> And what is 0x0C port ?

    SDHI0 if you look into the table 16.7 of the R-Car M1A manual 1.00 for the 
channels 21 thru 23.

> My datasheet doens't have it on Ch21 - Ch23

    Maybe you're looking at the wrong table or an obsolete manual?

>>> +static const struct hpb_dmae_channel hpb_dmae_channels[] = {
>>> +	/* ch. 21 SD0 */
>>> +	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_TX),
>>> +	/* ch. 22 SD0 */
>>> +	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_RX),
>>> +};
>>> +
>>> +static struct hpb_dmae_pdata dma_platform_data __initdata = {
>>> +	.slaves			= hpb_dmae_slaves,
>>> +	.num_slaves		= ARRAY_SIZE(hpb_dmae_slaves),
>>> +	.channels		= hpb_dmae_channels,
>>> +	.num_channels		= ARRAY_SIZE(hpb_dmae_channels),
>>> +	.ts_shift		= {
>>> +		[XMIT_SZ_8BIT]	= 0,
>>> +		[XMIT_SZ_16BIT]	= 1,
>>> +		[XMIT_SZ_32BIT]	= 2,
>>> +	},
>>> +	.num_hw_channels	= 39,
>>> +};

> This is not a big deal, but according to .num_hw_channels,
> we will have max 39 channels (or more over).

> I want 1 line for 1 channels on hpb_dmae_channels.
> like this

> static const struct hpb_dmae_channel hpb_dmae_channels[] = {
> 	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_TX), /* ch21 */
> 	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_RX), /* ch22 */
> }

    OK, done.

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei
