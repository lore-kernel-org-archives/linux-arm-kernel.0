From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 23 Aug 2016 09:38:12 -0700
Subject: [PATCH v2 2/4] remoteproc: Introduce Qualcomm ADSP PIL
In-Reply-To: <ae9f06c0-6e5e-8c33-f239-2fd60e2e6682@linaro.org>
References: <1471931866-3107-1-git-send-email-bjorn.andersson@linaro.org>
 <1471931866-3107-2-git-send-email-bjorn.andersson@linaro.org>
 <ae9f06c0-6e5e-8c33-f239-2fd60e2e6682@linaro.org>
Message-ID: <20160823163812.GB15161@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 23 Aug 08:14 PDT 2016, Stanimir Varbanov wrote:

> Hi Bjorn,
> 
> On 08/23/2016 08:57 AM, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > 
> > The Qualcomm ADSP Peripheral Image Loader is used on a variety of
> > different Qualcomm platforms for loading firmware into and controlling
> > the Hexagon based ADSP.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - Added platform names to compatibility
> > - Removed some incorrect quirks that tried to handle older platforms
> > 
> 
> <cut>
> 
> > +
> > +static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
> > +{
> > +	struct device_node *node;
> > +	struct resource r;
> > +	int ret;
> > +
> > +	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
> > +	if (!node) {
> > +		dev_err(adsp->dev, "no memory-region specified\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = of_address_to_resource(node, 0, &r);
> > +	if (ret)
> > +		return ret;
> > +
> 
> I think that the parsing of memory-region and subsequent
> address_to_resource is not so good. I had the same issue with Venus
> remoteproc driver and come to the more standard way by using
> of_reserved_mem_device_init() and dma_alloc_coherent.
> 

I tried this in an earlier version. But on 8974 the adsp is supposed to
be loaded at 0xdc00000, where we have a chunk that's 0x1900000 (25.6MB).

The problem is that dma_alloc_coherent(25.6MB) will fail, because there
is not 32MB free in that 25.6MB region. This stems from how
dma_alloc_coherent() is implemented, so some work would need to be done
there.


Further more, in remoteproc you are expected to provide a resource table
detailing carveout regions like this - a table that's supposed to come
from the ELF. We are currently looking into ways of injecting individual
resource requests from a remoteproc driver, so I hope to replace this
with a "rproc_add_carveout()".

But then this shows another issue with using dma_alloc_coherent(), it
suddenly requires us to create dummy devices for each memory region; to
be able to control which dma_mem should be used for each operation.


So, I intend to move most of this handling into the remoteproc core, but
I'm still uncertain if I we will not just have the same logic, but
shared in the core...

> Could you review "[PATCH 0/4] Venus remoteproc driver" patchset in this
> regard?
> 

I will, sorry for the delays.

> > +	adsp->mem_phys = adsp->mem_reloc = r.start;
> > +	adsp->mem_size = resource_size(&r);
> > +	adsp->mem_region = devm_ioremap_wc(adsp->dev, adsp->mem_phys, adsp->mem_size);
> > +	if (!adsp->mem_region) {
> > +		dev_err(adsp->dev, "unable to map memory region: %pa+%zx\n",
> > +			&r.start, adsp->mem_size);
> > +		return -EBUSY;
> > +	}
> > +
> > +	return 0;
> > +}
> > +

Regards,
Bjorn
