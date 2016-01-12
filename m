From: tphan@apm.com (Tuan Phan)
Date: Tue, 12 Jan 2016 10:46:15 -0800
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <20160112183228.GK30558@pd.tnic>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
 <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
 <20160111221305.GH4665@pd.tnic>
 <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
 <20160112143653.GB30558@pd.tnic>
 <CAGDN=za9Pjm0B0OMJevgesBdkm=XOGyU7jXXfWqk+dLSo7BVtQ@mail.gmail.com>
 <20160112183228.GK30558@pd.tnic>
Message-ID: <CAGDN=zbbfr8HVKhg4YEieyxzb6jT6eMJ2mTyn6zV9HFD_AA3aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 10:32 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Jan 12, 2016 at 10:26:04AM -0800, Tuan Phan wrote:
>> So are you good with it?
>
> How about this instead:
>
> ---
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index fa4585a6914e..e42f6b7eac13 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -46,17 +46,22 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>   * Returns: linux IRQ number on success (>0)
>   *          -EINVAL on failure
>   */
> -int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> +int acpi_gsi_to_irq(u32 gsi)
>  {
> +       unsigned int irq;
> +
>         struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
>                                                         DOMAIN_BUS_ANY);
>
> -       *irq = irq_find_mapping(d, gsi);
> +       irq = irq_find_mapping(d, gsi);
>         /*
>          * *irq == 0 means no mapping, that should
>          * be reported as a failure
>          */
> -       return (*irq > 0) ? *irq : -EINVAL;
> +       if (irq > 0)
> +               return irq;
> +       else
> +               return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);

Well, it basically the same as old code except the change of API
interface. And it requires some changes in ACPI core and X86/I64 arch
code. Do we really want to go with this solution instead of just
return 0 on success and -EINVAL on failure?

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
