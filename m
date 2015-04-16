From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 16 Apr 2015 10:48:42 +0800
Subject: [PATCH 2/2 RESEND] ARM: prima2: add NetWork on Chip driver for
 atlas7
In-Reply-To: <4918744.ypGiyU8ujI@wuerfel>
References: <1429012556-14041-1-git-send-email-21cnbao@gmail.com>
 <1429012556-14041-2-git-send-email-21cnbao@gmail.com>
 <4918744.ypGiyU8ujI@wuerfel>
Message-ID: <CAGsJ_4yPpiknFRCryX=FOMixF8TUH5JiHaFV-c5JQmaophi+dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-15 23:53 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 14 April 2015 11:55:56 Barry Song wrote:
>> diff --git a/Documentation/devicetree/bindings/bus/atlas7-noc.txt b/Documentation/devicetree/bindings/bus/atlas7-noc.txt
>> new file mode 100644
>> index 0000000..449ddb5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/atlas7-noc.txt
>> @@ -0,0 +1,34 @@
>> +Device tree bindings for CSRatlas7 NoC(Network on Chip)
>> +
>> +CSR atlas7 uses a NoC bus, SoC is splitted into mutiple MACROs. Every MACRO
>> +holds some hardware modules. For each MACRO
>> +properties:
>> +- compatible : Should be "arteris, flexnoc"
>> +- #address-cells: should be 1
>> +- #size-cells: should be 1
>> +- ranges : the child address space are mapped 1:1 onto the parent address space
>> +
>> +Sub-nodes:
>> +All the devices connected to noc are described using sub-node to noc. For
>> +example, AUDMSCM MARCO includes multimediam nodes such as KAS, AC97, IACC, I2S,
>> +USP0~3, LVDS.
>> +For each MARCO, there is at least a firewall sub-node. This firewall can detect
>> +illegal hardware access for security protection.
>> +
>> +Firewall sub-nodes:
>> +properties:
>> +- compatible : Should be one of
>> +     "sirf,nocfw-cpum",
>> +     "sirf,nocfw-cgum",
>> +     "sirf,nocfw-btm",
>> +     "sirf,nocfw-gnssm",
>> +     "sirf,nocfw-gpum",
>> +     "sirf,nocfw-mediam",
>> +     "sirf,nocfw-vdifm",
>> +     "sirf,nocfw-audiom",
>> +     "sirf,nocfw-ddrm",
>> +     "sirf,nocfw-rtcm",
>> +     "sirf,nocfw-dramfw",
>> +     "sirf,nocfw-spramfw"
>> +- reg: A resource specifier for the register space
>> +- interrupts : Should be the interrupt number - optional
>
> I think we should have a more generic binding here, which describes the
> differences between the instances of this bus in separate properties
> rather than keying them off the compatible string.
>

if there is a general binding, it might be "sirf, nocfw" string with
different properties. here each firewall has name, index, different
register offset and initialization.
it seems we need some careful thinking to figure out what is suitable
to be a property.

