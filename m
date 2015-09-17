From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 16 Sep 2015 23:08:46 -0700
Subject: [PATCH v2 2/3] soc: brcmstb: Add Bus Interface Unit control setup
In-Reply-To: <1442340900-15320-3-git-send-email-f.fainelli@gmail.com>
References: <1442340900-15320-1-git-send-email-f.fainelli@gmail.com>
 <1442340900-15320-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <CADtm3G6SkczVkFK0n=fpMCkocj_ijGWtHkfipTZZfp8deC=6zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 11:14 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Broadcom STB SoCs (brcmstb) require an early setup of their Bus
> Interface Unit control register, this needs to happen before SMP is
> brought up because it affects how the CPU complex will be interfaced to
> the memory controller.
>
> Add support code which properly initializes the BIU registers based on
> whether "brcm,write-pairing" is present in Device Tree, and take care of
> saving and restoring credit register settings during system-wide
> suspend/resume operations.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
>
> - add a pr_fmt prefix which is more descriptive
>
>  drivers/soc/brcmstb/Makefile        |   2 +-
>  drivers/soc/brcmstb/biuctrl.c       | 119 ++++++++++++++++++++++++++++++++++++
>  include/linux/soc/brcmstb/brcmstb.h |  10 +++
>  3 files changed, 130 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/brcmstb/biuctrl.c
>  create mode 100644 include/linux/soc/brcmstb/brcmstb.h
>
> [...]
> diff --git a/drivers/soc/brcmstb/biuctrl.c b/drivers/soc/brcmstb/biuctrl.c
> new file mode 100644
> index 000000000000..1d4deada1c4d
> --- /dev/null
> +++ b/drivers/soc/brcmstb/biuctrl.c
> @@ -0,0 +1,119 @@
> [...]
> +int __init brcmstb_biuctrl_init(void)
> +{
> +       int ret = 0;
> +
> +       ret = setup_hifcpubiuctrl_regs();
> +       if (ret)
> +               return ret;
> +
> +       ret = mcp_write_pairing_set();
> +       if (ret) {
> +               pr_err("MCP: Unable to disable write pairing!\n");
> +               return ret;

The return value isn't used in patch 3.  Is there a point to returning
an error from this function in either of the above two locations,
considering that?

Looks good otherwise.

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
