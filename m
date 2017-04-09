From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Sun, 9 Apr 2017 16:22:28 -0500
Subject: [PATCH v4 19/23] drivers/fsi: Add GPIO based FSI master
In-Reply-To: <1491344360.4166.68.camel@kernel.crashing.org>
References: <20170329174340.89109-1-cbostic@linux.vnet.ibm.com>
 <20170329174340.89109-20-cbostic@linux.vnet.ibm.com>
 <CACPK8XfOSYPidHF6=psC4mP-tkRyWTu0psdcK6EwA2E6FF53Uw@mail.gmail.com>
 <0e1bcf3a-e8d7-9f50-bdf7-2a1e7466665b@linux.vnet.ibm.com>
 <1490907014.3177.207.camel@kernel.crashing.org>
 <93b21624-11fc-b71b-aa78-6cb4371c87ae@linux.vnet.ibm.com>
 <1491344360.4166.68.camel@kernel.crashing.org>
Message-ID: <5344146a-f450-7959-4688-a83ee022574b@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/4/17 5:19 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-04 at 12:32 -0500, Christopher Bostic wrote:
>> Agreed that there is room for improvement.   I intend to look further
>> into your suggestions from here and our private conversation on the
>> matter and make changes as appropriate.  I have an open issue to track
>> this.  As it exists in this patch reads/writes from master to slave
>> fundamentally work.
> My understanding is they "seem to work if you get lucky with the timing
> and fall apart under load". Or did I hear wrong ?
>
>>   Given the pervasiveness and time to fully evaluate
>> and test any protocol updates I intend address this in the near future
>> with a separate follow on patch.
> Please try the simple change I proposed in my email. It's a 4 or 5
> lines change max to your clock_toggle function and how it's called in
> send and receive. It should be trivial to check if things still "seem
> to work" to begin with.
Hi Benjamin,

I did try reordering the clock delays from: delay, clock 0, delay clock 
1  to:  clock 0, delay, clock 1, delay.
This worked fine.  Making this change also removes the need for having a 
third delay I had in place prior to sampling
SDA when in slave response mode.

A 3 microsecond delay is required, however, to prevent occasional issues 
during heavy FSI bus load stress testing.
A 1 nanosecond delay using ndelay(1) had been specified prior to this 
but after looking more closely at real time performance it turned out to 
actually be roughly 1-2 microseconds.   This appears to be the minimum 
resolution using the delay() linux libraries on the AST2400/2500.   
Given this, increasing delay to 3 microseconds doesn't impact 
performance much considering I can now remove the sample input delay 
based on your recommendations to re-order the two clock delays.

Thanks for your input.
Chris

>
> Do you have some kind of test mechanism that hammers the FSI
> continuously ? Such as doing a series of putmemproc/getmemproc &
> checking the values ?
>
> Then you can run that while hammering the LPC bus and generally putting
> the BMC under load and you'll quickly see if it's reliable or not.
>
> Cheers,
> Ben.
>
