From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 28 Jan 2016 14:12:23 -0700
Subject: [PATCH V8 18/23] coresight: etm-perf: new PMU driver for ETM
 tracers
In-Reply-To: <87powl678z.fsf@ashishki-desk.ger.corp.intel.com>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-19-git-send-email-mathieu.poirier@linaro.org>
 <878u3c744r.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkxVoS0YLajgKrTf-RhA+2jO5nd5cLHEmrOroafNHfcvbw@mail.gmail.com>
 <87powl678z.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkyOEOW=8Q1Xc3r9Cb9Oz-juo8S8Pbh5AybUVaQrCi4Esg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2016 at 08:42, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>>> I'd like to understand all the potential failures here, because it's
>>> really a good idea to keep those to a minimum for the sake of
>>> consistency. That is, if the user succeeded in creating an event, about
>>> the only good reason for the event not starting is a filled up buffer.
>>
>> Enabling a path should fail when one or many components of that path
>> are already enabled by an ongoing trace session.  This situation is
>> quite likely to happen since in a lot of design tracers share the link
>> and sinks.
>
> Yes, but provided that we don't get interference from sysfs users
> (which, I guess, could be blocked out while etm perf events exist), this
> part shouldn't fail, as nobody else should be using these links and
> sinks but etm events and those are safe from overlapping because of
> PERF_PMU_CAP_EXCLUSIVE. Or am I missing something?

Interference from sysfs are being dealt with by drvdata->mode.  As
such a user can't muddle with perf sessions so things are good on that
front.

Reading the comment in [1], mutual exclusion rules aren't that clear
to me.  Perf is aware of the context and CPUs a session is slated for
but has no insight on the path from source to sink.  Tracing an "ls"
command on CPU1 and "uname" on CPU3 might look very distinct to Perf
but can easily share the same plumbing.  If setting
PERF_PMU_CAP_EXCLUSIVE in the PMU definition guarantees that a single
session on that PMU can be active at any given time, then yes, the
only cause of failutre is a buffer full condition.

[1]. http://lxr.free-electrons.com/source/kernel/events/core.c#L3608

>
>>> This is why it makes a lot of sense to keep all the
>>> coresight_build_path()/coresight_enable_path() to the .event_init()
>>> phase and let them fail early, if they should fail.
>>
>> If we do enable enable paths in .event_init() we can't support
>> multiple concurrent trace session (see explanation above).  The
>> ultimate design is to have a source directly connected to a sink but
>> so far none of the coresight topologies I've seen have been wired like
>> that.
>
> So if we call dibs on those paths early (like event_init early), in such
> a way that nobody but other etm events can use them, we should be ok, I
> think.

Elements get out of reach from sysfs as soon as a path is built, so we
are already covered there.

>
> Regards,
> --
> Alex
