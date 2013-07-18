From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 18 Jul 2013 15:55:55 -0700
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <20130718112555.GB1021@amd.pavel.ucw.cz>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
 <20130716041056.GA30067@S2101-09.ap.freescale.net>
 <51E56AA7.7020103@wwwdotorg.org>
 <20130717030246.GA4541@S2101-09.ap.freescale.net>
 <51E6CCE4.20705@wwwdotorg.org>
 <20130717213836.GA13324@amd.pavel.ucw.cz> <51E719A6.6070105@wwwdotorg.org>
 <20130718112555.GB1021@amd.pavel.ucw.cz>
Message-ID: <CACxGe6usDHi5sQFXTGB7wqEyzZud3J1cqaX19x9kqREz+WhQLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 4:25 AM, Pavel Machek <pavel@denx.de> wrote:
> Hi!
>
>> >>> I do not quite follow the argument here.  I agree with you that
>> >>> deferred probe is the approach to solve dependencies.  But it does not
>> >>> necessarily mean that initcall can not be used to help it save some
>> >>> nasty or nested deferring.  Deferred probe and initcalls are not two
>> >>> mutually exclusive mechanisms but two which can help each other.
>> >>
>> >> My understanding is that deferred probe was implemented specifically to
>> >> avoid having to, or allowing, the use of initcall levels to determine
>> >> probe order.
>> >>
>> >> However, if someone closely associated with the implementation of
>> >> deferred probe (e.g. Grant, or a device core maintainer) is willing to
>> >> step up and say I'm wrong, I'll drop my objection.
>> >
>> > AFAIR, defered probing is known to be a "hack" by its authors. We
>> > should still try to get initcall levels right...
>>
>> I don't /think/ it was the concept of deferred probe that was considered
>> hacky, but perhaps just the first proof-of-concept implementation, and
>> any hackiness was presumably solved before the feature was merged.
>
> Well...
>
> http://lwn.net/Articles/485194/
>
> From:           Grant Likely <grant.likely@secretlab.ca>
> To:                   linux-kernel at vger.kernel.org
> Subject:                [PATCH] drivercore: Add driver probe deferral
> mechanism
> Date:           Mon, 5 Mar 2012 08:47:41 -0700
> Message-ID:
> <1330962461-9061-1-git-send-email-grant.likely@secretlab.ca>
> ...
>
> I know that not everybody is happy with this approach, but I've yet to
> see a better alternative.  However, it is *really easy* to find all
> the
> users of deferred probe since any user must return -EPROBE_DEFER
> explicitly.
> If/when a better approach is found, all the users will be easy to find
> and modify.
>
> ...
>
> It sound to me like keeping ammount of -EPROBE_DEFER to minimum is
> still preferred.

That wasn't the point I was trying to make in the above thread. My
point was that -EPROBE_DEFER is the best option that we currently have
to get rid of the initcall ordering madness. I'm all ears if someone
comes up with a simple and inexpensive alternative that can take into
account dependencies between devices.

g.
