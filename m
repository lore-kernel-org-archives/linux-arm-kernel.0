From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 19 Feb 2018 18:25:16 +0530
Subject: [PATCH v2 10/16] mmc: sdhci: Fix to use data_timer only for data
 line commands
In-Reply-To: <192a7c1e-9180-e473-8000-4a4aa806df91@intel.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-11-kishon@ti.com>
 <192a7c1e-9180-e473-8000-4a4aa806df91@intel.com>
Message-ID: <7452a187-bdb6-e985-10c6-7829a2d04caf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adrian,

On Monday 19 February 2018 01:33 PM, Adrian Hunter wrote:
> On 05/02/18 14:50, Kishon Vijay Abraham I wrote:
>> commit d7422fb489eee5587d3eec ("mmc: sdhci: Separate timer timeout for
>> command and data requests") while separating timer timeout for
>> command and data requests, passed cmd->mrq to sdhci_mod_timer (cmd is an
>> argument to sdhci_send_command) and in sdhci_mod_timer used mrq->cmd
>> to check if it is a data line command. This results in using
>> data timer for commands like MMC_SET_BLOCK_COUNT (CMD23) though it is
>> not a data line command. Fix it here.
> 
> I am not sure why you need this change, but it is not right actually.  There

After adding below (similar to next patch)
+	timeout = jiffies;
+	if (sdhci_data_line_cmd(mrq->cmd))
+		timeout += nsecs_to_jiffies(host->data_timeout);
+	else
+		timeout += 10 * HZ;
+	sdhci_mod_timer(host, mrq->cmd, timeout);
+

I saw that host->data_timeout was having a value of '0'. And that's because for
set block count command, sdhci_data_line_cmd(mrq->cmd) evaluates to 'true'
though sdhci_prepare_data() doesn't set timeout.

> are 2 timers because there can be 2 mrqs and we need to delete the correct
> timer in sdhci_request_done() so it is better to make the selection based on
> the mrq not the last command.

okay, I have to change the mod_timer logic in sdhci_send_command().

Thanks
Kishon
> 
>>
>> Fixes: commit d7422fb489eee5587d3eec ("mmc: sdhci: Separate timer timeout for
>> command and data requests")
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 1aa74b4682f3..0489572d1892 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1073,10 +1073,10 @@ static void sdhci_finish_data(struct sdhci_host *host)
>>  	}
>>  }
>>  
>> -static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
>> +static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_command *cmd,
>>  			    unsigned long timeout)
>>  {
>> -	if (sdhci_data_line_cmd(mrq->cmd))
>> +	if (sdhci_data_line_cmd(cmd))
>>  		mod_timer(&host->data_timer, timeout);
>>  	else
>>  		mod_timer(&host->timer, timeout);
>> @@ -1135,7 +1135,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>  		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
>>  	else
>>  		timeout += 10 * HZ;
>> -	sdhci_mod_timer(host, cmd->mrq, timeout);
>> +	sdhci_mod_timer(host, cmd, timeout);
>>  
>>  	host->cmd = cmd;
>>  	if (sdhci_data_line_cmd(cmd)) {
>>
> 
