From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sun, 15 Aug 2010 22:28:41 +0900
Subject: [PATCH 3/3] ARM: S3C64XX: Stop and flush requests on freeing
In-Reply-To: <4c67e6b3.487e0e0a.0a1b.22d7@mx.google.com>
References: <4c67e6b3.487e0e0a.0a1b.22d7@mx.google.com>
Message-ID: <AANLkTimvW3KM6k5grpXXoZw1Z64J1OtZkqpCavPApbsn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 8:34 PM, Maurus Cuelenaere
<mcuelenaere@gmail.com> wrote:
> When a DMA channel is freed, its pending requests should be flushed and the
> channel should be halted. This patch ensures that happens.
>
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
> ?arch/arm/mach-s3c64xx/dma.c | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
> index 1fd9d0c..e1f22af 100644
> --- a/arch/arm/mach-s3c64xx/dma.c
> +++ b/arch/arm/mach-s3c64xx/dma.c
> @@ -560,7 +560,8 @@ int s3c2410_dma_free(unsigned int channel, struct s3c2410_dma_client *client)
> ? ? ? ? ? ? ? ? ? ? ? channel, chan->client, client);
> ? ? ? ?}
>
> - ? ? ? /* sort out stopping and freeing the channel */
> + ? ? ? s3c64xx_dma_flush(chan);
> + ? ? ? s3c64xx_dma_stop(chan);

I think, the order should be reverted.
