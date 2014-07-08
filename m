From: s-anna@ti.com (Suman Anna)
Date: Tue, 8 Jul 2014 10:37:56 -0500
Subject: [PATCHv5 04/15] hwspinlock/core: add common OF helpers
In-Reply-To: <CAK=WgbbZYwfOyeZuDTX2RXtEdYzsZc++crHZ-ZAqeiWds0BCcg@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-5-git-send-email-s-anna@ti.com>
 <CAK=WgbbZvBLT7U638fBfPjF7-MJaP=4WJcrT_fEg6Uu3cXRAyg@mail.gmail.com>
 <53B47626.4040506@ti.com>
 <CAK=WgbbJ6a17wrsEcvNq6tPiaciQ=E+22QE06t9EA8RFqicNRg@mail.gmail.com>
 <53B59471.30703@ti.com>
 <CAK=WgbbZYwfOyeZuDTX2RXtEdYzsZc++crHZ-ZAqeiWds0BCcg@mail.gmail.com>
Message-ID: <53BC1054.5090201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On 07/03/2014 11:58 PM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Thu, Jul 3, 2014 at 8:35 PM, Suman Anna <s-anna@ti.com> wrote:
>> Not at the moment, with the existing platform implementations. So, if I
>> understand you correctly, you are asking to leave out the xlate ops and
>> make the of_hwspin_lock_simple_xlate() internal until a need for an
>> xlate method arises.
> 
> Yes, please. It seems to me this way we're reducing complexity without
> compromising anything.

OK, will make this change and add a comment in the code in the next version.

> 
>> This also means, we only support a value of 1 for #hwlock-cells.
> 
> When a different #hwlock-cells value shows up, someone would have to
> write a new xlate implementation anyway. At the same time, the xlate
> ops could be brought back quite easily.
> 
> Since we're not imposing anything on the DT data, this doesn't affect
> our ability to support these scenarios in the future, but unless I'm
> missing a current use case, these scenarios right now seems somewhat
> fictional.

OK, fair enough.

> 
>> But, that would mean DT-based client users would have to invoke two
>> function calls to request a hwspinlock. We already have an API to get
>> the lock id given a hwspinlock - hwspin_lock_get_id(), so I added the OF
>> API for requesting a lock directly rather than giving an OF API for
>> getting the lock id. This is in keeping in convention with what other
>> drivers do normally - a regular get and an OF get. I can modify it if
>> you still prefer the OF API for getting a global lock id, but I feel its
>> a burden for client users.
> 
> Let's discuss this.
> 
> I was actually thinking of the more general use case of an heterogenous system:
> 
> - driver gets the global lock id from a remote processor
> - driver then requests the specific lock
> 
> Looking at these cases, the OF scenario only differs in the small part
> of fetching the lock id, and if we keep the regular request_specific
> API we'll have more common code between drivers.
> 
> What do you think?

We should also be thinking about the how to add the support for the
reserved locks. Please take a look at the added RFC patches 9 through
13, specifically the reworked Patch 12 [1]. I moved away from adding a
reserved property to the controller node, as it means updating both
controller and client nodes. Depending on where we enforce the check (in
the OF API or in the common request_specific, the behavior would change.

> 
>> Also, do you prefer an open property-name in client users (like I am
>> doing at the moment) or imposing a standard property name "hwlocks"?
> 
> Good point - I think we can start with an imposed "hwlocks" name, and
> evolve in the future as needed (again, only because we're not really
> imposing anything on the DT data - this is just kernel code that we
> could always extend as needed).
> 

OK. Actually, I didn't realize that I had already made this change as
part of the reserved locks RFC patch.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=139968467307977&w=2
