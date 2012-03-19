From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 19 Mar 2012 11:58:19 -0700
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <20120318134623.GB29638@S2101-09.ap.freescale.net>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <20120318134623.GB29638@S2101-09.ap.freescale.net>
Message-ID: <CAJOA=zNtbcoCyrPxuH2vkfBccA9htxP-j2wNxFpJQsy_TdG++Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 18, 2012 at 6:46 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Reading the documentation of function clk_set_rate(), I'm not sure
> it exactly matches what the code does.
>
> If there is mismatch, it might be worth sending an incremental patch
> to update the documentation and avoid the confusion?

The clk_set_rate code did change rapidly leading up to the merge
request, and updating the documentation slipped through the cracks.
I'll cook up a patch and it can probably go in one of the -rc's for
3.4.  I'll take in all of your comments below.

Thanks,
Mike

>
> On Thu, Mar 15, 2012 at 11:11:19PM -0700, Mike Turquette wrote:
>> +/**
>> + * clk_set_rate - specify a new rate for clk
>> + * @clk: the clk whose rate is being changed
>> + * @rate: the new rate for clk
>> + *
>> + * In the simplest case clk_set_rate will only change the rate of clk.
>> + *
>> + * If clk has the CLK_SET_RATE_GATE flag set and it is enabled this call
>> + * will fail; only when the clk is disabled will it be able to change
>> + * its rate.
>> + *
>> + * Setting the CLK_SET_RATE_PARENT flag allows clk_set_rate to
>> + * recursively propagate up to clk's parent; whether or not this happens
>> + * depends on the outcome of clk's .round_rate implementation. ?If
>> + * *parent_rate is 0 after calling .round_rate then upstream parent
>
> Might "*parent_rate is not changed" be more accurate?
>
>> + * propagation is ignored. ?If *parent_rate comes back with a new rate
>> + * for clk's parent then we propagate up to clk's parent and set it's
>> + * rate. ?Upward propagation will continue until either a clk does not
>> + * support the CLK_SET_RATE_PARENT flag or .round_rate stops requesting
>> + * changes to clk's parent_rate.
>
>> + * If there is a failure during upstream
>> + * propagation then clk_set_rate will unwind and restore each clk's rate
>> + * that had been successfully changed. ?Afterwards a rate change abort
>> + * notification will be propagated downstream, starting from the clk
>> + * that failed.
>
> I'm not sure this part still matches the code.
>
>> + *
>> + * At the end of all of the rate setting, clk_set_rate internally calls
>> + * __clk_recalc_rates and propagates the rate changes downstream,
>
> I do not see __clk_recalc_rates is called by clk_set_rate in any way.
>
> Regards,
> Shawn
>
>> + * starting from the highest clk whose rate was changed. ?This has the
>> + * added benefit of propagating post-rate change notifiers.
>> + *
>> + * Note that while post-rate change and rate change abort notifications
>> + * are guaranteed to be sent to a clk only once per call to
>> + * clk_set_rate, pre-change notifications will be sent for every clk
>> + * whose rate is changed. ?Stacking pre-change notifications is noisy
>> + * for the drivers subscribed to them, but this allows drivers to react
>> + * to intermediate clk rate changes up until the point where the final
>> + * rate is achieved at the end of upstream propagation.
>> + *
>> + * Returns 0 on success, -EERROR otherwise.
>> + */
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
