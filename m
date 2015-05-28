From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 28 May 2015 11:15:53 +0200
Subject: [PATCH 1/3] bus: mvebu-mbus: do not set WIN_CTRL_SYNCBARRIER
 on non io-coherent platforms.
In-Reply-To: <1432802414-12355-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1432802414-12355-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1432802414-12355-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5566DCC9.4010800@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 28/05/2015 10:40, Thomas Petazzoni wrote:
> From: Nicolas Schichan <nschichan@freebox.fr>
> 
> Commit a0b5cd4ac2d6 ("bus: mvebu-mbus: use automatic I/O
> synchronization barriers") enabled the usage of automatic I/O
> synchronization barriers by enabling bit WIN_CTRL_SYNCBARRIER in the
> control registers of MBus windows, but on non io-coherent platforms
> (orion5x, kirkwood and dove) the WIN_CTRL_SYNCBARRIER bit in
> the window control register is either reserved (all windows except 6
> and 7) or enables read-only protection (windows 6 and 7).
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v4.0+
> Fixes: a0b5cd4ac2d6 ("bus: mvebu-mbus: use automatic I/O synchronization barriers")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

applied on mvebu/fixes

Thanks,

Gregory

> ---
>  drivers/bus/mvebu-mbus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index fb9ec62..7fa4510 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -70,6 +70,7 @@
>   */
>  #define WIN_CTRL_OFF		0x0000
>  #define   WIN_CTRL_ENABLE       BIT(0)
> +/* Only on HW I/O coherency capable platforms */
>  #define   WIN_CTRL_SYNCBARRIER  BIT(1)
>  #define   WIN_CTRL_TGT_MASK     0xf0
>  #define   WIN_CTRL_TGT_SHIFT    4
> @@ -323,8 +324,9 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
>  	ctrl = ((size - 1) & WIN_CTRL_SIZE_MASK) |
>  		(attr << WIN_CTRL_ATTR_SHIFT)    |
>  		(target << WIN_CTRL_TGT_SHIFT)   |
> -		WIN_CTRL_SYNCBARRIER             |
>  		WIN_CTRL_ENABLE;
> +	if (mbus->hw_io_coherency)
> +		ctrl |= WIN_CTRL_SYNCBARRIER;
>  
>  	writel(base & WIN_BASE_LOW, addr + WIN_BASE_OFF);
>  	writel(ctrl, addr + WIN_CTRL_OFF);
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
