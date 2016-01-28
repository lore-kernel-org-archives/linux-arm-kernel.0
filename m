From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 28 Jan 2016 17:42:04 +0200
Subject: [PATCH V8 18/23] coresight: etm-perf: new PMU driver for ETM
 tracers
In-Reply-To: <CANLsYkxVoS0YLajgKrTf-RhA+2jO5nd5cLHEmrOroafNHfcvbw@mail.gmail.com>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-19-git-send-email-mathieu.poirier@linaro.org>
 <878u3c744r.fsf@ashishki-desk.ger.corp.intel.com>
 <CANLsYkxVoS0YLajgKrTf-RhA+2jO5nd5cLHEmrOroafNHfcvbw@mail.gmail.com>
Message-ID: <87powl678z.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

>> I'd like to understand all the potential failures here, because it's
>> really a good idea to keep those to a minimum for the sake of
>> consistency. That is, if the user succeeded in creating an event, about
>> the only good reason for the event not starting is a filled up buffer.
>
> Enabling a path should fail when one or many components of that path
> are already enabled by an ongoing trace session.  This situation is
> quite likely to happen since in a lot of design tracers share the link
> and sinks.

Yes, but provided that we don't get interference from sysfs users
(which, I guess, could be blocked out while etm perf events exist), this
part shouldn't fail, as nobody else should be using these links and
sinks but etm events and those are safe from overlapping because of
PERF_PMU_CAP_EXCLUSIVE. Or am I missing something?

>> This is why it makes a lot of sense to keep all the
>> coresight_build_path()/coresight_enable_path() to the .event_init()
>> phase and let them fail early, if they should fail.
>
> If we do enable enable paths in .event_init() we can't support
> multiple concurrent trace session (see explanation above).  The
> ultimate design is to have a source directly connected to a sink but
> so far none of the coresight topologies I've seen have been wired like
> that.

So if we call dibs on those paths early (like event_init early), in such
a way that nobody but other etm events can use them, we should be ok, I
think.

Regards,
--
Alex
