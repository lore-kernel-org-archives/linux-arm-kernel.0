From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 11 Aug 2011 10:25:58 +0800
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH 2/2]
	GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller)
In-Reply-To: <201108091515.47961.arnd@arndb.de>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<CAKnu2MpjOT8y5DfeAtrgBAKh0asqNouyhuin=z+ScAwx0Fa5rA@mail.gmail.com>
	<CAGsJ_4yb9vvKYzyXwQSwaBw1VnZWbv4jGBC4qe7uD032DL0y9A@mail.gmail.com>
	<201108091515.47961.arnd@arndb.de>
Message-ID: <CAGsJ_4ysq4RruD5oP=B6ZvNCa0baFPxtLdbgpsC8wZQsT1r1yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/9 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 09 August 2011, Barry Song wrote:
>> I guess same issues exist for other hardwares except GPIO. For
>> example, almost every different SoC has different DMA API, for
>> example:
>> mach-bcmring/dma.c:EXPORT_SYMBOL(dma_alloc_descriptor_ring);
>> mach-davinci/dma.c:EXPORT_SYMBOL(edma_alloc_channel);
>> mach-davinci/dma.c:EXPORT_SYMBOL(edma_clear_event);
>> mach-imx/dma-v1.c:EXPORT_SYMBOL(imx_dma_setup_single);
>> mach-s3c64xx/dma.c:EXPORT_SYMBOL(s3c2410_dma_enqueue);
>>
>> Do we also want to delete all arch/arm/mach-xxx/include/mach/dma.h?
>
> We need to eliminate all header files that have conflicting names
> and that are used by drivers or other header files outside of mach-*.
> How we get there is very different for each of these headers.

now every SoCs have different DMA APIs due to different DMA controller:

1. Tegra(dma has a queue with enqueue and dequeue API):
int tegra_dma_enqueue_req(struct tegra_dma_channel *ch,
        struct tegra_dma_req *req);
int tegra_dma_dequeue_req(struct tegra_dma_channel *ch,
        struct tegra_dma_req *req);
void tegra_dma_dequeue(struct tegra_dma_channel *ch);
void tegra_dma_flush(struct tegra_dma_channel *ch);

bool tegra_dma_is_req_inflight(struct tegra_dma_channel *ch,
        struct tegra_dma_req *req);
bool tegra_dma_is_empty(struct tegra_dma_channel *ch);

struct tegra_dma_channel *tegra_dma_allocate_channel(int mode);
void tegra_dma_free_channel(struct tegra_dma_channel *ch);


2. samsung(with queue and request/free, ctrl):
/* s3c2410_dma_request
 *
 * request a dma channel exclusivley
*/

extern int s3c2410_dma_request(enum dma_ch channel,
                               struct s3c2410_dma_client *, void *dev);


/* s3c2410_dma_ctrl
 *
 * change the state of the dma channel
*/

extern int s3c2410_dma_ctrl(enum dma_ch channel, enum s3c2410_chan_op op);

/* s3c2410_dma_setflags
 *
 * set the channel's flags to a given state
*/

extern int s3c2410_dma_setflags(enum dma_ch channel,
                                unsigned int flags);

/* s3c2410_dma_free
 *
 * free the dma channel (will also abort any outstanding operations)
*/

extern int s3c2410_dma_free(enum dma_ch channel, struct s3c2410_dma_client *);

/* s3c2410_dma_enqueue
 *
 * place the given buffer onto the queue of operations for the channel.
 * The buffer must be allocated from dma coherent memory, or the Dcache/WB
 * drained before the buffer is given to the DMA system.

*/

extern int s3c2410_dma_enqueue(enum dma_ch channel, void *id,
                               dma_addr_t data, int size);

/* s3c2410_dma_config
 *
 * configure the dma channel
*/

extern int s3c2410_dma_config(enum dma_ch channel, int xferunit);


3. PXA(pretty simple)
int __init pxa_init_dma(int irq, int num_ch);

