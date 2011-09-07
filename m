From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2011 01:01:15 +0200
Subject: [PATCH 16/18] dmaengine/amba-pl08x: Add support for sg len
	greater than one for slave transfers
In-Reply-To: <438BB0150E931F4B9CE701519A4463010871804A4C@bgsmsx502.gar.corp.intel.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
	<20110814083618.GE4986@n2100.arm.linux.org.uk>
	<4E4CCF7B.8060704@st.com>
	<20110821083306.GA12028@n2100.arm.linux.org.uk>
	<4E532B19.6000103@st.com> <4E5715CE.2070806@st.com>
	<CACRpkdapSvW=eMSoXTOOA2GyhfBLzq2OuyQcDctPxsnVzvr-4g@mail.gmail.com>
	<4E575E75.40603@st.com> <4E5F594D.10203@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A4C@bgsmsx502.gar.corp.intel.com>
Message-ID: <CAKnu2Mp3Ui7jZS2kjJykjuzcTzJhiAkoaVxZ2+tQX0banGh6mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/7 Koul, Vinod <vinod.koul@intel.com>:
> On Thu, 2011-09-01 at 15:37 +0530, Viresh Kumar wrote:
>> On 8/26/2011 2:21 PM, Viresh Kumar wrote:
>> > I just wanted to know, whether i need to do any other modification in this patch or not?
>>
>> Hello,
>>
>> Do i need to update anything in this patch? Or can this be pushed as it is?
>>
> I thought Linus W, and Russell had some comments on this.

I think the patch brings valuable functionality we don't want to loose when
there is a solution. Basically the dmaengine has a contract to handle
sglists of any lengths and it's a pity that we don't, and I suspect Viresh
cannot use the driver for MMC unless something like this is added, so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

BUT I think it is possible to rewrite it a bit later so as to get a better
handling of this. Isn't Russells initial remark that the LLI:s can simply just
take in the entire sglist at once true?

Check for example in drivers/dma/coh901318.c which evidently has
a LLI format similar or identical to what pl08x use (which is another
reason to refactor this later):

It will just fill in LLIs for all the elements of the sglist, and off you go.

Like this:

       /* The dma only supports transmitting packages up to
         * MAX_DMA_PACKET_SIZE. Calculate to total number of
         * dma elemts required to send the entire sg list
         */
        for_each_sg(sgl, sg, sg_len, i) {
                unsigned int factor;
                size = sg_dma_len(sg);

                if (size <= MAX_DMA_PACKET_SIZE) {
                        len++;
                        continue;
                }

                factor = size >> MAX_DMA_PACKET_SIZE_SHIFT;
                if ((factor << MAX_DMA_PACKET_SIZE_SHIFT) < size)
                        factor++;

                len += factor;
        }

        pr_debug("Allocate %d lli:s for this transfer\n", len);
        lli = coh901318_lli_alloc(&cohc->base->pool, len);

        if (lli == NULL)
                goto err_dma_alloc;

        /* initiate allocated lli list */
        ret = coh901318_lli_fill_sg(&cohc->base->pool, lli, sgl, sg_len,
                                    cohc_dev_addr(cohc),
                                    ctrl_chained,
                                    ctrl,
                                    ctrl_last,
                                    direction, COH901318_CX_CTRL_TC_IRQ_ENABLE);
        if (ret)
                goto err_lli_fill;


The rest of interesting code is in coh901318_lli_fill_sg() as you can
see.

Evidently this need to be fixed as part of factoring out the LLI handling
from PL08x and coh901318 into a single one. If we ever get to it.

Yours,
Linus Walleij
