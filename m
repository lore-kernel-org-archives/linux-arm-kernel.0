From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 03 Jun 2014 16:13:07 +0100
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <4294251.h9ODuG21v5@wuerfel>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <536800A8.7090801@intel.com> <538DE069.5030804@codethink.co.uk>
 <4294251.h9ODuG21v5@wuerfel>
Message-ID: <538DE603.60801@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/14 16:05, Arnd Bergmann wrote:
> On Tuesday 03 June 2014 15:49:13 Ben Dooks wrote:
>> On 05/05/14 22:20, Alexander Duyck wrote:
>>> On 05/05/2014 01:38 PM, Thomas Petazzoni wrote:
>>>
>>> Glad to hear that this is working on your ARM platform as expected.
>>>
>>> I believe the issue Shiv is having is due to a problem with the specific
>>> platform as the IGB device is reporting a Data Link Protocol error via
>>> AER and I believe this is what is causing his platform issues.  On
>>> enabling BME the device is likely signalling a Fatal Error message in
>>> response to the DLP error.  The original error he was seeing was:
>>>
>>> Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>>
>> I should sort out making these errors non-fatal to the system, there's
>> not really much point in killing a process that may not have been the
>> initiator of the problem.
> 
> We really shouldn't catch those errors system-wide, it belongs into
> the specific host bridge driver, but Shiv refuses to say which one that
> is, so we can't fix it.

I am not sure what else we can do, either we either have to have a
default null handler, or log that they have happened.

The whole issue with the "imprecise external" part is that you have
no idea what instruction (or core) caused the issue and IIRC there is
very little information about what actually sent the abort.

I believe these are useful to report as they tend to show that some
part of the system has gone wrong. For example, we get them on the
rcar-h2 if the system tries to access a unit that has not been
properly clocked.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
