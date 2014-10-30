From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Oct 2014 18:19:33 +0100
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <544A9FEA.6020304@gmail.com>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>
 <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>
 <20141021191149.GQ21108@lukather> <544A9FEA.6020304@gmail.com>
Message-ID: <20141030171933.GR21251@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 08:52:26PM +0200, Corentin LABBE wrote:
> On 10/21/14 21:11, Maxime Ripard wrote:
> > Hi Corentin,
> > 
> > Thanks for resending it.
> > 
> > On Sun, Oct 19, 2014 at 04:16:22PM +0200, LABBE Corentin wrote:
> >> Add support for the Security System included in Allwinner SoC A20.
> >> The Security System is a hardware cryptographic accelerator that support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
> >>
> >> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> >> ---
> >>  drivers/crypto/Kconfig                    |  17 ++
> >> +static int sunxi_ss_aes_poll_atomic(struct ablkcipher_request *areq)
> >> +{
> >> +	u32 spaces;
> >> +	struct scatterlist *in_sg = areq->src;
> >> +	struct scatterlist *out_sg = areq->dst;
> >> +	void *src_addr;
> >> +	void *dst_addr;
> >> +	unsigned int ileft = areq->nbytes;
> >> +	unsigned int oleft = areq->nbytes;
> >> +	unsigned int todo;
> >> +	u32 *src32;
> >> +	u32 *dst32;
> >> +	u32 rx_cnt = 32;
> >> +	u32 tx_cnt = 0;
> >> +	int i;
> >> +
> >> +	src_addr = kmap_atomic(sg_page(in_sg)) + in_sg->offset;
> > 
> > Where does this scatter_list is coming from? Can it even be allocated
> > in highmem?
> > 
> 
> With AF_ALG and cryptodev, the SG is in highmem. Verified with some
> PageHighMem().

Then fix AF_ALG and cryptodev, because all of the other drivers might
be affected.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/4edec1c4/attachment.sig>
