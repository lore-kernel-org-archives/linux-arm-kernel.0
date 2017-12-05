From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 5 Dec 2017 14:30:15 +0100
Subject: [PATCH v2 3/3] mtd: nand: squash struct nand_buffers into
 struct nand_chip
In-Reply-To: <CAK7LNAQken7cQEPJEyL107pLbVJ9rPc+zZoPh4CA8D+CiKZz4g@mail.gmail.com>
References: <1512463636-28934-1-git-send-email-yamada.masahiro@socionext.com>
 <1512463636-28934-3-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNATKBO=eNHdL_P2MOh7+uRcCjkq+v8+O3DXC5UF3-NGh2Q@mail.gmail.com>
 <20171205125711.74158b3b@bbrezillon>
 <CAK7LNAQken7cQEPJEyL107pLbVJ9rPc+zZoPh4CA8D+CiKZz4g@mail.gmail.com>
Message-ID: <20171205143015.681a2815@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

On Tue, 5 Dec 2017 21:28:55 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi Boris,
> 
> 2017-12-05 20:57 GMT+09:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> >>
> >>
> >> Sorry, I missed to update omap2.c
> >>
> >> I will send v3.  
> >
> > No need to send a v3, I already fixed it when applying [1].
> >
> > [1]https://github.com/bbrezillon/linux-0day/commit/59a7bfff7103d48713b2125c3844400301a3d028
> >  
> 
> Thank you for your kind help!
> 
> 

No problem.

Thanks for working on improving the NAND framework, and if you're
looking for other things to cleanup in this area, I have a long TODO
list, so don't hesitate to ask. Just one example: I'd like to
dynamically allocate the onfi/jedec_params [1] struct instead of
embedding them in the nand_chip struct, because this increases the size
of the nand_chip object for everyone, even for those who don't have
ONFI/JEDEC compliant chips.

This should also allow us to get rid of the onfi/jedec_version fields
(if chip->onfi_params or chip->jedec_params are NULL, the NAND is not
ONFI or JEDEC compliant and the version has no meaning, if it's not
NULL, the version can be directly retrieved from the ->onfi/jedec_params
object itself).

Regards,

Boris

[1]http://elixir.free-electrons.com/linux/v4.15-rc2/source/include/linux/mtd/rawnand.h#L922
