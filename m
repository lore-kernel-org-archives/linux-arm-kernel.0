From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 May 2016 11:46:40 +0200
Subject: [PATCH 1/3] mmc: core: fix using wrong io voltage if
 mmc_select_hs200 fails
In-Reply-To: <CAPDyKFrZW=FVd-5CNrkH4=PgHRxUkT3Vic3vDuuho0NACmziww@mail.gmail.com>
References: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrZW=FVd-5CNrkH4=PgHRxUkT3Vic3vDuuho0NACmziww@mail.gmail.com>
Message-ID: <CAPDyKFogfeCKTW030MN-yA2xSiTOjGOoVvU2x3QHsWq6brjvYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2016 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 20 April 2016 at 18:51, Dong Aisheng <aisheng.dong@nxp.com> wrote:
>> Currently MMC core will keep going if HS200/HS timing switch failed
>> with -EBADMSG error by the assumption that the old timing is still valid.
>>
>> However, for mmc_select_hs200 case, the signal voltage may have already
>> been switched. If the timing switch failed, we should fall back to
>> the old voltage in case the card is continue run with legacy timing.
>>
>> If fall back signal voltage failed, we explicitly report an EIO error
>> to force retry during the next power cycle.
>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> ---
>>  drivers/mmc/core/mmc.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index b8aa12c..f6683a9 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1245,9 +1245,11 @@ static int mmc_select_hs200(struct mmc_card *card)
>>         struct mmc_host *host = card->host;
>>         bool send_status = true;
>>         unsigned int old_timing;
>> +       unsigned int old_signal_voltage;
>
> Nitpick; you can merge this change into the line above.
>

Applied for next with a minor change dealing with the nitpick above, thanks!

Kind regards
Uffe
