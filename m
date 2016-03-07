From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 7 Mar 2016 09:16:25 +0100
Subject: [PATCH 4/6] [media] st-rc: prevent a endless loop
In-Reply-To: <087329695244e466f0c2d9a3a58e10ad399cd674.1457271549.git.mchehab@osg.samsung.com>
References: <076989c7736719982a1bc9557d7db072910d8efe.1457271549.git.mchehab@osg.samsung.com>
 <087329695244e466f0c2d9a3a58e10ad399cd674.1457271549.git.mchehab@osg.samsung.com>
Message-ID: <56DD38D9.20002@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro

On 03/06/2016 02:39 PM, Mauro Carvalho Chehab wrote:
> As warned by smatch:
> 	drivers/media/rc/st_rc.c:110 st_rc_rx_interrupt() warn: this loop depends on readl() succeeding
>
> as readl() might fail, with likely means some unrecovered error,
> let's loop only if it succeeds.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> ---
>   drivers/media/rc/st_rc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/rc/st_rc.c b/drivers/media/rc/st_rc.c
> index 1fa0c9d1c508..151bfe2aea55 100644
> --- a/drivers/media/rc/st_rc.c
> +++ b/drivers/media/rc/st_rc.c
> @@ -99,7 +99,7 @@ static irqreturn_t st_rc_rx_interrupt(int irq, void *data)
>   	unsigned int symbol, mark = 0;
>   	struct st_rc_device *dev = data;
>   	int last_symbol = 0;
> -	u32 status;
> +	int status;
>   	DEFINE_IR_RAW_EVENT(ev);
>   
>   	if (dev->irq_wake)
> @@ -107,7 +107,7 @@ static irqreturn_t st_rc_rx_interrupt(int irq, void *data)
>   
>   	status  = readl(dev->rx_base + IRB_RX_STATUS);
>   
> -	while (status & (IRB_FIFO_NOT_EMPTY | IRB_OVERFLOW)) {
> +	while (status > 0 && (status & (IRB_FIFO_NOT_EMPTY | IRB_OVERFLOW))) {
>   		u32 int_status = readl(dev->rx_base + IRB_RX_INT_STATUS);
>   		if (unlikely(int_status & IRB_RX_OVERRUN_INT)) {
>   			/* discard the entire collection in case of errors!  */

Acked-by: Patrice Chotard <patrice.chotard@st.com>
