From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 19:07:23 +0200
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
Message-ID: <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 12:44 PM, Vipin Kumar <vipin.kumar@st.com> wrote:

> read_buf/write_buf callbacks should be able to accept a user space memory
> address (virtually contiguous memory) as buffer pointer.
>
> This patch allocates a logically contiguous memory area which is use for dma

You mean PHYSICALLY contigous, don't you?

> xfers during read and write accesses.
>
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>

If you really want a physically contigous buffer you need to use
CMA, but I don't think that is the real problem here...

We're already using userspace buffers in e.g. the MMCI driver
(drivers/mmc/host/mmci.c).

The real problem is likely the DMA driver. The stuf that get
fed into dma.device_prep_dma_memcpy() needs to be
converted to a scatterlist and then set up in the LLI list
for the controller.

IIRC SPEAr is using drivers/dma/dw_dmac.c so
check this driver's dwc_prep_dma_memcpy().
It does seem like it is checking whether src or
dest is scattered in this for() loop:

for (offset = 0; offset < len; offset += xfer_count << src_width) {}

dma_sync_single_for_device() is translating the virtual
address to physical for every chunk BTW.

So instead of doing this copying, debug the problem, and
see if there is a bug in that for()-loop or similar, if it needs
to be rewritten or so.

Yours,
Linus Walleij
