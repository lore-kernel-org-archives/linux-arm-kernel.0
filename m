From: tphan@apm.com (Tuan Phan)
Date: Mon, 11 Jan 2016 14:04:52 -0800
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <20160110110714.GA22896@pd.tnic>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
Message-ID: <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 10, 2016 at 3:07 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 06, 2015 at 05:51:58PM -0700, Loc Ho wrote:
> > The function acpi_gsi_to_irq should returns 0 on success as upper function
> > caller expect an 0 for sucesss.
> >
> > Signed-off-by: Tuan Phan <tphan@apm.com>
> > Signed-off-by: Loc Ho <lho@apm.com>
> > ---
> >  drivers/acpi/gsi.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> > index fa4585a..0ed1003 100644
> > --- a/drivers/acpi/gsi.c
> > +++ b/drivers/acpi/gsi.c
> > @@ -43,7 +43,7 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
> >   *
> >   * irq location updated with irq value [>0 on success, 0 on failure]
> >   *
> > - * Returns: linux IRQ number on success (>0)
> > + * Returns: 0 on success
> >   *          -EINVAL on failure
> >   */
> >  int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> > @@ -56,7 +56,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> >        * *irq == 0 means no mapping, that should
> >        * be reported as a failure
> >        */
> > -     return (*irq > 0) ? *irq : -EINVAL;
> > +     return (*irq > 0) ? 0 : -EINVAL;
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>
> That function can be simplified. It should be made to return the irq
> number on success and 0 on failure. No need for that *irq output
> argument.
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.

Hi Boris,
The same function which is implemented for x86
(arch/x86/kernel/acpi/boot.c) also returns 0 on success and -1 on
failure. If we need to change the API, need to change for X86 too
which we don't have a way to test it.

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