int pxa_request_dma (char *name,
                         pxa_dma_prio prio,
                         void (*irq_handler)(int, void *),
                         void *data);

void pxa_free_dma (int dma_ch);


4. qualcomm msm(with queue cmd and exec cmd):
void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd);
void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful);
int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr);

5. TI omap(with request/free/enable/param config/mode set....)
extern void omap_set_dma_priority(int lch, int dst_port, int priority);
extern int omap_request_dma(int dev_id, const char *dev_name,
                        void (*callback)(int lch, u16 ch_status, void *data),
                        void *data, int *dma_ch);
extern void omap_enable_dma_irq(int ch, u16 irq_bits);
extern void omap_disable_dma_irq(int ch, u16 irq_bits);
extern void omap_free_dma(int ch);
extern void omap_start_dma(int lch);
extern void omap_stop_dma(int lch);
extern void omap_set_dma_transfer_params(int lch, int data_type,
                                         int elem_count, int frame_count,
                                         int sync_mode,
                                         int dma_trigger, int src_or_dst_synch);
extern void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode,
                                    u32 color);
extern void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode);
extern void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode);

extern void omap_set_dma_src_params(int lch, int src_port, int src_amode,
                                    unsigned long src_start,
                                    int src_ei, int src_fi);
extern void omap_set_dma_src_index(int lch, int eidx, int fidx);
extern void omap_set_dma_src_data_pack(int lch, int enable);
extern void omap_set_dma_src_burst_mode(int lch,
                                        enum omap_dma_burst_mode burst_mode);

extern void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
                                     unsigned long dest_start,
                                     int dst_ei, int dst_fi);
extern void omap_set_dma_dest_index(int lch, int eidx, int fidx);
extern void omap_set_dma_dest_data_pack(int lch, int enable);
extern void omap_set_dma_dest_burst_mode(int lch,


we might figure out some common DMA API framework so that all SoCs can
use. i think:

group1 : request/free/enable/disable/set_mode/set_priority are common
to all, but set_mode/set_priority can be empty.
group2:  enqueue/dequeue  are common to DMAC with queues
group3:  many param configurations.
group4:  other DMA controller with special work mode which can't be
covered by group1-3.
for example, prima2 has a 2D dma controller,  In 2-D DMA, the system
memory space is interpreted as a 2-D layout instead of a linear 1-D
layout. More specifically, the system memory can be considered as
multiple data lines. The length of the data line is determined by the
user-selected DMA_WIDTH register. The user can specify a data window
that the user wants to access using four parameters:
? Start address
? X length
? Y length
? Width

we might also want a dma_chip with many callbacks like gpio and irq,
then move all dma drivers to drivers/dma just like Linus W is moving
all gpio drivers to drivers/gpio. How do you think?

>
>> Or do we want to delete the whole arch/arm/mach-xxx/include/mach directory?
>
> Ideally, yes. However, that will take a lot of time. Meanwhile, we should
> rename the individual header files to have unique names for each API,
> and ensure that the symbols don't clash.
>
>> If not, it is probably that SoC can still hold some chip-specific APIs
>> in arch/arm/mach-xxx/include/mach/yyy.h.
>
> Can you name an example? Most of the ones I can think of will not work
> in a multiplatform kernel.

as i have posted the sirfsoc rtciobrg, we can't read rtc and pm
controller directly since they are not in memory space and any one of
i2c/spi/usb/pci busses, and we are reading them by the following
strange APIs indirectly:
extern void sirfsoc_rtc_iobrg_besyncing(void);
extern u32 sirfsoc_rtc_iobrg_readl(u32 addr);
extern void sirfsoc_rtc_iobrg_writel(u32 val, u32 addr);
now i have placed these APIs in a head file
include/linux/rtc/sirfsoc_rtciobrg.h not in
arch/arm/mach-prima2/include/mach considering we are tending to delete
the dir.

>
> ? ? ? ?Arnd
>

-barry
