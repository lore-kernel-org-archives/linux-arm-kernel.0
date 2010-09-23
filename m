From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 23 Sep 2010 07:39:33 -0700
Subject: [PATCH v3] power: introduce library for device-specific OPPs
In-Reply-To: <4C9A9F84.7000104@ti.com> (Nishanth Menon's message of "Wed, 22
	Sep 2010 19:29:56 -0500")
References: <1285192054-454-1-git-send-email-nm@ti.com>
	<201009230203.09230.rjw@sisk.pl> <4C9A9F84.7000104@ti.com>
Message-ID: <871v8k7cd6.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Rafael J. Wysocki had written, on 09/22/2010 07:03 PM, the following:
>> [Trimming the CC list slightly.]
> [...]
>
>> ...
>>
>> First, thanks for addressing the previous comments, things look much better
>> now.  In particular the documentation has been improved a lot in my view.
> Thanks for the excellent reviews :)
>
> [...]
>
>>> +
>>> +WARNING on OPP List Modification Vs Query operations:
>>> +----------------------------------------------------
>>> +The OPP layer's query functions are expected to be used in multiple contexts
>>> +(including calls from interrupt locked context) based on SoC framework
>>> +implementation. Only OPP modification functions are guaranteed exclusivity by
>>> +the OPP library. Exclusivity between query functions and modification functions
>>> +should be handled by the users such as the SoC framework appropriately; else,
>>> +there is a risk for the query functions to retrieve stale data.
>>
>> Well, this sounds like a good use case for RCU.
> Kevin did point out rwlock but am I confusing with
> http://lwn.net/Articles/364583/
> If I get the message right, rwlock is more or less on it's way out?

RCU is different from the reader-writer locks that are on their way out.

Let's think about RCU a little more and see if it might be worth using.

As these APIs are infrequencly accessed, I'm thinking a single spinlock
to protect the whole list from concurrent access/modification is
sufficient.

Kevin
