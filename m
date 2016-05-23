From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 23 May 2016 13:09:51 +0200
Subject: [RFC PATCH] soc: Amlogic: Add secure monitor driver
In-Reply-To: <CAOQ7t2aCccyqtzQGQ0q+Q4+toAwrVVVLG5=idgZ1eGOLyJMY2g@mail.gmail.com>
References: <1463335845-23534-1-git-send-email-carlo@caione.org>
 <20160516113333.GG656@leverpostej>
 <CAOQ7t2aCccyqtzQGQ0q+Q4+toAwrVVVLG5=idgZ1eGOLyJMY2g@mail.gmail.com>
Message-ID: <5742E4FF.7030504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/05/16 22:30, Carlo Caione wrote:
> On Mon, May 16, 2016 at 1:33 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Sun, May 15, 2016 at 08:10:45PM +0200, Carlo Caione wrote:
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> Introduce a driver to provide calls into secure monitor mode.
>>>
>>> In the Amlogic SoCs these calls are used for multiple reasons: access to
>>> NVMEM, reboot, set USB boot, enable JTAG, etc...
>>>
>>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>>> ---
>>>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |   4 +
>>>   drivers/soc/Kconfig                         |   1 +
>>>   drivers/soc/Makefile                        |   1 +
>>>   drivers/soc/amlogic/Kconfig                 |   8 ++
>>>   drivers/soc/amlogic/Makefile                |   1 +
>>>   drivers/soc/amlogic/meson_sm.c              | 141 ++++++++++++++++++++++++++++
>>>   include/linux/soc/amlogic/meson_sm.h        |  57 +++++++++++
>>>   7 files changed, 213 insertions(+)
>>
>> The binding is missing documentation.
>
> Yes, not much to document for this RFC.
>
>> Is there any documentation of the actual interface?
>
> There isn't or at least I do not have it. This driver has been written
> by reverse engineering the Amlogic driver shipped in their SDK [1]
>
>> Are there any restrictions on how it's used? It looks like calls are
>> only expected to happen from the boot CPU, per the code below.
>
> Yes, that's what I could infer from the Amlogic code here [2] but then
> I checked this better and it seems that's not the case (see below).
>
>> There are no users in this patch. Are there any example uses (i.e.
>> specific code rather than the high-level examples above)?
>
> I use it already to read the NVMEM. It works fine.
> I'll submit the NVMEM driver as soon as I have this merged (if ever)
>
>>>   create mode 100644 drivers/soc/amlogic/Kconfig
>>>   create mode 100644 drivers/soc/amlogic/Makefile
>>>   create mode 100644 drivers/soc/amlogic/meson_sm.c
>>>   create mode 100644 include/linux/soc/amlogic/meson_sm.h
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>>> index 76b3b6d..e4017c3 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>>> @@ -98,6 +98,10 @@
>>>                method = "smc";
>>>        };
>>>
>>> +     sm {
>>> +             compatible = "amlogic,meson-sm";
>>> +     };
>>
>> We should have more specific strings, at least in addition to this.
>
> Agree, not sure what I can add though.

I would say someting linke "amlogic,gxbb-sm" to specify the SoC.

