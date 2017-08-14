From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Aug 2017 17:06:54 +0200
Subject: [PATCH 3/3] soc: xilinx: zynqmp: Add firmware interface
In-Reply-To: <98038734d73c604dee6ac0d34740d5bc2034e87d.1501854302.git.michal.simek@xilinx.com>
References: <cover.1501854302.git.michal.simek@xilinx.com>
 <98038734d73c604dee6ac0d34740d5bc2034e87d.1501854302.git.michal.simek@xilinx.com>
Message-ID: <CAK8P3a1UhKAhYx2fCoWGm7HMka+8XrzFCxEphYNdyNS7yYR8cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 4, 2017 at 3:45 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> +static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
> +                                  u32 *ret_payload)
> +{
> +       struct arm_smccc_res res;
> +
> +       arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
> +
> +       if (ret_payload) {
> +               ret_payload[0] = (u32)res.a0;
> +               ret_payload[1] = (u32)(res.a0 >> 32);
> +               ret_payload[2] = (u32)res.a1;
> +               ret_payload[3] = (u32)(res.a1 >> 32);
> +               ret_payload[4] = (u32)res.a2;
> +       }
> +
> +       return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
> +}

It looks like you forgot to add the cpu_to_le32/le32_to_cpu conversions
here to make this work on big-endian kernels.

> +
> +static u32 pm_api_version;
> +
> +/**
> + * zynqmp_pm_get_api_version - Get version number of PMU PM firmware
> + * @version:   Returned version value
> + *
> + * Return:     Returns status, either success or error+reason
> + */
> +int zynqmp_pm_get_api_version(u32 *version)
> +{
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +       if (!version)
> +               return zynqmp_pm_ret_code(XST_PM_CONFLICT);
> +
> +       /* Check is PM API version already verified */
> +       if (pm_api_version > 0) {
> +               *version = pm_api_version;
> +               return XST_PM_SUCCESS;
> +       }
> +       invoke_pm_fn(GET_API_VERSION, 0, 0, 0, 0, ret_payload);
> +       *version = ret_payload[1];
> +
> +       return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_api_version);

How is this supposed to be used? API version number interfaces
are generally problematic, as you don't have that interface any
more if you change the version.

Normally this should be based on the "compatible" string
in DT to find our what you are talking to, in combination with
a list of features that you can query to find out if something
is available that you can't just try out by calling.

> diff --git a/include/linux/soc/xilinx/zynqmp/firmware.h b/include/linux/soc/xilinx/zynqmp/firmware.h
> new file mode 100644
> index 000000000000..5beb5988e3de
> --- /dev/null
> +++ b/include/linux/soc/xilinx/zynqmp/firmware.h
> @@ -0,0 +1,246 @@
> +
> +#ifndef __SOC_ZYNQMP_FIRMWARE_H__
> +#define __SOC_ZYNQMP_FIRMWARE_H__
> +
> +#define ZYNQMP_PM_VERSION_MAJOR        0
> +#define ZYNQMP_PM_VERSION_MINOR        3

Again, having the version number hardcoded in a global constant
seems pointless. If you expect to have to support different incompatible
versions in the future, name the header file firmware-0-3.h and
prefix the constants with the current version.

> +/*
> + * Internal functions
> + */
> +int invoke_pm_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
> +                u32 *ret_payload);
> +int zynqmp_pm_ret_code(u32 ret_status);
> +
> +/* Miscellaneous API functions */
> +int zynqmp_pm_get_api_version(u32 *version);
> +int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);

The "internal" functions probably shouldn't be declared in a global
header file.

      Arnd
