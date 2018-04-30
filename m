From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 30 Apr 2018 11:14:09 +0200
Subject: [PATCH V3 3/4] soc: mediatek: pwrap: add mt6351 for mt6797 SoCs
In-Reply-To: <1525074821.22276.6.camel@mtkswgap22>
References: <20180323083238.13569-1-argus.lin@mediatek.com>
 <20180323083238.13569-4-argus.lin@mediatek.com>
 <427130f0-9f7e-22cc-3679-2a8d22124515@gmail.com>
 <1525074821.22276.6.camel@mtkswgap22>
Message-ID: <531656de-b5bd-1b7a-2321-32c70aa8349c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/30/2018 09:53 AM, Argus Lin wrote:
> On Tue, 2018-04-17 at 23:10 +0200, Matthias Brugger wrote:
>> Please update the subject line, we don't add mt5797 here.
> 
> Dear matthias:
> I can't find where I wrote mt5797 at this patch.
>> 
>> More comments below.
>> 
>> On 03/23/2018 09:32 AM, argus.lin at mediatek.com wrote:
>> > From: Argus Lin <argus.lin@mediatek.com>
>> > 
>> > mt6351 is a new power management IC and it is
>> > used for mt6797 SoCs. We need to add mt6351_regs for
>> > pmic register mapping and pmic_mt6351 for
>> > register accessing by regmap.
>> > 
>> > Signed-off-by: Argus Lin <argus.lin@mediatek.com>
>> > ---
>> >  drivers/soc/mediatek/mtk-pmic-wrap.c | 31 +++++++++++++++++++++++++++++--
>> >  1 file changed, 29 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> > index d0a0a3d7e88d..d81a585fadf5 100644
>> > --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
>> > +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
>> > @@ -153,6 +153,21 @@ static const u32 mt6397_regs[] = {
>> >  [PWRAP_DEW_CIPHER_SWRST] =0xbc24,
>> >  };
>> >  
>> > +static const u32 mt6351_regs[] = {
>> > +[PWRAP_DEW_DIO_EN] =0x02F2,
>> > +[PWRAP_DEW_READ_TEST] =0x02F4,
>> > +[PWRAP_DEW_WRITE_TEST] =0x02F6,
>> > +[PWRAP_DEW_CRC_EN] =0x02FA,
>> > +[PWRAP_DEW_CRC_VAL] =0x02FC,
>> > +[PWRAP_DEW_CIPHER_KEY_SEL] =0x0300,
>> > +[PWRAP_DEW_CIPHER_IV_SEL] =0x0302,
>> > +[PWRAP_DEW_CIPHER_EN] =0x0304,
>> > +[PWRAP_DEW_CIPHER_RDY] =0x0306,
>> > +[PWRAP_DEW_CIPHER_MODE] =0x0308,
>> > +[PWRAP_DEW_CIPHER_SWRST] =0x030A,
>> > +[PWRAP_DEW_RDDMY_NO] =0x030C,
>> > +};
>> > +
>> >  enum pwrap_regs {
>> >  PWRAP_MUX_SEL,
>> >  PWRAP_WRAP_EN,
>> > @@ -721,6 +736,7 @@ static int mt8135_regs[] = {
>> >  
>> >  enum pmic_type {
>> >  PMIC_MT6323,
>> > +PMIC_MT6351,
>> >  PMIC_MT6380,
>> >  PMIC_MT6397,
>> >  };
>> > @@ -1179,8 +1195,6 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>> >  pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x0);
>> >  pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_KEY_SEL], 0x1);
>> >  pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_IV_SEL], 0x2);
>> > -pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD], 0x1);
>> > -pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_START], 0x1);
>> 
>> That might break the driver for other devices. You can't just delete these lines
>> without explanation. If you think these lines are not needed, then please put
>> the deletion in another patch explaining why.
>> 
> 
> Dear matthias:
> It is really a bug here. Below is the comment from you by patch V1.
> The register of PWRAP_DEW_CIPHER_LOAD and PWRAP_DEW_CIPHER_START only
> exist at mt6397.
> But I think I can still separate those lines to another patch and
> declare the reason.

You are right I didn't remember. Sorry.
Ok, can you please put this in a seperate patch and add stable at kernel.org as CC.
Also please add a "Fixes" tag so that third parties can quickly see which commit
the fix is for.

Thanks,
Matthias

>>       }
>>  
>>       /* Config cipher mode @PMIC */
>> @@ -1080,8 +1158,6 @@ static int pwrap_init_cipher(struct pmic_wrapper
> *wrp)
>>       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST],
> 0x0);
>>       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_KEY_SEL],
> 0x1);
>>       pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_IV_SEL],
> 0x2);
>> -     pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD],
> 0x1);
>> -     pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_START],
> 0x1);
>>  
> 
> Ok, it looks like these two lines are actually a bug, which shouldn't be
> here.
> Adding John, as he added these calls twice in
> 5ae48040aa47 ("soc: mediatek: PMIC wrap: add mt6323 slave support")
> 
> @John, this is an oversight in your commit, right?
> 
> If so, we should fix this in a separate patch, concerning to send it to
> stable
> as well.
> 
>> Other then these two comments, patch looks fine.
>> 
>> Regards,
>> Matthias
> 
> 
> ************* Email Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe
>  
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank
>  you!
> 
