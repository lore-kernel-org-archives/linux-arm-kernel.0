From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Apr 2017 13:57:47 +0100
Subject: [PATCH] arm64: pmuv3: Support v8.1 PMUv3 extension
In-Reply-To: <1493033503-4712-1-git-send-email-jnair@caviumnetworks.com>
References: <1493033503-4712-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <20170424125747.GA5767@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 24, 2017 at 11:31:43AM +0000, Jayachandran C wrote:
> The PMUVer field can have a value 4 for PMUv3 which supports 16 bit
> evtCount field (this is documented in ARM Architecture Reference Manual
> Supplement ARMv8.1).
>
> The current check for PMUVer to be equal to 1 fails on ThunderX2 which
> has value 4 in PMUVer field. Fix this.
>
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> ---
>
> This applies on top of the current arm64 tree and fixes a breakage due
> to the  ACPI perf patches.

Sorry for the delay on this. I'm still awaiting an architectural
clarification on how this field should be interpreted, as per my prior
comments [1].

I realise that's not much consolation here, so I'm happy to take an
intermediate fix. One comment on that below.

>  arch/arm64/kernel/perf_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 98c7493..5388ed8 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -972,7 +972,7 @@ static void __armv8pmu_probe_pmu(void *info)
>       dfr0 = read_sysreg(id_aa64dfr0_el1);
>       pmuver = cpuid_feature_extract_unsigned_field(dfr0,
>                       ID_AA64DFR0_PMUVER_SHIFT);
> -     if (pmuver != 1)
> +     if (pmuver != 1 && pmuver != 4)
>               return;

Can we please make this:

        pmuver = cpuid_feature_extract_signed_field(dfr0,
                        ID_AA64DFR0_PMUVER_SHIFT);
        if (pmuver < 1)
                return;

With that, I'm happy to take this while we await further clarification.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/501305.html
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