>
> [...]
>>> +struct meson_sm_data {
>>> +     unsigned int cmd;
>>> +     unsigned int arg0;
>>> +     unsigned int arg1;
>>> +     unsigned int arg2;
>>> +     unsigned int arg3;
>>> +     unsigned int arg4;
>>> +     unsigned int ret;
>>> +};
>>
>> Please be explicit and use u32 rather than unsigned int.
>
> Ok
>
>> It looks like all the calls you care about are SMC32 SiP calls, per the
>> IDs in the header.
>
> Yes, all the SMC function identifiers I gathered from the Amlogic
> sources are SMC32 SiP calls
>
>>> +
>>> +static void __meson_sm_call(void *info)
>>> +{
>>> +     struct meson_sm_data *data = info;
>>> +     struct arm_smccc_res res;
>>> +
>>> +     arm_smccc_smc(data->cmd,
>>> +                   data->arg0, data->arg1, data->arg2,
>>> +                   data->arg3, data->arg4, 0, 0, &res);
>>> +     data->ret = res.a0;
>>> +}
>>> +
>>> +unsigned int meson_sm_call(unsigned int cmd, unsigned int arg0,
>>> +                        unsigned int arg1, unsigned int arg2,
>>> +                        unsigned int arg3, unsigned int arg4)
>>> +{
>>> +     struct meson_sm_data data;
>>> +
>>> +     data.cmd = cmd;
>>> +     data.arg0 = arg0;
>>> +     data.arg1 = arg1;
>>> +     data.arg2 = arg2;
>>> +     data.arg3 = arg3;
>>> +     data.arg4 = arg4;
>>> +     data.ret = 0;
>>> +
>>> +     smp_call_function_single(0, __meson_sm_call, &data, 1);
>>
>> Why must this occur on a particular CPU?
>>
>> With kexec and so on logical CPU 0 is not necessarily the CPU that the
>> FW brought out of reset.
>
> You are right. I tried to move this to a different CPU and it keeps
> working fine. Still I wonder why Amlogic has something like [2]
>
>> Can the core with the secure OS be powered down, or is that prevented
>> with the usual PSCI machinery (e.g. MIGRATE, MIGRATE_INFO_TYPE,
>> MIGRATE_INFO_UP_CPU)
>>
>> I would recommend that any CPU restriction were described explicitly in
>> the DT, or detected dynamically based on the MIGRATE_INFO_UP_CPU value.
>
> MIGRATE_INFO_TYPE returns PSCI_0_2_TOS_MP. Does this confirm that the
> SMC calls can happen not only from the CPU 0?
>
>>> +
>>> +     return data.ret;
>>> +}
>>> +
>>> +unsigned int meson_sm_call_read(void *buffer, unsigned int cmd,
>>> +                             unsigned int arg0, unsigned int arg1,
>>> +                             unsigned int arg2, unsigned int arg3,
>>> +                             unsigned int arg4)
>>> +{
>>> +     unsigned int size;
>>> +
>>> +     size = meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
>>> +
>>> +     if (size != 0)
>>
>> Is the size guaranteed to never be > SM_MEM_SIZE? Can we sanity-check
>> that?
>
> Fix in v2
>
>> The call can't return an error code?
>
> 0 in R0 is considered error that we return back.
>
>>> +             memcpy(buffer, sm_sharemem_out_base, size);
>>
>> Is the buffer completely opaque to this layer?
>>
>> Are there any endianness concerns, for example?
>
> The best answer I can give you here is: not that I know of.
> The driver works fine when reading from the NVMEM, so I assume there
> isn't any endiness issue.
>
>>> +
>>> +     return size;
>>> +}
>>> +
>>> +unsigned int meson_sm_call_write(void *buffer, unsigned int size,
>>> +                              unsigned int cmd, unsigned int arg0,
>>> +                              unsigned int arg1, unsigned int arg2,
>>> +                              unsigned int arg3, unsigned int arg4)
>>> +{
>>> +     memcpy(sm_sharemem_in_base, buffer, size);
>>> +
>>> +     return meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
>>> +}
>>> +
>>> +static int meson_sm_probe(struct platform_device *pdev)
>>> +{
>>> +     sm_phy_in_base = meson_sm_call(SM_GET_SHARE_MEM_INPUT_BASE, 0, 0, 0, 0, 0);
>>> +
>>> +     sm_sharemem_in_base = ioremap_cache(sm_phy_in_base, SM_MEM_SIZE);
>>> +     if (!sm_sharemem_in_base)
>>> +             return -EINVAL;
>>
>> Are the attributes used for ioremap_cache guaranteed to match and not
>> cause a mismatched alias against the firmware's mapping?
>>
>> Which precise memory attributes does the secure firmware use for the
>> shared memory?
>
> Again I wish I had more information. Is there any way I can check this?
> The only reasonable answer I can give you right now is that this is
> how it is done in the original Amlogic driver in [1]
>
> [...]
>>> +#define SM_GET_SHARE_MEM_INPUT_BASE          0x82000020
>>> +#define SM_GET_SHARE_MEM_OUTPUT_BASE         0x82000021
>>> +#define SM_GET_REBOOT_REASON                 0x82000022
>>> +#define SM_GET_SHARE_STORAGE_IN_BASE         0x82000023
>>> +#define SM_GET_SHARE_STORAGE_OUT_BASE                0x82000024
>>> +#define SM_GET_SHARE_STORAGE_BLOCK_BASE              0x82000025
>>> +#define SM_GET_SHARE_STORAGE_MESSAGE_BASE    0x82000026
>>> +#define SM_GET_SHARE_STORAGE_BLOCK_SIZE              0x82000027
>>> +#define SM_EFUSE_READ                                0x82000030
>>> +#define SM_EFUSE_WRITE                               0x82000031
>>> +#define SM_EFUSE_WRITE_PATTERN                       0x82000032
>>> +#define SM_EFUSE_USER_MAX                    0x82000033
>>> +#define SM_JTAG_ON                           0x82000040
>>> +#define SM_JTAG_OFF                          0x82000041
>>> +#define SM_SET_USB_BOOT_FUNC                 0x82000043
>>> +#define SM_SECURITY_KEY_QUERY                        0x82000060
>>> +#define SM_SECURITY_KEY_READ                 0x82000061
>>> +#define SM_SECURITY_KEY_WRITE                        0x82000062
>>> +#define SM_SECURITY_KEY_TELL                 0x82000063
>>> +#define SM_SECURITY_KEY_VERIFY                       0x82000064
>>> +#define SM_SECURITY_KEY_STATUS                       0x82000065
>>> +#define SM_SECURITY_KEY_NOTIFY                       0x82000066
>>> +#define SM_SECURITY_KEY_LIST                 0x82000067
>>> +#define SM_SECURITY_KEY_REMOVE                       0x82000068
>>> +#define SM_DEBUG_EFUSE_WRITE_PATTERN         0x820000F0
>>> +#define SM_DEBUG_EFUSE_READ_PATTERN          0x820000F1
>>> +#define SM_AML_DATA_PROCESS                  0x820000FF
>>
>> Is there any documentation for these functions?
>
> Unfortunately there isn't.
> I could restrict the list to those functions I know how to use
> (*_EFUSE) maybe adding the remaining ones when we actually use them.
>
>>> +#define SM_PSCI_SYS_REBOOT                   0x84000009
>>
>> The existing PCSI code should be the only caller of this. This should
>> not be used here.
>
> Ups, that slipped through when pasting the list.
>
> Thank you for reviewing this RFC, I'll submit a v2 soon.
>
> Cheers,
>
> [1] https://github.com/hardkernel/linux/blob/odroidc2-3.14.y/drivers/amlogic/secmon/secmon.c
> [2] https://github.com/hardkernel/linux/blob/odroidc2-3.14.y/drivers/amlogic/efuse/efuse_hw64.c#L94
>
