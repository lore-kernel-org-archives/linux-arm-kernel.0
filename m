From: viresh.kumar@linaro.org (viresh kumar)
Date: Thu, 11 Oct 2012 09:45:59 +0530
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
 <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
Message-ID: <CAOh2x=ksMr7VRCnpF-rK+Mesg1p4Td++SQ-t=ShrguRRVWSSSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 10:37 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Oct 9, 2012 at 12:44 PM, Vipin Kumar <vipin.kumar@st.com> wrote:

> The real problem is likely the DMA driver. The stuf that get
> fed into dma.device_prep_dma_memcpy() needs to be
> converted to a scatterlist and then set up in the LLI list
> for the controller.
>
> IIRC SPEAr is using drivers/dma/dw_dmac.c so
> check this driver's dwc_prep_dma_memcpy().
> It does seem like it is checking whether src or
> dest is scattered in this for() loop:
>
> for (offset = 0; offset < len; offset += xfer_count << src_width) {}
>
> dma_sync_single_for_device() is translating the virtual
> address to physical for every chunk BTW.

I pray that i am wrong here, otherwise i would be thrown out from
the maintainers list for this driver :)

dma_sync_single_for_device() is not doing anything on the buffer, but
on the LLI item. Actually it is flushing LLI struct so that DMA h/w can get
the correct values.

dwc_prep_dma_memcpy() doesn't expect a virtual address, look at type
of src & dest bufs: dma_addr_t. It is responsibility of user drivers to pass
physically contiguous address to it.

--
viresh
