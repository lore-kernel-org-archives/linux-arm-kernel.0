From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 16:21:09 -0400
Subject: [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <alpine.DEB.2.02.1303282223430.28248@vroombuntu>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303211730.23247.arnd@arndb.de>
 <20130321184641.GB13280@titan.lakedaemon.net>
 <CAAfodu3cfphzUPPgH7OiicnD-_YinuZZOPPStKxmOcf4uWWgpw@mail.gmail.com>
 <20130328083306.3c2a23de@skate>
 <alpine.DEB.2.02.1303282223430.28248@vroombuntu>
Message-ID: <20130330202109.GU13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 10:27:28PM +0000, Neil Greatorex wrote:
...
> -- >8 --
> Subject: [PATCH] bus: mvebu-mbus: Restore checking for coherency fabric
>  hardware
> 
> The new mvebu-mbus driver was not checking the device tree for
> coherency fabric hardware and hence was not setting the hw_io_coherency
> flag in mbus_state. This prevented the mvsdio driver from operating
> correctly. This patch restores the check.

Neil,

If I could get you to put a Signed-off-by: on this, I'll queue it up so
folks can test it more easily.

thx,

Jason.

> ---
>  drivers/bus/mvebu-mbus.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index 586d03e..a0250c6 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -858,6 +858,9 @@ int __init mvebu_mbus_init(const char *soc,
> phys_addr_t mbuswins_phys_base,
>  		return -ENOMEM;
>  	}
> 
> +	if (of_find_compatible_node(NULL, NULL,
> "marvell,coherency-fabric"))
> +		mbus->hw_io_coherency = 1;
> +
>  	for (win = 0; win < mbus->soc->num_wins; win++)
>  		mvebu_mbus_disable_window(mbus, win);
> 
> -- 
> 1.7.10.4
