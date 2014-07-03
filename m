From: s-anna@ti.com (Suman Anna)
Date: Thu, 3 Jul 2014 12:35:45 -0500
Subject: [PATCHv5 04/15] hwspinlock/core: add common OF helpers
In-Reply-To: <CAK=WgbbJ6a17wrsEcvNq6tPiaciQ=E+22QE06t9EA8RFqicNRg@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-5-git-send-email-s-anna@ti.com>
 <CAK=WgbbZvBLT7U638fBfPjF7-MJaP=4WJcrT_fEg6Uu3cXRAyg@mail.gmail.com>
 <53B47626.4040506@ti.com>
 <CAK=WgbbJ6a17wrsEcvNq6tPiaciQ=E+22QE06t9EA8RFqicNRg@mail.gmail.com>
Message-ID: <53B59471.30703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On 07/03/2014 02:15 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Thu, Jul 3, 2014 at 12:14 AM, Suman Anna <s-anna@ti.com> wrote:
>>> Do we have a use case today that require the xlate() method?
>>>
>>> If not, let's remove it as we could always add it back if some new
>>> hardware shows up that needs it.
>>
>> The xlate() method is to support the phandle + args specifier way of
>> requesting hwlocks, platform implementations are free to implement their
>> own xlate functions, but the above supports the simplest case of
>> controller + relative lock index within controller.
> 
> Do we have a use case for a different implementation other than the
> simplest case? If not, it seems to me this will just become redundant
> boilerplate code (every platform will use the simple xlate method).

Not at the moment, with the existing platform implementations. So, if I
understand you correctly, you are asking to leave out the xlate ops and
make the of_hwspin_lock_simple_xlate() internal until a need for an
xlate method arises. This also means, we only support a value of 1 for
#hwlock-cells.

> 
>> This function again is to support the phandle + args specifier way of
>> requesting hwlocks, the hwspin_lock_request_specific() is invoked
>> internally within this function, so we are still reusing the actual
>> request code other than handling the DT parsing portion. If we go back
>> to using global locks in client hwlocks property, we don't need a
>> of_hwspin_lock_get_id(), the same can be achieved using the existing DT
>> function, of_property_read_u32_index().
> 
> I think you may have misunderstood me, sorry. I'm ok with the phandle
> + args specifier. I just think we can use it, together with the
> base_id property, to infer the global lock id from the DT data. 

Aah ok, its minor code rearrangement for what you are asking - I just
need to leave out invoking the request_specific invocation in the OF
request specific existing function, just return the global id and let
the client users call the normal request_specific API themselves.

But, that would mean DT-based client users would have to invoke two
function calls to request a hwspinlock. We already have an API to get
the lock id given a hwspinlock - hwspin_lock_get_id(), so I added the OF
API for requesting a lock directly rather than giving an OF API for
getting the lock id. This is in keeping in convention with what other
drivers do normally - a regular get and an OF get. I can modify it if
you still prefer the OF API for getting a global lock id, but I feel its
a burden for client users.

Also, do you prefer an open property-name in client users (like I am
doing at the moment) or imposing a standard property name "hwlocks"?

regards
Suman

> This is not only a must to support heterogenous multi-processing systems,
> it will also substantially simplify the code.
> 
> Thanks,
> Ohad.
> 
