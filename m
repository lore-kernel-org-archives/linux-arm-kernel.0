From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 10 Jan 2017 10:36:37 -0700
Subject: [PATCH] coresight: STM: Balance enable/disable
In-Reply-To: <1484047315-14407-1-git-send-email-suzuki.poulose@arm.com>
References: <1484047315-14407-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170110173637.GA12100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 11:21:55AM +0000, Suzuki K Poulose wrote:
> The stm is automatically enabled when an application sets the policy
> via ->link() call back by using coresight_enable(), which keeps the
> refcount of the current users of the STM. However, the unlink() callback
> issues stm_disable() directly, which leaves the STM turned off, without
> the coresight layer knowing about it. This prevents any further uses
> of the STM hardware as the coresight layer still thinks the STM is
> turned on and doesn't issue an stm_enable(). Even manually enabling
> the STM via sysfs can't really enable the hw.
> 
> e.g,
> 
> $ echo 1 > $CS_DEVS/$ETR/enable_sink
> $ mkdir -p $CONFIG_FS/stp-policy/$source.0/stm_test/
> $ echo 32768 65535 > $CONFIG_FS/stp-policy/$source.0/stm_test/channels
> $ echo 64 > $CS_DEVS/$source/traceid
> $ ./stm_app
> Sending 64000 byte blocks of pattern 0 at 0us intervals
> Success to map channel(32768~32783) to 0xffffa95fa000
> Sending on channel 32768
> $ dd if=/dev/$ETR of=~/trace.bin.1
> 597+1 records in
> 597+1 records out
> 305920 bytes (306 kB) copied, 0.399952 s, 765 kB/s
> $ ./stm_app
> Sending 64000 byte blocks of pattern 0 at 0us intervals
> Success to map channel(32768~32783) to 0xffff7e9e2000
> Sending on channel 32768
> $ dd if=/dev/$ETR of=~/trace.bin.2
> 0+0 records in
> 0+0 records out
> 0 bytes (0 B) copied, 0.0232083 s, 0.0 kB/s
> 
> Note that we don't get any data from the ETR for the second session.
> 
> Also dmesg shows :
> 
> [   77.520458] coresight-tmc 20800000.etr: TMC-ETR enabled
> [   77.537097] coresight-replicator etr_replicator at 20890000: REPLICATOR enabled
> [   77.558828] coresight-replicator main_replicator at 208a0000: REPLICATOR enabled
> [   77.581068] coresight-funnel 208c0000.main_funnel: FUNNEL inport 0 enabled
> [   77.602217] coresight-tmc 20840000.etf: TMC-ETF enabled
> [   77.618422] coresight-stm 20860000.stm: STM tracing enabled
> [  139.554252] coresight-stm 20860000.stm: STM tracing disabled
>  # End of first tracing session
> [  146.351135] coresight-tmc 20800000.etr: TMC read start
> [  146.514486] coresight-tmc 20800000.etr: TMC read end
>  # Note that the STM is not turned on via stm_generic_link()->coresight_enable()
>  # and hence none of the components are turned on.
> [  152.479080] coresight-tmc 20800000.etr: TMC read start
> [  152.542632] coresight-tmc 20800000.etr: TMC read end
> 
> This patch balances the unlink operation by using the coresight_disable(),
> keeping the coresight layer in sync with the hardware state.
> 
> Fixes: commit 237483aa5cf43 ("coresight: stm: adding driver for CoreSight STM component")
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable at vger.kernel.org # 4.7+
> Reported-by: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 3524452..57b7330 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -356,7 +356,7 @@ static void stm_generic_unlink(struct stm_data *stm_data,
>  	if (!drvdata || !drvdata->csdev)
>  		return;
>  
> -	stm_disable(drvdata->csdev, NULL);
> +	coresight_disable(drvdata->csdev);

This looks valid to me.

Chunyan, any reason to use stm_disable() directly rather than calling it as part
of the device OPS in coresight_disable()?

Thanks,
Mathieu

>  }
>  
>  static phys_addr_t
> -- 
> 2.7.4
> 
