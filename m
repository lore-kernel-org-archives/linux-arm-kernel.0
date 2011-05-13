From: lost.distance@yahoo.com (Paul Parsons)
Date: Fri, 13 May 2011 20:18:04 +0100 (BST)
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <20110513103255.GB18716@rainbow>
Message-ID: <20399.31072.qm@web29013.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

That patch found its way into 2.6.39-rc7 and earlier so I'm already using it. Thanks anyway.

As for the tmio_mmc driver, it more or less works for me in 2.6.39-rc7, though it does produce a lot of "tmio_mmc: Spurious irq" messages. My SD card is detected OK and reading / writing it works fine. I'll try to look into both the spurious IRQ problem and the suspend / resume bug(s).

mmc0 at 0xc489c800 irq 130
...
mmc0: new SD card at address 1234
mmcblk0: mmc0:1234 SD01G 972 MiB 
tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
 mmcblk0: p1
tmio_mmc: Spurious irq, disabling! 0x00800780 0x833f0304 0x00000000
...

Regards,
Paul

--- On Fri, 13/5/11, Dmitry Artamonow <mad_soft@inbox.ru> wrote:

> From: Dmitry Artamonow <mad_soft@inbox.ru>
> Subject: Re: [PATCH] pxa/hx4700: Fix basic suspend/resume
> To: "Paul Parsons" <lost.distance@yahoo.com>
> Cc: eric.y.miao at gmail.com, philipp.zabel at gmail.com, linux-arm-kernel at lists.infradead.org
> Date: Friday, 13 May, 2011, 11:32
> On 19:49 Wed 11 May?
> ???, Paul Parsons wrote:
> > 
> > Driver-specific bugs still remain. In particular the
> mmc driver does not resume properly after returning from
> sleep mode, thus preventing sleep mode from being entered a
> second time.
> 
> Sorry, no comments about your patch, just wanted to say
> about mmc
> driver. Some time ago when I tried to look at suspend on
> hx4700,
> this patch helped me to survive suspend-wakeup cycle with
> root on MMC:
> 
> diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
> index 4896a3c..4c686d9 100644
> --- a/drivers/mfd/asic3.c
> +++ b/drivers/mfd/asic3.c
> @@ -895,6 +895,8 @@ static struct mfd_cell asic3_cell_mmc =
> {
>  ??? .name? ? ? ? ?
> = "tmio-mmc",
>  ??? .enable? ? ? ? =
> asic3_mmc_enable,
>  ??? .disable? ?
> ???= asic3_mmc_disable,
> +??? .suspend??? =
> asic3_mmc_disable,
> +??? .resume???
> ??? = asic3_mmc_enable,
>  ??? .driver_data???=
> &asic3_mmc_data,
>  ??? .num_resources =
> ARRAY_SIZE(asic3_mmc_resources),
>  ??? .resources? ???=
> asic3_mmc_resources,
> 
> That was around 2.6.37. Not sure if it still helps and I
> have no possibility
> to check - tmio_mmc on ASIC3 seems to be totally borken in
> 2.6.39-rcX - it
> doesn't even detect card on my hx4700 :( And that's pity,
> as I mainly use
> SD for rootfs.
> 
> -- 
> Best regards,
> Dmitry "MAD" Artamonow
