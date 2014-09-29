From: stefan@agner.ch (Stefan Agner)
Date: Mon, 29 Sep 2014 14:47:13 +0200
Subject: [PATCH 0/9] ARM: vf610: Suspend/resume support
In-Reply-To: <20140928030857.GA12999@dragon>
References: <cover.1411404079.git.stefan@agner.ch>
 <87zjdqmjr3.fsf@nbsps.com> <4ee0621b0bf5f4d4e10eae7673bdf1cd@agner.ch>
 <87y4t9kmgz.fsf@nbsps.com> <20140928030857.GA12999@dragon>
Message-ID: <64d37b2cfb24737db93afbb6cf47978a@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill, Hi Shawn,

Am 2014-09-28 05:08, schrieb Shawn Guo:
> On Wed, Sep 24, 2014 at 12:33:00PM -0400, Bill Pringlemeir wrote:
>> >> I think that Shawn Guo already did a patchset to remove stuff from
>> >> the vf610.dtsi to the machine/configuration DT files.
> 
> Do you mean the pin configuration?  That's really more board-specific.
> But IP block/device is not really the case.
> 
>>
>> In this patchset, I suggested that we could include the notation in the
>> headers which are included in the 'DT' files.  So instead of 'dtsi', we
>> could use,
>>
>>    #define VF610_GPC_SUPPORT \
>>            gpc: gpc at 4006c000 {                \
>>                    compatible = "fsl,vf610-gpc"; \
>>                    reg = <0x4006c000 0x1000>;    \
>>            };
>>
>> Or even,
>>
>>    #define VF610_SUSPEND_DT_SUPPORT \ ...
> 
> I don't think this will be accepted by DT maintainers.  We have already
> got some objections when we define pin function ID as multiple integers.
> They expect the DT macro is used for single integer case.
> 
>>
>> Anyways, the DT issue doesn't matter so much.  People will have to make
>> custom versions for their own boards.  Although, I don't think it is not
>> that hard to support it at the machine level.
>>
>> I agree that so far there are some peripherals that make it difficult to
>> run the mainline Linux with an MQX.  However, I think this patch set
>> seems to bring it closer to making it impossible.  I am only suggesting
>> that we make it a configuration option and not include it for all Vybrid
>> devices.
>>
>> Is it clear that the desired way is to use,
>>
>>    &gpc { status = "disabled"; };
>>    &src { status = "disabled"; };
>>
>> We have,
>>
>> arch/arm/mach-imx/gpc.c
>>
>>       void __init vf610_gpc_init(void)
>>       {
>>               struct device_node *np;
>>
>>               np = of_find_compatible_node(NULL, NULL, "fsl,vf610-gpc");
>>               gpc_base = of_iomap(np, 0);
>>               gpc_imr_base = gpc_base + VF610_GPC_IMR1;
>>    ...
>>
>> arch/arm/mach-imx/mach-vf610.c
>>
>>    static void __init vf610_init_irq(void)
>>    {
>>            vf610_gpc_init();
>>            irqchip_init();
>>    }
>>
>>    ...
>>
>>    +	.init_irq	= vf610_init_irq,
>>
>> I don't think this will work.
> 
> Yes, you're right.  But I guess this can be fixed by an additional
> of_device_is_available() check after of_find_compatible_node() call.
> 
>> Not to mention that 'mach-vf610.c' will
>> not build if HAVE_IMX_GPC is not defined.
> 
> HAVE_IMX_GPC cannot be configured out, because it's selected by 
> SOC_VF610.
> 

Maybe we can make that optional when CONFIG_PM is on, e.g.
select HAVE_IMX_GPC if PM

The GPC module is all about power management, hence in case we want the
M4 taken care of that, we just have to configure a Linux kernel without
CONFIG_PM support.

>> Also, I don't really see a
>> use of the GPC module unless suspend/resume is active?   Even some wall
>> powered designs may wish to exclude this functionality?
>>
>> I think that the SRC maybe needed for secure parts.  I think that some
>> designs might wish to restrict Linux's access to these registers as
>> well.  I don't actually see why we need this module?  I think the imx6
>> needs it due to multi-CPU bring-up, but in the Vybrid case, this does
>> not exist.  Can you check to see why we need the SRC?  I don't see where
>> we actually use it?  In patch9/9, we record it but do we actually access
>> the registers?  Is it just for the vf610_src_init() code?  Even that
>> seems the whole 'src.c' file is only needed for the 'src_base'
>> reference, which we don't use?
> 
> +1.  I'm also wondering how SRC is used by suspend routine in this
> series.

Well I tried to bring LPStop modes to work, which would need GPR0/GPR1
registers of SRC. If I have it working in the next series, I will need
that, but if not, I will drop those changes.

--
Stefan
