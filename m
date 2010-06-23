From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 23 Jun 2010 16:58:16 +0200
Subject: [PATCH] otg/ulpi.c : fix register write
In-Reply-To: <1277304632-11314-1-git-send-email-eric@eukrea.com>
References: <1277304632-11314-1-git-send-email-eric@eukrea.com>
Message-ID: <20100623145816.GE2698@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 04:50:32PM +0200, Eric B?nard wrote:
> * drivers/usb/otg/ulpi.c :
> ulpi_set_vbus and ulpi_set_flags are using ULPI_SET(register) to write
> to the PHY's registers, which means we can only set bits in the PHY's
> register and not clear them.
> By directly using the address of the register without any offset, we
> now get the expected behaviour for these functions.
> 
> * this patch also keep usage of otg_io_write & ulpi parameters coherent
> as in include/linux/usb/otg.h we have :
> otg_io_write(struct otg_transceiver *otg, u32 reg, u32 val)
> so keep the same parameters order in drivers/usb/otg/ulpi.c and
> arch/arm/plat-mxc/ulpi.c.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Daniel Mack <daniel@caiaq.de>
> Cc: linux-usb at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> ---
>  arch/arm/plat-mxc/ulpi.c |    2 +-
>  drivers/usb/otg/ulpi.c   |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/ulpi.c b/arch/arm/plat-mxc/ulpi.c
> index 582c6df..84eb5c7 100644
> --- a/arch/arm/plat-mxc/ulpi.c
> +++ b/arch/arm/plat-mxc/ulpi.c
> @@ -83,7 +83,7 @@ static int ulpi_read(struct otg_transceiver *otg, u32 reg)
>  	return (__raw_readl(view) >> ULPIVW_RDATA_SHIFT) & ULPIVW_RDATA_MASK;
>  }
>  
> -static int ulpi_write(struct otg_transceiver *otg, u32 val, u32 reg)
> +static int ulpi_write(struct otg_transceiver *otg, u32 reg, u32 val)

Urgs. Is this really necessary? It's not that I have a strong opinion
about the order of arguments in such cases (I kept to the convention
of __readl() when I wrote it). But _changing_ it like this is really
confusing. Once in awhile I stumble over such API changes and I always
wonder about the reason. The problem is that not even the compiler will
warn you if you got it wrong, when you copied a sniplet from older
sources etc.

And you really want to break someone knee caps once you find out what
caused the breakage ;)

So - if we can avoid that, we should do. If anyone speaks up with a real
reason for changing it, I'd be fine :)

Daniel
