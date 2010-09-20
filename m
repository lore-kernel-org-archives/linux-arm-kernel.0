From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 20 Sep 2010 22:14:48 +0800
Subject: [PATCH 01/11] ARM: pxa: Prepare pxa2xx pcmcia for pxa320
In-Reply-To: <1284604382-23683-1-git-send-email-marek.vasut@gmail.com>
References: <1284604382-23683-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTi=EGm-WfkKbFASuJCV_1ztRh19BgUamxfdJG35=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 10:32 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> PXA320 also supports PCMCIA/CF interface. This patch generalizes register access
> in pxa2xx_pcmcia so the pxa320 is now supported as well.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> ?drivers/pcmcia/pxa2xx_base.c | ? 91 ++++++++++++++++++++++++++++++++----------
> ?1 files changed, 70 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
> index ae07b4d..3eb76c8 100644
> --- a/drivers/pcmcia/pxa2xx_base.c
> +++ b/drivers/pcmcia/pxa2xx_base.c
> @@ -84,6 +84,16 @@
> ?#define MCXX_ASST_SHIFT ? ? (7)
> ?#define MCXX_HOLD_SHIFT ? ? (14)
>
> +#define ? ? ? ?PXA2XX_SMC_BASE ? ? ? ? (0x48000000)
> +#define ? ? ? ?PXA3XX_SMC_BASE ? ? ? ? (0x4a000000)
> +#define ? ? ? ?MECR_OFFSET ? ? ? ? ? ? (0x14)
> +#define ? ? ? ?MCMEM_OFFSET ? ? ? ? ? ?(0x28)
> +#define ? ? ? ?MCATT_OFFSET ? ? ? ? ? ?(0x30)
> +#define ? ? ? ?MCIO_OFFSET ? ? ? ? ? ? (0x38)
> +#define ? ? ? ?MCIO_OFFSET ? ? ? ? ? ? (0x38)
> +

Since the SMC registers could be accessed by multiple entities, not
only the PCMCIA but also other drivers/setup code, e.g. NOR flash
timing, and considering the register offsets are almost same between
PXA2xx and PXA3xx (only differs in the starting base), I'd expect the
register definitions being separated into something like regs-smc.h

#define SMC_VIRT_BASE	(xxxxx)
#define SMC_REG(x)	(SMC_VIRT_BASE + x)

#define MECR		SMC_REG(0x014)
#define MCMEM		SMC_REG(0x028)
....

And possibly separating pxa_map_io() into pxa2xx_map_io() and
pxa3xx_map_io(), where each maps their different SMC into the same
virtual address. And use MECR/MCMEM in __raw_{read,write}l() directly
instead of doing ioremap() everywhere.

See arch/arm/mach-pxa/smemc.c, there should be some common register
definitions.

