From: robert.moore@intel.com (Moore, Robert)
Date: Tue, 31 May 2016 14:16:07 +0000
Subject: [PATCH] Add support to parse RASF Table
In-Reply-To: <TU4PR84MB004598D95417F3C00FC6BFC7D9460@TU4PR84MB0045.NAMPRD84.PROD.OUTLOOK.COM>
References: <1462796276-3987-1-git-send-email-nagendra.k-v@hpe.com>
 <TU4PR84MB0079FF2412932840DBE794C0C2770@TU4PR84MB0079.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR84MB004598D95417F3C00FC6BFC7D9460@TU4PR84MB0045.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E488955@ORSMSX110.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the delay.
Yes, this looks like we can take this.
Bob


> -----Original Message-----
> From: Sajjan, Vikas C [mailto:vikas.cha.sajjan at hpe.com]
> Sent: Monday, May 30, 2016 9:57 PM
> To: Moore, Robert
> Cc: Lakshminarasimha, Sunil Vishwanathpur; rjw at rjwysocki.net;
> devel at acpica.org; linux-acpi at vger.kernel.org; K V, Nagendra; linaro-
> acpi at lists.linaro.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH] Add support to parse RASF Table
> 
> Hi Bob,
> 
> Any thoughts on this patch
> 
> Regards
> Vikas Sajjan
> 
> -----Original Message-----
> From: K V, Nagendra
> Sent: Monday, May 16, 2016 2:05 PM
> To: robert.moore at intel.com
> Cc: Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>; Lakshminarasimha, Sunil
> Vishwanathpur <sunil.vl@hpe.com>; devel at acpica.org; linux-
> acpi at vger.kernel.org
> Subject: RE: [PATCH] Add support to parse RASF Table
> 
> Bob,
> 
> Did you get chance to look into this?
> 
> Regards
> Nagendra
> 
> -----Original Message-----
> From: K V, Nagendra
> Sent: Monday, May 09, 2016 5:48 PM
> To: robert.moore at intel.com
> Cc: Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>; Lakshminarasimha, Sunil
> Vishwanathpur <sunil.vl@hpe.com>; devel at acpica.org; K V, Nagendra
> <nagendra.k-v@hpe.com>
> Subject: [PATCH] Add support to parse RASF Table
> 
> This patch adds support to parse RASF table. Currently RASF table is not
> being recognized.
> ---
>  source/common/ahtable.c      |  1 +
>  source/common/dmtable.c      |  7 +++++++
>  source/common/dmtbinfo.c     | 13 +++++++++++++
>  source/compiler/dtcompiler.h |  1 +
>  source/compiler/dttemplate.h | 11 +++++++++++
>  source/compiler/dtutils.c    |  5 +++++
>  source/include/acdisasm.h    |  2 ++
>  7 files changed, 40 insertions(+)
> 
> diff --git a/source/common/ahtable.c b/source/common/ahtable.c index
> 021ae33..59ddc83 100644
> --- a/source/common/ahtable.c
> +++ b/source/common/ahtable.c
> @@ -196,6 +196,7 @@ const AH_TABLE      AcpiSupportedTables[] =
>      {ACPI_SIG_NFIT, "NVDIMM Firmware Interface Table"},
>      {ACPI_SIG_PCCT, "Platform Communications Channel Table"},
>      {ACPI_SIG_PMTT, "Platform Memory Topology Table"},
> +    {ACPI_SIG_RASF, "RAS Features Table"},
>      {ACPI_RSDP_NAME,"Root System Description Pointer"},
>      {ACPI_SIG_RSDT, "Root System Description Table"},
>      {ACPI_SIG_S3PT, "S3 Performance Table"}, diff --git
> a/source/common/dmtable.c b/source/common/dmtable.c index 51d91f8..321407c
> 100644
> --- a/source/common/dmtable.c
> +++ b/source/common/dmtable.c
> @@ -430,6 +430,7 @@ const ACPI_DMTABLE_DATA     AcpiDmTableData[] =
>      {ACPI_SIG_NFIT, AcpiDmTableInfoNfit,    AcpiDmDumpNfit,
> DtCompileNfit,  TemplateNfit},
>      {ACPI_SIG_PCCT, AcpiDmTableInfoPcct,    AcpiDmDumpPcct,
> DtCompilePcct,  TemplatePcct},
>      {ACPI_SIG_PMTT, NULL,                   AcpiDmDumpPmtt,
> DtCompilePmtt,  TemplatePmtt},
> +    {ACPI_SIG_RASF, AcpiDmTableInfoRasf,    NULL,           NULL,
> TemplateRasf},
>      {ACPI_SIG_RSDT, NULL,                   AcpiDmDumpRsdt,
> DtCompileRsdt,  TemplateRsdt},
>      {ACPI_SIG_S3PT, NULL,                   NULL,           NULL,
> TemplateS3pt},
>      {ACPI_SIG_SBST, AcpiDmTableInfoSbst,    NULL,           NULL,
> TemplateSbst},
> @@ -916,6 +917,11 @@ AcpiDmDumpTable (
>              ByteLength = 10;
>              break;
> 
> +        case ACPI_DMT_RASF:
> +
> +            ByteLength = 12;
> +            break;
> +
>          case ACPI_DMT_BUF16:
>          case ACPI_DMT_UUID:
> 
> @@ -1048,6 +1054,7 @@ AcpiDmDumpTable (
> 
>          /* Integer Data Types */
> 
> +        case ACPI_DMT_RASF:
>          case ACPI_DMT_UINT8:
>          case ACPI_DMT_UINT16:
>          case ACPI_DMT_UINT24:
> diff --git a/source/common/dmtbinfo.c b/source/common/dmtbinfo.c index
> 5520da2..3896b69 100644
> --- a/source/common/dmtbinfo.c
> +++ b/source/common/dmtbinfo.c
> @@ -178,6 +178,7 @@
>  #define ACPI_NFIT_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_NFIT,f)
>  #define ACPI_PCCT_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_PCCT,f)
>  #define ACPI_PMTT_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_PMTT,f)
> +#define ACPI_RASF_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_RASF,f)
>  #define ACPI_S3PT_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_S3PT,f)
>  #define ACPI_SBST_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_SBST,f)
>  #define ACPI_SLIT_OFFSET(f)             (UINT16) ACPI_OFFSET
> (ACPI_TABLE_SLIT,f)
> @@ -2512,6 +2513,18 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoPmtt2[]
> =
> 
> 
> /*************************************************************************
> ******
>   *
> + * RASF -  RAS Feature table
> + *
> + **********************************************************************
> + ********/
> +
> +ACPI_DMTABLE_INFO           AcpiDmTableInfoRasf[] =
> +{
> +    {ACPI_DMT_RASF,     ACPI_RASF_OFFSET (ChannelId[0]),
> "Channel Identifier", 0},
> +    ACPI_DMT_TERMINATOR
> +};
> +
> +/**********************************************************************
> +*********
> + *
>   * S3PT - S3 Performance Table
>   *
> 
> **************************************************************************
> ****/
> diff --git a/source/compiler/dtcompiler.h b/source/compiler/dtcompiler.h
> index eb85ddc..1072f52 100644
> --- a/source/compiler/dtcompiler.h
> +++ b/source/compiler/dtcompiler.h
> @@ -681,6 +681,7 @@ extern const unsigned char  TemplateMtmr[];  extern
> const unsigned char  TemplateNfit[];  extern const unsigned char
> TemplatePcct[];  extern const unsigned char  TemplatePmtt[];
> +extern const unsigned char  TemplateRasf[];
>  extern const unsigned char  TemplateRsdt[];  extern const unsigned char
> TemplateS3pt[];  extern const unsigned char  TemplateSbst[]; diff --git
> a/source/compiler/dttemplate.h b/source/compiler/dttemplate.h index
> e420ec4..d17b2af 100644
> --- a/source/compiler/dttemplate.h
> +++ b/source/compiler/dttemplate.h
> @@ -978,6 +978,17 @@ const unsigned char TemplatePmtt[] =
>      0x00,0x00,0x00,0x00                       /* 000000B0    "...."
> */
>  };
> 
> +const unsigned char TemplateRasf[] =
> +{
> +    0x42,0x45,0x52,0x54,0x30,0x00,0x00,0x00,  /* 00000000    "RASF0..."
> */
> +    0x01,0x15,0x49,0x4E,0x54,0x45,0x4C,0x20,  /* 00000008    "..INTEL "
> */
> +    0x54,0x45,0x4D,0x50,0x4C,0x41,0x54,0x45,  /* 00000010    "TEMPLATE"
> */
> +    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL"
> */
> +    0x28,0x05,0x10,0x20,0x00,0x00,0x00,0x00,  /* 00000020    "(.. ...."
> */
> +    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000028    "........"
> */
> +    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00   /* 00000030    "........"
> */
> +};
> +
>  const unsigned char TemplateRsdp[] =
>  {
>      0x52,0x53,0x44,0x20,0x50,0x54,0x52,0x20,  /* 00000000    "RSD PTR "
> */
> diff --git a/source/compiler/dtutils.c b/source/compiler/dtutils.c index
> 6ca418c..774db8b 100644
> --- a/source/compiler/dtutils.c
> +++ b/source/compiler/dtutils.c
> @@ -688,6 +688,11 @@ DtGetFieldLength (
>          ByteLength = 10;
>          break;
> 
> +    case ACPI_DMT_RASF:
> +
> +        ByteLength = 12;
> +        break;
> +
>      case ACPI_DMT_BUF16:
>      case ACPI_DMT_UUID:
> 
> diff --git a/source/include/acdisasm.h b/source/include/acdisasm.h index
> ba8f274..d59e4d9 100644
> --- a/source/include/acdisasm.h
> +++ b/source/include/acdisasm.h
> @@ -227,6 +227,7 @@ typedef enum
>      ACPI_DMT_NFIT,
>      ACPI_DMT_PCCT,
>      ACPI_DMT_PMTT,
> +    ACPI_DMT_RASF,
>      ACPI_DMT_SLIC,
>      ACPI_DMT_SRAT,
> 
> @@ -458,6 +459,7 @@ extern ACPI_DMTABLE_INFO
> AcpiDmTableInfoPcctHdr[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoPcct0[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoPcct1[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoPcct2[];
> +extern ACPI_DMTABLE_INFO        AcpiDmTableInfoRasf[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoRsdp1[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoRsdp2[];
>  extern ACPI_DMTABLE_INFO        AcpiDmTableInfoS3pt[];
> --
> 2.5.0
> 