> That way you get a simpler driver that is automatically reusable
> across chip generations, potentially using small extensions, but
> not per-chip instance lists.
>
>> diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
>> index 8cadb30..4a9dcad 100644
>> --- a/arch/arm/mach-prima2/common.c
>> +++ b/arch/arm/mach-prima2/common.c
>> @@ -15,6 +15,13 @@
>>  #include <linux/of_platform.h>
>>  #include "common.h"
>>
>> +static void __init sirfsoc_init_mach(void)
>> +{
>> +     of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> +
>> +     sirfsoc_noc_init();
>> +}
>> +
>>  static void __init sirfsoc_init_late(void)
>>  {
>>       sirfsoc_pm_init();
>> @@ -60,6 +67,7 @@ static const char *const atlas7_dt_match[] __initconst = {
>>  DT_MACHINE_START(ATLAS7_DT, "Generic ATLAS7 (Flattened Device Tree)")
>>       /* Maintainer: Barry Song <baohua.song@csr.com> */
>>       .smp            = smp_ops(sirfsoc_smp_ops),
>> +     .init_machine   = sirfsoc_init_mach,
>>       .dt_compat      = atlas7_dt_match,
>>  MACHINE_END
>>  #endif
>
> I think we can avoid adding this part.

this has not be avoided because platform_driver.probe() is not able to
call hook_fault_code(). this results in a section mismatch.
we used to have a platform_driver, finally, i feel it is more
difficult to convince people to move hook_fault_code() to support
hotplug.
do you think it is reasonable to refine hook_fault_code() to hotplug support?

>> +#define ddrm_SecureState_ReadClr0    0x1054
>> +#define ddrm_SecureState_ReadSts0    0x1058
>> +
>> +#define ddrm_SecureState_ReadSet1    0x105C
>> +#define ddrm_SecureState_ReadClr1    0x1060
>> +#define ddrm_SecureState_ReadSts1    0x1064
>> +
>> +#define ddrm_SecureState_ReadSet2    0x1068
>> +#define ddrm_SecureState_ReadClr2    0x106C
>> +#define ddrm_SecureState_ReadSts2    0x1070
>> +
>> +#define ddrm_SecureState_ReadSet3    0x1074
>> +#define ddrm_SecureState_ReadClr3    0x1078
>> +#define ddrm_SecureState_ReadSts3    0x107C
>> +
>> +
>> +#define ddrm_SecureState_WriteSet0    0x1080
>> +#define ddrm_SecureState_WriteClr0    0x1084
>> +#define ddrm_SecureState_WriteSts0    0x1088
>> +
>> +#define ddrm_SecureState_WriteSet1    0x108C
>> +#define ddrm_SecureState_WriteClr1    0x1090
>> +#define ddrm_SecureState_WriteSts1    0x1094
>> +
>> +#define ddrm_SecureState_WriteSet2    0x1098
>> +#define ddrm_SecureState_WriteClr2    0x109C
>> +#define ddrm_SecureState_WriteSts2    0x10A0
>> +
>> +#define ddrm_SecureState_WriteSet3    0x10A4
>> +#define ddrm_SecureState_WriteClr3    0x10A8
>> +#define ddrm_SecureState_WriteSts3    0x10AC
>> +
>> +struct dramfw_reg_secure_t {
>> +     u32 readset;
>> +     u32 readclr;
>> +     u32 writeset;
>> +     u32 writeclr;
>> +};
>>
>
> Can you move the dram controller parts into a child driver at
> drivers/memory?

i have no idea why we do that. this firewall driver controls all
firewall features and ddr is only one of the devices using firewall.
all firewall are sharing some same low-level codes.
>
>> +static struct dramfw_reg_secure_t dramfw_reg_secure_list[] = {
>> +     {ddrm_SecureState_ReadSet0, ddrm_SecureState_ReadClr0,
>> +             ddrm_SecureState_WriteSet0, ddrm_SecureState_WriteClr0},
>> +     {ddrm_SecureState_ReadSet1, ddrm_SecureState_ReadClr1,
>> +             ddrm_SecureState_WriteSet1, ddrm_SecureState_WriteClr1},
>> +     {ddrm_SecureState_ReadSet2, ddrm_SecureState_ReadClr2,
>> +             ddrm_SecureState_WriteSet2, ddrm_SecureState_WriteClr2},
>> +     {ddrm_SecureState_ReadSet3, ddrm_SecureState_ReadClr3,
>> +             ddrm_SecureState_WriteSet3, ddrm_SecureState_WriteClr3}
>> +};
>> +
>> +struct noc_info_t {
>> +     const char *desc;
>> +};
>> +
>> +static struct noc_info_t noc_initator_id_list[] = {
>> +     {"dmac2_ac97_aux_fifo"},
>> +     {"kas_dram"},
>> +     {"afe_cvd_vip0"},
>> +     {"usp0_axi_i"},
>> +     {"sgx"},
>> +     {"sdr"},
>> +     {"dmac2_usp1rx"},
>> +     {"dmac2_usp1tx"},
>
> This table seems artificially soc specific.

real. so you mean they can be in dts?

>
>> +enum NOC_MACRO_IDX {
>> +     CPUM_IDX = 0,
>> +     CGUM_IDX,
>> +     BTM_IDX,
>> +     GNSSM_IDX,
>> +     GPUM_IDX,
>> +     MEDIAM_IDX,
>> +     VDIFM_IDX,
>> +     AUDIOM_IDX,
>> +     DDRM_IDX,
>> +     RTCM_IDX,
>> +     DRAMFW_IDX,
>> +     SPRFW_IDX,
>> +};
>> +
>> +/*register firewall offset based on macro index*/
>> +static u32 noc_regfw_offset_list[10] = {0x1050, 0x50, 0x1050, 0x1050,
>> +             0x1050, 0x1050, 0x2050, 0x2050, 0x2050, 0x2050};
>> +
>> +/*dram firewall sched port:six*/
>> +#define FW_A7 0x0
>> +#define FW_DDR_BE 0x4000
>> +#define FW_DDR_RTLL 0x8000
>> +#define FW_DDR_RT   0xC000
>> +#define FW_DDR_SGX 0x10000
>> +#define FW_DDR_VXD 0x14000
>> +
>> +#define NOC_MACRO_NUM 12
>> +#define NOC_MACRO_NAME_LEN 12
>> +
>> +struct noc_macro {
>> +     void __iomem *mbase;
>> +     spinlock_t              lock;
>> +     u32 idx;
>> +     u32 irq;
>> +     u32 errlogoff;
>> +     u32 faultenoff;
>> +     char name[NOC_MACRO_NAME_LEN];
>> +     int (*init_macro)(struct platform_device *);
>> +};
>> +
>> +static int noc_macro_init(struct platform_device *);
>> +static int noc_spram_firewall_init(struct platform_device *);
>> +static int noc_dram_firewall_init(struct platform_device *);
>> +static int noc_a7_init(struct platform_device *);
>
> In general, please try to avoid forward declarations within on C file,
> and just reorder the code appropriately.

ok. let's try.

>
>> +static struct noc_macro noc_macro_list[] = {
>> +     {
>> +             .name = "cpum",
>> +             .idx = CPUM_IDX,
>> +             .errlogoff = NOC_CPUM_ERRLOG,
>> +             .faultenoff = NOC_CPUM_FAULTEN,
>> +             .init_macro = noc_a7_init,
>> +     }, {
>> +             .name = "cgum",
>> +             .idx = CGUM_IDX,
>> +     }, {
>> +             .name = "btm",
>> +             .idx = BTM_IDX,
>> +     }, {
>> +             .name = "gnssm",
>> +             .idx = GNSSM_IDX,
>> +     }, {
>> +             .name = "gpum",
>> +             .idx = GPUM_IDX,
>> +     }, {
>> +             .name = "mediam",
>> +             .idx = MEDIAM_IDX,
>> +     }, {
>> +             .name = "vdifm",
>> +             .idx = VDIFM_IDX,
>> +     }, {
>> +             .name = "audiom",
>> +             .idx = AUDIOM_IDX,
>> +             .errlogoff = NOC_AUDMSCM_ERRLOG,
>> +             .faultenoff = NOC_AUDMSCM_FAULTEN,
>> +             .init_macro = noc_macro_init,
>> +     }, {
>> +             .name = "ddrm",
>> +             .idx = DDRM_IDX,
>> +             .errlogoff = NOC_DDRM_ERRLOG,
>> +             .faultenoff = NOC_DDRM_FAULTEN,
>> +             .init_macro = noc_macro_init,
>> +     }, {
>> +             .name = "rtcm",
>> +             .idx = RTCM_IDX,
>> +             .errlogoff = NOC_RTCM_ERRLOG,
>> +             .faultenoff = NOC_RTCM_FAULTEN,
>> +             .init_macro = noc_macro_init,
>> +     }, {
>> +             .name = "dramfw",
>> +             .idx = DRAMFW_IDX,
>> +             .init_macro = noc_dram_firewall_init,
>> +     }, {
>> +             .name = "spramfw",
>> +             .idx = SPRFW_IDX,
>> +             .init_macro = noc_spram_firewall_init,
>> +     },
>> +};
>
> The index values here could easily be DT properties, and you already
> have a name for each from the device node. The fault enable and
> error log can also be simple boolean properties.

it seems here you are giving some good suggestions about how to
provide properties in your 1st comment.

>
>> +static ssize_t regfw_store(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     const char *buf, size_t len)
>> +{
>> +     struct noc_macro *nocm;
>> +
>> +     u32 idx, ns, a7, cssi, m3, kas;
>> +
>> +     if (sscanf(buf, "%x %x %x %x %x %x\n", &idx, &ns, &a7,
>> +                             &cssi, &m3, &kas) != 6 || idx > 9)
>> +             return -EINVAL;
>> +
>> +     nocm = &noc_macro_list[idx];
>> +     noc_regfw_set(nocm->mbase,
>> +                     noc_regfw_offset_list[idx], ns, a7, cssi, m3, kas);
>> +     return len;
>> +}
>> +
>> +static DEVICE_ATTR_WO(regfw);
>
> Any new sysfs files need a full description in Documentation/ABI.
>
> Without that documentation, it's also hard to tell whether this ABI
> is good.

this sysfs is only for debug purpose. it is not a normal API. firewall
has been set in bootloader and linux running in non-secure mode
actaully has no permission to do it.
so it is only for the automatic test when linux is running in secure mode.
do you think we can have a
#ifdef CONFIG_DEBUG...
#endif

>
>> +__init int sirfsoc_noc_init(void)
>> +{
>> +     struct device_node *np;
>> +     const struct of_device_id *match;
>> +     struct noc_macro *nocm;
>> +     struct platform_device *pdev;
>> +
>> +     for_each_matching_node_and_match(np, sirfsoc_nocfw_ids, &match) {
>> +             if (!of_device_is_available(np))
>> +                     continue;
>> +
>> +             nocm = (struct noc_macro *)match->data;
>> +             nocm->mbase = of_iomap(np, 0);
>> +             if (!nocm->mbase)
>> +                     return -ENOMEM;
>> +
>> +             spin_lock_init(&nocm->lock);
>> +             pdev = of_find_device_by_node(np);
>> +             platform_set_drvdata(pdev, nocm);
>> +
>> +             hook_fault_code(8, noc_abort_handler, SIGBUS, 0,
>> +                     "external abort on non-linefetch");
>> +
>> +             hook_fault_code(22, noc_abort_handler, SIGBUS, 0,
>> +                     "imprecise external abort");
>> +
>> +             if (nocm->init_macro)
>> +                     nocm->init_macro(pdev);
>> +     }
>
> This should become simpler if you have a platform driver for the
> base device and use of_platform_populate to create its child devices.

this has been explained by hook_fault_code() reason.


>
>         Arnd

-barry