> +static void __iomem *base;
> +
> ?static inline u_int pxa2xx_mcxx_hold(u_int pcmcia_cycle_ns,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? u_int mem_clk_10khz)
> ?{
> @@ -114,39 +124,57 @@ static inline u_int pxa2xx_pcmcia_cmd_time(u_int mem_clk_10khz,
> ? ? ? ?return (300000 * (pcmcia_mcxx_asst + 1) / mem_clk_10khz);
> ?}
>
> +static inline void pxa2xx_pcmcia_set_reg( uint32_t reg, uint32_t sock,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? uint32_t val )
> +{
> + ? ? ? writel(val, base + reg + (sock << 4));
> +}

I'd prefer __raw_{read,write}l() variants here since it's known that this
cannot be PCI accesses. And this function doesn't seem to be very essential,
ain't

	__raw_writel(val, MCMEM(sock));

looks simpler and cleaner?

> +
> ?static int pxa2xx_pcmcia_set_mcmem( int sock, int speed, int clock )
> ?{
> - ? ? ? MCMEM(sock) = ((pxa2xx_mcxx_setup(speed, clock)
> + ? ? ? uint32_t val;
> +
> + ? ? ? val = ((pxa2xx_mcxx_setup(speed, clock)
> ? ? ? ? ? ? ? ?& MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
> ? ? ? ? ? ? ? ?| ((pxa2xx_mcxx_asst(speed, clock)
> ? ? ? ? ? ? ? ?& MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
> ? ? ? ? ? ? ? ?| ((pxa2xx_mcxx_hold(speed, clock)
> ? ? ? ? ? ? ? ?& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
>
> + ? ? ? pxa2xx_pcmcia_set_reg(MCMEM_OFFSET, sock, val);
> +
> ? ? ? ?return 0;
> ?}
>
> ?static int pxa2xx_pcmcia_set_mcio( int sock, int speed, int clock )
> ?{
> - ? ? ? MCIO(sock) = ((pxa2xx_mcxx_setup(speed, clock)
> + ? ? ? uint32_t val;
> +
> + ? ? ? val = ((pxa2xx_mcxx_setup(speed, clock)
> ? ? ? ? ? ? ? ?& MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
> ? ? ? ? ? ? ? ?| ((pxa2xx_mcxx_asst(speed, clock)
> ? ? ? ? ? ? ? ?& MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
> ? ? ? ? ? ? ? ?| ((pxa2xx_mcxx_hold(speed, clock)
> ? ? ? ? ? ? ? ?& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
>
> + ? ? ? pxa2xx_pcmcia_set_reg(MCIO_OFFSET, sock, val);
> +
> ? ? ? ?return 0;
> ?}
>
> ?static int pxa2xx_pcmcia_set_mcatt( int sock, int speed, int clock )
> ?{
> - ? ? ? MCATT(sock) = ((pxa2xx_mcxx_setup(speed, clock)
> + ? ? ? uint32_t val;
> +
> + ? ? ? val = ((pxa2xx_mcxx_setup(speed, clock)
> ? ? ? ? ? ? ? ?& MCXX_SETUP_MASK) << MCXX_SETUP_SHIFT)
> ? ? ? ? ? ? ? ?| ((pxa2xx_mcxx_asst(speed, clock)
> ? ? ? ? ? ? ? ?& MCXX_ASST_MASK) << MCXX_ASST_SHIFT)
> ? ? ? ? ? ? ? ?| ((pxa2xx_mcxx_hold(speed, clock)
> ? ? ? ? ? ? ? ?& MCXX_HOLD_MASK) << MCXX_HOLD_SHIFT);
>
> + ? ? ? pxa2xx_pcmcia_set_reg(MCATT_OFFSET, sock, val);
> +
> ? ? ? ?return 0;
> ?}
>
> @@ -205,19 +233,18 @@ pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
> ?static void pxa2xx_configure_sockets(struct device *dev)
> ?{
> ? ? ? ?struct pcmcia_low_level *ops = dev->platform_data;
> -
> ? ? ? ?/*
> ? ? ? ? * We have at least one socket, so set MECR:CIT
> ? ? ? ? * (Card Is There)
> ? ? ? ? */
> - ? ? ? MECR |= MECR_CIT;
> + ? ? ? uint32_t mecr = MECR_CIT;

I hope this doesn't change the original semantics.

>
> ? ? ? ?/* Set MECR:NOS (Number Of Sockets) */
> ? ? ? ?if ((ops->first + ops->nr) > 1 ||
> ? ? ? ? ? ?machine_is_viper() || machine_is_arcom_zeus())
> - ? ? ? ? ? ? ? MECR |= MECR_NOS;
> - ? ? ? else
> - ? ? ? ? ? ? ? MECR &= ~MECR_NOS;
> + ? ? ? ? ? ? ? mecr |= MECR_NOS;
> +
> + ? ? ? pxa2xx_pcmcia_set_reg(MECR_OFFSET, 0, mecr);
> ?}
>
> ?static const char *skt_names[] = {
> @@ -270,16 +297,34 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
> ? ? ? ?struct pcmcia_low_level *ops;
> ? ? ? ?struct skt_dev_info *sinfo;
> ? ? ? ?struct soc_pcmcia_socket *skt;
> + ? ? ? uint32_t smc_addr;
>
> ? ? ? ?ops = (struct pcmcia_low_level *)dev->dev.platform_data;
> - ? ? ? if (!ops)
> - ? ? ? ? ? ? ? return -ENODEV;
> + ? ? ? if (!ops) {
> + ? ? ? ? ? ? ? ret = -ENODEV;
> + ? ? ? ? ? ? ? goto err0;
> + ? ? ? }
> +
> + ? ? ? if (cpu_is_pxa320() && ops->nr > 1) {
> + ? ? ? ? ? ? ? dev_err(&dev->dev, "pxa320 supports only one pcmcia slot");
> + ? ? ? ? ? ? ? ret = -EINVAL;
> + ? ? ? ? ? ? ? goto err0;
> + ? ? ? }
>
> ? ? ? ?pxa2xx_drv_pcmcia_ops(ops);
>
> + ? ? ? smc_addr = cpu_is_pxa320() ? PXA3XX_SMC_BASE : PXA2XX_SMC_BASE;
> + ? ? ? base = ioremap(smc_addr, 0x100);
> + ? ? ? if (!base) {
> + ? ? ? ? ? ? ? ret = -ENOMEM;
> + ? ? ? ? ? ? ? goto err0;
> + ? ? ? }
> +

This isn't good.

> ? ? ? ?sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
> - ? ? ? if (!sinfo)
> - ? ? ? ? ? ? ? return -ENOMEM;
> + ? ? ? if (!sinfo) {
> + ? ? ? ? ? ? ? ret = -ENOMEM;
> + ? ? ? ? ? ? ? goto err1;
> + ? ? ? }
>
> ? ? ? ?sinfo->nskt = ops->nr;
>
> @@ -295,18 +340,21 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
>
> ? ? ? ? ? ? ? ?ret = pxa2xx_drv_pcmcia_add_one(skt);
> ? ? ? ? ? ? ? ?if (ret)
> - ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? ? ? ? ? goto err2;
> ? ? ? ?}
>
> - ? ? ? if (ret) {
> - ? ? ? ? ? ? ? while (--i >= 0)
> - ? ? ? ? ? ? ? ? ? ? ? soc_pcmcia_remove_one(&sinfo->skt[i]);
> - ? ? ? ? ? ? ? kfree(sinfo);
> - ? ? ? } else {
> - ? ? ? ? ? ? ? pxa2xx_configure_sockets(&dev->dev);
> - ? ? ? ? ? ? ? dev_set_drvdata(&dev->dev, sinfo);
> - ? ? ? }
> + ? ? ? pxa2xx_configure_sockets(&dev->dev);
> + ? ? ? dev_set_drvdata(&dev->dev, sinfo);
> +
> + ? ? ? return 0;
>
> +err2:
> + ? ? ? while (--i >= 0)
> + ? ? ? ? ? ? ? soc_pcmcia_remove_one(&sinfo->skt[i]);
> + ? ? ? kfree(sinfo);
> +err1:
> + ? ? ? iounmap(base);
> +err0:
> ? ? ? ?return ret;
> ?}
>
> @@ -321,6 +369,7 @@ static int pxa2xx_drv_pcmcia_remove(struct platform_device *dev)
> ? ? ? ? ? ? ? ?soc_pcmcia_remove_one(&sinfo->skt[i]);
>
> ? ? ? ?kfree(sinfo);
> + ? ? ? iounmap(base);
> ? ? ? ?return 0;
> ?}
>
> --
> 1.7.1
>
>
