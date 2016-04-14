From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 14 Apr 2016 06:21:06 -0700
Subject: [PATCH 3/6] ARM: PSCI: Register with kernel restart handler
In-Reply-To: <20160414085242.GB1533@katana>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
 <1460120039-2497-4-git-send-email-linux@roeck-us.net>
 <20160413110519.GE32018@leverpostej> <570E4550.5000207@roeck-us.net>
 <CAMuHMdU+vj4HDTLdXngUsTjF-Ki-HtbhoRU6mV7UKCz-BhFAtQ@mail.gmail.com>
 <20160414004223.GA18564@roeck-us.net> <20160414085242.GB1533@katana>
Message-ID: <570F9942.30608@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2016 01:52 AM, Wolfram Sang wrote:
>
>> That makes things quite tricky. Best I can think of is a series of boolean
>> devicetree properties, such as
>>
>> 	broken-reset-handler
>> 	last-resort-restart-handler
>> 	secondary-restart-handler
>> 	default-restart-handler
>> 	primary-restart-handler
>>
>> which ends up being quite similar to the 'restart-priority' property. I'll
>> do this as follow-up patch, though
>
> Please CC me on this. I wanted to tackle this problem as well today. My

Sure.

> findings/conclusions so far:
>
> * There is one driver bringing 'priority' directly to DT already: gpio-restart
>
Correct.

> * Watchdog priorities are board dependant
>
> * Having the priorities clear at boot-time is safer than configuring them
>    at run-time
>
Correct.

> * The linux scheme (0-255) shouldn't be enforced in DT
>
> So, I wondered about a "priority" binding which just states "the higher,
> the more important". Then any OS can decide what to do with it. In the
> Linux case, this could be: sort them and give them priority 256 -
> position_in_sorted_list.
>

"the higher, the more important" makes sense to me. We don't have to
enforce the linux scheme, though that happens to be the same (the priority
argument in the notifier block takes an int, so it would not even be
necessary to adjust it unless someone specifies 0xffffffff).

> Opinions?
>
I am fine either way - boolean properties or numbers, with a personal
preference for numbers as more flexible. Whatever is acceptable for
the community is fine with me.

Guenter

>> - I do not see the point holding up the series for this, and it is
>> really a separate problem.
>
> Ack.
>
