From: benoit.thebaudeau.dev@gmail.com (=?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Sat, 27 Jan 2018 21:37:11 +0100
Subject: [PATCH] ARM: dts: imx25-pinfunc: Always set SION for SD CMD
In-Reply-To: <20180127153733.7ziaq6frli3jemc7@pengutronix.de>
References: <20180127000752.2879-1-benoit.thebaudeau.dev@gmail.com>
 <20180127153733.7ziaq6frli3jemc7@pengutronix.de>
Message-ID: <CA+sos78H1_ihvVghJcpZQZmB6rE2nfgXF8gq8kqK=cQE9Qs0mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 27, 2018 at 4:37 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Sat, Jan 27, 2018 at 01:07:52AM +0100, Beno?t Th?baudeau wrote:
>> The eSDHC does not work properly if the SION bit is not set for the
>> bidirectional CMD signal, whatever the eSDHC instance and the selected
>> pad. Therefore, setting SION is mandatory for all eSDHC CMD ports. Do
>> this for MX25_PAD_*__SD*_CMD in imx25-pinfunc.h in order to enforce this
>> behavior for all boards.
>>
>> This had already been done for eSDHC1, but not for eSDHC2. Also, define
>> MX25_PAD_FEC_MDC__SDHC2_CMD so that all the possible cases are covered
>> from now on.
>
> There is an inconsistency in the naming. The eSDHC1 CMD constants are
> named:
>
>         MX25_PAD_SD1_CMD__SD1_CMD
>
> The reference calls this:
>
>         CMD of instance: esdhc1.
>
> The register name is correct though. Not sure it's worth to fix this to
> use consistent naming (which would result in:
>
>         MX25_PAD_SD1_CMD__ESDHC1_CMD
>
> which looks ugly, too).

Indeed. I had also noticed this. I can send a patch to apply before
this one. But that would break the out-of-tree DT files using these
definitions. Would that be OK?

>> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau.dev@gmail.com>
>> ---
>>  arch/arm/boot/dts/imx25-pinfunc.h | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
>> index 6c63dca1b9b8..6cc71f7e1baa 100644
>> --- a/arch/arm/boot/dts/imx25-pinfunc.h
>> +++ b/arch/arm/boot/dts/imx25-pinfunc.h
>> @@ -236,7 +236,8 @@
>>  #define MX25_PAD_LD8__LD8                    0x0e8 0x2e0 0x000 0x00 0x000
>>  #define MX25_PAD_LD8__UART4_RXD                      0x0e8 0x2e0 0x570 0x02 0x000
>>  #define MX25_PAD_LD8__FEC_TX_ERR             0x0e8 0x2e0 0x000 0x05 0x000
>> -#define MX25_PAD_LD8__SDHC2_CMD                      0x0e8 0x2e0 0x4e0 0x06 0x000
>> +/* The eSDHC cannot work if SION is not set for the bidirectional CMD signal. */
>
> Maybe reference the more verbose comment for MX25_PAD_SD1_CMD__SD1_CMD
> here?

Good idea. That would avoid repeating the same thing everywhere while
giving a pointer to more details.

>> +#define MX25_PAD_LD8__SDHC2_CMD                      0x0e8 0x2e0 0x4e0 0x16 0x000
>>
>>  #define MX25_PAD_LD9__LD9                    0x0ec 0x2e4 0x000 0x00 0x000
>>  #define MX25_PAD_LD9__UART4_TXD                      0x0ec 0x2e4 0x000 0x02 0x000
>> @@ -316,7 +317,8 @@
>>  #define MX25_PAD_CSI_D5__CSPI3_RDY           0x12c 0x324 0x000 0x07 0x000
>>
>>  #define MX25_PAD_CSI_D6__CSI_D6                      0x130 0x328 0x000 0x00 0x000
>> -#define MX25_PAD_CSI_D6__SDHC2_CMD           0x130 0x328 0x4e0 0x02 0x001
>> +/* The eSDHC cannot work if SION is not set for the bidirectional CMD signal. */
>> +#define MX25_PAD_CSI_D6__SDHC2_CMD           0x130 0x328 0x4e0 0x12 0x001
>>  #define MX25_PAD_CSI_D6__SIM1_PD0            0x130 0x328 0x000 0x04 0x000
>>  #define MX25_PAD_CSI_D6__GPIO_1_31           0x130 0x328 0x000 0x05 0x000
>>
>> @@ -496,6 +498,8 @@
>>  #define MX25_PAD_KPP_COL3__GPIO_3_4          0x1c4 0x3bc 0x000 0x05 0x000
>>
>>  #define MX25_PAD_FEC_MDC__FEC_MDC            0x1c8 0x3c0 0x000 0x00 0x000
>> +/* The eSDHC cannot work if SION is not set for the bidirectional CMD signal. */
>> +#define MX25_PAD_FEC_MDC__SDHC2_CMD          0x1c8 0x3c0 0x4e0 0x11 0x002
>>  #define MX25_PAD_FEC_MDC__AUD4_TXD           0x1c8 0x3c0 0x464 0x02 0x001
>>  #define MX25_PAD_FEC_MDC__GPIO_3_5           0x1c8 0x3c0 0x000 0x05 0x000
>
> I double checked the numbers, and these seem all to be correct.

Thanks for your review.

Best regards,
Beno?t
