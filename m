From: elder@linaro.org (Alex Elder)
Date: Wed, 14 Nov 2018 21:11:38 -0600
Subject: [RFC PATCH 09/12] soc: qcom: ipa: main IPA source file
In-Reply-To: <CAK8P3a0RH4wbigKR0zsbxPzqWDjrLEkYfQk4GNxhGuxs=HJHHw@mail.gmail.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-10-elder@linaro.org>
 <CAK8P3a0RH4wbigKR0zsbxPzqWDjrLEkYfQk4GNxhGuxs=HJHHw@mail.gmail.com>
Message-ID: <4cc029b5-590d-fcba-6c29-b8dac6d03133@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/18 8:08 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> 
>> +static void ipa_client_remove_deferred(struct work_struct *work);
> 
> Try to avoid forward declarations by reordering the code in call order,
> it will also make it easier to read.
> 
>> +static DECLARE_WORK(ipa_client_remove_work, ipa_client_remove_deferred);

Done.  I've actually reworked this a lot, and pulled all the
clock (and interconnect) related code into a separate source file.
No more forward declarations (there anyway), and the work structure
is now embedded in the top-level IPA structure so I can derive
it again in the work function (rather than using the global).

>> +static struct ipa_context ipa_ctx_struct;
>> +struct ipa_context *ipa_ctx = &ipa_ctx_struct;
> 
> Global state variables should generally be removed as well, and
> passed around as function arguments.

Working on this.

>> +static int hdr_init_local_cmd(u32 offset, u32 size)
>> +{
>> +       struct ipa_desc desc = { };
>> +       struct ipa_dma_mem mem;
>> +       void *payload;
>> +       int ret;
>> +
>> +       if (ipa_dma_alloc(&mem, size, GFP_KERNEL))
>> +               return -ENOMEM;
>> +
>> +       offset += ipa_ctx->smem_offset;
>> +
>> +       payload = ipahal_hdr_init_local_pyld(&mem, offset);
>> +       if (!payload) {
>> +               ret = -ENOMEM;
>> +               goto err_dma_free;
>> +       }
>> +
>> +       desc.type = IPA_IMM_CMD_DESC;
>> +       desc.len_opcode = IPA_IMM_CMD_HDR_INIT_LOCAL;
>> +       desc.payload = payload;
>> +
>> +       ret = ipa_send_cmd(&desc);
> 
> You have a bunch of dynamic allocations in here, which you
> then immediately tear down again after the command is complete.
> I can't see at all what you do with the DMA address, since you
> seem to not use the virtual address at all but only store
> the physical address in some kind of descriptor without ever
> writing to it.

I should probably have added at least a comment here.  The
DMA memory was zeroed at the time of allocation.  That zero
buffer is then referred to in the payload to the HDR_INIT_LOCAL
immediate command.  So that command, when executing in the IPA
hardware, uses the contents of the buffer whose physical address
it's supplied, which in this case is full of zeroes.  We don't
use the virtual address because the buffer came pre-zeroed.

Based on your comment elsewhere I will be putting the command
payload in a structure on the stack rather than allocating it
dynamically.

> Am I missing something here?
> 
>> +/* Remoteproc callbacks for SSR events: prepare, start, stop, unprepare */
>> +int ipa_ssr_prepare(struct rproc_subdev *subdev)
>> +{
>> +       printk("======== SSR prepare received ========\n");
> 
> I think you mean dev_dbg() here. A plain printk() without a level
> is not correct and we probably don't want those messages to arrive
> on the console for normal users.

Yes, this was obviously a debug message in some code I should
have removed before sending...

>> +static int ipa_firmware_load(struct de
>> +
>> +err_clear_dev:
>> +       ipa_ctx->lan_cons_ep_id = 0;
>> +       ipa_ctx->cmd_prod_ep_id = 0;
>> +       ipahal_exit();
>> +err_dma_exit:
>> +       ipa_dma_exit();
>> +err_clear_gsi:
>> +       ipa_ctx->gsi = NULL;
>> +       ipa_ctx->ipa_phys = 0;
>> +       ipa_reg_exit();
>> +err_clear_ipa_irq:
>> +       ipa_ctx->ipa_irq = 0;
>> +err_clear_filter_bitmap:
>> +       ipa_ctx->filter_bitmap = 0;
>> +err_interconnect_exit:
>> +       ipa_interconnect_exit();
>> +err_clock_exit:
>> +       ipa_clock_exit();
>> +       ipa_ctx->dev = NULL;
>> +out_smp2p_exit:
>> +       ipa_smp2p_exit(dev);
>> +
> 
> No need to initialize members to zero when you are about
> to free the structure.

The IPA context is in fact a global, static structure at
the moment.  All of this bookkeeping (zeroing out things)
is a habitual practice, basically.  Regardless your point
is good and I'll remove these kinds of things as part of
converting to not using globals.

>> +static struct platform_driver ipa_plat_drv = {
>> +       .probe = ipa_plat_drv_probe,
>> +       .remove = ipa_plat_drv_remove,
>> +       .driver = {
>> +               .name = "ipa",
>> +               .owner = THIS_MODULE,
>> +               .pm = &ipa_pm_ops,
>> +               .of_match_table = ipa_plat_drv_match,
>> +       },
>> +};
>> +
>> +builtin_platform_driver(ipa_plat_drv);
> 
> This should be module_platform_driver(), and allow unloading
> the driver.

Yes.  I've done this for my own use, but the code is not
currently able to shut down cleanly.  I've been fixing a
*lot* of the things that don't clean up after themselves
today but there's more work before I can say this can be
safely built as a module.  But it's a requirement.

					-Alex



> 
>         Arnd
> 
