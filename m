From: tphan@apm.com (Tuan Phan)
Date: Tue, 12 Jan 2016 10:26:04 -0800
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <20160112143653.GB30558@pd.tnic>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
 <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
 <20160111221305.GH4665@pd.tnic>
 <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
 <20160112143653.GB30558@pd.tnic>
Message-ID: <CAGDN=za9Pjm0B0OMJevgesBdkm=XOGyU7jXXfWqk+dLSo7BVtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 6:36 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Jan 11, 2016 at 02:41:41PM -0800, Tuan Phan wrote:
>> It will be problem because irq number can be 0 on X86?
>
> tglx says not really but historically irq 0 has been the timer irq.
>
> How about returning a negative value on error and positive or 0 for an
> IRQ?
>

That's exactly the patch tries to do:
int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
@@ -56,7 +56,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
         * *irq == 0 means no mapping, that should
         * be reported as a failure
         */
-       return (*irq > 0) ? *irq : -EINVAL;
+       return (*irq > 0) ? 0 : -EINVAL;
 }

So are you good with it?

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
