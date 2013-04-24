From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Apr 2013 07:53:44 +0100
Subject: [PATCH 04/10] usb: musb: ux500: harden checks for platform data
In-Reply-To: <5176E927.908@cogentembedded.com>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-5-git-send-email-lee.jones@linaro.org>
 <5176E927.908@cogentembedded.com>
Message-ID: <20130424065344.GB17416@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

> >  	struct musb_hdrc_platform_data *plat = dev->platform_data;
> >-	struct ux500_musb_board_data *data = plat->board_data;
> >+	struct ux500_musb_board_data *data;

> >-	param_array = data->dma_rx_param_array;
> >+	param_array = (data) ? data->dma_rx_param_array : NULL;
> 
>    Why enclose a simple variable in parens?

Because 'data' is a pointer, so it contains a memory location, but if
'plat->board_data' is NULL, then 'data' will be NULL (essentially
memory location 0x00000000).

So if we were to read-in to 'struct ux500_musb_board_data *data', by
index 'dma_rx_param_array', which I believe is '0' in this case:

struct ux500_musb_board_data {
        void    **dma_rx_param_array;
        void    **dma_tx_param_array;
        bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
};

... then we're saying take the data from this memory location:

param_array = *((0x00000000)->(0x0));

Which will cause a kernel Oops, due to the fact that address 0x0 isn't
allocated to us, so you get something like:

"Unable to handle kernel NULL pointer dereference at virtual address 00000000"

Hope that helps.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
