From: bp@suse.de (Borislav Petkov)
Date: Mon, 26 Jun 2017 16:06:47 +0200
Subject: [PATCH v5] trace: ras: add ARM processor error information trace
 event
In-Reply-To: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
References: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <20170626140647.anigiqhk3l6ltet7@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 24, 2017 at 11:38:23AM +0800, Xie XiuQi wrote:
> Add a new trace event for ARM processor error information, so that
> the user will know what error occurred. With this information the
> user may take appropriate action.
> 
> These trace events are consistent with the ARM processor error
> information table which defined in UEFI 2.6 spec section N.2.4.4.1.
> 
> ---
> v5: add trace enabled condition which is lost on v4 back again
>     put flag after the type to keep multiple_error on a 2 byte boundary
> 
> v4: use __print_flags instead of __print_symbolic, because ARM_PROC_ERR_FLAGS
>     might have more than on bit set.
>     setting up default values for __entry to avoid a lot of else branches.
>     set flags to 0 by default instead of ~0.
>     fix a typo
>     rename arm_proc_err to arm_err_info_event
>     remove "ARM Processor Error: " prefix
>     rebase on Tyler's patchset v17 "Add UEFI 2.6 and ACPI 6.1 updates for RAS on ARM64"
> 
>     https://patchwork.kernel.org/patch/9806267/
> 
> v3: no change
> 
> v2: add trace enabled condition as Steven's suggestion.
>     fix a typo.
> 
>     https://patchwork.kernel.org/patch/9653767/
> ---
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tyler Baicar <tbaicar@codeaurora.org>
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> ---
>  drivers/ras/ras.c       | 11 +++++++
>  include/linux/cper.h    |  5 ++++
>  include/ras/ras_event.h | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 39701a5..f76ab0f 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -22,7 +22,17 @@ void log_non_standard_event(const uuid_le *sec_type, const uuid_le *fru_id,
>  
>  void log_arm_hw_error(struct cper_sec_proc_arm *err)
>  {
> +	int i;
> +	struct cper_arm_err_info *err_info;
> +
>  	trace_arm_event(err);
> +
> +	if (!trace_arm_err_info_event_enabled())
> +		return;

If we're going to check whether the tracepoint is enabled, you need
to do that for arm_event TP too. Because from looking at the spec,
arm_event dumps

Table 260. ARM Processor Error Section

and you're dumping

Table 261. ARM Processor Error Information Structure

which is embedded in the previous table.

So this is basically a single error event and the error info structures
can describe different incarnations to that error event.

And you need to mirror exactly that behavior.

Then, when you do that, you need to document somewhere so that userspace
knows to open *both* TPs in order to get the full error information.

Alternatively, you can extend arm_event to get issued with *each*
cper_arm_err_info but that would mean a lot of redundant information
being shuffled out to userspace.

So I guess that's ARM folks' call.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
