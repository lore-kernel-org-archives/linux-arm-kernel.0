From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Fri, 24 Mar 2017 22:36:16 -0700
Subject: [PATCH 6/9] bus: brcmstb_gisb: correct support for 64-bit address
 output
In-Reply-To: <20170324144632.5896-7-opendmb@gmail.com>
References: <20170324144632.5896-1-opendmb@gmail.com>
 <20170324144632.5896-7-opendmb@gmail.com>
Message-ID: <CADtm3G6vjy=8gJrs7tYKJ6E073J=OBCXvs4J8bFb-X0AFVAGYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 7:46 AM, Doug Berger <opendmb@gmail.com> wrote:
> The GISB bus can support addresses beyond 32-bits.  So this commit
> corrects support for reading a captured 64-bit address into a 64-bit
> variable by obtaining the high bits from the ARB_ERR_CAP_HI_ADDR
> register (when present) and then outputting the full 64-bit value.
>
> It also removes unused definitions.
>
> Fixes: 44127b771d9c ("bus: add Broadcom GISB bus arbiter timeout/error handler")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  drivers/bus/brcmstb_gisb.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
> [snip]
> @@ -119,6 +116,16 @@ static u32 gisb_read(struct brcmstb_gisb_arb_device *gdev, int reg)
>                 return ioread32(gdev->base + offset);
>  }
>
> +static u64 gisb_read_address(struct brcmstb_gisb_arb_device *gdev)
> +{
> +       u64 value;
> +
> +       value = (u64)gisb_read(gdev, ARB_ERR_CAP_ADDR);

Unlike the one on the next line, this cast can be omitted.

> +       value |= (u64)gisb_read(gdev, ARB_ERR_CAP_HI_ADDR) << 32;
> +
> +       return value;
> +}
> [snip]

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
