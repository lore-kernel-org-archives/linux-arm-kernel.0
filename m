From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 14 Sep 2015 09:49:35 +0200
Subject: [PATCH v3] mtd: nand: sunxi: fix OOB handling in ->write_xxx()
 functions
In-Reply-To: <20150911224603.GG11487@google.com>
References: <1441264008-24569-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150911224603.GG11487@google.com>
Message-ID: <20150914094935.5a20b6d8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Fri, 11 Sep 2015 15:46:03 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Thu, Sep 03, 2015 at 09:06:48AM +0200, Boris Brezillon wrote:
> > The USER_DATA register cannot be accessed using byte accessors on A13
> > SoCs, thus triggering a bug when using memcpy_toio on this register.
> > Declare two helper macros to convert an OOB buffer into a suitable
> > USER_DATA value and vice-versa.
> > 
> > This patch also fixes an error in the oob_required logic (some OOB data
> > are not written even if the user required it) by removing the
> > oob_required condition, which is perfectly valid since the core already
> > fill ->oob_poi with FFs when oob_required is false.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Cc: <stable@vger.kernel.org> # 3.19+
> > Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
> > 
> > ---
> > Changes since v2:
> > - add the NFC_USER_DATA_TO_BUF() macro and rename NFC_USER_DATA() into
> >   NFC_BUF_TO_USER_DATA()
> > - rework the commit message
> > 
> > Changes since v1:
> > - drop the !oob_required conditional path
> > - replace endianness conversions by a macro relying on byte shifting
> >   operations
> > ---
> >  drivers/mtd/nand/sunxi_nand.c | 33 ++++++++++++++++-----------------
> >  1 file changed, 16 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> > index f97a58d..f9b5a4c 100644
> > --- a/drivers/mtd/nand/sunxi_nand.c
> > +++ b/drivers/mtd/nand/sunxi_nand.c
> > @@ -147,6 +147,17 @@
> >  #define NFC_ECC_MODE		GENMASK(15, 12)
> >  #define NFC_RANDOM_SEED		GENMASK(30, 16)
> >  
> > +/* NFC_USER_DATA helper macros */
> > +#define NFC_BUF_TO_USER_DATA(buf)	((buf)[0] | ((buf)[1] << 8) | \
> > +					((buf)[2] << 16) | ((buf)[3] << 24))
> 
> I thought you were treading on thin ice with bit-shifting a uint8_t, but
> it appears that C integer promotion rules are on your side here. (The
> result of this operation should be an int.)

Yep. I used to cast the first element to an u32 to deal with such use
cases until I realized it was actually not needed ;-).

> 
> > +#define NFC_USER_DATA_TO_BUF(buf, val)	\
> 
> BTW, why do you need this macro? It's currently unused. Just as an
> example? I can take it as-is if you'd like, but I was curious why you
> felt the need for this in v3, especially for -stable.

You're right, it's not needed in this patch. I'll remove it from this
commit and re-introduce it when needed.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
