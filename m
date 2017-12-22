From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 22 Dec 2017 22:24:41 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <87lghucykr.fsf@belgarion.home>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon>
 <877etkecig.fsf@belgarion.home> <20171218092535.2ca1fe13@xps13>
 <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon>
 <87lghucykr.fsf@belgarion.home>
Message-ID: <20171222222441.0fd77df9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Fri, 22 Dec 2017 21:11:32 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
> 
> > Looks like there is a mismatch on the nand bus width detected by the
> > core and the one declared by the driver. Can you try with the following
> > diff applied?  
> 
> Sure.
> 
> Now I get a lot of these message which I didn't have before :
> [   26.897372] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 242:4096, read only 126976 bytes, retry
> [   26.928559] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 242:4096, read only 126976 bytes, retry
> [   26.959623] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 242:4096, read only 126976 bytes, retry
> [   26.990714] ubi0 error: ubi_io_read: error -74 (ECC error) while reading 126976 bytes from PEB 242:4096, read 126976 bytes
> [   27.002084] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-ge371e97 #737
> [   27.009674] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
> [   27.016750] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
> [   27.024729] [<c000df94>] (show_stack) from [<c02c5bd4>] (ubi_io_read+0x124/0x368)
> [   27.032453] [<c02c5bd4>] (ubi_io_read) from [<c02cd550>] (ubi_attach+0xbd8/0x1868)
> [   27.040148] [<c02cd550>] (ubi_attach) from [<c02be7c4>] (ubi_attach_mtd_dev+0x548/0xe58)
> [   27.048473] [<c02be7c4>] (ubi_attach_mtd_dev) from [<c05526e4>] (ubi_init+0x134/0x1d4)
> [   27.056623] [<c05526e4>] (ubi_init) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
> [   27.064466] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
> [   27.073398] [<c053fd80>] (kernel_init_freeable) from [<c0423ab8>] (kernel_init+0x8/0xf8)
> [   27.081715] [<c0423ab8>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)
> [   27.090115] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 64 bytes from PEB 243:2048, read only 64 bytes, retry
> [   27.102363] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 64 bytes from PEB 243:2048, read only 64 bytes, retry
> [   27.114586] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading 64 bytes from PEB 243:2048, read only 64 bytes, retry
> [   27.126813] ubi0 error: ubi_io_read: error -74 (ECC error) while reading 64 bytes from PEB 243:2048, read 64 bytes
> [   27.137416] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc1-00041-ge371e97 #737
> [   27.145143] Hardware name: PXA3xx Platform Development Kit (aka Zylonite)
> [   27.152207] [<c0010440>] (unwind_backtrace) from [<c000df94>] (show_stack+0x10/0x14)
> [   27.160037] [<c000df94>] (show_stack) from [<c02c5bd4>] (ubi_io_read+0x124/0x368)
> [   27.167742] [<c02c5bd4>] (ubi_io_read) from [<c02c63dc>] (ubi_io_read_vid_hdr+0x60/0x3ac)
> [   27.176156] [<c02c63dc>] (ubi_io_read_vid_hdr) from [<c02cce58>] (ubi_attach+0x4e0/0x1868)
> [   27.184675] [<c02cce58>] (ubi_attach) from [<c02be7c4>] (ubi_attach_mtd_dev+0x548/0xe58)
> [   27.193010] [<c02be7c4>] (ubi_attach_mtd_dev) from [<c05526e4>] (ubi_init+0x134/0x1d4)
> [   27.201159] [<c05526e4>] (ubi_init) from [<c00099f8>] (do_one_initcall+0x3c/0x17c)
> [   27.208839] [<c00099f8>] (do_one_initcall) from [<c053fd80>] (kernel_init_freeable+0x104/0x1c0)
> [   27.217755] [<c053fd80>] (kernel_init_freeable) from [<c0423ab8>] (kernel_init+0x8/0xf8)
> [   27.226074] [<c0423ab8>] (kernel_init) from [<c000a780>] (ret_from_fork+0x14/0x34)

Looks like a mismatch in the ECC config. Can you check the ecc
strength/step_size in both situation (old driver vs new driver)? Could
you also dump the NDCR register in both cases?

Thanks,

Boris
