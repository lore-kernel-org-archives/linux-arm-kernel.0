From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 19 Oct 2018 10:42:48 +0200
Subject: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <695f6a8b-d37b-bc57-215b-eb6c36252a80@amlogic.com>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
 <20181018225009.59d94aee@bbrezillon>
 <695f6a8b-d37b-bc57-215b-eb6c36252a80@amlogic.com>
Message-ID: <20181019104248.528a3409@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Oct 2018 16:29:40 +0800
Liang Yang <liang.yang@amlogic.com> wrote:

> On 2018/10/19 4:50, Boris Brezillon wrote:
> > On Thu, 18 Oct 2018 13:09:05 +0800
> > Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> >   
> >> +static int meson_nfc_buffer_init(struct mtd_info *mtd)
> >> +{
> >> +	struct nand_chip *nand = mtd_to_nand(mtd);
> >> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> >> +	static int max_page_bytes, max_info_bytes;
> >> +	int page_bytes, info_bytes;
> >> +	int nsectors;
> >> +
> >> +	nsectors = mtd->writesize / nand->ecc.size;
> >> +	page_bytes =  mtd->writesize + mtd->oobsize;
> >> +	info_bytes = nsectors * PER_INFO_BYTE;
> >> +
> >> +	if (nfc->data_buf && nfc->info_buf) {
> >> +		if (max_page_bytes < page_bytes)
> >> +			meson_nfc_free_buffer(nfc);
> >> +		else
> >> +			return 0;
> >> +	}
> >> +
> >> +	max_page_bytes = max_t(int, max_page_bytes, page_bytes);
> >> +	max_info_bytes = max_t(int, max_info_bytes, info_bytes);
> >> +
> >> +	nfc->data_buf = kmalloc(max_page_bytes, GFP_KERNEL);  
> > 
> > Is there a good reason for not using chip->data_buf and allocating a
> > new buffer here?
> >   
> when calling read_oob or write_oob, i need a mid-buffer which is used in 
> meson_nfc_prase_data_oob(). i.e. after reading a page data into 
> nfc->data_buf, I will format it and transfer to chip->data_buf.
> 
> 
> >> +	if (!nfc->data_buf)
> >> +		return -ENOMEM;
> >> +
> >> +	nfc->info_buf = kmalloc(max_info_bytes, GFP_KERNEL);
> >> +	if (!nfc->info_buf) {
> >> +		kfree(nfc->data_buf);
> >> +		return -ENOMEM;
> >> +	}  
> > 
> > I'd recommend moving this info_buf in the priv chip struct, otherwise
> > you'll have to protect nfc->info_buf with a lock to prevent an already
> > register chip from using this pointer while you're reallocating the
> > buffer. Also, I think you have a memleak here.
> >   
> ok, i will move it in the chip struct .
> 
> but how memleak happens even i have called meson_nfc_free_buffer before 
> and free data_buf if info_buf alloc faied.

You're right, I missed the call to meson_nfc_free_buffer() when
max_page_bytes < page_bytes. Still, this part is racy, just like the
nfc->data_buf replacement is if you have several NAND chips. I'd
recommend moving those bufs to the priv chip struct.

> 
> >> +
> >> +	return 0;
> >> +}  
> > 
> > .
> >   
