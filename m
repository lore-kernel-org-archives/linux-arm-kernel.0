From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 12 Aug 2014 16:28:21 -0600
Subject: [PATCH 07/10 v3] coresight-etm: add CoreSight ETM/PTM driver
In-Reply-To: <DEE44AFE682197449410588EB783A5146887DDF1CA@BUNGLE.Emea.Arm.com>
References: <1407435706-19441-1-git-send-email-mathieu.poirier@linaro.org>
 <1407435706-19441-8-git-send-email-mathieu.poirier@linaro.org>
 <DEE44AFE682197449410588EB783A5146887DDED0F@BUNGLE.Emea.Arm.com>
 <CANLsYkxmCg2fZaORYzCHiBx4ugtP+67TJfPmiB7WiqG_s760Mg@mail.gmail.com>
 <DEE44AFE682197449410588EB783A5146887DDF1CA@BUNGLE.Emea.Arm.com>
Message-ID: <CANLsYky6z2y8pTro4hRZmjUytjOEx9Jsmer7nHQcX0=0ODioUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many thanks for the clarifications - please see comments in-lined.

Mathieu

On 12 August 2014 11:02, Al Grant <Al.Grant@arm.com> wrote:
>> On 8 August 2014 10:58, Al Grant <Al.Grant@arm.com> wrote:
>> > Hi,
>> >
>> > Comments inline...
>> >
>> >
>> >> -----Original Message-----
>> >> From: mathieu.poirier at linaro.org
>> [mailto:mathieu.poirier at linaro.org]
>>
>> SNIP...
>>
>> >> ETMCNTVRn(i));
>> >> +     }
>> >> +     etm_writel(drvdata, drvdata->seq_12_event, ETMSQ12EVR);
>> >> +     etm_writel(drvdata, drvdata->seq_21_event, ETMSQ21EVR);
>> >> +     etm_writel(drvdata, drvdata->seq_23_event, ETMSQ23EVR);
>> >> +     etm_writel(drvdata, drvdata->seq_31_event, ETMSQ31EVR);
>> >> +     etm_writel(drvdata, drvdata->seq_32_event, ETMSQ32EVR);
>> >> +     etm_writel(drvdata, drvdata->seq_13_event, ETMSQ13EVR);
>> >> +     etm_writel(drvdata, drvdata->seq_curr_state, ETMSQR);
>> >> +     for (i = 0; i < drvdata->nr_ext_out; i++)
>> >> +             etm_writel(drvdata, ETM_DEFAULT_EVENT_VAL,
>> >> ETMEXTOUTEVRn(i));
>> >> +     for (i = 0; i < drvdata->nr_ctxid_cmp; i++)
>> >> +             etm_writel(drvdata, drvdata->ctxid_val[i],
>> >> ETMCIDCVRn(i));
>> >> +     etm_writel(drvdata, drvdata->ctxid_mask, ETMCIDCMR);
>> >> +     etm_writel(drvdata, drvdata->sync_freq, ETMSYNCFR);
>> >> +     /* no external input selected */
>> >> +     etm_writel(drvdata, 0x0, ETMEXTINSELR);
>> >> +     etm_writel(drvdata, drvdata->timestamp_event, ETMTSEVR);
>> >> +     /* no auxiliary control selected */
>> >> +     etm_writel(drvdata, 0x0, ETMAUXCR);
>> >> +     etm_writel(drvdata, drvdata->cpu + 1, ETMTRACEIDR);
>> >
>> > This seems slightly hardwired.  When you have additional non-CPU
>> trace
>> > sources like STM (perhaps several STM) there will need to be a
>> scheme
>> > for allocating the trace ids uniquely across the sources.
>> Numbering
>> > the ETMs statically from 1 upwards and the non-CPU sources
>> dynamically
>> > from say 0x70 downwards is fine, but something ought to check they
>> > don't collide.
>>
>> I think you are right - source IDs should be configurable from
>> userspace.  On the flip side I don't think the kernel should enforce
>> having unique IDs among sources - what if someone want to have
>> source
>> of the same type have the same ID?
>
> Then it would be impossible to demultiplex if those trace streams ever
> came together in the same funnel.  The CoreSight architecture just says
> "The ID for each trace stream must be unique".  You can only get away
> with reusing ids if you are 100% sure they will never be funnelled together.
> Having unique ids avoids this fragility.

ack - all IDs will be unique.

>
>
>> I think we can display a warning
>> message when the ID of a source that is about become active matches
>> an
>> already active one but nothing more.  Get back to me if you feel
>> differently about that.
>
> I'd be happy with that.  The main thing is that if the framework itself
> is auto allocating trace source ids, make sure they don't bump into any
> that the user might have set.  You could do that by reserving some
> ids for the CPUs (i.e. ETMs) or some other way.

I can add code that guarantees a unique trace ID is configured for
each source (using a static variable or something like that).  That
would be just for the default configuration, after that users can do
whatever they want.  The check performed as part of the enabling
process discussed above would prevent user mistake.

>
>
>> > Also, if the intention is the user can find the configuration of a
>> > component from the drvdata without a device read, this needs to be
>> true
>> > of TRACEID too.
>>
>> Sorry, I don't quite get your comment.  Could you please be more
>> specific of provide an example?  That way I can be sure that your
>> comment is addressed.
>
> I meant, if you do let the user set the trace id (e.g. by adding a
> drvdata->traceid, ways to set it via debugfs etc.), please provide a
> way to read it back out again.  Then something that's producing a
> post-mortem trace package (say) can produce all the required metadata
> to associate trace ids with sources.

Absolutely.

>
>
>> > Does that mean ETM can't be enabled over cpu power-down?
>> > In the case where an ETM is powered up and the cpu is not,
>> > you might want to program and enable the ETM, to trace the
>> > cpu's power-up sequence.
>>
>> This a valid usecase that I had not considered - ok, I'll look into
>> that.
>>
>> >
>> > Or, if the ETM is powered down but can be powered up independently
>> > of the CPU, etm_enable could do so.
>>
>> Once again, I'm not sure that I fully grasp your train of thoughts -
>> please rephrase or be more specific.
>
> I meant that if the ETM was in a separate power domain from the CPU
> and could be powered up before the CPU was, the driver could take some
> action to power up the ETM's power domain.
>
>
>> You're touching on something I've been thinking about for a while...
>> Since configuration is pushed to the HW when a source is "enabled",
>> there is a window where what the SW report is different from how the
>> HW is configured.  One can't really live without the other - when
>> configuring the system it is always good to have the "current" value
>> held by a register.  I'll have to think about how to represent
>> ongoing
>> configuration (SW) and what the HW really reports.
>>
>> > It would be good to have a way of directly reading
>> > and changing the sequencer state via debugfs, since that could
>> enable
>> > some quite interesting kinds of trace control.  The same applies
>> to the
>> > counter values.
>>
>> You mean while an ETM/PTM is configured and tracing?
>
> Yes, you can read out the sequencer and counters at any time, and you'll
> see a value that it held at some recent point.  Use of the sequencer
> and counters is quite advanced, but if you're using them at all, to set
> up complex trace enable/disable conditions, then being able to monitor
> their current state without stopping the ETM could be useful.
>
> You can only change them once the ETM is stopped and in programming mode.

That is a reasonable request - you got it.

>
> Al
>
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
>
> ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
> ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
