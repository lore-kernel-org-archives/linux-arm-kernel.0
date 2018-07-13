From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri, 13 Jul 2018 09:49:03 -0700
Subject: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
In-Reply-To: <aff517d2-df92-da86-fc1e-5f8f8c42f736@codeaurora.org>
References: <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com>
 <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
 <20180629235417.GY129942@google.com>
 <8144dd3c-6138-7f16-ec17-d75e84fcfb34@codeaurora.org>
 <CAD=FV=XqoRajjNcW8RyJfrcXQVDihfjAnAsN+O9g+6qDrLHfJw@mail.gmail.com>
 <03904a71-c6be-4f93-ad43-7d25631f9a04@codeaurora.org>
 <CAD=FV=XbnuNg_B_Uoj8j9hz0t7=ORdcVB16oDmVk1q2iZYGs9A@mail.gmail.com>
 <aff517d2-df92-da86-fc1e-5f8f8c42f736@codeaurora.org>
Message-ID: <20180713164903.GX129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 05:10:50PM -0700, David Collins wrote:
> Hello Doug,
> 
> On 07/11/2018 03:43 PM, Doug Anderson wrote:
> > On Wed, Jul 11, 2018 at 3:36 PM, David Collins <collinsd@codeaurora.org> wrote:
> >>> On Tue, Jul 10, 2018 at 10:45 AM, David Collins <collinsd@codeaurora.org> wrote:
> >>>> On 06/29/2018 04:54 PM, Matthias Kaehlcke wrote:
> >>>>> On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
> >>>> ...
> >>>>>> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> >>>>>> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> >>>>>> off peripherals within the PMIC that are expected to draw significant
> >>>>>> current.  The set of peripherals included varies between PMICs.  This
> >>>>>> partial shutdown will occur simultaneously with the triggering of an
> >>>>>> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> >>>>>> driver that an over-temperature threshold has been crossed.
> >>>>>>
> >>>>>> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
> >>>>>> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
> >>>>>> interrupt in this case because all power is cut.
> >>>>>
> >>>>> This information is very useful, thanks David!
> >>>>>
> >>>>> The (partial) hardware shutdown seems like a good measure of last
> >>>>> resort, however I suppose we prefer Linux to initiate a shutdown
> >>>>> before losing part of the peripherals (drivers might not be happy
> >>>>> about this and probably not revover even when the temperature goes
> >>>>> down again) or reach a full PMIC shutdown.
> >>>>>
> >>>>> Please let me know if there are reasons to prefer to go the hardware
> >>>>> limits, it's also an option for device makers to overwrite these
> >>>>> settings if they want different behavior.
> >>>>
> >>>> Disabling stage 3 automatic full PMIC shutdown at 145 C is definitely a
> >>>> bad idea.  This exists as a last resort in order to save the hardware and
> >>>> ensure end user safety in case of excessive temperature even if software
> >>>> is locked up.
> >>>>
> >>>> Disabling stage 2 automatic partial PMIC shutdown at 125 C is not
> >>>> recommended as the PMIC is already outside of reasonable operating
> >>>> conditions and needs to take corrective action quickly.  However, doing so
> >>>> may be acceptable if software is taking action to shut down the system
> >>>> immediately upon receiving the stage 2 over-temperature interrupt.
> >>>> Just to confirm: is it expected that at stage 2 the CPU's on the SoC
> >>> should continue running even with partial PMIC shutdown enabled?
> >>
> >> This is not guaranteed.
> >>
> >>
> >>> It sounded to me like partial PMIC shutdown was supposed to shut down
> >>> high-power rails that were not essential to the task of performing an
> >>> orderly shutdown.
> >>
> >> Shutting down high-power peripherals is accurate; however, special care is
> >> not taken to ensure that an orderly shutdown is possible.  At the very
> >> least, the HW and SW state will be out of sync for the peripherals that
> >> are shut down.
> > 
> > OK, I guess I'm confused now.  Why does partial PMIC shutdown even
> > exist then?  What is the point of leaving some rails alive if software
> > could stop running?  It seems like it would be better to just shut
> > everything down.
> > 
> > Said another way: can you describe what benefit you see for only
> > partially shutting down the PMIC at stage 2 compared to just fully
> > shutting it down at stage 2?
> 
> Stage 2 partial shutdown is present on PM8998 for legacy reasons.  It is
> being phased out on future PMICs.  My understanding is that it was
> originally intended to be a less aggressive mitigation option than a full
> shutdown and that it allows for more post-mitigation analysis (e.g.
> preserved RAM contents).
> 
> The set of peripherals which are disabled during stage 2 partial shutdown
> is not well defined which leads to the kind of uncertainty and ill-defined
> behavior being discussed in this thread.

Thanks for the information!

> >> Disabling stage 2 partial shutdown and then using software to
> >> perform a controlled shutdown at 125 C is probably the best option for you
> >> at this point.
> > 
> > This seems OK to me given that I don't understand the original purpose
> > of the partial PMIC shutdown.  Would you expect that all upstream PMIC
> > users would want stage 2 partial shutdown disabled, so we should just
> > do this for all users of the PMIC?
> 
> I'd think that we only want to override stage 2 partial shutdown if
> thermal nodes are defined which cause a graceful software controlled
> shutdown in place of the PMIC partial shutdown.  Therefore, management of
> the feature should probably be tied to a boolean DT property.

Sounds good, I'll send a patch to disable the partial shutdown through
a DT property soon.
